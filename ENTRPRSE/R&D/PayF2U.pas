Unit PayF2U;

{$I DEFOVR.Inc}

{**************************************************************}
{                                                              }
{             ====----> E X C H E Q U E R <----===             }
{                                                              }
{                      Created : 07/08/90                      }
{                                                              }
{                 Common Non-Overlaid Unit                     }
{                                                              }
{               Copyright (C) 1990 by EAL & RGS                }
{        Credit given to Edward R. Rought & Thomas D. Hoops,   }
{                 &  Bob TechnoJock Ainsbury                   }
{**************************************************************}


Interface

Uses
  Classes,
  GlobVar,
  VarConst,
  ETMiscU,
  SBSOutL,
  ExBtTh1U;


Const
  //HV 29/03/2016 2016-R2 ABSEXCH-17052: �Copy Last year actual and adjust on the traders record bring back zero or a random value 
  AdvBudgetNSet
           =  [NomHedCode,CtrlNHCode,BankNHCode,CarryFlg,PLNHCode,CustHistCde];

  AdvBudgetSSet
           =  [StkGrpCode,StkStkCode,StkDescCode,StkBillCode];


  AdvBudgetSet
           =  AdvBudgetNSet+AdvBudgetSSet+[ViewBalCode,ViewHedCode];

  ModeSet  =  [StkGrpCode,NomHedCode];



{$IFDEF PF_On}

type
  TUpBudget=  Object(TThreadQueue)

                     private
                       UMode    :  Byte;
                       BKeyRef  :  Str255;

                       ScanFileNum,
                       SKeypath :  SmallInt;

                       ItemTotal1,
                       ItemCount:  LongInt;

                       UStk     :  StockRec;
                       UNom     :  NominalRec;

                       CCNomFilt
                                :   CCNomFiltType;

                       CCNomMode
                                :   Boolean;
                       StkLocFilt
                                :   Str10;

                       GLViewMode
                                :  Boolean;
                       GLViewRec
                                :  NomViewRec;

                     public
                       Constructor Create(AOwner  :  TObject);

                       Destructor  Destroy; Virtual;


                       Function Set_NHist( NRec  :  NominalRec;
                                           SRec  :  StockRec;
                                           Mode,
                                           AltOn :  Boolean)  :  Str255;

                       Procedure FillBudget(NKey  :  Str255);

                       Procedure Reset_BHeadings(HCode  :  Char);

                       {$IFDEF MC_On}
                         Procedure Calc_L0Budget(NKey       :  Str255);
                       {$ENDIF}

                       Procedure Update_ParentBudget(LowKey,
                                                     HiKey      :  Str255;
                                                     Add2Total  :  Boolean);

                       Procedure Update_GlobalBudgets(NKey       :  Str255;
                                                      AutoOn     :  Boolean);

                       Procedure Process_ProfileUpdate(NKey       :  Str255);

                       Procedure Scan_BudgetTree(Fnum,
                                                 Keypath    :  Integer;
                                                 ProMode    :  Boolean;
                                            Var  NoAbort    :  Boolean);

                       Procedure Process; Virtual;
                       Procedure Finish;  Virtual;

                       Function Start(KeyRef  :  Str255;
                                      Fnum,
                                      Keypath :  SmallInt;
                                      NomR      :  NominalRec;
                                      StkR      :  StockRec;
                                      GLVR      :  NomViewRec;
                                      NomNHCtrl :  TNHCtrlRec)  :  Boolean;


                   end; {Class..}

    TRollUpBudget = Object(TUpBudget)
                    private
                      RollBasis,  {0 = CC, 1= Dep, 2 = CC + Dep independant, 3 = CC/Dep Combined}
                      UpBudget    {0 = Update orig + Revised, 1 = Orig, 2 = Revised, 3 = Orig=rev , update rev }
                                 :  Byte;

                      CostCentreList : TStringList;
                      DepartmentList : TStringList;

                      Procedure LoadCCDeptCacheList (Var CacheList : TStringList; Const CostCentres, LoadData : Boolean);
                      Procedure BuildCostCentreCache (Const LoadCostCentres : Boolean);
                      Procedure BuildDepartmentCache (Const LoadDepartments : Boolean);
                    public
                      Constructor Create(AOwner  :  TObject);

                      Destructor  Destroy; Virtual;


                      Procedure Process; Virtual;
                      Procedure Finish;  Virtual;

                      Procedure RollUpThisNom(ThisNom  :  NominalRec);

                      Procedure Scan_RollUp(ThisNomCat  :  LongInt);

                      Function Start(NomR      :  NominalRec;
                                     RB,UB     :  Byte)  :  Boolean;

                    End; // TRollUpBudget

    Procedure RollUpBudget2Thread(AOwner    :  TObject;
                                  Mode,
                                  RollM,
                                  UM        :  Byte;
                                  NomR      :  NominalRec);



{$ENDIF}


Function Check_DocChanges(OInv,InvR  :  InvRec) : Boolean;


Function PRequired(Const UseRBaseEQ  :  Boolean;
                   Const InvR        :  InvRec)  :  Real;


Function Get_StkProdTime(SCode  :  Str10)  :  LongInt;

Procedure Calc_BillCost(QtyUsed,
                        QtyCost  :  Real;
                        Mode     :  Boolean;
                    Var StockR   :  StockRec;
                        BuildTime:  LongInt);

Function HeadCode(NRec  :  NominalRec;
                    SRec  :  StockRec;
                    Mode  :  Boolean)  :  Char;

{Function Set_NHist( NRec  :  NominalRec;
                    SRec  :  StockRec;
                    Mode,
                    AltOn :  Boolean)  :  Str255;}


{$IFDEF PF_On}

  Procedure AddUpBudget2Thread(AOwner    :  TObject;
                             Mode      :  Byte;
                             KeyRef    :  Str255;
                             Fnum,
                             Keypath   :  SmallInt;
                             NomR      :  NominalRec;
                             StkR      :  StockRec;
                             GLVR      :  NomViewRec;
                             NomNHCtrl :  TNHCtrlRec);



{$ENDIF}


{$IFDEF STK}
  Function Stk_InGroup(StkGroup  :  Str20;
                       StockR    :  StockRec)  :  Boolean;

  {$IFDEF SOP}
    Function Check_OverCommited(Line,OldLine
                                          :  IDetail;
                                ShowMsg   :  Boolean)  :  Boolean;
  {$ENDIF}
{$ENDIF}


{$IFDEF WOP}

  Procedure UpdateWORCost(Var LInv  :  InvRec;
                              LId   :  IDetail;
                              Mode  :  Byte);
{$ENDIF}

procedure Check_OtherDocs(Var  LInv  :  InvRec;
                               Mode  :  Byte);

procedure RSynch_PayFromTo(Var  LInv  :  InvRec;
                                Mode  :  Byte);


//PR: 16/05/2016 ABSEXCH-17353 Function to return total of absolute values of values passed in
function AbsTotal(const Values : Array of Real) : Real;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Implementation

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Uses
     Forms,
     Controls,
     Dialogs,
     ETStrU,
     ETDateU,
     BtrvU2,
     BTKeys1U,
     VarRec2U,
     ComnUnit,
     ComnU2,
     SalTxL1U,
     CurrncyU,
     InvLst2U,
     BTSupU1,
     SysU1,
     SysU2,
     SysUtils,
     MiscU,
     Warn1U,

     {$IFDEF JC}
       JobSup2U,
     {$ENDIF}

  {$IFDEF EXSQL}
    SQLUtils,
  {$ENDIF}

     SavePos,
     InvFSu3U,
     ExThrd2U,
     Event1U,

     Windows,
     oProcessLock;

function AbsTotal(const Values : Array of Real) : Real;
var
  i : integer;
begin
  Result := 0;
  for i := Low(Values) to High(Values) do
    Result := Result + Abs(Values[i]);
end;

{ ========= Procedure to update any changes to Doc Headers on to their lines ========= }

Function Check_DocChanges(OInv,InvR  :  InvRec) : Boolean;

Const
  Fnum     =  IDetailF;
  Keypath  =  IDFolioK;


Var
  KeyS,
  KeyChk   :  Str255;

  LRecAddr :  LongInt;



Begin
  Result := False;
  If (OInv.TransDate<>InvR.TransDate) or
     (OInv.AcYr<>InvR.AcYr) or
     (OInv.AcPr<>InvR.AcPr) or
     (OInv.CustCode<>InvR.CustCode) or
     ((OInv.DueDate<>InvR.DueDate) and (InvR.InvDocHed=WOR)) or
     ((OInv.PDiscTaken<>InvR.PDiscTaken) and (SyssJob^.JobSetUp.JADelayCert) and (InvR.InvDocHed In [JPA,JSA]) and (JBCostOn)) or
     (OInv.CXRate[BOn]<>InvR.CXRate[BOn]) then

  Begin

    KeyChk:=FullNomKey(InvR.FolioNum);

    KeyS:=KeyChk;

    Status:=Find_Rec(B_GetGEq,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);

    While (StatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOn)) do
    Begin

      Ok:=GetMultiRecAddr(B_GetDirect,B_MultLock,KeyS,KeyPath,Fnum,BOn,GlobLocked,LRecAddr);

      If (Ok) and (GlobLocked) then
      With Id do
      Begin

        CustCode:=InvR.CustCode;

        {* Do not change all currencies as mixed variance lines would otherwise be destroyed. *}

        If (Id.Currency=InvR.Currency) then {* Only change lines of same currency as header *}
          CXRate[BOn]:=InvR.CXRate[BOn];

        PPr:=InvR.AcPr;

        PYr:=InvR.AcYr;

        {* Do not alter Pdate on these, as they are independant *}
        If (Not (IdDocHed In OrderSet+WOPSPlit)) and ((SOPLink=0) or (Not (IdDocHed In SalesSplit+PurchSplit))) and (PDate<>InvR.TransDate) then
        Begin
          PDate:=InvR.TransDate;
        end
        else
          If (IdDocHed In [WOR]) and (PDate<>InvR.DueDate) then
            PDate:=InvR.DueDate;

        
        {$IFDEF PF_On}

          If (JbCostOn) {and (NetValue<>0)} and ((KitLink=0) or (IdDocHed in [ADJ])) then
            Update_JobAct(Id,InvR);

        {$ENDIF}
         
        Status:=Put_Rec(F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath);

        If (StatusOk) then
        Begin
          //GS
          Result := True;
          Status:=UnLockMultiSing(F[Fnum],Fnum,LRecAddr);

          Report_BError(Fnum,Status);

          {$IFDEF JC}
            If ((OInv.PDiscTaken<>InvR.PDiscTaken) and (SyssJob^.JobSetUp.JADelayCert) and (InvR.InvDocHed In [JPA,JSA]) and (JBCostOn)) then
            Begin
              Update_JTLink(Id,OInv,BOn,BOn,Fnum,IdLinkK,Keypath,0);

              Update_JTLink(Id,InvR,BOff,BOn,Fnum,IdLinkK,Keypath,0);
            end;
          {$ENDIF}

        end;

      end; {If Ok to Use..}

      Status:=Find_Rec(B_GetNext,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);

    end; {While..}
  end; {If Not Changed..}

