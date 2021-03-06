unit uSettings;

{$ALIGN 1}

interface

uses
  Graphics, Forms, Controls, Classes, Dialogs, uBtrv, SysUtils, BTUtil, uMultiList
  , FileUtil, GfxUtil, StrUtil, APIUtil, BTConst;

const
  mrRestoreDefaults = mrRetry;

type
  TFormSettings = class
  private
    fBufferSize: integer;
    fFileVar: TFileVar;
    fEXEName : string;
    fUserName: string20;
    procedure SetEXEName(const Value: string);
    procedure SetUserName(const Value: string20);
  protected
    procedure CloseFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ExportBtrieveFileTo(sFileName : string);
    procedure SaveList(TheList : TMultiList; sFormName : string);
    procedure LoadList(TheList : TMultiList; sFormName : string);
    procedure SaveParentFromControl(TheControl : TControl; sFormName : string; sParentName : string = '');
    procedure LoadParentToControl(sParentName, sFormName : string; TheControl : TControl);
    procedure LoadForm(TheForm : TForm); overload;
    procedure LoadForm(TheForm : TForm; var bSaveCoords : boolean); overload;
//    procedure SaveForm(TheForm : TForm); overload;
    procedure SaveForm(TheForm : TForm; bSaveCoord : boolean = TRUE);
    procedure RestoreListDefaults(TheList : TMultiList; sFormName : string);
    procedure RestoreParentDefaults(TheParent : TWinControl; sFormName : string);
    procedure RestoreFormDefaults(sFormName : string);
    procedure ColorFieldsFrom(TheControl : TControl; TheParent : TWinControl; iTag : integer = 0);
    function Edit(TheList : TMultiList; sFormName : string; TheControl : TControl) : TModalResult;
    procedure CopyList(FromList, ToList : TMultiList); 
    property EXEName : string read fEXEName write SetEXEName;
    property UserName : string20 read fUserName write SetUserName;
//    property LocalDir : string read fLocalDir write SetLocalDir;
  end;

  Function oSettings : TFormSettings;

var
  sMiscDirLocation : string;

implementation
uses
  CheckLst, ExtCtrls, OutLine, Mask, ComCtrls, StdCtrls, EditSettEnt, SBSOutL;

Var
  oLSettings : TFormSettings;

const

  fsNumOfKeys = 1;
  fsNumSegments = 2;

  fsLookupIdx = 0;

  FILENAME = 'Misc\Settings.dat';

  FS_LIST = 'L';
  FS_FORM = 'F';
  FS_PARENT = 'P';

type

  TFontStyleRec = record
    fnsBold : boolean;
    fnsItalic : boolean;
    fnsUnderline : boolean;
    fnsStrikeOut : boolean;
  end;

  TFontRec = record
    fntColor: TColor;
    fntSize: LongInt;
    fntStyle: TFontStyleRec;
    fntName: String[32];
    fntSpare: Array [1..25] of Char;
  end;

  TColumnOrderRec = array[0..59] of Byte;
  TColumnWidthsRec = array[0..59] of SmallInt;

  TListSettingsRec = Record
    lsMainFont : TFontRec;
    lsHeaderFont : TFontRec;
    lsHighlightFont : TFontRec;
    lsMultiSelectFont : TFontRec;
    lsMainBackColor : TColor;
    lsHighlightColor : TColor;
    lsMultiSelectColor : TColor;
    lsColumnOrder : TColumnOrderRec;
    lsColumnWidths : TColumnWidthsRec;
    lsSpare            : Array [1..200] of Char;
  end;

  TParentSettingsRec = Record
    psParentFont : TFontRec;
    psParentColor : TColor;
  end;

  TFormSizeSettingsRec = Record
    fssTop : LongInt;
    fssLeft : LongInt;
    fssHeight : LongInt;
    fssWidth : LongInt;
    fssSaveCoordinates : boolean; //nf: added 11/02/2004
  end;

  TFormSettingsRec = record
    fsRecType : char;           // L = List Settings, P = Parent Settings, F = FormSettings
    fsLookup : String[120];     // ApplicationName + UserName + FormName ( + ParentName / ListName)
    fsDummyChar : char;         // for botching integer indexes

    Case byte of
      1 : (fsList : TListSettingsRec;);
      2 : (fsParent : TParentSettingsRec;);
      3 : (fsForm : TFormSizeSettingsRec;);
  end;{TillSalesRec}

  TFormSettingsFileDef = Record
    RecLen,
    PageSize,
    NumIndex  : SmallInt;
    NotUsed   : LongInt;
    Variable  : SmallInt;
    reserved : array[1..4] of Char;
    KeyBuff  : array[1..fsNumSegments] of KeySpec;
    AltColt : TAltColtSeq;
  end;

var
  SettingsFile : TFormSettingsFileDef;
  SettingsRec : TFormSettingsRec;

Function oSettings : TFormSettings;
// Function Called to create Object
Begin{oSettings}
  if (not Assigned(oLSettings)) then begin
    oLSettings := TFormSettings.Create;
    oLSettings.UserName := StringOfChar(' ', 20);
  end;{if}

  Result := oLSettings;
End;{oSettings}


