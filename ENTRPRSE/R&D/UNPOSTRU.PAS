unit UnPostRU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,BTSupU3,
  Repinp1u, ExtCtrls, SBSPanel, StdCtrls, TEditVal, bkgroup, Animate,
  BorBtns, Mask;

type
  TUnpostRInp = class(TRepInpMsg)
    Label84: Label8;
    Label81: Label8;
    PostFF: TCurrencyEdit;
    Post2F: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkCP1BtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    CRepParam  :    PUnPostPtr;

  public
    { Public declarations }
  end;


procedure UnPostxRunNo(AOwner  :  TComponent);


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Implementation

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Uses
  ETStrU,
  ETDateU,
  ETMiscU,
  GlobVar,
  VarConst,
  SysU1,
  UnPostU,
  BTSupU2,
  BTSupU1,

  oProcessLock;

{$R *.DFM}

procedure TUnpostRInp.FormCreate(Sender: TObject);

begin
  inherited;
  //PL: 22/09/2016 ABSEXCH-15418 Reset ClientHeight 140 from 175 Due to UI changes
  ClientHeight:=140;
  ClientWidth:=299;

  New(CRepParam);

  try
    FillChar(CRepParam^,Sizeof(CRepParam^),0);
  except
    Dispose(CRepParam);
    CRepParam:=nil;
  end;


  SetLastValues;

  PostFF.Value:=Pred(GetNextCount(RUN,BOff,BOff,0));
  Post2F.Value:=PostFF.Value;

end;

procedure TUnpostRInp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (Assigned(CRepParam)) then
    Dispose(CRepParam);

  //PR: 15/05/2017 ABSEXCH-18683 v2017 R1 Release process lock if cancelled
  if ModalResult <> mrOK then
    SendMessage(Application.MainForm.Handle, WM_LOCKEDPROCESSFINISHED, Ord(plUnpost), 0);
end;



procedure TUnpostRInp.OkCP1BtnClick(Sender: TObject);
begin
  If (Sender=OkCP1Btn) then
  Begin
    If (PostFF.Value<=Post2F.Value) then
    Begin
      OKCP1Btn.Enabled:=BOff;

      With CRepParam^ do
      Begin
        { PL: 22/09/2016 ABSEXCH-15418 Removed checkbox available on 'Unpost by
         Posting Run Number' needs to be set UnResetVAT:= BOff }
        UnResetVAT:= BOff;

        FromRunUP:=Round(PostFF.Value);
        ToRunUP:=Round(Post2F.Value);

        AddRunUnpost2Thread(Owner,CRepParam^);
      end;
    end
    else
      ShowMessage('The starting Run number must be smaller then the finish Run number.');
  end;

  inherited;

end;




procedure TUnpostRInp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {}
  Inherited;
end;

procedure TUnpostRInp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {}
  Inherited;
end;


procedure UnPostxRunNo(AOwner  :  TComponent);



Var
  RepInpMsg1  :  TUnpostRInp;

Begin
  RepInpMsg1:=TUnpostRInp.Create(AOwner);

  try
  except
    RepInpMsg1.Free;
  end;

end;


end.
