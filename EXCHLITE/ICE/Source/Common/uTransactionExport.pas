unit uTransactionExport;

interface

uses
  Classes, SysUtils, ComObj, Controls, Variants, Forms,
  // Exchequer units
  Enterprise01_Tlb,
  EnterpriseBeta_Tlb,
  // ICE units
  MSXML2_TLB,
  uXmlBaseClass,
  uConsts,
  uCommon,
  uExportBaseClass,
  uXMLFileManager,
  uXMLWriter
  ;

{$I ice.inc}

type
  TTransactionExport = class(_ExportBase)
  private
    fFromDate: TDateTime;
    fToDate: TDateTime;
    oToolkit: IToolkit;
//    fOutputDirectory: string;
    FileManager: TXMLFileManager;
    XMLWriter: TXMLWriter;
    function BuildRecord: Boolean;
    function BuildLineRecord(Line: ITransactionLine3): Boolean;
    function LoadLinesFromDB: Boolean;
//    procedure SetOutputDirectory(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function LoadFromDB: Boolean; override;
    property FromDate: TDateTime read fFromDate write fFromDate;
    property ToDate: TDateTime read fToDate write fToDate;
//    property OutputDirectory: string
//      read fOutputDirectory write SetOutputDirectory;
  end;

implementation

uses
  CTKUtil,
  DateUtils,
  ComnUnit,
  uTransactionTracker, uBaseClass
  ;

const
  VATCodes:       array[1..23] of Char = ('S','E','Z','M','I','1','2','3','4','5','6','7','8','9','T','X','B','C','F','G','R','W','Y');
  VATCodesLessMI: array[1..21] of Char = ('S','E','Z','1','2','3','4','5','6','7','8','9','T','X','B','C','F','G','R','W','Y');

{ TTransactionExport }

constructor TTransactionExport.Create;
begin
  inherited Create;
  UseFiles := True;
  FileManager := TXMLFileManager.Create;
  FileManager.BaseFileName := 'tra';
  XMLWriter := TXMLWriter.Create;
  XMLWriter.NameSpace := 'trans';
end;

destructor TTransactionExport.Destroy;
begin
  if Assigned(oToolkit) then
  begin
    oToolkit.CloseToolkit;
    oToolkit := nil;
  end;
  FileManager.Free;
  inherited;
end;

function TTransactionExport.LoadFromDB: Boolean;
var
  FuncRes: LongInt;
  Key: ShortString;
  ErrorCode: Integer;
  oTrans: ITransaction;
  FileName: string;
  RecordIncluded: Boolean;
  Tracker: TTransactionTracker;
  StartYear, StartPeriod: Byte;
  EndYear, EndPeriod: Byte;

  function IsInRange(oTrans: ITransaction): Boolean;
  begin
    Result := (oTrans.thYear < EndYear) or
              ((oTrans.thYear = StartYear) and (oTrans.thPeriod <= EndPeriod));
  end;

  function IsAutogenerated(oTrans: ITransaction): Boolean;
  var
    oMatching: IMatching;
    FuncRes: Integer;
  begin
    Result := False;
    if (oTrans.thDocType = dtNMT) then
    begin
      oMatching := oTrans.thMatching;
      FuncRes := oMatching.GetFirst;
      while (FuncRes = 0) do
      begin
        if (oMatching.maType in [maTypeFinancial, maTypeSPOP, maTypeCIS]) then
        begin
          Result := True;
          break;
        end;
        FuncRes := oMatching.GetNext;
      end;
    end;
  end;

  function IncludeRecord(oTrans: ITransaction; Tracker: TTransactionTracker): Boolean;
  var
    DocCode: string;
  const
    DocCodes: string =
//      'ADJ NOM SIN SRC SCR SJI SJC SRF SRI SQU SOR SBT PIN PPY PCR PJI PJC PRF PPI PQU POR PBT';
      'NOM SIN SJI SJC SRF SRC SCR SRI PIN PJI PJC PPI PRF PCR PPY SBT PBT';
  begin
