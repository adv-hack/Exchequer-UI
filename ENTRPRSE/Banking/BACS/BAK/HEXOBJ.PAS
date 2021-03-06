unit HexObj;
{This format is slightly more complex to deal with than usual export formats.  The file
header has to have the count and total of transactions which we don't yet have when we
write the header.  As we are limited to 200 transactions per file, the easiest way of doing
this is to have an array[1..200] of payment records, add data to the array during the
writerec method, then write to file either when we reach 200 records or when contra is called.}

interface

uses
  ExpObj, Hex01, CustAbsU, Classes;

type

  THexagonExportObject = Class(TExportObject)
    protected
      HeaderRec    : THexFileHeaderRec;
      ContraRec    : THexBalanceHeader;
      FileCount    : integer;
      FilePrefix   : string;
      PayLines     : Array[1..MaxPayLines] of THexPaymentRec;
      PayCount     : Word;
      PayValue     : longint;
      ContraCount  : integer;
      FileList     : TStringList;
      procedure InitialiseHeader(const EventData : TAbsEnterpriseSystem); virtual;
      procedure InitialiseContra(const EventData : TAbsEnterpriseSystem);
      function WriteBatch(const EventData : TAbsEnterpriseSystem) : Boolean; virtual;
      function NewFile(const EventData : TAbsEnterpriseSystem) : Boolean;
      function CloseExportFile : integer;
    public
      constructor Create(const EventData : TAbsEnterpriseSystem);
      destructor Destroy; override;
      function CreateOutFile(const AFileName : string;
                             const EventData :
                             TAbsEnterpriseSystem) : integer; override;
      function CloseOutFile : integer; override;
      function WriteRec(const EventData : TAbsEnterpriseSystem;
                           Mode : word) : Boolean; override;
      function GetDate(const ADate : string) : string;
      procedure CompletionMessage(const EventData : TAbsEnterpriseSystem); override;
    end;

var
  HexagonExportObject : THexagonExportObject;


implementation

uses
  SysUtils;

constructor THexagonExportObject.Create(const EventData : TAbsEnterpriseSystem);
begin
  inherited Create;
  FileList := TStringList.Create;
  FileCount := 0;
  PayCount := 0;
  PayValue := 0;
  ContraCount := 0;
  InitialiseHeader(EventData);
  InitialiseContra(EventData);
end;

destructor THexagonExportObject.Destroy;
begin
  if Assigned(FileList) then
    FileList.Free;
  inherited Destroy;
end;


function THexagonExportObject.CreateOutFile(const AFileName : string;
                                            const EventData :
                                      TAbsEnterpriseSystem) : integer;
begin
  FilePrefix := RequiredPath + Copy(FileNameOnly(AFilename), 1, 3);
  Result := 0; {Files are opened in WriteBatch method}
end;



procedure THexagonExportObject.InitialiseHeader(const EventData : TAbsEnterpriseSystem);
begin
  FillChar(HeaderRec, SizeOf(HeaderRec), 0);
  with HeaderRec do
  begin
    GetEventData(EventData);
    Count       := 1;     {number of payments in file}
    TotalValue  := 0;     {value of all payments}
    if ProcControl.PayCurr[1] <> '�' then  {is there a better way of doing this?}
       Currency := 'EUR'
    else
       Currency := 'GBP';
  end;
end;



function THexagonExportObject.NewFile(const EventData : TAbsEnterpriseSystem) : Boolean;
{create and open files: FilePrefix + FileCount + Ext. Increment file count}
var
  FName : string;
begin
  inc(FileCount);
  if FileCount > MaxFiles then
  begin
    ShowExportMessage('Error','Maximum number of files reached', 'Run aborted');
    Result := False;
  end
  else
  begin
    FName := FilePrefix + ZeroesAtFront(FileCount, 5);
    Result := (inherited CreateOutFile(FName + DefaultExt, EventData) = 0);
  end;
end;

procedure THexagonExportObject.InitialiseContra(const EventData : TAbsEnterpriseSystem);
begin
  GetEventData(EventData);
  with EventData, ContraRec do
  begin
     CoAcc      := UserBankAcc;
     ValDate    := GetDate(ProcControl.PDate);
     Descript   := 'BACS/' + IntToStr(ProcControl.PayRun);
     PCount     := 0;
     PTotal     := 0;
  end;
  PayCount := 1;
  PayValue := 0;
  Inc(ContraCount);
  if not AllDigits(ContraRec.ValDate) then
  begin
    ShowExportMessage('Error','Invalid Windows date format','Run aborted');
    EventData.BoResult := False;
    Failed := flDate;
  end;
end;


function THexagonExportObject.WriteRec(const EventData : TAbsEnterpriseSystem;
                                                  Mode : word) : Boolean;
var
  Target : TAbsCustomer;
begin
  Result := True;
  Target := GetTarget(EventData);
  if Mode = wrContra then
  begin
    GetEventData(EventData);
    ContraRec.Descript   := 'BACS/' + IntToStr(ProcControl.PayRun);
    if ContraRec.PCount > 0 then
      Result := WriteBatch(EventData);
  end
  else
  begin
    with EventData, PayLines[PayCount] do
    begin
      DestAcc    := Target.acBankAcc;
      DestSort   := Target.acBankSort;
      DestName   := Target.acCompany;
      Amount     := Pennies(Transaction.thTotalInvoiced);
      if not IsBlank(Bacs_Safe(Target.acBankRef)) then
        PayDescrip := Bacs_Safe(Target.acBankRef)
      else
        PayDescrip := Transaction.thOurRef + '/' + IntToStr(ProcControl.PayRun);

      ContraRec.PTotal := ContraRec.PTotal + Amount;
      TotalPenceWritten := TotalPenceWritten + Amount;
    end;
    inc(TransactionsWritten);
    ContraRec.PCount := PayCount;
    inc(PayCount);
    if PayCount > MaxPayLines then
    begin
      Result := WriteBatch(EventData);
    end;
  end; {with}