end; {Proc..}


{ ============== Function to Return Amount Required for Exit ============== }

Function PRequired(Const UseRBaseEQ  :  Boolean;
                   Const InvR        :  InvRec)  :  Real;

Var
 DRnum  :  Real;

Begin
  With InvR do
    If (UseRBaseEq) then            {* Altered to rounding on v4.30 as PPI $75@16.$/� wrong *&}
      DRnum:=(ConvCurrITotal(InvR,BOff,BOff,BOn)-TotalInvoiced)
    else
      DRnum:=(ConvCurrITotal(InvR,BOff,BOff,BOff)-TotalOrdered);

  PRequired:=DRnum;
end;


{ == Protected function to return production time == }
{ Replicated within ReValueU }

Function Get_StkProdTime(SCode  :  Str10)  :  LongInt;

Const
    Fnum     =  StockF;
    Keypath  =  StkFolioK;


Var
  StockR  :  StockRec;
  TmpKPath,
  LocalStat,
  TmpStat :  Integer;

  TmpRecAddr
          :  LongInt;

  KeyS    :  Str255;


Begin
  StockR:=Stock;

  TmpKPath:=GetPosKey;

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpRecAddr,BOff,BOff);


  If (FullNomKey(Stock.StockFolio)<>SCode) then
  Begin
    KeyS:=SCode;

    LocalStat:=Find_Rec(B_GetEq,F[Fnum],Fnum,RecPtr[Fnum]^,Keypath,KeyS);

    If (LocalStat<>0) then
      ResetRec(Fnum);

  end;


  Result:=Stock.ProdTime;

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpRecAddr,BOn,BOff);

  Stock:=StockR;
end;

{ ============ Procedure to Calculate Cost Price ============ }


Procedure Calc_BillCost(QtyUsed,
                        QtyCost  :  Real;
                        Mode     :  Boolean;
                    Var StockR   :  StockRec;
                        BuildTime:  LongInt);


  Var
    DCnst  :  Integer;

  Begin

    If (Mode) then
      DCnst:=1
    else
      DCnst:=-1;


    With StockR do
    Begin

      {$IFDEF STK}
        If (FIFO_Mode(StkValType)=4) then 
        Begin
          {$IFDEF MC_On}
            If (PCurrency<>ROCurrency) then
            Begin
              QtyCost:=Round_UP(Currency_ConvFT(QtyCost,PCurrency,ROCurrency,UseCoDayRate),Syss.NoCosDec);
            end;
          {$ENDIF}

          ROCPrice:=(ROCPrice+((QtyUsed*QtyCost)*DCnst))
        end
        else
      {$ENDIF}

        CostPrice:=(CostPrice+((QtyUsed*QtyCost)*DCnst));

    end; {With..}

    If (StockR.CalcProdTime) then {We also need to update the total production time}
    Begin
      StockR.BOMProdTime:=StockR.BOMProdTime+(BuildTime*DCnst);
    end;

  end; {Proc..}



  { ======= Return appropriate Type Code ======= }

  Function HeadCode(NRec  :  NominalRec;
                    SRec  :  StockRec;
                    Mode  :  Boolean)  :  Char;


  Begin

    Case Mode of

      BOff  :  HeadCode:=SRec.StockType;
      BOn   :  HeadCode:=NRec.NomType;
      else
        raise Exception.Create('Unicorn alert'); //PR: 22/03/2016 v2016 R2 ABSEXCH-17390

    end; {Case..}

  end; {Func..}



  

{$IFDEF PF_On}

{ ========== TUpBudget methods =========== }

  Constructor TUpBudget.Create(AOwner  :  TObject);

  Begin
    Inherited Create(AOwner);

    fTQNo:=1;
    fCanAbort:=BOn;

    fOwnMT:=BOn; {* This must be set if MTExLocal is created/destroyed by thread *}

    MTExLocal:=nil;

    CCNomMode:=BOff;

    FillChar(CCNomFilt,Sizeof(CCNomfilt),0);

    StkLocFilt:='';

  end;

  Destructor TUpBudget.Destroy;

  Begin
    //PR: 23/05/2017 ABSEXCH-18683 v2017 R1 Release process lock
    if Assigned(Application.Mainform) then
      SendMessage(Application.MainForm.Handle, WM_LOCKEDPROCESSFINISHED, Ord(plRollUpGLBudgets), 0);

    Inherited Destroy;
  end;



{ ====== Function to set full NHist Key ====== }


  Function TUpBudget.Set_NHist( NRec  :  NominalRec;
                                SRec  :  StockRec;
                                Mode,
                                AltOn :  Boolean)  :  Str255;

  Var
    NCode  :  Char;

  Begin

    Case Mode of
      {$IFDEF STK}
        BOff  :  With SRec do
                 Begin
                   If (AltOn) then
                     Ncode:=Calc_AltStkHCode(StockType)
                   else
                     NCode:=StockType;

                   Set_NHist:=FullNHistKey(NCode,CalcKeyHist(StockFolio,StkLocFilt),0,GetLocalPr(0).CYr,1);
                 end;
      {$ENDIF}

      BOn  :  With NRec do
              Begin
                If (AltOn) then
                  Ncode:=Calc_AltStkHCode(NomType)
                else
                  NCode:=NomType;

                Set_NHist:=FullNHistKey(Ncode,CalcCCKeyHistP(NomCode,CCNomMode,CCNomFilt[CCNomMode]),0,GetLocalPr(0).CYr,1);
              end;
    end; {case..}


    If (GLViewMode) then
    With MTExLocal^.LNomView^.NomViewLine do
    Begin
      Set_NHist:=FullNHistKey(ViewType,PostNVIdx(NomViewNo,ABSViewIdx),0,GetLocalPr(0).CYr,1);

    end;
  end; {Func..}



  { ============ Procedure to Create any Blank history records ============ }

Procedure TUpBudget.FillBudget(NKey  :  Str255);

Var
  n      :  Byte;

Begin

  With MTExLocal^ do
  Begin
    n:=0;

    LFillBudget(ScanFileNum,SKeyPath,n,NKey);

    {LResetRec(ScanFileNum);  v5.01 call the main thread routine as it adds in the ytd record as well.

    Extract_NHistfromNKey(NKey,LNHist);

    With LNHist do
    For n:=1 to Syss.PrinYr do
      If (Not LCheckExsists(FullNHistKey(ExClass,Code,Cr,GetLocalPr(0).CYr,n),ScanFileNum,SKeyPath)) then
        LAdd_NHist(ExClass,Code,Cr,GetLocalPr(0).CYr,n,ScanFileNum,SKeyPAth);}

  end;

