�
 TDMMAIN 0�	  TPF0TdmMaindmMainOldCreateOrderOnCreateDataModuleCreate	OnDestroyDataModuleDestroyLeft��  Top� Height�Width� TDataSource	srcMasterDataSet	tblMasterLeftPTop  TTable	tblMasterDatabaseNameDBDEMOS	FieldDefsNameSYMBOLDataTypeftStringSize NameCO_NAMEDataTypeftStringSize NameEXCHANGEDataTypeftStringSize Name	CUR_PRICEDataTypeftFloat NameYRL_HIGHDataTypeftFloat NameYRL_LOWDataTypeftFloat Name	P_E_RATIODataTypeftFloat NameBETADataTypeftFloat Name	PROJ_GRTHDataTypeftFloat NameINDUSTRYDataType
ftSmallint Name	PRICE_CHGDataType
ftSmallint NameSAFETYDataType
ftSmallint NameRATINGDataTypeftStringSize NameRANKDataTypeftFloat NameOUTLOOKDataType
ftSmallint Name
RCMNDATIONDataTypeftStringSize NameRISKDataTypeftStringSize  	IndexDefsNameSYMBOLFieldsSYMBOLOptionsixUnique Source
MASTER.MDX Name	GROWTHASCFields	PROJ_GRTHSource
MASTER.MDX Name
GROWTHDESCFields	PROJ_GRTHOptionsixDescending Source
MASTER.MDX  	StoreDefs		TableName
master.dbfLeftTop  TQueryqryCustomerDatabaseNameDBDEMOSSQL.Stringsselect * from customer LeftTopH  TQuery	qryOrdersDatabaseNameDBDEMOSSQL.Strings%select * from orders where custno=:P0 LeftTop� 	ParamDataDataTypeftFloatNameP0	ParamType	ptUnknown    TDataSourcesrcCustomerDataSetqryCustomerLeftXTopH  TDataSource	srcOrdersDataSet	qryOrdersLeftXTop�   TTabletblPartsDatabaseNameDBDEMOSIndexFieldNamesPartNo	TableNamePARTS.DBLeft� Top  TDataSourcesrcPartsDataSettblPartsLeft� Top  TDataSourceDataSource1Left8Top  TTable
tblBiolifeDatabaseNameDBDEMOSMasterSourceDataSource1	TableName
BIOLIFE.DBLeft Top TFloatFieldtblBiolifeSpeciesNo	FieldName
Species No  TStringFieldtblBiolifeCategory	FieldNameCategorySize  TStringFieldtblBiolifeCommon_Name	FieldNameCommon_NameSize  TStringFieldtblBiolifeSpeciesName	FieldNameSpecies NameSize(  TFloatFieldtblBiolifeLengthcm	FieldNameLength (cm)  TFloatFieldtblBiolifeLength_In	FieldName	Length_In  
TMemoFieldtblBiolifeNotes	FieldNameNotesBlobTypeftMemoSize2  TGraphicFieldtblBiolifeGraphic	FieldNameGraphicBlobType	ftGraphic   TTabletblCustomerActive	DatabaseNameDBDEMOSIndexFieldNamesCustNo	TableNameCUSTOMER.DBLeft� TopH   