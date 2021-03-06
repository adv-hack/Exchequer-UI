unit Mainf;

{ prutherford440 09:40 30/10/2001: Disabled Byte Alignment in Delphi 6.0 }
{$ALIGN 1}  { Variable Alignment Disabled }
{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, Menus, ImgList, ComCtrls, ToolWin, About, jpeg, ElVar,
  SchedVar, BTSupU1, VarConst, AdvToolBar, AdvGlowButton, AdvToolBarStylers;

const

  WM_StartPolling = WM_APP + 2001;
  WM_ShutDown = WM_APP + 2002;
  VAOEntDirRootKey = HKEY_CURRENT_USER;
  VAOEntDirKey = 'Software\Exchequer\Enterprise';
  VAOEntName = 'SystemDir';



type

  TServiceCallBackProc = procedure(WhichFunc : Byte; const Msg : string = '') of Object;

  TfrmScheduler = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    Polling1: TMenuItem;
    Start1: TMenuItem;
    HideBackground1: TMenuItem;
    About1: TMenuItem;
    N1: TMenuItem;
    StatBar: TStatusBar;
    HelpContents1: TMenuItem;
    imgCentreLeft: TImage;
    imgTopRight: TImage;
    AdvStyler: TAdvToolBarOfficeStyler;
    AdvDockPanel: TAdvDockPanel;
    AdvToolBar: TAdvToolBar;
    Bevel0: TAdvToolBarSeparator;
    ToolButton2: TAdvGlowButton;
    btnExit: TAdvGlowButton;
    btnPause: TAdvGlowButton;
    btnStart: TAdvGlowButton;
    DDn1Btn: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Exit1Click(Sender: TObject);
    procedure HideBackground1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpContents1Click(Sender: TObject);
  private
    { Private declarations }
    FServiceCallBack : TServiceCallBackProc;
    Abort : Boolean;
    MDIDefProc:pointer;
    MDIInstance:TFarProc;
    FirstTime, FirstActivate : Boolean;

    FirstRun : Boolean; //PR: 11/01/2011 Set this to true until all companies have been polled once
                        //in order to allow crashed tasks to be reset to idle.
    AmClosing : Boolean;
    FlagsInUse : Boolean;
    FCoList, FDirList, FDebug : TStringList;
    EntPath, ToolkitVersion : string;
    MapiOk : Boolean;
    ToolkitOK : Boolean;
    FMappedDrive : String;
    FLocalPath : string;
    MyDC       : hDC;
    FPrevState : TWindowState;
    procedure MDIWndProc(var prmMsg:TMessage);
    procedure CreateWnd;override;
    procedure ShowBitmap(prmDC:hDC);

    procedure SentProgress(const TaskName, DataPath : string; OffLine : Boolean);
    function CheckPath(const DataPath : AnsiString) : Boolean;
    procedure DisplayHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    Procedure WMSysCommand(Var Message  :  TMessage); Message WM_SysCommand;
    procedure HideMe;
    procedure NotifyError(Sender : TObject; WhichType : Integer);
    procedure NotifyErrorSync;
    procedure WMSetFocus(var Msg : TMessage); message WM_SetFocus;
    function InBackupWindow : Boolean;
    procedure InitGlobalVars;
    function CloseFormPos : integer;
    procedure SetEnterpriseDir(const ADir : AnsiString);
    procedure LoadDirList;
    function Localise(const APath : string) : string;
    procedure SetServiceDriveStrings;
    function GetImagePath : string;
    procedure AddTaskToQueue(DataRec : TScheduledTaskRec; DataPath: string);
    Procedure Print_File(SetAddr  :  LongInt);
    procedure DoRequests;
    procedure InitialiseClientID;
  public
    { Public declarations }
    CurrentData : SmallInt;
    Running : Boolean;
    LocalPath : string;
    procedure Run(DataPath : AnsiString);
    procedure Start;
    procedure Stop;
    procedure ShutDown;

   { procedure WMStopPolling(var Msg : TMessage); message WM_StopPolling}
    procedure WMStartPolling(var Msg : TMessage); message WM_StartPolling;
    Procedure WMFormCloseMsg(Var Message  :  TMessage); Message WM_FormCloseMsg;
    Procedure WMShutDown(Var Message  :  TMessage); Message WM_ShutDown;

    //PR: 15/05/2017 ABSEXCH-18683 v2017 R1 Release process lock
    Procedure WMLockedProcessFinished(Var Message  :  TMessage); Message WM_LOCKEDPROCESSFINISHED;

    property ServiceCallBack : TServiceCallBackProc read FServiceCallBack write FServiceCallBack;

    procedure StartPolling;
    procedure StartVAO;

    property PrevState : TWindowState read FPrevState;
  end;

  procedure MapDriveFromIniFile;

var
  frmScheduler: TfrmScheduler;
  OurRef : string;
  DriveMapped : Boolean;




implementation


{$R *.DFM}
uses
  SchThred, ComObj, Enterprise01_TLB,
  CommsInt, ExThrd2U, {$IFNDEF SERVICE}TrayF,{$ENDIF} SecCodes, Variants,
   GlobVar, Btrvu2, APIUtil, CloseF, FileUtil, RegUtil,
  BtSupU2, UDebug, VAOUtil, Registry, ActiveX, StrUtils,  DataObjs, CtkUtil,
{$IFDEF EXSQL}
  SQLUtils,
{$ENDIF}
  LogF,

  GFXUtil,
  Brand,

  //PR: 13/12/2013 ABSEXCH-14845
  ServiceDrive,

  oProcessLock;

const
  ChkString = ' checking tasks';

var
  ClientID : ClientIDType;

procedure MapDriveFromIniFile;
var
  Res : Integer;
begin
  Res := ConnectNetworkDrive;
  DriveMapped := (Res in [NO_ERROR, ERROR_ALREADY_ASSIGNED]) or (Res = 1202);
end;

(* //PR: 13/12/2013 ABSEXCH-14845 Function moved to ServiceDrive.pas
function ConnectDrive(_drvLetter: string; _netPath: string; _showError: Boolean;
  _reconnect: Boolean): DWORD;
var
  nRes: TNetResource;
  errCode: DWORD;
  dwFlags: DWORD;
Begin // ConnectDrive
  { Fill NetRessource with #0 to provide uninitialized values }
  { NetRessource mit #0 f�llen => Keine unitialisierte Werte }
  FillChar(NRes, SizeOf(NRes), #0);
  nRes.dwType := RESOURCETYPE_DISK;
  { Set Driveletter and Networkpath }
  { Laufwerkbuchstabe und Netzwerkpfad setzen }
  nRes.lpLocalName  := PChar(_drvLetter);
  nRes.lpRemoteName := PChar(_netPath); { Example: \\Test\C }
  { Check if it should be saved for use after restart and set flags }
  { �berpr�fung, ob gespeichert werden soll }
  if _reconnect then
    dwFlags := CONNECT_UPDATE_PROFILE
  else
    dwFlags := CONNECT_TEMPORARY;

  //errCode := WNetAddConnection3(Form1.Handle, nRes, nil, nil, dwFlags);
  errCode := WNetAddConnection2(nRes, nil, nil, dwFlags);

  { Show Errormessage, if flag is set }
  { Fehlernachricht aneigen }
  if (errCode <> NO_ERROR) and (_showError) then
  begin
    Application.MessageBox(PChar('An error occured while connecting:' + #13#10 +
      SysErrorMessage(GetLastError)),
      'Error while connecting!',
      MB_OK);
  end;
  Result := errCode; { NO_ERROR }

End; // ConnectDrive
*)



function TfrmScheduler.CheckPath(const DataPath : AnsiString) : Boolean;
//Returns true if there's a scheduled task data file in the Company Dataset in DataPath
begin
{$IFDEF EXSQL}
  Result := SQLUtils.TableExists(IncludeTrailingBackSlash(DataPath) + TaskFileName);
{$ELSE}
  Result := FileExists(IncludeTrailingBackSlash(DataPath) + TaskFileName);
{$ENDIF}
end;

procedure TfrmScheduler.Run(DataPath : AnsiString);
var
  Res : Integer;
begin
  DoRequests;
  DataPath := Trim(DataPath);
  if CheckPath(DataPath) then
  begin
    //PR: 13/12/2010 Let other applications know the scheduler engine is running.
    UpdateSchedulerTimeStamp;
    if InBackupWindow then
    begin
      SentProgress('', '', True);
      SleepEx(60000, True);

    end
    else
    begin
      //Read all scheduled tasks in this company's datafile. If any are due to
      //run, add them to the thread queue.
      CompanyPath := DataPath;
      Res := TaskObject.OpenFile;
      //PR: 12/04/2011 Removed COM Toolkit opening and closing - wasn't needed and was causing problems.
      if Res = 0 then
      begin
        Res := TaskObject.FindRecord(B_GetFirst, '');

        while (Res in [0, 84, 85]) and not Abort do //If record locked then ignore it and go to next
        begin
          SentProgress(Trim(TaskObject.Name), DataPath,  False);
{          if TaskObject.TaskType in ['B', 'C'] then
            DoLog(Trim(TaskObject.Name) + ': Include: ' + IntToStr(TaskObject.IncludeInPost));}
          if FirstRun then
          begin
            if (Res = 0) and (TaskObject.Status = tsProcessing) then
            begin
              if TaskObject.OneTimeOnly then
                TaskObject.DeleteRec
              else
              begin
                if not TaskObject.Restart then
                  DoLog('Task ' + TaskObject.Name + ' has failed to run successfully three times.');
              end;
            end;
          end;

          if (Res = 0) and (TaskObject.Status = tsIdle) and (TaskObject.NextRunDue <= Now) then
          begin
            //LockRecord
            Res := TaskObject.FindRecord(B_GetEq, LJVar(TaskObject.Name, 50), True);
            if Res = 0 then
            begin
              TaskObject.Status := tsProcessing;
              TaskObject.PutRec;
              AddTaskToQueue(TaskObject.DataRecord, DataPath);
              DoLog('Path: ' + DataPath + '. Task ' +
                       QuotedStr(Trim(TaskObject.Name)) + ' added to queue.');
            end
            else
              Res := TaskObject.FindRecord(B_GetEq, LJVar(TaskObject.Name, 50));
          end;
          SleepEx(1000, True);
          Res := TaskObject.FindRecord(B_GetNext, '');
          DoRequests;
        end;
        SleepEx(1000, True);
        SentProgress('', DataPath,  False);
        Res := TaskObject.CloseFile;
      end;
    end;
  end;
end;

procedure TfrmScheduler.FormCreate(Sender: TObject);
const
  DbgFileName = 'DebugSentimail.txt';
var
  a, b, c : longint;
  Res : Word;
  Stat : longint;
begin
  DoLog('Current Dir: ' + GetCurrentDir);
  InitialiseClientID;
  Res := ConfigObject.OpenFile;
  if Res = 0 then
  begin
    ConfigObject.GetRecord;
  end
  else
  begin
    {$IFNDEF SERVICE}
    msgBox('Unable to open Configuration File. Application will terminate', mtError, [mbOK], mbOK, 'Exchequer Scheduler');
    {$ENDIF}
  end;
  MyDC := 0;
  Caption := SchedEngineName;
  Init_STDCurrList; //In btsupu2.pas
  {$IFNDEF SERVICE}
  if ParamCount > 0 then
    DebugModeOn := UpperCase(ParamStr(1))[2] = 'D'
  else
    DebugModeOn := False;
  {$ENDIF}
  WorkStationName := WinGetComputerName;
  HideBackGround1.Checked := NoXLogo;
//  MapiOK := ECMAPIAVAILABLE; //need this call for static linking of entcomms.dll
  FirstActivate := True;
  FirstRun := True;
  AmClosing := True;
  Abort := False;
  Running := False;
  {$IFNDEF VAO}
  Try
    oToolkit := CreateToolkitWithBackDoor;
//    DoLog('Toolkit created');
  Except
    oToolkit := nil;
    {$IFNDEF SERVICE}
    msgBox('Unable to create COM Toolkit. Application will terminate', mtError, [mbOK], mbOK, 'Exchequer Scheduler');
    Application.Terminate;
    {$ENDIF}
  End;
  {$ENDIF}

    FCoList := TStringList.Create;
    FDirList := TStringList.Create;
    FDebug := TStringList.Create;

    CurrentData := 0;

  {$IFNDEF SERVICE}
  Application.OnShowHint := DisplayHint;
  Application.HintPause := 100;
  {$ENDIF}
//  ProgressProc := SentProgress;
  InitGlobalVars;
  FPrevState := WindowState;

    With Branding.BrandingFile('E8263') Do
    Begin
      ExtractImageCD (imgCentreLeft, 'back-centre-left');
      ExtractImageCD (imgTopRight, 'back-top-right');
    End; // With Branding.BrandingFile('E8263')
  

 {$IFNDEF SERVICE}
  PostMessage(Self.Handle, WM_StartPolling, 0, 0);
 {$ENDIF}
end;


procedure TfrmScheduler.ToolButton2Click(Sender: TObject);
var
  i : integer;
begin
  if FirstActivate then
  begin
    Create_BackThread;
    FirstActivate := False;
  end;

  if not InBackupWindow then
  begin
    if Running then
    begin
      Running := False;
      Start1.Caption := '&Resume';
{      Start1.ImageIndex := 1;
      ToolButton2.ImageIndex := 1;
//      ToolButton2.Hint := Start1.Caption;
}
      ToolButton2.Picture.Assign(btnStart.Picture);

      DoLog('Scheduler paused');
      Application.ProcessMessages;
      Stop;
      PollThread.Terminate;
      StatBar.Panels[1].Text := 'Paused';
     //
    end
    else
    begin
//      Reset_B;
      Start1.Caption := '&Pause';
{      Start1.ImageIndex := 0;
      ToolButton2.ImageIndex := 0;
//      ToolButton2.Hint := 'Stop' + ChkString;
}

      ToolButton2.Picture.Assign(btnPause.Picture);

      DoLog('Scheduler started');
      Application.ProcessMessages;
      {$IFDEF VAO}
      PollProc := StartVAO;
      {$ELSE}
      PollProc := Start;
      {$ENDIF}

      Running := True;
      Abort := False;


      PollThread := TPollThread.Create;
      ErrorProc := NotifyErrorSync;

      ResetCloseFlags;
      Pollthread.Resume;
    end;
    ToolButton2.Hint := Copy(Start1.Caption, 2, 6);
    {$IFNDEF SERVICE}
    if not FirstTime then
      frmSchedTray.SetPause;
    {$ENDIF}
  end;
end;

procedure TfrmScheduler.FormDestroy(Sender: TObject);
begin
  ConfigObject.CloseFile;
  oToolkit := nil;
  STDCurrList.Free; //In btsupu2.pas
  if Assigned(FCoList) then
    FCoList.Free;
  if Assigned(FDirList) then
    FDirList.Free;
  Try
    if Assigned(PollThread) then
      PollThread.Terminate;
  Except
  End;
  {$IFDEF SERVICE}
  Try
    if Assigned(BackThread) then
    begin
      while not BackThread.AllClear do
        SleepEx(100, True);
      FreeAndNil(BackThread);
    end;
  Except
  End;
  {$ENDIF}
end;

procedure TfrmScheduler.Start;
begin
  SentinelsSoFar := 0;
  Abort := False;
  while not Abort and not PollThread.IsTerminated do
  begin
    Running := True;
    if Not Abort then
    begin
      Run(FCoList[CurrentData]);
    end;
    Running := False;
    {$IFNDEF SERVICE}
    Application.ProcessMessages;
    {$ENDIF}
    if Not Abort then
      inc(CurrentData);
    if CurrentData > Pred(FCoList.Count) then
    begin
      CurrentData := 0;
      FirstRun := False;
    end;
  end;
end;

procedure TfrmScheduler.Stop;
begin
  Abort := True;
  Running := False;
end;

procedure TfrmScheduler.SentProgress(const TaskName, DataPath : string; OffLine : Boolean);
var
  i, j : longint;
begin
    if Offline then
      StatBar.Panels[1].Text := 'Offline'
    else
      if Running then
        StatBar.Panels[1].Text := 'Polling ' + DataPath + ' - Checking Task ' +
                                 QuotedStr(Trim(TaskName));
  {$IFNDEF SERVICE}
  Application.ProcessMessages;
  {$ENDIF}
end;


procedure TfrmScheduler.MDIWndProc(var prmMsg:TMessage);
begin
 with prmMsg do
  begin
   if (Msg=WM_ERASEBKGND) and not HideBackGround1.Checked then
    begin
      ShowBitmap(wParam);
      Result :=1;
    end
{    else
    if Msg = WM_SetFocus then
      WMSetFocus(prmMsg)     }
    else
    Result:=CallWindowProc(MDIDefProc,ClientHandle,Msg,wParam,lParam);
  end;
end;

procedure TfrmScheduler.CreateWnd;
begin
 inherited CreateWnd;
 MDIInstance:=MakeObjectInstance(MDIWndProc); { create wrapper }
 MDIDefProc:=pointer(SetWindowLong(ClientHandle,GWL_WNDPROC,
     longint(MDIInstance)) );
end;

procedure TfrmScheduler.ShowBitmap(prmDC:hDC);
Var
//  MyDC       : hDC;
  Ro, Co     : Word;
  MyDC       : hDC;
//  Ro, Co     : Word;
  OldPalette : HPalette;
  BackgroundRect: TRect;
//  X, Y,
  bgHeight, bgWidth, clTop, clRight, trLeft, trBottom: Integer;
//  BlitResult: Boolean;
Begin
  MyDC := prmDC;

  OldPalette:=SelectPalette(MyDC,imgCentreLeft.Picture.BitMap.Palette,False);
  try
    RealizePalette(MyDC);

    (***
    { CJS 2012-09-07 ABSEXCH-12952 - Rebranding - Background bitmap handling }
    X := 0;
    Y := self.ClientHeight - StatusBar.Height - AdvToolbar.Height - 6 - Image1.Picture.Height;
    if (Y < 0) then
      Y := 0;

    BackgroundRect := Rect(0, 0, ClientWidth, Y);
    FillRect(MyDC, BackgroundRect, clWhite);

    BackgroundRect := Rect(Image1.Picture.Width, Y, ClientWidth, ClientHeight - StatusBar.Height - 6 - AdvToolbar.Height);
    FillRect(MyDC, BackgroundRect, clWhite);

    BlitResult := BitBlt(MyDC, 0, Y, Image1.Picture.Width, Image1.Picture.Height,
                         Image1.Picture.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
    if not BlitResult then
      OutputDebugString('BitBlt failed');
    ***)

    //
    // To avoid flickering the background is painted in 6 blocks
    //
    //    +----------+--------+--------+
    //    |          |        |   TR   |
    //    |    B1    |        +--------+
    //    |          |        |        |
    //    +----------+        |        |
    //    |    CL    |   B3   |        |
    //    +----------+        |   B4   |
    //    |          |        |        |
    //    |    B2    |        |        |
    //    |          |        |        |
    //    +----------+--------+--------+
    //

    // Calculate the height of the area we are putting the background in
    bgHeight := self.ClientHeight - StatBar.Height - AdvToolbar.Height - 6; // WTF does 6 come from?
    bgWidth := Self.ClientWidth; // - GetSystemMetrics(SM_CXVSCROLL) - 4;

    // Calculate the position of the Centre-Left bitmap (CL)
    clTop := (bgHeight - imgCentreLeft.Picture.Height) Div 2;
    clRight := imgCentreLeft.Picture.Width;

    // Calculate the position of the Top-Right bitmap (TR)
    trLeft := bgWidth - imgTopRight.Picture.Width;
    trBottom := imgTopRight.Picture.Height;

    // Paint in background B1 above Centre-Left bitmap
    BackgroundRect := Rect(0, 0, clRight, clTop);  // LTRB
    FillRect(MyDC, BackgroundRect, clRed);//clWhite);

    // Paint in background B2 below Centre-Left bitmap
    BackgroundRect := Rect(0, clTop + imgCentreLeft.Picture.Height, clRight, bgHeight);  // LTRB
    FillRect(MyDC, BackgroundRect, clWhite);

    // Paint in Centre-Left bitmap (CL)
    BitBlt(MyDC, 0, clTop, imgCentreLeft.Picture.Width, imgCentreLeft.Picture.Height,
           imgCentreLeft.Picture.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);

    If ((clRight + 1) < trLeft) Then
    Begin
      // Paint in central background column B3
      BackgroundRect := Rect(clRight, 0, trLeft, bgHeight);  // LTRB
      FillRect(MyDC, BackgroundRect, clWhite);
    End; // If ((clRight + 1) < trLeft)

    // Paint in Top-Right bitmap (TR)
    BitBlt(MyDC, trLeft, 0, imgTopRight.Picture.Width, imgTopRight.Picture.Height,
           imgTopRight.Picture.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);

    // Paint in background B4 below Top-Right bitmap
    BackgroundRect := Rect(trLeft, imgTopRight.Picture.Height, bgWidth, bgHeight);  // LTRB
    FillRect(MyDC, BackgroundRect, clWhite);
  finally
    SelectPalette(MyDC,OldPalette,true);
  end; {try..}
end;

procedure TfrmScheduler.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  T : Integer;
  TerminateNow : Boolean;
  FinishCount : longint;
begin
  TerminateNow := False;
  Poller_WantToClose := True;
  {$IFNDEF SERVICE}
  if ToolButton2.ImageIndex <> 1 then
    ToolButton2Click(Self);
  Application.ProcessMessages;
  Application.ProcessMessages;
  Show;
  Abort := True;
  Application.ProcessMessages;
  Sleep(100);
  Application.ProcessMessages;

  if AnyTasksInUse then
  begin
    with TfrmSchedCloseStatus.Create(Self) do
    Try
      T := CloseFormPos;
      if T + Height < Screen.Height then
        Top := T;
      Show;
      Application.ProcessMessages;
      Sleep(100);
      while AnyTasksInUse and not TerminateNow do
      begin
        Application.ProcessMessages;
        SleepEx(1, True);
{        SetActiveLabel(0, Poller_OkToClose);
        SetActiveLabel(1, GetQuery_OkToClose);
        SetActiveLabel(2, Conveyor_OkToClose);}
        IncProgress;
        TerminateNow := DoTerminate;
{        if DoTerminate then
          Application.Terminate;}
        Application.ProcessMessages;
        if TerminateNow then
        begin
          //If we have any tasks queued in the object controller, their current status will be 'processing'.
          //We need to reset them to idle, so they will be run when the engine runs again.
          if not Running then
            ResetQueuedTasks;
        end;
      end;
      Close;
    Finally
      Free;
    End;
  end;
  {$ELSE}
  FinishCount := 1;
  while AnyTasksInUse and (FinishCount < ServiceTimeOut) do
  begin
    Application.ProcessMessages;
    SleepEx(1000, True);
    inc(FinishCount);
  end;
  {$ENDIF}
  CanClose := True;
end;

{procedure WMStopPolling(var Msg : TMessage); message WM_StopPolling;
procedure WMStartPolling(var Msg : TMessage); message WM_StartPolling;}


procedure TfrmScheduler.Exit1Click(Sender: TObject);
begin
  HideMe;
end;

procedure TfrmScheduler.HideBackground1Click(Sender: TObject);
begin
  HideBackGround1.Checked := not HideBackGround1.Checked;
  InvalidateRect(0, nil, True);
  Application.ProcessMessages;
end;

procedure TfrmScheduler.About1Click(Sender: TObject);
begin
  with TfrmAbout.Create(nil) do
  Try
    lblTitle.Caption := SchedEngineName;
    lblVersion.Caption := 'Version: ' + SchedulerVersion;
    ShowModal;
  Finally
    Free;
  end;
end;

procedure TfrmScheduler.DisplayHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if Assigned(HintInfo.HintControl) then
    StatBar.Panels[0].Text := GetLongHint(HintInfo.HintControl.Hint);
end;

procedure TfrmScheduler.FormResize(Sender: TObject);
begin
  if not HideBackGround1.Checked then
  begin
    InvalidateRect(0, nil, False);
    Application.ProcessMessages;
  end;
{  if MyDC <> 0 then
    ShowBitmap(MyDC);}
  StatBar.Panels[0].Width := StatBar.Width div 2;
  FPrevState := WindowState;
end;


Procedure TfrmScheduler.WMSysCommand(Var Message  :  TMessage);
begin
//Intercept close commands from form and just hide it
   if (Message.wParam = SC_CLOSE) {or (Message.wParam = SC_MINIMIZE) }then
   begin
     HideMe;
   end
   else
     Inherited;
end;

procedure TfrmScheduler.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  WaitCount : integer;
begin
   if Running then
     ToolButton2Click(Self);
   WaitCount := 1;
   While FlagsInUse and (WaitCount < 11) do
   begin
     Sleep(10);
     inc(WaitCount);
   end;

   Application.ProcessMessages;
   SetWindowLong(ClientHandle,GWL_WNDPROC,longint(MDIDefProc));
 { dispose of instance }
   FreeObjectInstance(MDIInstance);
end;

procedure TfrmScheduler.HideMe;
begin
   Hide;
end;

procedure TfrmScheduler.FormHide(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmScheduler.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOW);
  FormResize(Self);
end;


procedure TfrmScheduler.NotifyError(Sender : TObject; WhichType : Integer);
begin
 {$IFNDEF SERVICE}
  frmSchedTray.SetTrayIcon(icError);
 {$ENDIF}
end;

procedure TfrmScheduler.WMSetFocus(var Msg : TMessage);
var
  OtherID, MyID : Longint;
  p : PChar;
begin
{  if not Visible then
  with Msg do
  begin
    GetMem(p, 256);
    GetWindowText(HWnd(wParam),
    OtherID := GetWindowThreadProcessId(HWnd(wParam), nil);
    MyID := GetCurrentThreadId;
    if AttachThreadInput(MyID, OtherID, True) then
    begin
      Windows.SetFocus(HWnd(wParam));
      AttachThreadInput(MyID, OtherID, False);
      Result := 0;
    end;
  end;}
end;



function TfrmScheduler.InBackupWindow : Boolean;
var
  t1Start, t1End, T : TDateTime;
  FCrossMidnight : Boolean;

  function GetTime(const s : string) : TDateTime;
  begin
    Try
      Result := StrToTime(s);
    Except
      Result := 0;
    End;
  end;

begin
  Result := IsInBackupWindow(Now);
{  Result := False;
  ConfigObject.OpenFile;
  Try
    ConfigObject.GetRecord;
    t1Start := ConfigObject.StartTime;
    t1End := ConfigObject.EndTime;

    FCrossMidnight := t1Start > t1End;



    T := Now;
    T := T - Trunc(T);

    if FCrossMidnight then
      Result := (T > t1Start) or (T < t1End)
    else
      Result := (T > t1Start) and (T < t1End);
  Finally
    ConfigObject.CloseFile;
  End;}
end;

procedure TfrmScheduler.NotifyErrorSync;
begin
 // NotifyError(ErrorSender, ErrorTransType);
end;

procedure TfrmScheduler.WMStartPolling(var Msg : TMessage);
begin
  StartPolling;
end;



procedure TfrmScheduler.InitGlobalVars;
var
  i : integer;
  a, b, c : longint;
begin
  {$IFDEF VAO}
  ResetVAOInfo;
  oToolkit := nil;
  SleepEx(1000, True);
  oToolkit := CreateOLEObject('Enterprise01.Toolkit') as IToolkit;
  {$ENDIF}
  if Assigned(oToolkit) then
  begin
    FCoList.Clear;
    ToolkitVersion := oToolkit.Version;
    {$IFDEF SERVICE}
    if not DriveMapped then
      SetServiceDriveStrings;
    {$ENDIF}
    for i := 1 to oToolkit.Company.cmCount do
    {$IFNDEF SERVICE}
      FCoList.Add(Trim(oToolkit.Company.cmCompany[i].coPath));
    {$ELSE}
      FCoList.Add(Localise(Trim(oToolkit.Company.cmCompany[i].coPath)));
    {$ENDIF}
{    FCoList.SaveToFile('c:\complist.txt');
    FDebug.SaveToFile('c:\debug.txt');}
    GlobalEntPath := GetEnterpriseDirectory;
    EntPath := GlobalEntPath;
    {$IFDEF VAO}
    {$ELSE}
//    LogDir := GlobalEntPath + 'LOGS\';
    {$ENDIF}
  end;
{  for i := 0 to FCoList.Count - 1 do
    DoLog(FCoList[i]);}
end;


procedure TfrmScheduler.HelpContents1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

function TfrmScheduler.CloseFormPos : integer;
var
  P : TPoint;
  i : integer;
  t, h : integer;
begin
  t := 0;
  h := 0;
  
  for i := 0 to MDIChildCount - 1 do
    if Pos('Object', MDIChildren[i].Caption) > 0 then
    begin
      t := MDIChildren[i].Top;
      h := MDIChildren[i].Height;
    end;
  P := Point(0, t);

  P := ClientToScreen(P);

  if P.Y < 250 then
  begin
    P := Point(0, t + h + 16);
    P := ClientToScreen(P);
  end
  else
    P.Y := P.Y - 250;

  Result := P.Y;
end;







procedure TfrmScheduler.StartPolling;
begin
  {$IFDEF SERVICE}
   {$IFNDEF VAO}
{   if not CheckLicenceOK then
   begin
     if Assigned(FServiceCallBack) then
       FServiceCallBack(1, 'Sentimail is not licenced. Closing down.');
   end
   else}
   if not Assigned(oToolkit) then
   begin
     if Assigned(FServiceCallBack) then
       FServiceCallBack(1, 'Unable to create COM Toolkit. Closing down.');
   end
   else
   {$ENDIF}
   begin
  {$ENDIF}
  FirstTime := True;
  DoLog('Start Polling');
  ToolButton2Click(Self);
  FirstTime := False;
  {$IFDEF SERVICE}
  end;
  {$ENDIF}
end;

procedure TfrmScheduler.ShutDown;
begin
  if Running then
    ToolButton2Click(Self);
  Stop;
  SleepEx(2000, True);
  Close;
end;

procedure TfrmScheduler.SetEnterpriseDir(const ADir : AnsiString);
begin
  with TRegistry.Create do
  Try
    LazyWrite := False;
    RootKey := VAOEntDirRootKey;
    OpenKey(VAOEntDirKey, True);
    WriteString(VAOEntName, ADir);
  Finally
    Free;
  End;
end;


procedure TfrmScheduler.LoadDirList;
//Used by vao service to create a list of Exchequer directories
var
  SRec : TSearchRec;
  s, DirMask, SubDir : string;
begin
{  with TElertWorkstationSetup.Create do
  Try
    DirMask := VAODirPrefix + '*';
    SubDir := IncludeTrailingBackslash(VAOSubDir);
  Finally
    Free;
  End;}

  FDirList.Clear;
  if FindFirst(DirMask, faDirectory, SRec) = 0 then
  begin
    repeat
      s := Copy(DirMask, 1, 3) + IncludeTrailingBackslash(SRec.Name);
{$IFDEF EXSQL}
      // MH 20/09/07: Modified to check for an Exchequer System directory as Company.Dat was never
      // present in additional company directories 
      //if SQLUtils.ValidCompany(s + SubDir) then
      if SQLUtils.ValidSystem(s + SubDir) then
{$ELSE}
      if FileExists(s + SubDir + 'Company.Dat') then
{$ENDIF}
        FDirList.Add(s + SubDir);
      Application.ProcessMessages;
    until FindNext(SRec) <> 0;
    FindClose(SRec);
  end;
end;

procedure TfrmScheduler.StartVAO;
var
  CurrentDir : Integer;
begin
  SentinelsSoFar := 0;
  Abort := False;
  LoadDirList;
  CurrentDir := 0;
  CoInitialize(nil);
  while not Abort and not PollThread.IsTerminated do
  begin
    Running := True;

    SetEnterpriseDir(FDirList[CurrentDir]);
    InitGlobalVars;

    while not Abort and not PollThread.IsTerminated and (CurrentData < FCoList.Count) do
    begin
      if Not Abort then
      begin
        Run(FCoList[CurrentData]);
      end;
      Application.ProcessMessages;
      if Not Abort then
      inc(CurrentData);

    end; //while

    if CurrentData > Pred(FCoList.Count) then
    begin
      CurrentData := 0;
      SentinelsSoFar := 0;
      while not BackThread.AllClear do
        SleepEx(100, True);
      inc(CurrentDir);
      if CurrentDir > Pred(FDirList.Count) then
      begin
        LoadDirList; //refresh directories
        CurrentDir := 0;
      end;
    end;

  end; //while

end;

function TfrmScheduler.Localise(const APath: string): string;
begin
  {$IFNDEF VAO}
  if SQLUtils.UsingSQL then //PR: 10/12/2010 ABSEXCH-10152 - don't localise path for SQL version as it won't recognise it!
    Result := APath
  else
  begin
    Result := AnsiReplaceStr(APath, FMappedDrive, FLocalPath);
    Result := WinGetShortPathName(Result);
    FDebug.Add('Localise: ' + APath + ', Result: ' + Result);
  end;
  {$ELSE}
   Result := APath;
  {$ENDIF}
end;

procedure TfrmScheduler.SetServiceDriveStrings;
var
  s, NetPath : string;
  i, j, Res : integer;
begin
  LocalPath := ExtractFilePath(ParamStr(0));
  //PR 24/02/2009 Need to shorten long path names to compare with MCM path names
  LocalPath := UpperCase(WinGetShortPathName(LocalPath));
  FDebug.Add('LocalPath: ' + LocalPath);
  with oToolkit.Company do
  begin
    for i := 1 to cmCount do
    begin
      s := UpperCase(Trim(cmCompany[i].coPath));
      FMappedDrive := Copy(s, 1, 3);
      ServiceMappedDrive := FMappedDrive;
      FDebug.Add('FMappedDrive: ' + FMappedDrive);
      s := Copy(s, 4, Length(s));
      FDebug.Add('s : ' + s);
      j := Pos(s, LocalPath);
      if j > 0 then
      begin
        FLocalPath := IncludeTrailingBackslash(Copy(LocalPath, 1, j - 1));
        ServiceLocalDir := FLocalPath;
        FDebug.Add('FLocalPath: ' + FLocalPath);
        Break;
      end;

    end;
  end;
  NetPath := FLocalPath;
  //PR: 16/08/2011 Leave drive letter and use full local path to find correct share name.
//  Delete(NetPath, 1, 2); //Remove drive letter + ':'
  if NetPath[Length(NetPath)] = '\' then
    Delete(NetPath, Length(NetPath), 1);
  NetPath := '\\' + WinGetComputerName + '\' + GetShareNameFromPath(NetPath);

  //PR: 13/12/2013 ABSEXCH-14845 Changed to call ConnectNetworkDrive rather than ConnectDrive
  Res := ConnectNetworkDrive(Copy(FMappedDrive, 1, 2), NetPath);
  DoLog('Network Path = ' + QuotedStr(NetPath));
  if (Res in [NO_ERROR, ERROR_ALREADY_ASSIGNED]) then
  begin
    DoLog(NetPath + ' mapped to ' + Copy(FMappedDrive, 1, 2) + ' ' + IntToStr(Res)) ;
  end
  else
  begin
    DoLog('Error: ConnectDrive returned  ' + IntToStr(Res));
  end;

end;

function TfrmScheduler.GetImagePath: string;
begin
  with TRegistry.Create(KEY_READ) do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('SYSTEM\CurrentControlSet\Services\' + 'SentimailService', False) then
    begin
      Result := UpperCase(ExtractFilePath(ReadString('ImagePath')));
    end;
  finally
    Free;
  end;


end;

procedure TfrmScheduler.AddTaskToQueue(DataRec : TScheduledTaskRec; DataPath: string);
var
  ANom     :  NominalRec;
  AJob     :  JobRecType;
begin
  if not Abort then
  begin
    //We need to keep a record of tasks currently queued to avoid losing them if the application is closed.
    AddInUse(DataPath, DataRec.stTaskName);
    Case DataRec.stTaskType of
      tcView           : begin
                           FillChar(ANom, SizeOf(ANom), 0);
                           ANom.CarryF := StrToInt(Copy(DataRec.stTaskID, 1, 4));
                           ANom.AltCode := DataRec.stTaskName;
                           AddSchedCheckNom2Thread(Self, ANom, AJob, 6, DataPath);
                         end;
      tcSalesDaybook..tcStockDaybook
                       : begin
                           AddSchedPost2Thread(Ord(DataRec.stTaskType) - Ord(tcView),
                                               Self,
                                               GetDocTypesInPost(DataRec.stIncludeInPost),
                                               DataRec.stPostSeparated, DataRec.stPostProtected,
                                               DataRec.stTaskName,
                                               DataPath,
                                               DataRec.stEmailAddress);
                         end;
      tcJobDaybook     : begin
                           AddSchedJobPost2Thread(0, Self, DataRec.stIncludeInPost,
                                                  DataRec.stPostSeparated, DataRec.stPostProtected,
                                                  DataRec.stTaskName,
                                                  DataPath, DataRec.stEmailAddress);
                         end;
      else
        AddCustomTask2Thread(Self, DataRec.stTaskName, DataRec.stCustomClassName, DataPath);
    end; //Case
  end;
end;

procedure TfrmScheduler.Print_File(SetAddr: Integer);
begin
  If (Assigned(BackThread)) then
  Try
    BackThread.PrintJobAddr:=SetAddr;
    BackThread.Print_ThJob;
  except;

  end; {Try..}
end;

procedure TfrmScheduler.WMFormCloseMsg(var Message: TMessage);
begin
  With Message do
  Begin

    Case WParam of
      98  :  Print_File(LParam);
    end;
  end;
end;

procedure TfrmScheduler.DoRequests;
begin
  if Assigned(FServiceCallBack) then
    FServiceCallback(3);
end;

procedure TfrmScheduler.WMShutDown(var Message: TMessage);
begin
  ShutDown;
end;

procedure TfrmScheduler.InitialiseClientID;
begin
  FillChar(ClientID, SizeOf(ClientID), 0);
  ClientID.AppId[1] := 'S';
  ClientID.AppId[2] := 'C';
  ClientID.TaskId := 1;
  TaskObject.ClientID := @ClientID;
end;


procedure TfrmScheduler.WMLockedProcessFinished(var Message: TMessage);
begin
  if SQLUtils.UsingSQLAlternateFuncs and (TProcessLockType(Message.WParam) <> plNone) then
    RemoveCurrentProcessLock(TProcessLockType(Message.WParam));
end;

Initialization

finalization



end.
