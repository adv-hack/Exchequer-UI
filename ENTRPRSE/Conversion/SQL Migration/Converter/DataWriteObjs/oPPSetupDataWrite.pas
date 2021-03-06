Unit oPPSetupDataWrite;

{$ALIGN 1}
{$REALCOMPATIBILITY ON}

Interface

Uses ADODB, SysUtils, oBaseDataWrite, oDataPacket;

Type
  TPPSetupDataWrite = Class(TBaseDataWrite)
  Private
    FADOQuery : TADOQuery;
    ppsfolionoParam, ppsdaysfieldParam, ppsholdflagfieldParam, ppsdummycharParam, 
    ppsbaseinterestonduedateParam : TParameter;
  Public
    Constructor Create;
    Destructor Destroy; Override;

    // Called from the SQL Write Threads to provide basic info required for SQL Execution
    Procedure Prepare (Const ADOConnection : TADOConnection; Const CompanyCode : ShortString); Override;

    // Implemented in descendant classes to (a) populate the ADO Query with the data from the DataPacket and
    // (b) return the ADOQuery in use by the descendant
    Procedure SetQueryValues (Var ADOQuery : TADOQuery; Const DataPacket : TDataPacket; Var SkipRecord : Boolean); Override;
  End; // TPPSetupDataWrite

Implementation

Uses Graphics, Variants, VarConst, SQLConvertUtils;

//=========================================================================

Constructor TPPSetupDataWrite.Create;
Begin // Create
  Inherited Create;
  FADOQuery := TADOQuery.Create(NIL);
End; // Create

//------------------------------

Destructor TPPSetupDataWrite.Destroy;
Begin // Destroy
  FADOQuery.Connection := Nil;
  FADOQuery.Free;
  Inherited Destroy;
End; // Destroy

//-------------------------------------------------------------------------

// Called from the SQL Write Threads to provide basic info required for SQL Execution
Procedure TPPSetupDataWrite.Prepare (Const ADOConnection : TADOConnection; Const CompanyCode : ShortString);
Var
  sqlQuery : ANSIString;
Begin // Prepare
  Inherited Prepare (ADOConnection, CompanyCode);

  // Link the ADO Connection into the Query so it can access the data
  FADOQuery.Connection := ADOConnection;

  // Setup the SQL Query and prepare it
  sqlQuery := 'INSERT INTO [COMPANY].PPSetup (' + 
                                              'ppsfoliono, ' + 
                                              'ppsdaysfield, ' + 
                                              'ppsholdflagfield, ' + 
                                              'ppsdummychar, ' + 
                                              'ppsbaseinterestonduedate' + 
                                              ') ' + 
              'VALUES (' + 
                       ':ppsfoliono, ' + 
                       ':ppsdaysfield, ' + 
                       ':ppsholdflagfield, ' + 
                       ':ppsdummychar, ' + 
                       ':ppsbaseinterestonduedate' + 
                       ')';
  FADOQuery.SQL.Text := StringReplace(sqlQuery, '[COMPANY]', '[' + Trim(CompanyCode) + ']', [rfReplaceAll]);
  FADOQuery.Prepared := True;

  // Setup references to the parameters so we can directly access them for each row instead of having
  // to search for them each time
  With FADOQuery.Parameters Do
  Begin
    ppsfolionoParam := FindParam('ppsfoliono');
    ppsdaysfieldParam := FindParam('ppsdaysfield');
    ppsholdflagfieldParam := FindParam('ppsholdflagfield');
    ppsdummycharParam := FindParam('ppsdummychar');
    ppsbaseinterestonduedateParam := FindParam('ppsbaseinterestonduedate');
  End; // With FADOQuery.Parameters
End; // Prepare

//-------------------------------------------------------------------------

// Sets the values of the private parameters prior to inserting the data
Procedure TPPSetupDataWrite.SetQueryValues (Var ADOQuery : TADOQuery; Const DataPacket : TDataPacket; Var SkipRecord : Boolean);
Type
  TPPSetupRec = record
    ppsFolioNo : LongInt;
    ppsDaysField : LongInt;
    ppsHoldFlagField : LongInt;
    ppsDummyChar : char;
    ppsBaseInterestOnDueDate : boolean;
    ppsSpare : Array [1..999] of Char;
  end;{TPPSetupRec}

Var
  DataRec : ^TPPSetupRec;
  sTemp : ShortString;
Begin // SetParameterValues
  // Return the ADOQuery instance for this data
  ADOQuery := FADOQuery;

  // Redirect the local record to point to the data buffer in the Data Packet
  DataRec := DataPacket.dpData;

  // Populate the TParameter objects with the data - which populates the Query values
  With DataRec^ Do
  Begin
    ppsfolionoParam.Value := ppsFolioNo;                                     // SQL=int, Delphi=LongInt
    ppsdaysfieldParam.Value := ppsDaysField;                                 // SQL=int, Delphi=LongInt
    ppsholdflagfieldParam.Value := ppsHoldFlagField;                         // SQL=int, Delphi=LongInt
    ppsdummycharParam.Value := Ord(ppsDummyChar);                            // SQL=int, Delphi=char
    ppsbaseinterestonduedateParam.Value := ppsBaseInterestOnDueDate;         // SQL=bit, Delphi=boolean
  End; // With DataRec^
End; // SetParameterValues

//=========================================================================

End.