end; {Proc..}




  { ========== Procedure to reset all Headings prior to an update ======= }

  Procedure TUpBudget.Reset_BHeadings(HCode  :  Char);

  Const
    Fnum      =  NHistF;
    Keypath   =  NHK;


  Var
    KeyS,
    KeyChk    :  Str255;

    LOk,
    Locked    :  Boolean;

    ftLen     :  Byte;

    LastStatus
           :  Integer;

    ChkFilt,
    CCDDMode,
    SMode  :  Boolean;

    Filt2Chk,
    CCDepChk
           :  Str10;



  Begin

    LastStatus:=0;


    KeyChk:=HCode;

    KeyS:=HCode;

    If (GLViewMode) then
      KeyS:=KeyS+#1+#1+FullNomKey(GLViewRec.NomViewLine.NomViewNo);

    Filt2Chk:='';
    CCDepChk:='';
    ChkFilt:=BOff;
    ftLen:=ccKeyLen;
    CCDDMode:=BOff;

    SMode:=(HCode=NomHedCode);

    Case SMode of
      BOff  :  Begin
                 If (Not EmptyKey(StkLocFilt,MLocKeyLen)) and (Syss.UseMLoc) then
                 Begin
                   ChkFilt:=BOn;
                   Filt2Chk:=StkLocFilt;
                 end;
               end;

      BOn   :  Begin
                 If (Syss.PostCCNom) and (Syss.UseCCDep) and (Not EmptyKeyS(CCNomFilt[CCNomMode],ccKeyLen,BOff)) then
                 Begin
                   ChkFilt:=BOn;
                   Filt2Chk:=CCNomFilt[CCNomMode];
                   CCDepChk:=CSubCode[CCNomMode];
                   ftLen:=Length(Filt2Chk);

                   If (ftLen<ccKeyLen) then  {* incase of short codes, we must check at least 3 chars *}
                     ftLen:=ccKeyLen;

                   CCDDMode:=(ftLen>ccKeyLen); {* We are in combined mode *}
                 end;

               end;

    end; {Case..}



    Locked:=BOff;

    With MTEXLocal^ do
    Begin
      LStatus:=LFind_Rec(B_GetGEq,Fnum,keypath,KeyS);

      ItemCount:=Round(ItemTotal1*0.05);

      UpdateProgress(ItemCount);

      While (LStatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOff)) and (Not ThreadRec^.THAbort) do
      With LNHist do
      Begin


        {* Blank this years totals only, and check for filters *}
        If (Yr=GetLocalPr(0).CYr) and (((ChkFilt) and (CheckKey(Filt2Chk,Copy(Code,6,ftLen),ftLen,BOff))
                           and (CheckKey(CCDepChk,Copy(Code,1,1),Length(CCDepChk),BOff)) and
                           ((Not (Code[9] In [#1,#2])) or CCDDMode) and
                           ((Not (Code[1] In [CSubCode[BOff],CSubCode[BOn]]) and (Length(Code)>4)) or ChkFilt or (HCode<>NomHedCode)))
                           or ((Not ChkFilt) and (Length(Strip('R',[#32],Code))<>8)  and (Not (Code[1] In [CSubCode[BOff],CSubCode[BOn]])) and (Length(Code)>4) )) then
                                                                                               {* This section added so that when updating all budgets headdings unfiltered by cc/dept, any existing
                                                                                                  filtered budgets are not reset *}
        Begin
          // MH 25/01/2011 v6.6 ABSEXCH-10770: Added check to improve performance
          //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
          If (Budget <> 0) Or (AbsTotal([RevisedBudget1, RevisedBudget2, RevisedBudget3, RevisedBudget4,
                               RevisedBudget5]) <> 0) Then
          Begin
            LOk:=LGetMultiRec(B_GetDirect,B_MultLock,KeyS,KeyPath,Fnum,BOn,Locked);

            If (LOk) and (Locked) then
            Begin
              LGetRecAddr(Fnum);

              Budget:=0;

              RevisedBudget1:=0.0;

              //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
              RevisedBudget2:=0.0;
              RevisedBudget3:=0.0;
              RevisedBudget4:=0.0;
              RevisedBudget5:=0.0;

              LStatus:=LPut_Rec(Fnum,Keypath);


              If (LastStatus=0) then
                LastStatus:=LStatus;

              LStatus:=LUnLockMLock(Fnum);

            end;
          End; // If (Budget <> 0) Or (Budget2 <> 0)
        end;

        LStatus:=LFind_Rec(B_GetNext,Fnum,Keypath,KeyS);


      end; {While..}

      LReport_BError(Fnum,LastStatus);
    end; {With.}

    ItemCount:=Round(ItemTotal1*0.25);

  end; {Proc..}


{$IFDEF MC_On}

  { ============ Procedure to Update Level 0 with Other currency Budgets ============ }

  Procedure TUpBudget.Calc_L0Budget(NKey       :  Str255);



  Var
    Cn,n   :  Byte;




    PerPr,
    PerPr2 :  Real;

    KeyS   :  Str255;

    LOk,
    Locked,
    BeenFilled
           :  Boolean;

    LastStatus
           :  Integer;

    BeenThere
           :  Array[1..99] of Boolean;

    //PR: 10/05/2016 ABSEXCH-17353 Variable for extra revised budgets
    Revised  :  Array[2..5] of Real;

  Begin

    LastStatus:=0;

    Blank(BeenThere,Sizeof(BeenThere));

    Locked:=BOff;  BeenFilled:=BOff;

    With MTExLocal^ do
    Begin
      Extract_NHistfromNKey(NKey,LNHist);

      For Cn:=1 to CurrencyType do
        // MH 25/01/2011 v6.6 ABSEXCH-10770: Added check on whether currency in used to improve performance
        If IsCurrencyUsed(Cn) Then
          For n:=1 to Syss.PrinYr do
            With LNHist do
            Begin

              KeyS:=FullNHistKey(ExClass,Code,Cn,GetLocalPr(0).CYr,n);

              LStatus:=LFind_Rec(B_GetEq,ScanFileNum,Skeypath,KeyS);

              If (LStatusOk) and (AbsTotal([LNHist.Budget, LNHist.RevisedBudget1,
                                  LNHist.RevisedBudget2, LNHist.RevisedBudget3,
                                  LNHist.RevisedBudget4, LNHist.RevisedBudget5]) <> 0) then
              Begin


                PerPr:=Currency_ConvFT(LNHist.Budget,Cr,0,UseCoDayRate);
                PerPr2:=Currency_ConvFT(LNHist.RevisedBudget1,Cr,0,UseCoDayRate);

                //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                Revised[2] := Currency_ConvFT(LNHist.RevisedBudget2,Cr,0,UseCoDayRate);
                Revised[3] := Currency_ConvFT(LNHist.RevisedBudget3,Cr,0,UseCoDayRate);
                Revised[4] := Currency_ConvFT(LNHist.RevisedBudget4,Cr,0,UseCoDayRate);
                Revised[5] := Currency_ConvFT(LNHist.RevisedBudget5,Cr,0,UseCoDayRate);

                KeyS:=FullNHistKey(ExClass,Code,0,GetLocalPr(0).CYr,n);

                If (Not BeenFilled) then
                Begin
                  BeenFilled:=BOn;

                  FillBudget(KeyS);

                end;

                LOk:=LGetMultiRec(B_GetEQ,B_MultLock,KeyS,SKeyPath,ScanFileNum,BOn,Locked);

                If (LOk) and (Locked) then
                Begin
                  LGetRecAddr(ScanFileNum);

                  If (Not BeenThere[n]) then {* Zero level 0 budgets initially *}
                  Begin
                    Budget:=0;

                    RevisedBudget1:=0.0;

                    //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                    RevisedBudget2:=0.0;
                    RevisedBudget3:=0.0;
                    RevisedBudget4:=0.0;
                    RevisedBudget5:=0.0;

                  end;

                  BeenThere[n]:=BOn;

                  Budget:=Budget+PerPr;
                  RevisedBudget1:=RevisedBudget1+PerPr2;

                  //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                  RevisedBudget2:=RevisedBudget2 + Revised[2];
                  RevisedBudget3:=RevisedBudget3 + Revised[3];
                  RevisedBudget4:=RevisedBudget4 + Revised[4];
                  RevisedBudget5:=RevisedBudget5 + Revised[5];

                  LStatus:=LPut_Rec(ScanFileNum,SKeypath);


                  If (LastStatus=0) then
                    LastStatus:=LStatus;

                  LStatus:=LUnLockMLock(ScanFileNum);
                End; // If (LOk) and (Locked)
              End; // If (LStatusOk) and (LNHist.Budget+LNHist.Budget2 <>0)
            End; // With LNHist

      LReport_BError(ScanFileNum,LastStatus);
    end; {with..}

  end; {Proc..}

{$ENDIF}

  { ============ Procedure to Update all Parent with lower budget records  ============ }

  Procedure TUpBudget.Update_ParentBudget(LowKey,
                                          HiKey      :  Str255;
                                          Add2Total  :  Boolean);

  Var
    Cn,n,
    Ce    :  Byte;




    PerPr,
    PerPr2 :  Real;

    //PR: 10/05/2016 ABSEXCH-17353 Variable for extra revised budgets
    Revised  :  Array[2..5] of Real;

    KeyS   :  Str255;

    BeenWarned,
    BeenFilled,
    LOk,
    Locked :  Boolean;

    LowHist,
    HiHist :  HistoryRec;

    LastStatus
           :  Integer;



  Begin

    LastStatus:=0;


    Locked:=BOff;

    Extract_NHistfromNKey(Lowkey,LowHist);

    Extract_NHistfromNKey(Hikey,HiHist);


    {$IFDEF MC_On}

      Ce:=CurrencyType;


    {$ELSE}

      Ce:=0;

    {$ENDIF}

    BeenWarned:=BOff;

    With MTeXLocal^ do
    Begin
      For Cn:=0 to Ce do
      Begin
        // MH 25/01/2011 v6.6 ABSEXCH-10770: Added check on whether currency in used to improve lamentable performance
        If IsCurrencyUsed(Cn) Then
        Begin
          BeenFilled:=BOff;

          For n:=1 to Syss.PrinYr do
          Begin
            If (THreadRec^.THAbort) and (Not BeenWarned) then
            Begin
              ShowStatus(3,'Please Wait, finishing current budget.');

              BeenWarned:=BOn;

            end;

            With LowHist do
              KeyS:=FullNHistKey(ExClass,Code,Cn,GetLocalPr(0).CYr,n);

            LStatus:=LFind_Rec(B_GetEq,ScanFileNum,Skeypath,KeyS);

            If (LStatusOk) and (LNHist.Budget+LNHist.RevisedBudget1<>0) then
            Begin


              PerPr:=LNHist.Budget;
              PerPr2:=LNHist.RevisedBudget1;

              //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
              Revised[2] := LNHist.RevisedBudget2;
              Revised[3] := LNHist.RevisedBudget3;
              Revised[4] := LNHist.RevisedBudget4;
              Revised[5] := LNHist.RevisedBudget5;


              If (Not BeenFilled) then  {* Add any missing budgets *}
              Begin
                BeenFilled:=BOn;

                With HiHist do
                  HiKey:=FullNHistKey(ExClass,Code,Cn,GetLocalPr(0).CYr,n);

                FillBudget(HiKey);

              end;

              With HiHist do
                KeyS:=FullNHistKey(ExClass,Code,Cn,GetLocalPr(0).CYr,n);

              LOk:=LGetMultiRec(B_GetEQ,B_MultLock,KeyS,SKeyPath,ScanFileNum,BOn,Locked);

              If (LOk) and (Locked) then
              Begin

                LGetRecAddr(ScanFilenum);

                If (Add2Total) then
                Begin
                  LNHist.Budget:=LNHist.Budget+PerPr;
                  LNHist.RevisedBudget1:=LNHist.RevisedBudget1+PerPr2;

                  //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                  LNHist.RevisedBudget2 := LNHist.RevisedBudget2 + Revised[2];
                  LNHist.RevisedBudget3 := LNHist.RevisedBudget3 + Revised[3];
                  LNHist.RevisedBudget4 := LNHist.RevisedBudget4 + Revised[4];
                  LNHist.RevisedBudget5 := LNHist.RevisedBudget5 + Revised[5];

                end
                else
                Begin
                  LNHist.Budget:=PerPr;
                  LNHist.RevisedBudget1:=PerPr2;

                  //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                  LNHist.RevisedBudget2 := Revised[2];
                  LNHist.RevisedBudget3 := Revised[3];
                  LNHist.RevisedBudget4 := Revised[4];
                  LNHist.RevisedBudget5 := Revised[5];
                end;

                LStatus:=LPut_Rec(ScanFileNum,SKeypath);

                If (LastStatus=0) then
                  LastStatus:=LStatus;

                LStatus:=LUnLockMLock(ScanFileNum);

              end; {If Ok..}
            end; {If Ok..}
          end; {Loop..}

          LReport_BError(ScanFileNum,LastStatus);
        End; // If IsCurrencyUsed(Cn)
      End; // For Cn
    End; // With MTeXLocal^
  end; {Proc..}






  { === Procedure to Scan all low level nom/stock types and update upper levels with budget totals === }

  Procedure TUpBudget.Update_GlobalBudgets(NKey       :  Str255;
                                           AutoOn     :  Boolean);


  Const
    Fnum1    =  NomF;
    Keypath1 =  NomCodeK;

    Fnum2    =  StockF;
    Keypath2 =  StkCodeK;

    ModeCode :  Array[BOff..BOn] of Char = (StkGrpCode,NomHedCode);




  Var
    ModeChr  :  Char;

    KeyS,
    KeyChk,
    KeyChk2,
    KeyCat,
    LowKey,
    HiKey    :  Str255;

    RecAddr  :  LongInt;

    CtrlHist :  HistoryRec;

    Mode,
    LoopEnd,
    NoAbort  :  Boolean;

    mbRet    :  Word;

    Fnum,
    Keypath,
    TmpKPath,
    B_FuncGet,
    B_FuncNext,
    TmpStat
             :  Integer;

    TmpRecAddr,
    TmpRecAddr2
             :  LongInt;


  Begin

    FNum := 0; //PR: 22/03/2016 v2016 R2 ABSEXCH-17390
    Extract_NHistfromNKey(Nkey,CtrlHist);

    {$B-}

    NoAbort:=(CtrlHist.ExClass In AdvBudgetSet);


    If (NoAbort) then
    With MTExLocal^ do
    Begin

    {$B+}

      Mode:=(CtrlHist.ExClass In AdvBudgetNSet);


      ItemCount:=0;

      KeyS:='';

      Blank(KeyChk2,Sizeof(KeyChk2));

      LowKey:='';

      HiKey:='';

      LoopEnd:=BOff;

      ModeChr:=ModeCode[Mode];

      B_FuncGet:=B_StepFirst;
      B_FuncNext:=B_StepNext;

      Case Mode of

        BOff :  Begin

                  Fnum:=Fnum2;

                  Keypath:=Keypath2;

                end;

        BOn  :  Begin

                  Fnum:=Fnum1;

                  Keypath:=Keypath1;

                end;

      end; {Case..}

      If (GLViewMode) then
      Begin
        Fnum:=NomViewF;
        Keypath:=NVViewIdxK;
        ModeChr:=ViewHedCode;
        B_FuncGet:=B_GetGEq;
        B_FuncNext:=B_GetNext;
        KeyChk2:=PrimeNVCode(NVRCode,NVVSCode,GLViewRec.NomViewLine.NomViewNo,BOn);
        KeyS:=KeyChk2;
      end;



      ItemTotal1:=Used_RecsCId(LocalF^[Fnum],Fnum,ExClientId);

      InitProgress(ItemTotal1+Round(ItemTotal1*0.25));

      ShowStatus(2,'Resetting existing totals.');

      Reset_BHeadings(ModeChr);


      ShowStatus(1,'Processing:-');

      LStatus:=LFind_Rec(B_FuncGet,Fnum,keypath,KeyS);


      While (LStatusOk) and (Not ThreadRec^.THAbort) and ((Not GLViewMode) or (CheckKey(KeyChk2,KeyS,Length(KeyChk2),BOn))) do
      Begin

        Inc(ItemCount);

        UpdateProgress(ItemCount);

        If (Not (HeadCode(LNom,LStock,Mode) In ModeSet)) and ((LNom.NomType<>CarryFlg) or (Not Mode))
        and ((LNomView^.NomViewLine.ViewType<>ViewHedCode) or (Not GLViewMode)) then
        Begin

          If (GLViewMode) then
            With LNomView^.NomViewLine do
              ShowStatus(2,dbFormatName(ViewCode,Desc))
          else
          Begin
            If (Mode) then
              With LNom do
                ShowStatus(2,dbFormatName(Form_Int(NomCode,0),Desc))
            else
              With LStock do
                ShowStatus(2,dbFormatName(StockCode,Desc[1]));
          end;

          TmpStat:=LPresrv_BTPos(Fnum,Keypath,LocalF^[Fnum],TmpRecAddr2,BOff,BOff);


          LowKey:=Set_NHist(LNom,LStock,Mode,BOff);

          Case Mode of

          {$IFDEF STK}

            BOff  :  With LStock do
                      KeyChk:=FullStockCode(StockCat);

          {$ENDIF}

            BOn   :  With LNom do
                      KeyChk:=FullNomKey(Cat);
          end; {case..}

          If (GLViewMode) then
            With LNomView^.NomViewLine do
                   KeyChk:=FullNVIdx(NVRCode,NVVSCode,NomViewNo,ViewCat,BOn);

          LoopEnd:=BOff;

          {$IFDEF MC_On}  {* Calculate Level 0 automaticly if needed *}

            Calc_L0Budget(LowKey);

          {$ENDIF}

          Repeat

            LStatus:=LFind_Rec(B_GetEq,Fnum,keypath,KeyChk);

            LoopEnd:=Not LStatusOk;

            If (LStatusOk) then
            Begin

              HiKey:=Set_NHist(LNom,LStock,Mode,BOff);


              Update_ParentBudget(LowKey,HiKey,BOn);

            end;

            If (Not LoopEnd) then
            Begin
              Case Mode of
                BOff :  With LStock do
                        Begin

                          {$IFDEF STK}

                            LoopEnd:=EmptyKey(StockCat,StkKeyLen);

                            KeyChk:=FullStockCode(StockCat);

                          {$ENDIF}

                        end;

                BOn  :  With LNom do
                        Begin
                          LoopEnd:=(Cat=0);

                          KeyChk:=FullNomKey(Cat);
                        end;
              end; {case..}

              If (GLViewMode) then
                With LNomView^.NomViewLine do
                Begin
                  LoopEnd:=(ViewCat=0);

                  KeyChk:=FullNVIdx(NVRCode,NVVSCode,NomViewNo,ViewCat,BOn);
                end;
            end;

          Until (LoopEnd) or (ThreadRec^.THAbort);


          TmpStat:=LPresrv_BTPos(Fnum,Keypath,LocalF^[Fnum],TmpRecAddr2,BOn,BOff);


        end; {If a non heading variable}

        LStatus:=LFind_Rec(B_FuncNext,Fnum,keypath,KeyS);

      end; {while..}


      Send_UpdateList(8);



    end; {If In Nom/Stock}


  end; {Proc..}




  { ========= Procedure to Scan Tree and update Lower Period profiles ======= }



    Procedure TUpBudget.Scan_BudgetTree(Fnum,
                                        Keypath    :  Integer;
                                        ProMode    :  Boolean;
                                   Var  NoAbort    :  Boolean);

    Var
      KeyS,
      KeyChk,
      LowKey,
      HiKey   :  Str255;

      RecAddr :  LongInt;



    Begin

      LowKey:='';
      HiKey:='';

      With MTExLocal^ do
      Begin
        Case ProMode of

        {$IFDEF STK}

          BOff  :  KeyChk:=FullStockCode(LStock.StockCode);

        {$ENDIF}

          BOn   :  KeyChk:=FullNomKey(LNom.NomCode);

        end; {Case..}

        KeyS:=KeyChk;

        LowKey:=Set_NHist(LNom,LStock,ProMode,BOn);


        LStatus:=LFind_Rec(B_GetGEq,Fnum,Keypath,KeyS);


        While (LStatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOn)) and (Not ThreadRec^.THAbort) do
        Begin

          Begin
            If (ProMode) then
              With LNom do
                ShowStatus(2,dbFormatName(Form_Int(NomCode,0),Desc))
            else
              With LStock do
                ShowStatus(2,dbFormatName(StockCode,Desc[1]));
          end;

          Inc(ItemCount);

          UpdateProgress(ItemCount);


          If (HeadCode(LNom,LStock,ProMode) In ModeSet) then
          Begin

            LStatus:=LGetPos(Fnum,RecAddr);

            HiKey:=Set_NHist(LNom,LStock,ProMode,BOn);

            Update_ParentBudget(LowKey,HiKey,BOff);

            Scan_BudgetTree(Fnum,KeyPath,ProMode,NoAbort);

            LSetDataRecOfs(Fnum,RecAddr);

            LStatus:=LGetDirect(Fnum,KeyPath,0);

          end;

          LStatus:=LFind_Rec(B_GetNext,Fnum,Keypath,KeyS);

        end; {While..}
      end; {With..}
    end; {Proc..}




{ ===== Procedure to process Profile update ===== }

  Procedure TUpBudget.Process_ProfileUpdate(NKey       :  Str255);


  Const
    Fnum1    =  NomF;
    Keypath1 =  NomCatK;

    Fnum2    =  StockF;
    Keypath2 =  StkCatK;


  Var

    ProMode,
    NoAbort  :  Boolean;

    Fnum,
    Keypath  :  Integer;

    CtrlHist :  HistoryRec;


  Begin
    FNum := 0; //PR: 22/03/2016 v2016 R2 ABSEXCH-17390
    KeyPath := 0;


    Extract_NHistfromNKey(Nkey,CtrlHist);

    NoAbort:=(Rev_AltStkHCode(CtrlHist.ExClass) In AdvBudgetSet);

    {If (NoAbort) then
    Begin
      mbRet:=MessageDlg('Please Confirm you wish to Update all Profiles below this level.',mtConfirmation,[mbYes,mbNo],0);

      NoAbort:=(mbRet=mrYes);
    end;}

    If (NoAbort) then
    With MTExLocal^ do
    Begin


      ProMode:=(Rev_AltStkHCode(CtrlHist.ExClass) In AdvBudgetNSet);

      Case ProMode of

        BOff :  Begin

                  Fnum:=Fnum2;

                  Keypath:=Keypath2;

                end;

        BOn  :  Begin

                  Fnum:=Fnum1;

                  Keypath:=Keypath1;

                end;

      end; {Case..}

      If (GLViewMode) then
      Begin
        Fnum:=NomViewF;
        Keypath:=NVCatK;
      end;

      ItemTotal1:=Used_RecsCId(LocalF^[Fnum],Fnum,ExClientId);

      InitProgress(ItemTotal1);

      ItemCount:=0;

      Scan_BudgetTree(Fnum,KeyPath,ProMode,NoAbort);

      UpdateProgress(ItemTotal1);

    end; {If Valid History Mode..}

  end; {Proc..}



  Procedure TUpBudget.Process;

  Begin
    InMainThread:=BOn;

    Inherited Process;


    Case UMode of
      0  :  Begin
              ShowStatus(0,'Update Budget Headings.');

              Update_GlobalBudgets(BKeyRef,BOff);
            end;
      1  :  With MTExLocal^ do
            Begin
              ShowStatus(0,'Update Budget Profiles.');

              LNom:=UNom;
              LStock:=UStk;
              Process_ProfileUpdate(BKeyRef);
            end;
    end; {Case..}

  end;


  Procedure TUpBudget.Finish;
  Begin
    Inherited Finish;

    {Overridable method}

    InMainThread:=BOff;

  end;






  Function TUpBudget.Start(KeyRef  :  Str255;
                           Fnum,
                           Keypath :  SmallInt;
                           NomR      :  NominalRec;
                           StkR      :  StockRec;
                           GLVR      :  NomViewRec;
                           NomNHCtrl :  TNHCtrlRec)  :  Boolean;

  Var
    KeyS     :  Str255;
    LastFnum :  Integer;

  Begin
    Result:=BOn;

    BKeyRef:=KeyRef;
    ScanFileNum:=Fnum;
    SKeypath:=KeyPath;
    UStk:=StkR;
    UNom:=NomR;

    LastFnum:=NHistF;

    With NomNHCtrl do
    Begin
      CCNomMode:=NHCCMode;
      CCNomFilt[CCNomMode]:=NHCDCode;
      StkLocFilt:=NHLocCode;

      GLViewMode:=(NomNHCtrl.NHMode=50);
      GLViewRec:=GLVR;

      If (GLViewMode) then
        LastFnum:=NomViewF
      else
        LastFnum:=NHistF;
    end;

    Begin
      if not GetProcessLock(plRollUpGLBudgets) then
      begin
        Result := False;
        EXIT;
      end;

      If (Not Assigned(MTExLocal)) then { Open up files here }
      Begin
        {$IFDEF EXSQL}
        if SQLUtils.UsingSQL then
        begin
          // CJS - 18/04/2008: Thread-safe SQL Version (using unique ClientIDs)
          if (not Assigned(LPostLocal)) then
            Result := Create_LocalThreadFiles;

          If (Result) then
            MTExLocal := LPostLocal;

        end
        else
        {$ENDIF}
        begin
          New(MTExLocal,Create(13));

          try
            With MTExLocal^ do
              Open_System(NomF,LastFnum);

          except
            Dispose(MTExLocal,Destroy);
            MTExLocal:=nil;

          end; {Except}

          Result:=Assigned(MTExLocal);
        end;
      end;
      {$IFDEF EXSQL}
      if Result and SQLUtils.UsingSQL then
      begin
        MTExLocal^.Close_Files;
        CloseClientIdSession(MTExLocal^.ExClientID, False);
      end;
      {$ENDIF}
    end;
  end;




Procedure AddUpBudget2Thread(AOwner    :  TObject;
                             Mode      :  Byte;
                             KeyRef    :  Str255;
                             Fnum,
                             Keypath   :  SmallInt;
                             NomR      :  NominalRec;
                             StkR      :  StockRec;
                             GLVR      :  NomViewRec;
                             NomNHCtrl :  TNHCtrlRec);


Const
  ThreadTit  :  Array[0..1] of Str20 = ('Update Budgets','Update Profiles');

  Var
    LCheck_Budget :  ^TUpBudget;

  Begin

    If (Create_BackThread) then
    Begin
      New(LCheck_Budget,Create(AOwner));

      try
        With LCheck_Budget^ do
        Begin
          If (Start(KeyRef,Fnum,Keypath,NomR,StkR,GLVR,NomNHCtrl)) and (Create_BackThread) then
          Begin
            UMode:=Mode;
            With BackThread do
              AddTask(LCheck_Budget,ThreadTit[UMode]);
          end
          else
          Begin
            Set_BackThreadFlip(BOff);
            Dispose(LCheck_Budget,Destroy);
          end;
        end; {with..}

      except
        Set_BackThreadFlip(BOff);

        Dispose(LCheck_Budget,Destroy);
      end; {try..}
    end; {If process got ok..}

  end;



{ ========== TRollUpBudget methods =========== }

  Constructor TRollUpBudget.Create(AOwner  :  TObject);

  Begin
    Inherited Create(AOwner);

    RollBasis:=0;
    UpBudget:=0;

    CostCentreList := NIL;
    DepartmentList := NIL;
  end;

  Destructor TRollUpBudget.Destroy;

  Begin
    FreeAndNIL(CostCentreList);
    FreeAndNIL(DepartmentList);

    Inherited Destroy;
  end;

  //-------------------------------------------------------------------------

  Procedure TRollUpBudget.LoadCCDeptCacheList (Var CacheList : TStringList; Const CostCentres, LoadData : Boolean);
  Var
    KeyS : Str255;
    iStatus : SmallInt;
  Begin // LoadCCDeptCacheList
    // Check to see if it has already been loaded
    If (Not Assigned(CacheList)) Then
    Begin
      CacheList := TStringList.Create;

      // Check we actually want to load the data - if only processing Cost Centres then we don't load Departments - but we do create the list to avoid Access Violatey problems
      If LoadData Then
      Begin
        With TBtrieveSavePosition.Create Do
        Begin
          Try
            // Save the current position in the file for the current key
            SaveFilePosition (PwrdF, GetPosKey);
            SaveDataBlock (@MtExLocal^.LPassword, SizeOf(MtExLocal^.LPassword));

            //------------------------------

            KeyS := PartCCKey (CostCCode, CSubCode[CostCentres]);
            iStatus := MTExLocal^.LFind_Rec(B_GetGEq, PwrdF, PWK, KeyS);
            While (iStatus = 0) And (MtExLocal^.LPassword.RecPFix = CostCCode) And (MtExLocal^.LPassword.SubType = CSubCode[CostCentres]) Do
            Begin
              CacheList.Add (MtExLocal^.LPassword.CostCtrRec.PCostC);

              iStatus := MTExLocal^.LFind_Rec(B_GetNext, PwrdF, PWK, KeyS);
            End; // While (iStatus = 0) And (MtExLocal^.LPassword.RecPFix = CostCCode) And (MtExLocal^.LPassword.SubType = CSubCode[CostCentres])

            //------------------------------

            // Restore position in file
            RestoreDataBlock (@MtExLocal^.LPassword);
            RestoreSavedPosition;
          Finally
            Free;
          End; // Try..Finally
        End; // With TBtrieveSavePosition.Create
      End; // If LoadData
    End; // If (Not Assigned(CacheList))
  End; // LoadCCDeptCacheList

  //------------------------------

  Procedure TRollUpBudget.BuildCostCentreCache (Const LoadCostCentres : Boolean);
  Begin // BuildCostCentreCache
    LoadCCDeptCacheList (CostCentreList, True, LoadCostCentres);
  End; // BuildCostCentreCache

  //------------------------------

  Procedure TRollUpBudget.BuildDepartmentCache (Const LoadDepartments : Boolean);
  Begin // BuildDepartmentCache
    LoadCCDeptCacheList (DepartmentList, False, LoadDepartments);
  End; // BuildDepartmentCache

  //-------------------------------------------------------------------------

  Procedure TRollUpBudget.RollUpThisNom(ThisNom  :  NominalRec);

  Const
    Fnum    =  NHistF;
    Keypath =  NHK;

    Fnum2   =  PwrdF;
    Keypath2=  PWK;



  Var
    Cn,n  :  Byte;

    NRecAddr,
    CRecAddr,
    DRecAddr
          :  LongInt;

    BeenFilled,
    BeenWarned,
    LOK,
    Locked
          :  Boolean;

    CCCounter
          :  LongInt;

    iCostCentre, iDepartment : LongInt;

    MasterHist,
    CHist,
    DHist :  HistoryRec;

    CCode1,
    DCode1 : Str10;

    KeyC,
    KeyD,
    KeyS,
    KeyN,
    KeyCChk,
    KeyChk :  Str255;

    ComboCD:  CCDepType;

    //PR: 10/05/2016 ABSEXCH-17353 Total of all revised budgets for ease of reading
    Function RevisedTotal : Double;
    begin
      Result := AbsTotal([DHist.RevisedBudget1, DHist.RevisedBudget2, DHist.RevisedBudget3, DHist.RevisedBudget4, DHist.RevisedBudget5,
          CHist.RevisedBudget1,CHist.RevisedBudget2, CHist.RevisedBudget3, CHist.RevisedBudget4, CHist.RevisedBudget5]);

    end;

    //------------------------------

    // Update Master history record (the one we are recalculating)
    Procedure UpdateMasterHistRec;
    Begin // UpdateMasterHistRec
      If (AbsTotal([DHist.Budget, CHist.Budget]) + RevisedTotal <> 0.0) Then
      Begin
        If (Not (UpBudget In [2,3])) then
          // Roll up original budget
          MasterHist.Budget := MasterHist.Budget + (CHist.Budget + DHist.Budget);

        If (UpBudget <> 1) then
        begin
          // Roll up revised budget
          //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
          MasterHist.RevisedBudget1 := MasterHist.RevisedBudget1 + (CHist.RevisedBudget1 + DHist.RevisedBudget1);
          MasterHist.RevisedBudget2 := MasterHist.RevisedBudget2 + (CHist.RevisedBudget2 + DHist.RevisedBudget2);
          MasterHist.RevisedBudget3 := MasterHist.RevisedBudget3 + (CHist.RevisedBudget3 + DHist.RevisedBudget3);
          MasterHist.RevisedBudget4 := MasterHist.RevisedBudget4 + (CHist.RevisedBudget4 + DHist.RevisedBudget4);
          MasterHist.RevisedBudget5 := MasterHist.RevisedBudget5 + (CHist.RevisedBudget5 + DHist.RevisedBudget5);
        end;
      End; // If (DHist.Budget + DHist.RevisedBudget1 + CHist.Budget + CHist.RevisedBudget1 <> 0.0)
    End; // UpdateMasterHistRec

    //------------------------------

  Begin
    NRecAddr:=0; CRecAddr:=0; DRecAddr:=0;  BeenWarned:=BOff; BeenFilled:=BOff;

    Blank(MasterHist,Sizeof(MasterHist));

    Blank(CHist,Sizeof(CHist));
    Blank(DHist,Sizeof(DHist));

    With MTExLocal^ do
    Begin
      {$IFDEF MC_On}
        For Cn:=1 to CurrencyType do
      {$ELSE}
        Cn:=0;
      {$ENDIF}
      Begin
        // MH 21/01/2011 v6.6 ABSEXCH-10759: Added check on whether currency in used to improve lamentable performance
        If IsCurrencyUsed(Cn) Then
        Begin
          // MH 24/01/2011: Added CC/Dept Caching to improve performance
          BuildCostCentreCache (RollBasis <> 1);
          BuildDepartmentCache (RollBasis <> 0);

          For n:=1 to Syss.PrInYr do
          Begin
            If (THreadRec^.THAbort) and (Not BeenWarned) then
            Begin
              ShowStatus(3,'Please Wait, finishing current budget.');

              BeenWarned:=BOn;

            end;

            CCCounter:=0;

            With ThisNom do
              KeyChk:=FullNHistKey(NomType,FullNomKey(NomCode),Cn,GetLocalPr(0).CYr,n);

            KeyS:=KeyChk;

            If (Not BeenFilled) then
            Begin
              //NOTE: This routine will only be called for Currency 1 - is this a bug or deliberate? (And how do I find out?)
              BeenFilled:=BOn;

              ScanFileNum:=Fnum; SKeyPath:=Keypath;  // ScanFileNum and SKeyPath are used by FillBudget - apparently parameters are not good enough!
              FillBudget(KeyS);
            end;

            // Look for existing history record for GL, Ccy, Yr, Pr
            LStatus:=LFind_Rec(B_GetEq,Fnum,Keypath,KeyS);
            If (LStatusOk) then
            Begin
              // Remember record position so we can find it for the Update at the end
              MasterHist:=LNHist;
              LGetRecAddr(Fnum);
              NRecAddr:=LastRecAddr[Fnum];
            end
            else
            Begin
              // Create new blank history record
              Blank(MasterHist,Sizeof(MasterHist));
              Extract_NHistfromNKey(KeyChk,MasterHist);
              NRecAddr:=0;
            end;

            With MasterHist do
            Begin
              Case UpBudget of
                // 3=Set Orig. from Revised, Roll Up Revised
                3  :  Begin
                        Budget:=RevisedBudget1;
                        RevisedBudget1:=0.0;

                        //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                        RevisedBudget2:=0.0;
                        RevisedBudget3:=0.0;
                        RevisedBudget4:=0.0;
                        RevisedBudget5:=0.0;
                      end
                else  Begin
                        // 0=Roll Up Original & Revised
                        // 1=Roll Up Original Only
                        If (UpBudget In [0,1]) then
                          Budget:=0.0;

                        // 0=Roll Up Original & Revised
                        // 2=Roll up Revised Only
                        If (UpBudget In [0,2]) then
                        begin
                          RevisedBudget1:=0.0;

                          //PR: 10/05/2016 ABSEXCH-17353 Include extra revised budgets
                          RevisedBudget2:=0.0;
                          RevisedBudget3:=0.0;
                          RevisedBudget4:=0.0;
                          RevisedBudget5:=0.0;
                        end;
                      end;
              end; {Case..}
            end; {With..}

            //-------------------------------------------------------------------------

            // MH 25/01/2011 v6.6 ABSEXCH-10759: Completely rewrote CC/Dept processing to improve performance by approx 95%

            // 0=Cost Centres Only
            // 2=Individual CC + Dept
            If (RollBasis In [0, 2]) And (CostCentreList.Count > 0) Then
            Begin
              Blank(DCode1, Sizeof(DCode1));
              Blank(DHist, Sizeof(DHist));

              For iCostCentre := 0 To (CostCentreList.Count - 1) Do
              Begin
                CCode1 := CostCentreList[iCostCentre];

                // Get history record for Cost Centre
                KeyN:=FullNHistKey(ThisNom.NomType,CalcCCKeyHistP(ThisNom.NomCode,BOn,CCode1),Cn,GetLocalPr(0).CYr,n);
                LStatus:=LFind_Rec(B_GetEq,Fnum,Keypath,KeyN);
                If (LStatusOk) then
                  CHist:=LNHist
                Else
                  Blank(CHist, Sizeof(CHist));

                UpdateMasterHistRec;
              End; // For iCostCentre
            End; // If (RollBasis In [0, 2]) And (CostCentreList.Count > 0)

            //------------------------------

            // 1=Departments Only
            // 2=Individual CC + Dept
            If (RollBasis In [1, 2]) And (DepartmentList.Count > 0) Then
            Begin
              Blank(CCode1, Sizeof(CCode1));
              Blank(CHist, Sizeof(CHist));

              For iDepartment := 0 To (DepartmentList.Count - 1) Do
              Begin
                DCode1 := DepartmentList[iDepartment];

                // Get history record for Department
                KeyN:=FullNHistKey(ThisNom.NomType,CalcCCKeyHistP(ThisNom.NomCode,BOff,DCode1),Cn,GetLocalPr(0).CYr,n);
                LStatus:=LFind_Rec(B_GetEq,Fnum,Keypath,KeyN);
                If (LStatusOk) then
                  DHist:=LNHist
                Else
                  Blank(DHist, Sizeof(DHist));

                UpdateMasterHistRec;
              End; // For iDepartment
            End; // If (RollBasis In [1, 2]) And (DepartmentList.Count > 0)

            //------------------------------

            // 3=Combined CC + Dept
            // 4=Combined Dept. + CC
            If (RollBasis In [3, 4]) And (CostCentreList.Count > 0) And (DepartmentList.Count > 0) Then
            Begin
              For iCostCentre := 0 To (CostCentreList.Count - 1) Do
              Begin
                CCode1 := CostCentreList[iCostCentre];
                Blank(CHist, Sizeof(CHist));

                For iDepartment := 0 To (DepartmentList.Count - 1) Do
                Begin
                  DCode1 := DepartmentList[iDepartment];

                  // Get history record for CostCentre/Department or Department/Cost Centre
                  ComboCD[BOn]  := CCode1;
                  ComboCD[BOff] := DCode1;
                  KeyN:=FullNHistKey(ThisNom.NomType,CalcCCKeyHistP(ThisNom.NomCode,(RollBasis=3),CalcCCDepKey((RollBasis=3),ComboCD)),Cn,GetLocalPr(0).CYr,n);
                  LStatus:=LFind_Rec(B_GetEq,Fnum,Keypath,KeyN);
                  If (LStatusOk) then
                    DHist:=LNHist
                  Else
                    Blank(DHist, Sizeof(DHist));

                  UpdateMasterHistRec;
                End; // For iDepartment
              End; // For iCostCentre
            End; // If (RollBasis In [3, 4]) And (CostCentreList.Count > 0) And (DepartmentList.Count > 0)

            //-------------------------------------------------------------------------

            If (Not ThreadRec^.THAbort) then
            Begin
              If (NRecAddr<>0) then
              Begin
                // Get and update existing history record
                LastRecAddr[Fnum]:=NRecAddr;

                LStatus:=LGetDirectRec(Fnum,KeyPath);

                LOk:=LGetMultiRec(B_GetDirect,B_MultLock,KeyS,KeyPath,Fnum,BOn,Locked);

                If (LOk) and (Locked) then
                Begin
                  LNHist:=MasterHist;

                  LStatus:=LPut_Rec(Fnum,Keypath);

                  LReport_BError(Fnum,LStatus);

                  LStatus:=LUnLockMLock(Fnum);

                end;
              end
              else
                With MasterHist do
                  If (Budget + RevisedBudget1 +
                      RevisedBudget2 + RevisedBudget3 +
                      RevisedBudget4 + RevisedBudget5 <>0.0) then
                  Begin
                    // Create new history record
                    LNHist:=MasterHist;

                    LStatus:=LAdd_Rec(Fnum,Keypath);

                    LReport_BError(Fnum,LStatus);
                  end;
            End; // If (Not ThreadRec^.THAbort)
          end; {Period Loop..}
        End; // If IsCurrencyUsed(Cn)
      end; {Currency Loop..}
    end; {With..}
  end; {Proc..}


  Procedure TRollUpBudget.Scan_RollUp(ThisNomCat  :  LongInt);

  Const
    Fnum     =  NomF;
    Keypath  =  NomCatK;

  Var
    KeyS,
    KeyChk   :  Str255;

    TmpKPath,
    TmpStat
             :  Integer;

    TmpRecAddr
             :  LongInt;


  Begin
    With MTExLocal^ do
    Begin
      KeyChk:=FullNomKey(ThisNomCat);
      KeyS:=KeyChk;

      LStatus:=LFind_Rec(B_GetGEq,Fnum,Keypath,KeyS);


      While (LStatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOff)) and (Not ThreadRec^.THAbort) do
      With LNom do
      Begin
        ShowStatus(1,'Processing '+dbFormatName(IntToStr(NomCode),Desc));

        If (NomType=NomHedCode) then
        Begin
          TmpKPath:=Keypath;

          TmpStat:=LPresrv_BTPos(Fnum,TmpKPath,LocalF^[Fnum],TmpRecAddr,BOff,BOff);

          Scan_RollUp(NomCode);

          TmpStat:=LPresrv_BTPos(Fnum,TmpKPath,LocalF^[Fnum],TmpRecAddr,BOn,BOn);

        end
        else
           If (NomType<>CarryFlg) and (NomCode<>Syss.NomCtrlCodes[ProfitBF]) then
             RollUpThisNom(LNom);

        LStatus:=LFind_Rec(B_GetNext,Fnum,Keypath,KeyS);

      end; {While..}

    end; {With..}
  end; {Proc..}




  Procedure TRollUpBudget.Process;

  Begin
    InMainThread:=BOn;

    Inherited Process;


    Case UMode of
      5  :  Begin
              ShowStatus(0,'Roll Up Budget Headings.');

              Scan_RollUp(UNom.NomCode);

            end;
    end; {Case..}

  end;


  Procedure TRollUpBudget.Finish;
  Begin
    Inherited Finish;

  end;






  Function TRollUpBudget.Start(NomR      :  NominalRec;
                               RB,UB     :  Byte)  :  Boolean;


  Begin
    Result:=BOn;

    UNom:=NomR;

    RollBasis:=RB;
    UpBudget:=UB;


    Begin
      If (Not Assigned(MTExLocal)) then { Open up files here }
      Begin
        {$IFDEF EXSQL}
        if SQLUtils.UsingSQL then
        begin
          // CJS - 18/04/2008: Thread-safe SQL Version (using unique ClientIDs)
          if (not Assigned(LPostLocal)) then
            Result := Create_LocalThreadFiles;

          If (Result) then
            MTExLocal := LPostLocal;

        end
        else
        {$ENDIF}
        begin
          New(MTExLocal,Create(42));

          try
            With MTExLocal^ do
              Open_System(NomF,PWrdF);

          except
            Dispose(MTExLocal,Destroy);
            MTExLocal:=nil;

          end; {Except}

          Result:=Assigned(MTExLocal);
        end;
      end;
      {$IFDEF EXSQL}
      if Result and SQLUtils.UsingSQL then
      begin
        MTExLocal^.Close_Files;
        CloseClientIdSession(MTExLocal^.ExClientID, False);
      end;
      {$ENDIF}
    end;
  end;




Procedure RollUpBudget2Thread(AOwner    :  TObject;
                              Mode,
                              RollM,
                              UM        :  Byte;
                              NomR      :  NominalRec);



  Var
    LCheck_Budget :  ^TRollUpBudget;

  Begin

    If (Create_BackThread) then
    Begin
      New(LCheck_Budget,Create(AOwner));

      try
        With LCheck_Budget^ do
        Begin
          If (Start(NomR,RollM,UM)) and (Create_BackThread) then
          Begin
            UMode:=Mode;

            With BackThread do
              AddTask(LCheck_Budget,'Budget Roll Up');
          end
          else
          Begin
            Set_BackThreadFlip(BOff);
            Dispose(LCheck_Budget,Destroy);
          end;
        end; {with..}

      except
        Set_BackThreadFlip(BOff);

        Dispose(LCheck_Budget,Destroy);
      end; {try..}
    end; {If process got ok..}

  end;




{$ENDIF}



{$IFDEF STK}


  { ======= Function to Check belongs to tree ====== }

  Function Stk_InGroup(StkGroup  :  Str20;
                       StockR    :  StockRec)  :  Boolean;


  Const
    Fnum     =  StockF;
    Keypath  =  StkCodeK;


  Var
    KeyS    :  Str255;
    FoundOk :  Boolean;
    TmpKPath,
    TmpStat,
    LastStat:  Integer;

    TStock  :  StockRec;

    TmpRecAddr
            :  LongInt;


  Begin

    LastStat:=Status;

    TmpKPath:=GetPosKey;

    TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpRecAddr,BOff,BOff);

    TStock:=Stock;

    KeyS:=StockR.StockCat;

    FoundOk:=((EmptyKey(StkGroup,StkKeyLen)) or (FullStockCode(StkGroup)=FullStockCode(KeyS)));


    If (Not FoundOk) then
      Status:=Find_Rec(B_GetEq,F[Fnum],Fnum,RecPtr[Fnum]^,Keypath,KeyS);


    While (StatusOk) and (Not FoundOk) and (Not EmptyKey(Stock.StockCat,StkKeyLen)) do
    With Stock do
    Begin

      FoundOk:=((FullStockCode(StkGroup)=StockCode) or (FullStockCode(StkGroup)=FullStockCode(StockCat)));

      If (Not FoundOk) then
      Begin
        KeyS:=StockCat;

        Status:=Find_Rec(B_GetEq,F[Fnum],Fnum,RecPtr[Fnum]^,Keypath,KeyS);

      end;

    end; {While..}

    TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpRecAddr,BOn,BOff);

    Stock:=TStock;

    Stk_InGroup:=FoundOk;

    Status:=LastStat;
  end; {Func..}

{$ENDIF}


{$IFDEF WOP}

  Procedure UpdateWORCost(Var LInv  :  InvRec;
                              LId   :  IDetail;
                              Mode  :  Byte);

  Var
    DCnst :  Integer;

  Begin
    If (Mode In [1,11]) then
      DCnst:=-1
    else
      DCnst:=1;

    With LInv,LId do
    Begin
      TotalCost:=TotalCost+(Round_Up((WORReqQty(LId)*CostPrice)*DCnst,2));

      If (Mode In [10,11]) then {Only update total issued via check. Not currently called as this figure is controlled by the issuing of stock}
        TotalInvoiced:=TotalInvoiced+(Round_Up((QtyDel*CostPrice)*DCnst,2));
    end;

  end;

{$ENDIF}


procedure Check_OtherDocs(Var  LInv  :  InvRec;
                               Mode  :  Byte);


  Const
    Fnum     =  IDetailF;
    Keypath  =  IDFolioK;



Var
  KeyS,
  KeyChk    :  Str255;

  TmpKPath,
  TmpStat  :  Integer;
  TmpAddr  :  LongInt;

  mbRet    :  TModalResult;


  MsgForm  :  TForm;


Begin
  Set_BackThreadMVisible(BOn);

  MsgForm:=CreateMessageDialog('Please wait... Recalculating totals.',mtInformation,[mbAbort]);
  MsgForm.Show;
  MsgForm.Update;

  TmpKPath:=Keypath;

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpAddr,BOff,BOff);

  With LInv do
  Begin

    If (Not (InvDocHed In RecieptSet+DirectSet)) then
    Begin
      InvNetVal:=0.0;

      If (Not (InvDocHed In WOPSplit)) then
        TotalReserved:=0.0;
    end;


    If (Not (InvDocHed In DirectSet)) then
    Begin
      If (InvDocHed<>NMT) then
      Begin

        Blank(InvVatAnal,Sizeof(InvVatAnal));

      end;

      InvVat:=0.0;  DiscAmount:=0.0; DiscSetAm:=0.0; TotalCost:=0.0;

      TotalWeight:=0.0; TotOrdOS:=0.0; Variance:=0.0; PostDiscAm:=0.0;
      
    end;


    If (Not (InvDocHed In WOPSplit)) or (Mode In [10,11]) then
      TotalInvoiced:=0.0;

    TotalOrdered:=0.0;

    NoAbort:=BOn;



    KeyChk:=FullNomKey(FolioNum);

    If (InvDocHed In [TSH,WOR]) then
      KeyS:=FullIdKey(FolioNum,1)
    else
      KeyS:=FullIdKey(FolioNum,RecieptCode);


    Status:=Find_Rec(B_GetGEq,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);

    While (StatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOn)) and (NoAbort) do
    With Id do
    Begin

      mbRet:=MsgForm.ModalResult;
      Loop_CheckKey(NoAbort,mbRet);
      MsgForm.ModalResult:=mbRet;

      Application.ProcessMessages;

      Case InvDocHed of

        TSH  :  InvFSU3U.UpdateRecBal(Id,LInv,BOff,BOff,Mode);
        {$IFDEF WOP}
          WOR,ADJ
             :  If (LineNo>1) then
                    UpdateWORCost(LInv,Id,Mode);
        {$ENDIF}

          NMT  : MiscU.UpdateRecBal(LInv,NomCode,NetValue,VAT,CXRate,Currency,UseORate,Mode);

        else    MiscU.UpdateRecBal(LInv,NomCode,NetValue,0.0,CXRate,Currency,UseORate,Mode);

      end; {case..}

      Status:=Find_Rec(B_GetNext,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);


    end; {While..}

  end; {With..}

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpAddr,BOn,BOn);

  MsgForm.Free;

  Set_BackThreadMVisible(BOff);

end; {Proc..}




procedure RSynch_PayFromTo(Var  LInv  :  InvRec;
                                Mode  :  Byte);


  Const
    Fnum     =  IDetailF;
    Keypath  =  IDFolioK;



Var
  KeyS,
  KeyChk    :  Str255;

  TmpKPath,
  TmpStat  :  Integer;
  TmpAddr  :  LongInt;

  mbRet    :  TModalResult;


  MsgForm  :  TForm;


Begin
  Set_BackThreadMVisible(BOn);

  MsgForm:=CreateMessageDialog('Please wait... Recalculating totals.',mtInformation,[mbAbort]);
  MsgForm.Show;
  MsgForm.Update;

  TmpKPath:=Keypath;

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpAddr,BOff,BOff);

  With LInv do
  Begin

    TotalInvoiced:=0.0;

    TotalOrdered:=0.0;

    NoAbort:=BOn;

    KeyChk:=FullNomKey(FolioNum);

    KeyS:=FullIdKey(FolioNum,RecieptCode);


    Status:=Find_Rec(B_GetGEq,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);

    While (StatusOk) and (CheckKey(KeyChk,KeyS,Length(KeyChk),BOn)) and (NoAbort) do
    With Id do
    Begin

      mbRet:=MsgForm.ModalResult;
      Loop_CheckKey(NoAbort,mbRet);
      MsgForm.ModalResult:=mbRet;

      Application.ProcessMessages;

      If (CXRate[BOn]<>LInv.CXRate[BOn]) and (Currency<>0) then
      Begin
        Currency:=LInv.Currency;
        
        CXRate[BOn]:=LInv.CXRate[BOn];

        Status:=Put_Rec(F[Fnum],Fnum,RecPtr[Fnum]^,KeyPAth);

        Report_BError(Fnum,Status);

      end;

      MiscU.UpdateRecBal(LInv,NomCode,NetValue,0.0,CXRate,Currency,UseORate,Mode);

      Status:=Find_Rec(B_GetNext,F[Fnum],Fnum,RecPtr[Fnum]^,KeyPath,KeyS);


    end; {While..}

  end; {With..}

  TmpStat:=Presrv_BTPos(Fnum,TmpKPath,F[Fnum],TmpAddr,BOn,BOn);

  MsgForm.Free;

  Set_BackThreadMVisible(BOff);

end; {Proc..}


{$IFDEF SOP}
 { ==  Message to over committed  ============== }

Procedure Warn_OverCommited(GLCode  :  LongInt;
                            CC      :  CCDepType;
                            CCMode  :  Boolean;
                            FoundCC :  Byte;
                            Act,Comm,
                            Budg    :  Double;
                            HistCR  :  Byte);


Var
  mbRet  :  Word;
  S      :  String;


Begin

  If (Nom.NomCode<>GLCode) then
    Global_GetMainRec(NomF,FullNomKey(GLCode));

  S:=' - WARNING! - '+#13+'GLCode : '+Form_Int(GLCode,0)+','+Trim(Nom.Desc)+'.  ';

  If (Syss.UseCCDep) and (Syss.PostCCNom) and (FoundCC<>0) then
  Begin
    If (FoundCC=1) then
      S:=S+CostCtrRTitle[CCMode]+Trim(CC[CCMode])+'. '
    else
      S:=S+CostCtrRTitle[BOn]+Trim(CC[BOn])+'/ '+CostCtrRTitle[BOff]+Trim(CC[BOff])+'.'
  end;

  S:=S+'Has gone over budget.'+#13;

  S:=S+'Actual Value : '+FormatCurFloat(GenRealMask,Act,BOff,HistCR)+'. Committed Value : '+
                         FormatCurFloat(GenRealMask,Comm,BOff,HistCR)+#13+'Budget : '+
                         FormatCurFloat(GenRealMask,Budg,BOff,HistCR);

  mbRet:=MessageDlg(S,mtWarning,[mbOk],0);

end;

{ == Function to check if G/L & CC combination over budget == }

Function Check_OverCommited(Line,OldLine
                                      :  IDetail;
                            ShowMsg   :  Boolean)  :  Boolean;

Var

  AutoLZ,
  Loop,FoundOk  :  Boolean;

  FoundCC,
  UOR,
  DPr,DYr,
  HistCr        :  Byte;

  NomBal,
  Purch,
  Sales,
  Cleared,
  Budget1,
  Budget2,

  BV1,BV2,
  ComNomBal,
  ComPrevBal,
  LiveComBal,
  ComPurch,
  ComSales,
  ComCleared,
  ComBudget1,
  ComBudget2,

  ComBV1,ComBV2,
  LineValue,Rate
                :  Double;

  LineDate      :  LongDate;


Begin
  With Line do
  Begin
    FoundOk:=BOff;   UOR:=0;

    //PR: 22/03/2016 v2016 R2 ABSEXCH-17390
    ComNomBal := 0;
    LiveComBal := 0;

    If (Nom.NomCode<>NomCode) then
      Global_GetMainRec(NomF,FullNomKey(NomCode));

    HistCr:=Currency;
    AutoLZ:=(Currency<>0);

    If (OldLine.NomCode=Line.NomCode) then {Adjust for existing edit value}
      LineValue:=(DetLTotal(Line,BOn,BOff,0.0)-DetLTotal(OldLine,BOn,BOff,0.0))
    else
      LineValue:=DetLTotal(Line,BOn,BOff,0.0);


    {LineValue:=LineValue*LineCnst(Payment);}


    If (PDate<>'') then
      LineDate:=PDate
    else
      LineDate:=Today;

    Date2Pr(LineDate,DPr,DYr,nil);

    Repeat
      Loop:=BOff;  FoundCC:=0;
      NomBal:=Total_Profit_To_Date(Nom.NomType,FullNomKey(NomCode),HistCR,DYr,Syss.PrInYr,Purch,Sales,Cleared,Budget1,Budget2,BV1,BV2,BOn);

      If (Budget1<>0.0) then
      Begin

        ComNomBal:=Total_Profit_To_Date(Nom.NomType,CommitKey+FullNomKey(NomCode),HistCR,DYr,Syss.PrInYr,ComPurch,ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

        LiveComBal:=Total_Profit_To_Date(StkBillCode,CommitKey+FullNomKey(NomCode),HistCR,DYr,Syss.PrInYr,ComPurch,ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

        If (Nom.NomType In YTDSet) then
        Begin
          NomBal:=NomBal-Total_Profit_To_Date(Nom.NomType,FullNomKey(NomCode),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,Purch,Sales,Cleared,ComBudget1,Budget2,BV1,BV2,BOn);
          ComPrevBal:=Total_Profit_To_Date(Nom.NomType,CommitKey+FullNomKey(NomCode),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,ComPurch,ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);
          ComNomBal:=ComNomBal-ComPrevBal;
        end;

        FoundOk:=(((NomBal+ComNomBal+LiveComBal+LineValue)*LineCnst(Payment))>(Budget1*LineCnst(Payment)));


      end;


      If (Not FoundOk) and (Syss.UseCCDep) and (Syss.PostCCNom) then {* Check CC/Dep*}
      Begin
        FoundCC:=1;

        For Loop:=BOff to BOn do
        Begin
          NomBal:=Total_Profit_To_Date(Nom.NomType,CalcCCKeyHistPOn(NomCode,Loop,Line.CCDep[Loop]),HistCR,DYr,Syss.PrInYr,Purch,
                                       Sales,Cleared,Budget1,Budget2,BV1,BV2,BOn);

          If (Budget1<>0.0) then
          Begin
            ComNomBal:=Total_Profit_To_Date(Nom.NomType,CommitKey+CalcCCKeyHistPOn(NomCode,Loop,Line.CCDep[Loop]),HistCR,DYr,Syss.PrInYr,ComPurch,
                                            ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

            LiveComBal:=Total_Profit_To_Date(StkBillCode,CommitKey+CalcCCKeyHistPOn(NomCode,Loop,Line.CCDep[Loop]),HistCR,DYr,Syss.PrInYr,ComPurch,
                                             ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

            If (Nom.NomType In YTDSet) then
            Begin
              NomBal:=NomBal-Total_Profit_To_Date(Nom.NomType,CalcCCKeyHistPOn(NomCode,Loop,Line.CCDep[Loop]),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,Purch,Sales,Cleared,ComBudget1,Budget2,BV1,BV2,BOn);
              ComNomBal:=ComNomBal-Total_Profit_To_Date(Nom.NomType,CommitKey+CalcCCKeyHistPOn(NomCode,Loop,Line.CCDep[Loop]),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,ComPurch,
                                                        ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);
            end;

            FoundOk:=(((NomBal+ComNomBal+LineValue+LiveComBal)*LineCnst(Payment))>(Budget1*LineCnst(Payment)));

          end;

          If (FoundOk) then
            Break;
        end; {Loop..}

        If (Not FoundOk) and (Syss.PostCCDCombo) then
        Begin
          FoundCC:=2;

          For Loop:=BOff to BOn do
          Begin
            NomBal:=Total_Profit_To_Date(Nom.NomType,CalcCCKeyHistP(NomCode,Loop,CalcCCDepKey(Loop,Line.CCDep)),HistCR,DYr,Syss.PrInYr,Purch,
                                         Sales,Cleared,Budget1,Budget2,BV1,BV2,BOn);

            If (Budget1<>0.0) then
            Begin
              ComNomBal:=Total_Profit_To_Date(Nom.NomType,CommitKey+CalcCCKeyHistP(NomCode,Loop,CalcCCDepKey(Loop,Line.CCDep)),HistCR,DYr,Syss.PrInYr,ComPurch,
                                              ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

              LiveComBal:=Total_Profit_To_Date(StkBillCode,CommitKey+CalcCCKeyHistP(NomCode,Loop,CalcCCDepKey(Loop,Line.CCDep)),HistCR,DYr,Syss.PrInYr,ComPurch,
                                               ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);

              If (Nom.NomType In YTDSet) then
              Begin
                NomBal:=NomBal-Total_Profit_To_Date(Nom.NomType,CalcCCKeyHistP(NomCode,Loop,CalcCCDepKey(Loop,Line.CCDep)),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,Purch,Sales,Cleared,ComBudget1,Budget2,BV1,BV2,BOn);
                ComNomBal:=ComNomBal-Total_Profit_To_Date(Nom.NomType,CommitKey+CalcCCKeyHistP(NomCode,Loop,CalcCCDepKey(Loop,Line.CCDep)),HistCR,AdjYr(DYr,BOff),Syss.PrInYr,ComPurch,
                                                          ComSales,ComCleared,ComBudget1,ComBudget2,BV1,BV2,BOn);
              end;

              FoundOk:=(((NomBal+ComNomBal+LineValue+LiveComBal)*LineCnst(Payment))>(Budget1*LineCnst(Payment)));

            end;

            If (FoundOk) then
              Break;
          end; {Loop..}


        end;

      end;

      AutoLZ:=(Not AutoLZ) or (FoundOk);

      If (Not AutoLZ) then
      Begin
        HistCR:=0;

        Rate:=XRate(CXrate,BOff,Currency);

        UOR:=fxUseORate(BOff,BOn,CXRate,UseORate,Currency,0);

        LineValue:=Conv_TCurr(LineValue,Rate,Currency,UOR,BOff);
      end;

    Until (AutoLZ) or (FoundOk);


    If (FoundOk) and (ShowMsg) then
      Warn_OverCommited(NomCode,Line.CCDep,Loop,FoundCC,NomBal,ComNomBal+LiveComBal+LineValue,Budget1,HistCR);

  end; {With..}

  Result:=FoundOk;
end; {Proc..}

{$ENDIF}



end.