end;

function THexagonExportObject.WriteBatch(const EventData : TAbsEnterpriseSystem): boolean;
var
  OutString : string;
  i : integer;
begin
{$I-}
  Result := NewFile(EventData); {opens new out file}
  if not Result then
    Exit;
  FileList.Add('  ' + OutFileName);

  with HeaderRec do
  begin
    Count := 1;
    TotalValue := TotalPenceWritten;

    OutString := tagContras + IntToStr(Count) + CR +
                 tagTotal + Pounds(TotalValue) +
                 tagCurrency + Currency + CR;
    Write(OutFile, OutString);
  end;

  with ContraRec do
  begin
    Descript   := 'BACS/' + IntToStr(ProcControl.PayRun);

    OutString := tagStartBalance + CR +
                 tagCoAcc + CoAcc + CR +
                 tagValDate + ValDate + CR +
                 tagDescript + Descript + CR +
                 tagPayCount + IntToStr(PCount) + CR +
                 tagPayTotal + Pounds(PTotal) + CR;
    Write(OutFile, OutString);
  end;
  Result := (IOResult = 0);
  If Result then
  begin
    for i := 1 to ContraRec.PCount do
    begin
      with PayLines[i] do
      begin
        OutString := tagStartPay + CR +
                     tagDestAcc + DestAcc + CR +
                     tagDestSort + DestSort + CR +
                     tagDestName + DestName + CR +
                     tagAmount + Pounds(Amount) + CR +
                     tagPayDescript + PayDescrip + CR +
                     tagEndPay + CR;
        Write(OutFile, OutString);
      end; {with}
    end; {for i}

    Result := (IOResult = 0);
    If Result then
      Write(Outfile, tagEndBalance + CR);
    Result := (IOResult = 0);
    if Result then
      Result := (inherited CloseOutFile = 0);
  end;
  InitialiseHeader(EventData);
  InitialiseContra(EventData);

end; {write batch}


function THexagonExportObject.GetDate(const ADate : string) : string;
var
  TempString,
  StoreDateFormat    : string;
  StoreDateSeparator : char;
  DateInQuestion : TDateTime;
  i : integer;
begin
{date comes in as yyyymmdd and we need to convert it to a string using windows format
(but can't be more than 6 chars). Let's assume for simplicity that the options in windows
are either dd/mm/yy, dd/mm/yyyy, mm/dd/yy and mm/dd/yyyy. I think that we can reasonably
expect users to use one of these}
  StoreDateFormat := ShortDateFormat;
  StoreDateSeparator := DateSeparator;
  ShortDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  TempString := Copy(ADate, 7, 2) + '/' +
                Copy(ADate, 5, 2) + '/' +
                Copy(ADate, 1, 4);
  Try
    DateInQuestion := StrToDate(TempString);
  Except
    DateInQuestion := 0;
  End;

  ShortDateFormat := StoreDateFormat;
  DateSeparator := StoreDateSeparator;

  if DateInQuestion > 0 then
  begin
    Result := DateToStr(DateInQuestion);

    i := Pos('yyyy', ShortDateFormat);
    if i > 0 then
      Delete(Result, i, 2);

    i := 1;
    while i < Length(Result) do
      if not IsDigit(Result[i]) then
        Delete(Result, i, 1)
      else
        inc(i);

    if Length(Result) <> 6 then
      Result := 'N/A';
  end
  else
    Result := 'N/A';

end;

procedure THexagonExportObject.CompletionMessage(const EventData : TAbsEnterpriseSystem);
var
  ReportMemo : TStringList;
  TotalValue : Real;
begin
  if Failed = 0 then
  with EventData do
  begin
     ReportMemo := TStringList.Create;
     Try
       ReportMemo.Add(Setup.ssUserName);
       ReportMemo.Add('Batch processing run no. ' + IntToStr(ProcControl.PayRun));
       ReportMemo.Add('');
       ReportMemo.Add('Total number of transactions: ' + IntToStr(TransactionsWritten));
       TotalValue := TotalPenceWritten / 100;
       ReportMemo.Add('Value: ' + TrimRight(ProcControl.PayCurr) +
            Format('%.2n',[TotalValue]));
       ReportMemo.Add('');

       ReportMemo.Add('Batch process completed successfully');
       ReportMemo.Add('Written to files: ');
       ReportMemo.AddStrings(FileList);
       ReportMemo.Add('');
       ReportMemo.Add('Press ''Close'' to continue printing reports');
       ShowExportReport('Batch processing run no. ' + IntToStr(ProcControl.PayRun),
                         ReportMemo);
     Finally
      ReportMemo.Free;
     End;
  end;
end;

function THexagonExportObject.CloseOutFile : integer;
begin
  Result := 0; {closing files is done in the WriteBatch method}
end;

function THexagonExportObject.CloseExportFile : integer;
begin
  Result := inherited CloseOutFile;
end;



end.