//    if Tracker.IsNew(oTrans.thOurRef) then
//    begin
      DocCode := Copy(oTrans.thOurRef, 1, 3);
      Result := (Pos(DocCode, DocCodes) <> 0);
      if Result then
      begin
        { Don't include auto-items. }
        if (oTrans.thRunNo = -1) or
           (oTrans.thRunNo = -2) then
          Result := False;
      end;
//    end
//    else
//      Result := False;
(*
    if Result then
    begin
      Result := not IsAutogenerated(oTrans);
    end;
*)
  end;

begin
  ErrorCode := 0;
  FuncRes := 0;
  Result := False;
  FileManager.Directory := DataPath + cICEFOLDER;

  { Remove any existing transaction files from the export path. }
  DeleteFiles(FileManager.Directory, FileManager.BaseFileName + '*.xml');
  DeleteFile(IncludeTrailingPathDelimiter(FileManager.Directory) + 'ICETrack.ini');
  DeleteFile(IncludeTrailingPathDelimiter(FileManager.Directory) + 'DripFeed.dat');

  oToolkit := OpenToolkit(DataPath, True);
  if not Assigned(oToolkit) then
  begin
    DoLogMessage('TTransactionExport.LoadFromDB: Cannot create COM Toolkit instance', cCONNECTINGDBERROR);
    Result := False;
    Exit;
  end;
  oTrans := oToolkit.Transaction;
  Tracker := TTransactionTracker.Create;
  try
    try
      Tracker.DataPath := DataPath;
(*
      { Record the last used document numbers. }
      try
        { Take a copy of the 'next document number' details -- these will be
          stored in the ICS folder, ready for use by the Tracker in
          determining transactions which have been added since the last
          export }
        Tracker.UpdateDocumentNumbers;
      except
        on E:Exception do
          DoLogMessage('TTransactionExport.LoadFromDB: Failed to update data-tracking file for DripFeed mode: ' +
                       E.Message, cCONNECTINGDBERROR);
      end;
*)
      oTrans.Index := thIdxYearPeriod;
      if not VarIsNull(Param1) then
      begin
        if (Param2 > 1900) then
          Param2 := Param2 - 1900;
        if (Param4 > 1900) then
          Param4 := Param4 - 1900;
        StartPeriod := Param1;
        StartYear   := Param2;
        EndPeriod   := Param3;
        EndYear     := Param4;
        { Find the first transaction in the specified period. }
        Key := oTrans.BuildYearPeriodIndex(StartYear, StartPeriod);
        FuncRes := oTrans.GetGreaterThanOrEqual(Key);
        XMLWriter.StartPeriod := StartPeriod;
        XMLWriter.StartYear   := StartYear;
        XMLWriter.EndPeriod   := EndPeriod;
        XMLWriter.EndYear     := EndYear;
      end
      else
      begin
        StartPeriod := 0;
        StartYear   := 0;
        EndPeriod   := 0;
        EndYear     := 0;
        FuncRes := oTrans.GetFirst;
      end;

      Result  := (FuncRes = 0);
      while (FuncRes = 0) and (IsInRange(oTrans)) do
      begin

        Application.ProcessMessages;
//        Sleep(10);

        RecordIncluded := IncludeRecord(oTrans, Tracker);
        if RecordIncluded then
        begin

          { Start the XML file }
          XMLWriter.Start(cTRANSACTIONTABLE, 'trans');

          { Build the required XML record from the Transaction details }
          BuildRecord;

          { Finish the XML file and save it to the XML directory. Store the
            file name in the Files list (this list will be passed back to the
            DSR, which will use it to find the files to be emailed) }
          XMLWriter.Finish;
          FileName := FileManager.SaveXML(XMLWriter.XML.Text);
          Files.Add(FileName);

        end; { if (IncludeRecord(oTrans)... }

        { Find the next transaction record }
        FuncRes := oTrans.GetNext;

      end;

      try

        { Record the last used document numbers. }
        try
          { Take a copy of the 'next document number' details -- these will be
            stored in the ICS folder, ready for use by the Tracker in
            determining transactions which have been added since the last
            export }
          Tracker.UpdateDocumentNumbers;
        except
          on E:Exception do
            DoLogMessage('TTransactionExport.LoadFromDB: Failed to update data-tracking file for DripFeed mode: ' +
                         E.Message, cCONNECTINGDBERROR);
        end;

        { As we have done a bulk export of Transaction records, we are now
          in drip-feed mode, so update the drip-feed information file with
          the details }
        Tracker.DripFeed.Datapath    := Datapath + cICEFOLDER;
        Tracker.DripFeed.StartPeriod := StartPeriod;
        Tracker.DripFeed.StartYear   := StartYear;
        Tracker.DripFeed.EndPeriod   := EndPeriod;
        Tracker.DripFeed.EndYear     := EndYear;
        Tracker.DripFeed.IsActive    := False;
//          Tracker.DripFeed.UseCompression := False; // DEBUG ONLY -- REMOVE
        if Tracker.DripFeed.IsValidForSaving then
        begin
          if not Tracker.DripFeed.Save then
            DoLogMessage('TTransactionExport.LoadFromDB: Failed to update drip-feed file: ' +
                         Tracker.DripFeed.ErrorMessage,
                         cCONNECTINGDBERROR);
        end
        else
          DoLogMessage('TTransactionExport.LoadFromDB: Failed to update drip-feed file: ' +
                       Tracker.DripFeed.ErrorMessage,
                       cCONNECTINGDBERROR);
      except
        on E:Exception do
          DoLogMessage('TTransactionExport.LoadFromDB: Failed to update drip-feed file: ' +
                       E.Message, cCONNECTINGDBERROR);
      end;

      Result := (Files.Count > 0);
    except
      on E:Exception do
        DoLogMessage('TTransactionExport.LoadFromDB: ' + E.Message, 0)

    end;
  finally
    Tracker.Free;
    oTrans := nil;
  end;
  { Log any errors. }
  if (ErrorCode <> 0) then
    DoLogMessage('TTransactionExport.LoadFromDB', ErrorCode, 'Error: ' + IntToStr(FuncRes));

end;

function TTransactionExport.LoadLinesFromDB: Boolean;
var
  ErrorCode: Integer;
  LineNo: Integer;
  oTrans: ITransaction;
begin
  ErrorCode := 0;
  oTrans := oToolkit.Transaction;
  try
    for LineNo := 1 to oTrans.thLines.thLineCount do
      { Build the required XML record from the Transaction Line details. }
      BuildLineRecord(oTrans.thLines[LineNo] as ITransactionLine3);
    Result := True;
  finally
    oTrans := nil;
  end;
  { Log any errors. }
  if (ErrorCode <> 0) then
    DoLogMessage('TTransactionExport.LoadLinesFromDB', ErrorCode);
end;

(*
procedure TTransactionExport.SetOutputDirectory(const Value: string);
begin
  fOutputDirectory := Value;
  ForceDirectories(fOutputDirectory);
  if not DirectoryExists(fOutputDirectory) then
    DoLogMessage('TTransactionExport.SetOutputDirectory: ' +
                 'Directory does not exist and could not be created',
                 cNOOUTPUTDIRECTORY);
end;
*)

function TTransactionExport.BuildRecord: Boolean;

  function IsPaymentOrReceipt(Ref: string): Boolean;
  begin
    Result := (Uppercase(Copy(Ref, 1, 3)) = 'PPY') or
              (Uppercase(Copy(Ref, 1, 3)) = 'SRC');
  end;

  function IsInvoice(Ref: string): Boolean;
  begin
    Result := (Uppercase(Copy(Ref, 1, 3)) = 'SIN') or
              (Uppercase(Copy(Ref, 1, 3)) = 'PIN') or
              (Uppercase(Copy(Ref, 1, 3)) = 'ADJ') or
              (Uppercase(Copy(Ref, 1, 3)) = 'SCR');
  end;

var
  oTrans: ITransaction3;
  i: Integer;
  LineType: TTransactionLineType;
  RunNo: LongInt;
  RunStr: ShortString;
const
  AS_CDATA = True;
Begin
  Result := False;
  oTrans := oToolkit.Transaction as ITransaction3;

//if (oTrans.thOurRef = 'SIN008427') then
//  oToolkit.Functions.entBrowseObject(oTrans, True);
  try
    try

      { Add the record node. }
      XMLWriter.AddOpeningTag('threc');

      XMLWriter.AddLeafTag('thaccode',        oTrans.thAcCode);
      XMLWriter.AddLeafTag('thourref',        oTrans.thOurRef);
      XMLWriter.AddLeafTag('thamountsettled', oTrans.thAmountSettled);

{
      if (Trim(oTrans.thJobCode) = '') then
        XMLWriter.AddLeafTag('thanalysiscode',  oTrans.thAnalysisCode)
      else
        XMLWriter.AddLeafTag('thanalysiscode',  '');

      if (oTrans.thAsApplication <> nil) then
      with oTrans.thAsApplication do
      begin
        XMLWriter.AddOpeningTag('thasapplication');
        XMLWriter.AddLeafTag('tpapplicationbasis', tpApplicationBasis);
        XMLWriter.AddLeafTag('tpapplied',          tpApplied);
        XMLWriter.AddLeafTag('tpappsinterimflag',  tpAppsInterimFlag);
        XMLWriter.AddLeafTag('tpatr',              tpATR);
        XMLWriter.AddLeafTag('tpcertified',        tpCertified);
        XMLWriter.AddLeafTag('tpcertifiedvalue',   tpCertifiedValue);
        XMLWriter.AddLeafTag('tpcisdate',          tpCISDate);
        XMLWriter.AddLeafTag('tpcismanualtax',     tpCISManualTax);
        XMLWriter.AddLeafTag('tpcissource',        tpCISSource);
        XMLWriter.AddLeafTag('tpcistaxdeclared',   tpCISTaxDeclared);
        XMLWriter.AddLeafTag('tpcistaxdue',        tpCISTaxDue);
        XMLWriter.AddLeafTag('tpcistotalgross',    tpCISTotalGross);
        XMLWriter.AddLeafTag('tpdefervat',         tpDeferVAT);
        XMLWriter.AddLeafTag('tpemployeecode',     tpEmployeeCode);
        XMLWriter.AddLeafTag('tpparentterms',      tpParentTerms);
        XMLWriter.AddLeafTag('tptermsinterimflag', tpTermsInterimFlag);
        XMLWriter.AddLeafTag('tptermsstage',       tpTermsStage);
        XMLWriter.AddLeafTag('tptotalappliedytd',  tpTotalAppliedYTD);
        XMLWriter.AddLeafTag('tptotalbudget',      tpTotalBudget);
        XMLWriter.AddLeafTag('tptotalcertytd',     tpTotalCertYTD);
        XMLWriter.AddLeafTag('tptotalcontra',      tpTotalContra);
        XMLWriter.AddLeafTag('tptotaldeduct',      tpTotalDeduct);
        XMLWriter.AddLeafTag('tptotaldeductytd',   tpTotalDeductYTD);
        XMLWriter.AddLeafTag('tptotalretain',      tpTotalRetain);
        XMLWriter.AddLeafTag('tptotalretainytd',   tpTotalRetainYTD);
        XMLWriter.AddClosingTag('thasapplication');
      end;
}
      if (oTrans.thAsBatch <> nil) then
      with oTrans.thAsBatch do
      begin
        XMLWriter.AddOpeningTag('thasbatch');
        XMLWriter.AddLeafTag('btbankgl',        btBankGL);
        XMLWriter.AddLeafTag('btchequenostart', btChequeNoStart);
        XMLWriter.AddLeafTag('bttotal',         btTotal);
        XMLWriter.AddClosingTag('thasbatch');
      end;

      if (oTrans.thAsNOM <> nil) then
      with oTrans.thAsNOM as ITransactionAsNOM2 do
      begin
        XMLWriter.AddOpeningTag('thasnom');
        XMLWriter.AddLeafTag('tnautoreversing', tnAutoReversing);
        XMLWriter.AddLeafTag('tnvatio',         tnVatIO);
        XMLWriter.AddClosingTag('thasnom');
      end;

      if (oTrans.thAutoSettings <> nil) then
      with oTrans.thAutoSettings do
      begin
        XMLWriter.AddOpeningTag('thautosettings');
        XMLWriter.AddLeafTag('atautocreateonpost', atAutoCreateOnPost);
        XMLWriter.AddLeafTag('atenddate',          atEndDate);
        XMLWriter.AddLeafTag('atendperiod',        atEndPeriod);
        XMLWriter.AddLeafTag('atendyear',          atEndYear);
        XMLWriter.AddLeafTag('atincrement',        atIncrement);
        XMLWriter.AddLeafTag('atincrementtype',    atIncrementType);
        XMLWriter.AddLeafTag('atstartdate',        atStartDate);
        XMLWriter.AddLeafTag('atstartperiod',      atStartPeriod);
        XMLWriter.AddLeafTag('atstartyear',        atStartYear);
        XMLWriter.AddClosingTag('thautosettings');
      end;

      XMLWriter.AddLeafTag('thautotransaction', oTrans.thAutoTransaction);
      XMLWriter.AddLeafTag('thbatchdiscamount', oTrans.thBatchDiscAmount);
      XMLWriter.AddLeafTag('thcisdate',         oTrans.thCISDate);
      XMLWriter.AddLeafTag('thcisemployee',     oTrans.thCISEmployee);
      XMLWriter.AddLeafTag('thcismanualtax',    oTrans.thCISManualTax);
      XMLWriter.AddLeafTag('thcissource',       oTrans.thCISSource);
      XMLWriter.AddLeafTag('thcistaxdeclared',  oTrans.thCISTaxDeclared);
      XMLWriter.AddLeafTag('thcistaxdue',       oTrans.thCISTaxDue);
      XMLWriter.AddLeafTag('thcistotalgross',   oTrans.thCISTotalGross);
      XMLWriter.AddLeafTag('thcompanyrate',     oTrans.thCompanyRate);
      XMLWriter.AddLeafTag('thcontrolgl',       oTrans.thControlGL);
      XMLWriter.AddLeafTag('thcurrency',        oTrans.thCurrency);
      XMLWriter.AddLeafTag('thdailyrate',       oTrans.thDailyRate);

      if (oTrans.thDelAddress <> nil) then
      with oTrans.thDelAddress do
      begin
        XMLWriter.AddOpeningTag('thdeladdress');
        XMLWriter.AddLeafTag('street1',  Street1);
        XMLWriter.AddLeafTag('street2',  Street2);
        XMLWriter.AddLeafTag('town',     Town);
        XMLWriter.AddLeafTag('county',   County);
        XMLWriter.AddLeafTag('postcode', PostCode);
        XMLWriter.AddClosingTag('thdeladdress');
      end;

      XMLWriter.AddLeafTag('thdeliverynoteref', oTrans.thDeliveryNoteRef);

      RunStr := oTrans.thDeliveryRunNo;
      if IsPaymentOrReceipt(oTrans.thOurRef) and
         (Length(RunStr) >= 7) then
      begin
        Move (RunStr, RunNo, SizeOf(RunNo));
        XMLWriter.AddLeafTag('thdeliveryrunno', RunNo);
      end
      else if IsInvoice(oTrans.thOurRef) and
              (Length(RunStr) >= 7) then
      begin
        Move (RunStr, RunNo, SizeOf(RunNo));
        XMLWriter.AddLeafTag('thdeliveryrunno', RunNo);
      end
      else
        XMLWriter.AddLeafTag('thdeliveryrunno',   oTrans.thDeliveryRunNo);

      XMLWriter.AddLeafTag('thdeliveryterms',   oTrans.thDeliveryTerms);
      XMLWriter.AddLeafTag('thdoctype',         oTrans.thDocType);
      XMLWriter.AddLeafTag('thduedate',         oTrans.thDueDate);
      XMLWriter.AddLeafTag('themployeecode',    oTrans.thEmployeeCode);
      XMLWriter.AddLeafTag('thexternal',        oTrans.thExternal);
      XMLWriter.AddLeafTag('thfixedrate',       oTrans.thFixedRate);
      XMLWriter.AddLeafTag('thfolionum',        oTrans.thFolioNum);

      XMLWriter.AddOpeningTag('thgoodsanalysis');
      for i := Low(VATCodesLessMI) to High(VATCodesLessMI) do
      begin
        XMLWriter.AddOpeningTag('tgaline');
        XMLWriter.AddLeafTag('tgacode', VATCodesLessMI[i]);
        XMLWriter.AddLeafTag('tgavalue', oTrans.thGoodsAnalysis[VATCodes[i]]);
        XMLWriter.AddClosingTag('tgaline');
      end;
      XMLWriter.AddClosingTag('thgoodsanalysis');

      if (oTrans.thRunNo > 0) then
        { Do not export the hold status for posted transactions -- always
          export it as not on hold. }
        XMLWriter.AddLeafTag('thholdflag',            0)
      else
        XMLWriter.AddLeafTag('thholdflag',            oTrans.thHoldFlag);
        
//      XMLWriter.AddLeafTag('thjobcode',             oTrans.thJobCode);
      XMLWriter.AddLeafTag('thjobcode',             '');
      XMLWriter.AddLeafTag('thlastdebtchaseletter', oTrans.thLastDebtChaseLetter);

      XMLWriter.AddOpeningTag('thlineanalysis');
      for LineType := tlTypeNormal to tlTypeMaterials2 do //tlTypeMisc2
      begin
        XMLWriter.AddOpeningTag('tlaline');
        XMLWriter.AddLeafTag('tlacode', LineType);
        XMLWriter.AddLeafTag('tlavalue', oTrans.thLineTypeAnalysis[LineType]);
        XMLWriter.AddClosingTag('tlaline');
      end;
      XMLWriter.AddClosingTag('thlineanalysis');

      XMLWriter.AddLeafTag('thlongyourref',       oTrans.thLongYourRef);
      XMLWriter.AddLeafTag('thmanualvat',         oTrans.thManualVAT);
      XMLWriter.AddLeafTag('thnetvalue',          oTrans.thNetValue);
      XMLWriter.AddLeafTag('thnolabels',          oTrans.thNoLabels);
      XMLWriter.AddLeafTag('thoperator',          oTrans.thOperator);
      XMLWriter.AddLeafTag('thoutstanding',       oTrans.thOutstanding);
      XMLWriter.AddLeafTag('thperiod',            oTrans.thPeriod);
      XMLWriter.AddLeafTag('thpickingrunno',      oTrans.thPickingRunNo);
      XMLWriter.AddLeafTag('thporpicksor',        oTrans.thPORPickSOR);
      XMLWriter.AddLeafTag('thpostcompanyrate',   oTrans.thPostCompanyRate);
      XMLWriter.AddLeafTag('thpostdailyrate',     oTrans.thPostDailyRate);
      XMLWriter.AddLeafTag('thpostdiscamount',    oTrans.thPostDiscAmount);
      XMLWriter.AddLeafTag('thpostdisctaken',     oTrans.thPostDiscTaken);
      XMLWriter.AddLeafTag('thposteddate',        oTrans.thPostedDate);
      XMLWriter.AddLeafTag('thprepost',           oTrans.thPrePost);
      XMLWriter.AddLeafTag('thprinted',           oTrans.thPrinted);
                                                 
      try                                        
        XMLWriter.AddLeafTag('thprocess',           oTrans.thProcess);
      except                                     
        on E:Exception do                        
          XMLWriter.AddLeafTag('thprocess', ' ')
      end;

      XMLWriter.AddLeafTag('thrunno',             oTrans.thRunNo);
      XMLWriter.AddLeafTag('thsettlediscamount',  oTrans.thSettleDiscAmount);
      XMLWriter.AddLeafTag('thsettlediscdays',    oTrans.thSettleDiscDays);
      XMLWriter.AddLeafTag('thsettlediscperc',    oTrans.thSettleDiscPerc);
      XMLWriter.AddLeafTag('thsettledisctaken',   oTrans.thSettleDiscTaken);
      XMLWriter.AddLeafTag('thsettledvat',        oTrans.thSettledVat);
      XMLWriter.AddLeafTag('thsource',            oTrans.thSource);
      XMLWriter.AddLeafTag('thtagged',            oTrans.thTagged);
      XMLWriter.AddLeafTag('thtagno',             oTrans.thTagNo);
      XMLWriter.AddLeafTag('thtotalcost',         oTrans.thTotalCost);
      XMLWriter.AddLeafTag('thtotalcostapport',   oTrans.thTotalCostApport);
      XMLWriter.AddLeafTag('thtotallinediscount', oTrans.thTotalLineDiscount);
      XMLWriter.AddLeafTag('thtotalorderos',      oTrans.thTotalOrderOS);
      XMLWriter.AddLeafTag('thtotalvat',          oTrans.thTotalVAT);
      XMLWriter.AddLeafTag('thtotalweight',       oTrans.thTotalWeight);
      XMLWriter.AddLeafTag('thtransdate',         oTrans.thTransDate);
      XMLWriter.AddLeafTag('thtransportmode',     oTrans.thTransportMode);
      XMLWriter.AddLeafTag('thtransportnature',   oTrans.thTransportNature);
      XMLWriter.AddLeafTag('thuserfield1',        oTrans.thUserField1);
      XMLWriter.AddLeafTag('thuserfield2',        oTrans.thUserField2);
      XMLWriter.AddLeafTag('thuserfield3',        oTrans.thUserField3);
      XMLWriter.AddLeafTag('thuserfield4',        oTrans.thUserField4);

      XMLWriter.AddOpeningTag('thvatanalysis');
      for i := Low(VATCodesLessMI) to High(VATCodesLessMI) do
      begin
        XMLWriter.AddOpeningTag('tvaline');
        XMLWriter.AddLeafTag('tvacode', VATCodesLessMI[i]);
        XMLWriter.AddLeafTag('tvavalue', oTrans.thVATAnalysis[VATCodesLessMI[i]]);
        XMLWriter.AddClosingTag('tvaline');
      end;
      XMLWriter.AddClosingTag('thvatanalysis');

      XMLWriter.AddLeafTag('thvatclaimed',     oTrans.thVATClaimed);
      XMLWriter.AddLeafTag('thvatcompanyrate', oTrans.thVATCompanyRate);
      XMLWriter.AddLeafTag('thvatdailyrate',   oTrans.thVATDailyRate);
      XMLWriter.AddLeafTag('thyear',           oTrans.thYear);
      XMLWriter.AddLeafTag('thyourref',        oTrans.thYourRef);

      with oTrans as IBetaTransaction do
      begin
        XMLWriter.AddLeafTag('thordmatch', thOrdMatch);
        XMLWriter.AddLeafTag('thautopost', thAutoPost);
      end;

      { Load the lines for this transaction. }
      LoadLinesFromDB;

      XMLWriter.AddClosingTag('threc');

      Result := True;
    except
      On e:Exception Do
        DoLogMessage('TTransactionExport.BuildHeaderRecord', cBUILDINGXMLERROR, 'Error: ' +
          e.message);
    end;

  finally
    oTrans := nil;
  end;
end;

function TTransactionExport.BuildLineRecord(Line: ITransactionLine3): Boolean;
begin
  Result := False;

  with Line do
  begin
    try
      { Add the record node. }
      XMLWriter.AddOpeningTag('tlrec');

      { Add the field nodes. }

      XMLWriter.AddLeafTag('tlabslineno',    tlABSLineNo);
      XMLWriter.AddLeafTag('tlaccode',       tlAcCode);
{
      if (Trim(tlJobCode) = '') then
        XMLWriter.AddLeafTag('tlanalysiscode', tlAnalysisCode)
      else
        XMLWriter.AddLeafTag('tlanalysiscode', '');

      if (tlAsApplication <> nil) then
      with tlAsApplication do
      begin
        XMLWriter.AddOpeningTag('tlasapplication');
        XMLWriter.AddLeafTag('tplcalculatebeforeretention', tplCalculateBeforeRetention);
        XMLWriter.AddLeafTag('tpldeductiontype',            tplDeductionType);
        XMLWriter.AddLeafTag('tploverridevalue',            tplOverrideValue);
        XMLWriter.AddLeafTag('tplretentionexpiry',          tplRetentionExpiry);
        XMLWriter.AddLeafTag('tplretentiontype',            tplRetentionType);
        XMLWriter.AddClosingTag('tlasapplication');
      end;
}
      if (tlAsNOM <> nil) then
      with tlAsNOM as ITransactionLineAsNOM2 do
      begin
        XMLWriter.AddOpeningTag('tlasnom');
        XMLWriter.AddLeafTag('tlnnomvattype', tlnNomVatType);
        XMLWriter.AddClosingTag('tlasnom');
      end;

      XMLWriter.AddLeafTag('tlb2blineno',           tlB2BLineNo );
      XMLWriter.AddLeafTag('tlb2blinkfolio',        tlB2BLinkFolio );
      XMLWriter.AddLeafTag('tlbinqty',              tlBinQty );
      XMLWriter.AddLeafTag('tlbomkitlink',          tlBOMKitLink);
      XMLWriter.AddLeafTag('tlchargecurrency',      tlChargeCurrency);
      XMLWriter.AddLeafTag('tlcisrate',             tlCISRate );
      XMLWriter.AddLeafTag('tlcisratecode',         tlCISRateCode );
      XMLWriter.AddLeafTag('tlcompanyrate',         tlCompanyRate);
      XMLWriter.AddLeafTag('tlcosdailyrate',        tlCOSDailyRate );
      XMLWriter.AddLeafTag('tlcost',                tlCost);
      XMLWriter.AddLeafTag('tlcostapport',          tlCostApport );
      XMLWriter.AddLeafTag('tlcostcentre',          tlCostCentre);
      XMLWriter.AddLeafTag('tlcurrency',            tlCurrency);
      XMLWriter.AddLeafTag('tldailyrate',           tlDailyRate);
      XMLWriter.AddLeafTag('tldepartment',          tlDepartment);
      XMLWriter.AddLeafTag('tldescr',               tlDescr);
      XMLWriter.AddLeafTag('tldiscflag',            tlDiscFlag);
      XMLWriter.AddLeafTag('tldiscount',            tlDiscount);
      XMLWriter.AddLeafTag('tldoctype',             tlDocType );
      XMLWriter.AddLeafTag('tlfolionum',            tlFolioNum);
      XMLWriter.AddLeafTag('tlglcode',              tlGLCode);
      XMLWriter.AddLeafTag('tlinclusivevatcode',    tlInclusiveVATCode);
      XMLWriter.AddLeafTag('tlitemno',              tlItemNo);
//      XMLWriter.AddLeafTag('tljobcode',             tlJobCode);
      XMLWriter.AddLeafTag('tljobcode',             '');
      XMLWriter.AddLeafTag('tllineclass',           tlLineClass);
      XMLWriter.AddLeafTag('tllinedate',            tlLineDate);
      XMLWriter.AddLeafTag('tllineno',              tlLineNo);
      XMLWriter.AddLeafTag('tllinesource',          tlLineSource );
      XMLWriter.AddLeafTag('tllinetype',            tlLineType);
      XMLWriter.AddLeafTag('tllocation',            tlLocation);
      XMLWriter.AddLeafTag('tlnetvalue',            tlNetValue);
      XMLWriter.AddLeafTag('tlnominalmode',         tlNominalMode);
      XMLWriter.AddLeafTag('tlourref',              tlOurRef);
      XMLWriter.AddLeafTag('tlpayment',             tlPayment);
      XMLWriter.AddLeafTag('tlperiod',              tlPeriod );
      XMLWriter.AddLeafTag('tlpricemultiplier',     tlPriceMultiplier);
      XMLWriter.AddLeafTag('tlqty',                 tlQty);
      XMLWriter.AddLeafTag('tlqtydel',              tlQtyDel);
      XMLWriter.AddLeafTag('tlqtymul',              tlQtyMul);
      XMLWriter.AddLeafTag('tlqtypack',             tlQtyPack );
      XMLWriter.AddLeafTag('tlqtypicked',           tlQtyPicked);
      XMLWriter.AddLeafTag('tlqtypickedwo',         tlQtyPickedWO);
      XMLWriter.AddLeafTag('tlqtywoff',             tlQtyWOFF);
      XMLWriter.AddLeafTag('tlreconciliationdate',  tlReconciliationDate );
      XMLWriter.AddLeafTag('tlrecstatus',           tlRecStatus);
      XMLWriter.AddLeafTag('tlrunno',               tlRunNo );
      XMLWriter.AddLeafTag('tlsopabslineno',        tlSOPABSLineNo);
      XMLWriter.AddLeafTag('tlsopfolionum',         tlSOPFolioNum);
      XMLWriter.AddLeafTag('tlssdcommodcode',       tlSSDCommodCode);
      XMLWriter.AddLeafTag('tlssdcountry',          tlSSDCountry);
      XMLWriter.AddLeafTag('tlssdsalesunit',        tlSSDSalesUnit);
      XMLWriter.AddLeafTag('tlssdupliftperc',       tlSSDUpliftPerc);
      XMLWriter.AddLeafTag('tlssduselinevalues',    tlSSDUseLineValues);
      XMLWriter.AddLeafTag('tlstockcode',           tlStockCode);
      XMLWriter.AddLeafTag('tlstockdeductqty',      tlStockDeductQty );
      XMLWriter.AddLeafTag('tlunitweight',          tlUnitWeight);
      XMLWriter.AddLeafTag('tluserfield1',          tlUserField1);
      XMLWriter.AddLeafTag('tluserfield2',          tlUserField2);
      XMLWriter.AddLeafTag('tluserfield3',          tlUserField3);
      XMLWriter.AddLeafTag('tluserfield4',          tlUserField4);
      XMLWriter.AddLeafTag('tluseqtymul',           tlUseQtyMul );
      XMLWriter.AddLeafTag('tlvatamount',           tlVATAmount);
      XMLWriter.AddLeafTag('tlvatcode',             tlVATCode);
      XMLWriter.AddLeafTag('tlvatincvalue',         tlVATIncValue );
      XMLWriter.AddLeafTag('tlyear',                tlYear );
                                                    
      XMLWriter.AddClosingTag('tlrec');

      Result := True;
    except
      On e: Exception Do
        DoLogMessage('TTransactionExport.BuildLineRecord', cBUILDINGXMLERROR, 'Error: ' +
          e.message);
    end;
  end;
end;

end.