constructor TFormSettings.Create;

  Procedure OpenBTFile;
  var
    iFileNo, iOpenStatus : integer;

    Procedure DefineSettingsFile;
    Begin{DefineSettingsFile}
      With SettingsFile do
      begin
        Fillchar(SettingsFile,Sizeof(SettingsFile),#0);

        RecLen := Sizeof(TFormSettingsRec);
//        PageSize := DefPageSize;                     { 1024 bytes }
        PageSize := DefPageSize2;                     { 1536 bytes }
        NumIndex := fsNumOfKeys;

        Variable:=B_Variable+B_Compress+B_BTrunc;  { Used for max compression }

        // Index 0 : lsLookupIdx = lsRecType + lsLookup
        KeyBuff[1].KeyPos := BtKeyPos(@SettingsRec.fsRecType, @SettingsRec);
        KeyBuff[1].KeyLen := 1;
        KeyBuff[1].KeyFlags := ModSeg + AltColSeq;

        KeyBuff[2].KeyPos := BtKeyPos(@SettingsRec.fsLookup[1], @SettingsRec);
        KeyBuff[2].KeyLen := SizeOf(SettingsRec.fsLookup) - 1;
        KeyBuff[2].KeyFlags := Modfy + AltColSeq;

        AltColt:=UpperALT;   { Definition for AutoConversion to UpperCase }
      End; { With }

      Fillchar(SettingsRec,Sizeof(SettingsRec),#0);

    end;{DefineSettingsFile}

  begin{OpenBTFile}
    // define file structures
    DefineSettingsFile;

    // open file
    if FileExists(sMiscDirLocation + FILENAME) then iOpenStatus := 0
    else begin
      iOpenStatus := BTMakeFile(fFileVar, sMiscDirLocation + FILENAME, SettingsFile, SizeOf(SettingsFile));
      BTShowError(iOpenStatus, 'BTMakeFile', sMiscDirLocation + FILENAME);
    end;{if}

    if iOpenStatus = 0 then begin
      iOpenStatus := BTOpenFile(fFileVar, sMiscDirLocation + FILENAME, 0);
      BTShowError(iOpenStatus, 'BTOpenFile', sMiscDirLocation + FILENAME);
    end;{if}
  end;{OpenBTFile}

begin
  fBufferSize:= SizeOf(TFormSettingsRec);

//  if not(csDesigning in ComponentState) then begin
    fEXEName := ExtractFileName(Paramstr(0));
    OpenBTFile;
//  end;{if}
end;

function FontStyleRec2FontStyles(FontStyleRec : TFontStyleRec) : TFontStyles;
var
  TheFontStyles : TFontStyles;
begin
  TheFontStyles := [];
  with FontStyleRec do begin
    if fnsBold then TheFontStyles := TheFontStyles + [fsBold];
    if fnsItalic then TheFontStyles := TheFontStyles + [fsItalic];
    if fnsStrikeOut then TheFontStyles := TheFontStyles + [fsStrikeOut];
    if fnsUnderline then TheFontStyles := TheFontStyles + [fsUnderline];
  end;{with}
  Result := TheFontStyles;
end;

procedure FontRec2Font(FontRec : TFontRec; TheFont : TFont);
begin
  TheFont.Style := FontStyleRec2FontStyles(FontRec.fntStyle);
  TheFont.Color := FontRec.fntColor;
  TheFont.Name := FontRec.fntName;
  TheFont.Size := FontRec.fntSize;
end;

function GetCurrentListColumnOrder(TheList : TMultiList): TColumnOrderRec;
var
  iColumn, iCol2 : integer;
begin
  FillChar(Result,SizeOf(Result),#0);
  For iColumn := 0 to TheList.Columns.Count -1
  do begin
    for iCol2 := 0 to TheList.Columns.Count -1 do begin
      if TheList.DesignColumns[iColumn] = TheList.Columns[iCol2] then
      begin
        Result[iCol2] := iColumn;
        Break;
      end;{if}
    end;{for}
  end;{for}
end;

procedure ListRec2List(TheListSettingsRec : TListSettingsRec; TheList: TMultiList; bMoveColumns : boolean = TRUE);
var
  iCol2, iColumn : integer;
  CurrentColumnOrder : TColumnOrderRec;
  iTempPos : Byte;

  function MoveRefToColumns(iColFrom, iColTo : byte) : TColumnOrderRec;
  var
    iPos2, iPos : integer;
  begin{MoveRefToColumns}
    Result := CurrentColumnOrder;
    For iPos := 0 to TheList.Columns.Count -1 do begin
      // this is the column that has been moved
      if (Result[iPos] = iColTo) then
      begin
        // moves other columns up one (like the list does, when you drop a column)
        For iPos2 := iPos to (iColFrom  - 1) do Result[iPos2 + 1] := CurrentColumnOrder[iPos2];

        Result[iPos] := iColFrom;
        break;
      end;{if}
    end;{for}
  end;{MoveRefToColumns}

begin{ListRec2List}
  FontRec2Font(TheListSettingsRec.lsMainFont, TheList.Font);
  FontRec2Font(TheListSettingsRec.lsHeaderFont, TheList.HeaderFont);
  FontRec2Font(TheListSettingsRec.lsHighlightFont, TheList.HighlightFont);
  FontRec2Font(TheListSettingsRec.lsMultiSelectFont, TheList.MultiSelectFont);

  CurrentColumnOrder := GetCurrentListColumnOrder(TheList);

  For iColumn := 0 to TheList.Columns.Count -1 do
  begin
    TheList.DesignColumns[iColumn].Color := TheListSettingsRec.lsMainBackColor;

    if bMoveColumns then begin

      // assign column widths
      TheList.DesignColumns[iColumn].Width := TheListSettingsRec.lsColumnWidths[iColumn];

      // assign column order
      if TheListSettingsRec.lsColumnOrder[iColumn] <> CurrentColumnOrder[iColumn] then
      begin
        // This column has been moved, but 2 where.....
        for iCol2 := (iColumn + 1) to TheList.Columns.Count -1 do begin
          if TheListSettingsRec.lsColumnOrder[iColumn] = CurrentColumnOrder[iCol2] then begin
            // This is the column that it has moved to
            TheList.MoveColumn(iCol2, iColumn);
            CurrentColumnOrder := MoveRefToColumns(iCol2, iColumn); // reflect the new column order
            Break;
          end;{if}
        end;{for}
      end;{if}
    end;{if}

  end;{for}

  TheList.Colours.Selection := TheListSettingsRec.lsHighlightColor;
  TheList.Colours.MultiSelection := TheListSettingsRec.lsMultiSelectColor;

  TheList.RefreshList;
end;{ListRec2List}

procedure ListRec2Panels(TheListSettingsRec : TListSettingsRec; panFields, panHeader, panHighlight, panMultiSelect : TPanel);
var
  iCol2, iColumn : integer;
  CurrentColumnOrder : TColumnOrderRec;
  iTempPos : Byte;

begin{ListRec2Panels}
  FontRec2Font(TheListSettingsRec.lsMainFont, panFields.Font);
  FontRec2Font(TheListSettingsRec.lsHeaderFont, panHeader.Font);
  FontRec2Font(TheListSettingsRec.lsHighlightFont, panHighlight.Font);
  FontRec2Font(TheListSettingsRec.lsMultiSelectFont, panMultiSelect.Font);
  panFields.Color := TheListSettingsRec.lsMainBackColor;
  panHighlight.Color := TheListSettingsRec.lsHighlightColor;
  panMultiSelect.Color := TheListSettingsRec.lsMultiSelectColor;
end;{ListRec2Panels}

function FontStyles2FontStyleRec(FontStyles : TFontStyles) : TFontStyleRec;
var
  TheFontStyleRec : TFontStyleRec;
begin
  FillChar(TheFontStyleRec,SizeOf(TheFontStyleRec),#0);

  with TheFontStyleRec do begin
    if (fsBold in FontStyles) then fnsBold := TRUE;
    if (fsItalic in FontStyles) then fnsItalic := TRUE;
    if (fsStrikeOut in FontStyles) then fnsStrikeOut := TRUE;
    if (fsUnderLine in FontStyles) then fnsUnderLine := TRUE;
  end;
  Result := TheFontStyleRec;
end;

procedure Font2FontRec(TheFont : TFont; var FontRec : TFontRec);
begin
  FontRec.fntStyle := FontStyles2FontStyleRec(TheFont.Style);
  FontRec.fntColor := TheFont.Color;
  FontRec.fntName := TheFont.Name;
  FontRec.fntSize := TheFont.Size;
end;

procedure List2ListRec(TheList: TMultiList; var TheListSettingsRec : TListSettingsRec; bMoveColumns : boolean = TRUE);
var
  iColumn : integer;
  iColor : TColor;
begin{List2ListRec}
  FillChar(TheListSettingsRec,SizeOf(TheListSettingsRec),#0);
  with TheListSettingsRec do begin

    Font2FontRec(TheList.Font, TheListSettingsRec.lsMainFont);
    Font2FontRec(TheList.HeaderFont, TheListSettingsRec.lsHeaderFont);
    Font2FontRec(TheList.HighlightFont, TheListSettingsRec.lsHighlightFont);
    Font2FontRec(TheList.MultiSelectFont, TheListSettingsRec.lsMultiSelectFont);

    iColor :=  -1;
    // get column properties
    For iColumn := 0 to TheList.Columns.Count -1
    do begin
      if iColumn = 0 then lsMainBackColor := TheList.DesignColumns[iColumn].Color;
      if iColor = TheList.DesignColumns[iColumn].Color
      then lsMainBackColor := iColor;
      iColor := TheList.DesignColumns[iColumn].Color;
      if bMoveColumns then lsColumnWidths[iColumn] := TheList.DesignColumns[iColumn].Width;
    end;{for}

    if bMoveColumns then lsColumnOrder := GetCurrentListColumnOrder(TheList);

    lsHighlightColor := TheList.Colours.Selection;
    lsMultiSelectColor := TheList.Colours.MultiSelection;

  end;{with}
end;{List2ListRec}

procedure Panels2ListRec(panFields, panHeader, panHighlight, panMultiSelect : TPanel;
var TheListSettingsRec : TListSettingsRec; bMoveColumns : boolean = TRUE);
var
  iColumn : integer;
  iColor : TColor;
begin{Panels2ListRec}
  FillChar(TheListSettingsRec,SizeOf(TheListSettingsRec),#0);
  with TheListSettingsRec do begin

    Font2FontRec(panFields.Font, TheListSettingsRec.lsMainFont);
    Font2FontRec(panHeader.Font, TheListSettingsRec.lsHeaderFont);
    Font2FontRec(panHighlight.Font, TheListSettingsRec.lsHighlightFont);
    Font2FontRec(panMultiSelect.Font, TheListSettingsRec.lsMultiSelectFont);

    lsMainBackColor := panFields.Color;
    lsHighlightColor := panHighlight.Color;
    lsMultiSelectColor := panMultiSelect.Color;

  end;{with}
end;{Panels2ListRec}

procedure InitialiseRec(var TheFormSettingsRec : TFormSettingsRec; cType : char; sLookUp : string);
begin{InitialiseRec}
  with TheFormSettingsRec do begin
    fsRecType := cType;
    fsLookup := sLookUp;
    fsDummyChar := IDX_DUMMY_CHAR;
  end;{with}
end;{InitialiseRec}

procedure TFormSettings.SaveList(TheList : TMultiList; sFormName : string);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];

begin{SaveList}
  sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + TheList.Name,#0,120);

  KeyS := FS_LIST + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);

  InitialiseRec(SettingsRec, FS_LIST, sLookUp);
  List2ListRec(TheList, SettingsRec.fsList);

  if iStatus = 0 then
  begin
    iStatus := BTUpdateRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
    BTShowError(iStatus, 'BTUpdateRecord', sMiscDirLocation + FILENAME);
  end else
  begin
    if iStatus in [4,9] then
    begin
      iStatus := BTAddRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
      BTShowError(iStatus, 'BTAddRecord', sMiscDirLocation + FILENAME);
    end else BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{SaveList}

procedure TFormSettings.LoadList(TheList : TMultiList; sFormName : string);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];
begin{LoadList}
  sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + TheList.Name,#0,120);
  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_LIST + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then ListRec2List(SettingsRec.fsList, TheList)
  else begin
    if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{LoadList}

procedure TFormSettings.CloseFile;
begin
  BTCloseFile(fFileVar);
  inherited
end;

procedure Control2ParentRec(TheControl : TControl; var TheParentRec : TParentSettingsRec);
begin{Control2ParentRec}
  if (TheControl is TEdit) then
  begin
    // TEdit
    TheParentRec.psParentColor := TEdit(TheControl).Color;
    Font2FontRec(TEdit(TheControl).Font, TheParentRec.psParentFont);
  end else begin
    if (TheControl is TComboBox) then
    begin
      // TComboBox
      TheParentRec.psParentColor := TComboBox(TheControl).Color;
      Font2FontRec(TComboBox(TheControl).Font, TheParentRec.psParentFont);
    end else begin
      if (TheControl is TMemo) then
      begin
        // TMemo
        TheParentRec.psParentColor := TMemo(TheControl).Color;
        Font2FontRec(TMemo(TheControl).Font, TheParentRec.psParentFont);
      end else begin
        if (TheControl is TRichEdit) then
        begin
          // TRichEdit
          TheParentRec.psParentColor := TRichEdit(TheControl).Color;
          Font2FontRec(TRichEdit(TheControl).Font, TheParentRec.psParentFont);
        end else begin
          if (TheControl is TMaskEdit) then
          begin
            // TMaskEdit
            TheParentRec.psParentColor := TMaskEdit(TheControl).Color;
            Font2FontRec(TMaskEdit(TheControl).Font, TheParentRec.psParentFont);
          end else begin
            if (TheControl is TDateTimePicker) then
            begin
              // TDateTimePicker
              TheParentRec.psParentColor := TDateTimePicker(TheControl).Color;
              Font2FontRec(TDateTimePicker(TheControl).Font, TheParentRec.psParentFont);
            end else begin
              if (TheControl is TListBox) then
              begin
                // TListBox
                TheParentRec.psParentColor := TListBox(TheControl).Color;
                Font2FontRec(TListBox(TheControl).Font, TheParentRec.psParentFont);
              end else begin
                if (TheControl is TListView) then
                begin
                  // TListView
                  TheParentRec.psParentColor := TListView(TheControl).Color;
                  Font2FontRec(TListView(TheControl).Font, TheParentRec.psParentFont);
                end else begin
                  if (TheControl is TOutLine) then
                  begin
                    // TOutLine
                    TheParentRec.psParentColor := TOutLine(TheControl).Color;
                    Font2FontRec(TOutLine(TheControl).Font, TheParentRec.psParentFont);
                  end else begin
                    if (TheControl is TTreeView) then
                    begin
                      // TTreeView
                      TheParentRec.psParentColor := TTreeView(TheControl).Color;
                      Font2FontRec(TTreeView(TheControl).Font, TheParentRec.psParentFont);
                    end else begin
                      if (TheControl is TMultiList) then
                      begin
                        // TMultiList
                        TheParentRec.psParentColor := TMultiList(TheControl).DesignColumns[0].Color;
                        Font2FontRec(TMultiList(TheControl).Font, TheParentRec.psParentFont);
                      end;{if}
                    end;{if}
                  end;{if}
                end;{if}
              end;{if}
            end;{if}
          end;{if}
        end;{if}
      end;{if}
    end;{if}
  end;{if}
end;{Control2ParentRec}

procedure TFormSettings.SaveParentFromControl(TheControl : TControl; sFormName : string; sParentName : string = '');
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];

begin{SaveParent}
  if sFormName = sParentName then sParentName := '';
  sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + sParentName,#0,120);

  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_PARENT + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);

  InitialiseRec(SettingsRec, FS_PARENT, sLookUp);
  Control2ParentRec(TheControl, SettingsRec.fsParent);

  if iStatus = 0 then
  begin
    iStatus := BTUpdateRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
    BTShowError(iStatus, 'BTUpdateRecord', sMiscDirLocation + FILENAME);
  end else
  begin
    if iStatus in [4,9] then
    begin
      iStatus := BTAddRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
      BTShowError(iStatus, 'BTAddRecord', sMiscDirLocation + FILENAME);
    end else BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{SaveParent}

procedure ParentRec2Control(ParentSettingsRec : TParentSettingsRec; TheControl : TControl; iTag : integer = 0);
var
  iComp : integer;
begin
  if (iTag = 0) or (TheControl.Tag = iTag) then begin
    if (TheControl is TEdit) then
    begin
      // TEdit
      TEdit(TheControl).Color := ParentSettingsRec.psParentColor;
      FontRec2Font(ParentSettingsRec.psParentFont, TEdit(TheControl).Font);
    end else begin
      if (TheControl is TComboBox) then
      begin
        // TComboBox
        TComboBox(TheControl).Color := ParentSettingsRec.psParentColor;
        FontRec2Font(ParentSettingsRec.psParentFont, TComboBox(TheControl).Font);
      end else begin
        if (TheControl is TMemo) then
        begin
          // TMemo
          TMemo(TheControl).Color := ParentSettingsRec.psParentColor;
          FontRec2Font(ParentSettingsRec.psParentFont, TMemo(TheControl).Font);
        end else begin
          if (TheControl is TRichEdit) then
          begin
            // TRichEdit
            TRichEdit(TheControl).Color := ParentSettingsRec.psParentColor;
            FontRec2Font(ParentSettingsRec.psParentFont, TRichEdit(TheControl).Font);
          end else begin
            if (TheControl is TMaskEdit) then
            begin
              // TMaskEdit
              TMaskEdit(TheControl).Color := ParentSettingsRec.psParentColor;
              FontRec2Font(ParentSettingsRec.psParentFont, TMaskEdit(TheControl).Font);
            end else begin
              if (TheControl is TDateTimePicker) then
              begin
                // TDateTimePicker
                TDateTimePicker(TheControl).Color := ParentSettingsRec.psParentColor;
                FontRec2Font(ParentSettingsRec.psParentFont, TDateTimePicker(TheControl).Font);
              end else begin
                if (TheControl is TListBox) then
                begin
                  // TListBox
                  TListBox(TheControl).Color := ParentSettingsRec.psParentColor;
                  FontRec2Font(ParentSettingsRec.psParentFont, TListBox(TheControl).Font);
                end else begin
                  if (TheControl is TListView) then
                  begin
                    // TListView
                    TListView(TheControl).Color := ParentSettingsRec.psParentColor;
                    FontRec2Font(ParentSettingsRec.psParentFont, TListView(TheControl).Font);
                  end else begin
                    if (TheControl is TOutLine) then
                    begin
                      // TOutLine
                      TOutLine(TheControl).Color := ParentSettingsRec.psParentColor;
                      FontRec2Font(ParentSettingsRec.psParentFont, TOutLine(TheControl).Font);
                    end else begin
                      if (TheControl is TSBSOutLineB) then
                      begin
                        // TSBSOutLineB - HM 10/02/04: SBSOutlineB & C not derived from TOutline or TSBSOutline!
                        TSBSOutLineB(TheControl).Color := ParentSettingsRec.psParentColor;
                        FontRec2Font(ParentSettingsRec.psParentFont, TSBSOutLineB(TheControl).Font);
                      end else begin
                        if (TheControl is TTreeView) then
                        begin
                          // TTreeView
                          TTreeView(TheControl).Color := ParentSettingsRec.psParentColor;
                          FontRec2Font(ParentSettingsRec.psParentFont, TTreeView(TheControl).Font);
                        end else begin
                          if (TheControl is TCheckListBox) then
                          begin
                            // TCheckListBox
                            TCheckListBox(TheControl).Color := ParentSettingsRec.psParentColor;
                            FontRec2Font(ParentSettingsRec.psParentFont, TCheckListBox(TheControl).Font);
                          end;
                        end;{if}
                      end;{if}
                    end;{if}
                  end;{if}
                end;{if}
              end;{if}
            end;{if}
          end;{if}
        end;{if}
      end;{if}
    end;{if}
  end;{if}
end;

procedure ParentRec2Parent(ParentSettingsRec : TParentSettingsRec; TheParent : TWinControl; iTag : integer = 0);
var
  iComp : integer;
begin
  with TheParent do begin
    For iComp := 0 to (ControlCount - 1) do begin

      ParentRec2Control(ParentSettingsRec, Controls[iComp], iTag);

      if (Controls[iComp] is TWinControl)
      and (TWinControl(Controls[iComp]).ControlCount > 0)
      then ParentRec2Parent(ParentSettingsRec, TWinControl(Controls[iComp]), iTag);
    end;{for}
  end;{with}
end;

procedure TFormSettings.LoadParentToControl(sParentName, sFormName : string; TheControl : TControl);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];
begin{LoadParentToControl}
  if sFormName = sParentName then sLookUp := PadString(psRight,fEXEName + fUserName + sFormName,#0,120)
  else sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + sParentName,#0,120);

  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_PARENT + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then ParentRec2Control(SettingsRec.fsParent, TheControl)
  else begin
    if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{LoadParentToControl}

procedure TFormSettings.ColorFieldsFrom(TheControl : TControl; TheParent : TWinControl; iTag : integer = 0);
var
  TheParentRec : TParentSettingsRec;
begin{ColorFieldsFrom}
  Control2ParentRec(TheControl, TheParentRec);
  ParentRec2Parent(TheParentRec, TheParent, iTag)
end;{ColorFieldsFrom}

destructor TFormSettings.Destroy;
begin
  CloseFile;
  oLSettings := nil;
  inherited;
end;

procedure TFormSettings.ExportBtrieveFileTo(sFileName: string);
var
  KeyS : str255;
  i, iStatus : integer;
  sKey : string;
  pColumnBackColor : pChar;

  function FontRecToStr(AFontRec : TFontRec) : string;

    function FontStyleToString(AFontStyleRec : TFontStyleRec) : string;
    begin{FontStyleToString}
      if AFontStyleRec.fnsBold then
      begin
        if AFontStyleRec.fnsItalic then Result := 'BoldItalic'
        else Result := 'Bold';
      end else
      begin
        if AFontStyleRec.fnsItalic then Result := 'Italic'
        else Result := 'Regular';
      end;{if}
    end;{FontStyleToString}

  begin{FontRecToStr}
    Result := '[ ' + ColorToStr(AFontRec.fntColor) + ', '
    + IntToStr(AFontRec.fntSize) + ', '
    + FontStyleToString(AFontRec.fntStyle) + ', '
    + Trim(AFontRec.fntName) + ' ]'
  end;{FontRecToStr}

  function GetColOrderString(a : array of Byte) : string;
  var
    iPos : integer;
  begin{GetColString}
    Result := '[ ';
    For iPos := 0 to 59 do Result := Result + IntToStr(a[iPos]) + ',';
    Result := Result + ' ]';
  end;{GetColString}

  function GetColWidthString(a : array of SmallInt) : string;
  var
    iPos : integer;
  begin{GetColString}
    Result := '[ ';
    For iPos := 0 to 59 do Result := Result + IntToStr(a[iPos]) + ',';
    Result := Result + ' ]';
  end;{GetColString}

begin{ExportBtrieveFileTo}
  DeleteFile(sFileName);
  FillChar(KeyS, SizeOf(KeyS), #0);
  iStatus := BTFindRecord(B_GetFirst, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  while iStatus = 0 do begin
    case SettingsRec.fsRecType of
      FS_LIST : begin
        with SettingsRec, fsList do begin
          AddLineToFile(fsRecType + ' '
          + Trim(fsLookup) + ' '
          + FontRecToStr(lsMainFont) + ' '
          + FontRecToStr(lsHeaderFont) + ' '
          + FontRecToStr(lsHighlightFont) + ' '
          + FontRecToStr(lsMultiSelectFont) + ' '
          + ColorToStr(lsMainBackColor) + ' '
          + ColorToStr(lsHighlightColor) + ' '
          + ColorToStr(lsMultiSelectColor) + ' '
          + GetColOrderString(lsColumnOrder) + ' '
          + GetColWidthString(lsColumnWidths) + ' '
          , sFileName);
        end;{with}
      end;

      FS_PARENT : begin
        with SettingsRec, fsParent do begin
          AddLineToFile(fsRecType + ' '
          + Trim(fsLookup) + ' '
          + FontRecToStr(psParentFont) + ' '
          + ColorToStr(psParentColor) + ' '
          , sFileName);
        end;{with}
      end;

      FS_FORM : begin
        with SettingsRec, fsForm do begin
          AddLineToFile(fsRecType + ' '
          + Trim(fsLookup) + ' '
          + IntToStr(fssTop)  + ' '
          + IntToStr(fssLeft) + ' '
          + IntToStr(fssHeight) + ' '
          + IntToStr(fssWidth) + ' '
          , sFileName);
        end;{with}
      end;
    end;{case}
    iStatus := BTFindRecord(B_GetNext, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  end;{while}
  ShowMessage('File Export Completed (' + sFileName + ')');
end;{ExportBtrieveFileTo}
(*
function TFormSettings.Edit(TheList : TMultiList; sFormName : string; TheControl : TControl) : boolean;
var
  FrmEditSettings : TFrmEditSettings;
begin{Edit}
  Result := FALSE;
  FrmEditSettings := TFrmEditSettings.create(application);
  with FrmEditSettings do begin
    try
      if TheList = nil then
      begin
        Height := 163;
        mlExample.visible := FALSE;
        btnEditFields.Visible := TRUE;
        btnEditColours.Visible := FALSE;
        btnEditFonts.Visible := FALSE;
      end else
      begin
        List2ListRec(TheList, SettingsRec.fsList);
        ListRec2List(SettingsRec.fsList, mlExample, FALSE);
        mlExample.Options.MultiSelection := TheList.Options.MultiSelection;
      end;

      if TheControl = nil then
      begin
        Height := 251;
        memName.visible := FALSE;
        edCode.visible := FALSE;
        edDate.visible := FALSE;
      end else
      begin
        Control2ParentRec(TheControl, SettingsRec.fsParent);
        ParentRec2Parent(SettingsRec.fsParent, FrmEditSettings);
      end;{if}

      if Showmodal = mrOK then begin
        Result := TRUE;

        if TheList = nil then
        begin
        end else
        begin
          List2ListRec(mlExample, SettingsRec.fsList);
          ListRec2List(SettingsRec.fsList, TheList, FALSE);
        end;{if}

        SettingsRec.fsParent.psParentColor := edCode.Color;
        Font2FontRec(edCode.Font, SettingsRec.fsParent.psParentFont);
        ParentRec2Control(SettingsRec.fsParent, TheControl);

        if TheList <> nil then TheList.RefreshList;
      end;
    finally
      Release;
    end;{try}
  end;{with}
end;{Edit}
*)
function TFormSettings.Edit(TheList : TMultiList; sFormName : string; TheControl : TControl) : TModalResult;
var
  FrmEditSettingsEnt : TFrmEditSettingsEnt;
begin{Edit}
  Result := mrCancel;
  FrmEditSettingsEnt := TFrmEditSettingsEnt.create(application);
  with FrmEditSettingsEnt do begin
    try
      if TheList = nil then
      begin
          Height := 278;
          lFields.Caption := 'Fields';
          lListHeadings.Enabled := FALSE;
          lHighlightBar.Enabled := FALSE;

//        mlExample.visible := FALSE;
//        btnEditFields.Visible := TRUE;
//        btnEditColours.Visible := FALSE;
//        btnEditFonts.Visible := FALSE;
          btnHeaderFont.Enabled := FALSE;
          btnHighlightColour.Enabled := FALSE;
          btnHighlightFont.Enabled := FALSE;
          panMultiSelectStuff.Visible := FALSE;
      end else
      begin
        List2ListRec(TheList, SettingsRec.fsList);
        ListRec2Panels(SettingsRec.fsList, panFields, panHeader, panHighlight, panMultiSelect);
        panMultiSelectStuff.Visible := TheList.Options.MultiSelection;
        if not panMultiSelectStuff.Visible then Height := 278;
      end;

      if TheControl = nil then
      begin
          lFields.Caption := 'List';
//        Height := 251;
//        memName.visible := FALSE;
//        edCode.visible := FALSE;
//        edDate.visible := FALSE;
      end else
      begin
        Control2ParentRec(TheControl, SettingsRec.fsParent);
        panFields.Color := SettingsRec.fsParent.psParentColor;
        FontRec2Font(SettingsRec.fsParent.psParentFont, panFields.Font);
//        ParentRec2Parent(SettingsRec.fsParent, FrmEditSettingsEnt);
      end;{if}

      Result := Showmodal;

      case Result of
        mrOK : begin
          if TheList = nil then
          begin
          end else
          begin
            Panels2ListRec(panFields, panHeader, panHighlight, panMultiSelect, SettingsRec.fsList);
            ListRec2List(SettingsRec.fsList, TheList, FALSE);
          end;{if}

          SettingsRec.fsParent.psParentColor := panFields.Color;
          Font2FontRec(panFields.Font, SettingsRec.fsParent.psParentFont);
          ParentRec2Control(SettingsRec.fsParent, TheControl);

          if TheList <> nil then TheList.RefreshList;
        end;

        mrRestoreDefaults : begin
          MsgBox('You will need to close the current window, in order for defaults to be restored.'
          + #13#13 + 'Your defaults will take effect, next time you open this window.'
          , mtInformation, [mbOK], mbOK, 'Restore Defaults');
        end;
      end;{case}
    finally
      Release;
    end;{try}
  end;{with}
end;{Edit}

procedure TFormSettings.LoadForm(TheForm : TForm);
var
  bSaveCoords : boolean;
begin
  LoadForm(TheForm, bSaveCoords);
end;

procedure TFormSettings.LoadForm(TheForm : TForm; var bSaveCoords : boolean);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];

  function FormSettingsAreFine : boolean;

    function CrazySetting(iSetting : integer) : boolean;
    begin{CrazySetting}
      Result := (iSetting < 0) or (iSetting > 5000);
    end;{CrazySetting}

  begin{FormSettingsAreFine}
    with SettingsRec.fsForm do begin
      // do not apply zero settings
      Result := not ((fssTop = 0) and (fssLeft = 0) and (fssWidth = 0) and (fssHeight = 0));

      // do not apply crazy settings !
      if CrazySetting(fssTop) or CrazySetting(fssLeft)
      or CrazySetting(fssWidth) or CrazySetting(fssHeight) then Result := FALSE;

      // do not apply settings that take the entire window wildy outside the screen space
      if (fssTop >= Screen.Height) or (fssLeft >= Screen.Width)
      or (fssWidth >= Screen.Width) or (fssHeight >= Screen.Height) then Result := FALSE;
    end;{with}
  end;{FormSettingsAreFine}

begin{LoadForm}
  sLookUp := PadString(psRight,fEXEName + fUserName + TheForm.Name,#0,120);

  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_FORM + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then
  begin
    TheForm.Position := poDesigned;
    with SettingsRec.fsForm do begin

      if FormSettingsAreFine then begin
        TheForm.Top := fssTop;
        TheForm.Left := fssLeft;
        if TheForm.BorderStyle <> bsDialog then begin
          TheForm.Width := fssWidth;
          TheForm.Height := fssHeight;
        end;
      end;{if}
      bSaveCoords := fssSaveCoordinates;
    end;{with}
  end
  else begin
    if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{LoadForm}

{procedure TFormSettings.SaveForm(TheForm : TForm);
begin
  SaveForm(TheForm, TRUE);
end;}

procedure TFormSettings.SaveForm(TheForm : TForm; bSaveCoord : boolean = TRUE);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];

begin{SaveForm}
  sLookUp := PadString(psRight,fEXEName + fUserName + TheForm.Name,#0,120);

  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_FORM + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);

  InitialiseRec(SettingsRec, FS_FORM, sLookUp);

  if bSaveCoord then begin
    with SettingsRec.fsForm do begin

      if TheForm.Width > Screen.Width
      then fssWidth := Screen.Width
      else fssWidth := TheForm.Width;

      if TheForm.Height > Screen.Height
      then fssHeight := Screen.Height
      else fssHeight := TheForm.Height;

      if TheForm.Top > (Screen.Height - fssHeight)
      then fssTop := Screen.Height - fssHeight
      else fssTop := TheForm.Top;

      if TheForm.Top < 0 then fssTop := 0;

      if TheForm.Left > (Screen.Width - fssWidth)
      then fssLeft := Screen.Width - fssWidth
      else fssLeft := TheForm.Left;

      if TheForm.Left < 0 then fssLeft := 0;

    end;{with}
  end;{if}
  SettingsRec.fsForm.fssSaveCoordinates := bSaveCoord;

  if iStatus = 0 then
  begin
    iStatus := BTUpdateRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
    BTShowError(iStatus, 'BTUpdateRecord', sMiscDirLocation + FILENAME);
  end else
  begin
    if iStatus in [4,9] then
    begin
      iStatus := BTAddRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
      BTShowError(iStatus, 'BTAddRecord', sMiscDirLocation + FILENAME);
    end else BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
  end;{if}
end;{SaveForm}

procedure TFormSettings.RestoreParentDefaults(TheParent: TWinControl; sFormName: string);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];
begin{RestoreParentDefaults}
  // delete parent settings
  if sFormName = TheParent.Name then sLookUp := PadString(psRight,fEXEName + fUserName + sFormName,#0,120)
  else sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + TheParent.Name,#0,120);

  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_PARENT + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then begin
    iStatus := BTDeleteRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
    if iStatus <> 0 then begin
      if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
    end;{if}
  end;{if}
end;{RestoreParentDefaults}

procedure TFormSettings.RestoreListDefaults(TheList: TMultiList; sFormName: string);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];
begin{RestoreListDefaults}
  // delete list settings
  sLookUp := PadString(psRight,fEXEName + fUserName + sFormName + TheList.Name,#0,120);
  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_LIST + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then begin
    iStatus := BTDeleteRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
    if iStatus <> 0 then begin
      if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
    end;{if}
  end;{if}
end;{RestoreListDefaults}

procedure TFormSettings.RestoreFormDefaults(sFormName: string);
var
  KeyS : Str255;
  iStatus : integer;
  sLookUp : String[120];
begin{RestoreFormDefaults}
  // delete form settings
  sLookUp := PadString(psRight,fEXEName + fUserName + sFormName,#0,120);
  FillChar(KeyS,SizeOf(KeyS),#0);
  KeyS := FS_FORM + sLookUp;
  iStatus := BTFindRecord(B_GetEq, fFileVar, SettingsRec, fBufferSize, fsLookupIdx, KeyS);
  if iStatus = 0 then begin
    iStatus := BTDeleteRecord(fFileVar, SettingsRec, fBufferSize, fsLookupIdx);
    if iStatus <> 0 then begin
      if not (iStatus in [4, 9]) then BTShowError(iStatus, 'BTFindRecord', sMiscDirLocation + FILENAME);
    end;{if}
  end;{if}
end;{RestoreFormDefaults}

procedure TFormSettings.SetEXEName(const Value: string);
begin
  fEXEName := Trim(Value);
end;

procedure TFormSettings.SetUserName(const Value: string20);
begin
  if (Value = StringOfChar(' ', 20)) then fUserName := Value
  else fUserName := Trim(Value);
end;

procedure TFormSettings.CopyList(FromList, ToList: TMultiList);
var
  iColumn : integer;
begin
  ToList.Font.Assign(FromList.Font);
  ToList.HeaderFont.Assign(FromList.HeaderFont);
  ToList.HighlightFont.Assign(FromList.HighlightFont);
  ToList.MultiSelectFont.Assign(FromList.MultiSelectFont);
  ToList.Colours.Selection := FromList.Colours.Selection;
  ToList.Colours.MultiSelection := FromList.Colours.MultiSelection;

  For iColumn := 0 to ToList.Columns.Count -1 do
  begin
    ToList.DesignColumns[iColumn].Color := FromList.DesignColumns[0].Color;
  end;{for}

  ToList.RefreshList;
end;

Initialization
  oLSettings := NIL;
  sMiscDirLocation := '';

Finalization
  FreeAndNIL(oLSettings);

end.
