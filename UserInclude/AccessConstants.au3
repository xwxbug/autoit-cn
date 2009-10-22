;Global Const $adoProvider = 'Microsoft.Jet.OLEDB.4.0; '
Global Const $adoProvider = _adoProvider()
 ;CursorTypeEnum
Global Const $adOpenUnspecified = -1
Global Const $adOpenForwardOnly = 0
Global Const $adOpenKeyset = 1
Global Const $adOpenDynamic = 2
Global Const $adOpenStatic = 3
 ;CursorOptionEnum
Global Const $adHoldRecords = 256
Global Const $adMovePrevious = 512
Global Const $adAddNew = 16778240
Global Const $adDelete = 16779264
Global Const $adUpdate = 16809984
Global Const $adBookmark = 8192
Global Const $adApproxPosition = 16384
Global Const $adUpdateBatch = 65536
Global Const $adResync = 131072
Global Const $adNotify = 262144
Global Const $adFind = 524288
Global Const $adSeek = 4194304
Global Const $adIndex = 8388608
 ;LockTypeEnum
Global Const $adLockUnspecified = -1
Global Const $adLockReadOnly = 1
Global Const $adLockPessimistic = 2
Global Const $adLockOptimistic = 3
Global Const $adLockBatchOptimistic = 4
 ;ExecuteOptionEnum
Global Const $adOptionUnspecified = -1
Global Const $adAsyncExecute = 16
Global Const $adAsyncFetch = 32
Global Const $adAsyncFetchNonBlocking = 64
Global Const $adExecuteNoRecords = 128
 ;ConnectOptionEnum
Global Const $adConnectUnspecified = -1
Global Const $adAsyncConnect = 16
 ;ObjectStateEnum
Global Const $adStateClosed = 0
Global Const $adStateOpen = 1
Global Const $adStateConnecting = 2
Global Const $adStateExecuting = 4
Global Const $adStateFetching = 8
 ;CursorLocationEnum
Global Const $adUseNone = 1
Global Const $adUseServer = 2
Global Const $adUseClient = 3
Global Const $adUseClientBatch = 3
 ;DataTypeEnum
Global Const $adEmpty = 0
Global Const $adTinyInt = 16
Global Const $adSmallInt = 2
Global Const $adInteger = 3
Global Const $adBigInt = 20
Global Const $adUnsignedTinyInt = 17
Global Const $adUnsignedSmallInt = 18
Global Const $adUnsignedInt = 19
Global Const $adUnsignedBigInt = 21
Global Const $adSingle = 4
Global Const $adDouble = 5
Global Const $adCurrency = 6
Global Const $adDecimal = 14
Global Const $adNumeric = 131
Global Const $adBoolean = 11
Global Const $adError = 10
Global Const $adUserDefined = 132
Global Const $adVariant = 12
Global Const $adIDispatch = 9
Global Const $adIUnknown = 13
Global Const $adGUID = 72
Global Const $adDate = 7
Global Const $adDBDate = 133
Global Const $adDBTime = 134
Global Const $adDBTimeStamp = 135
Global Const $adBSTR = 8
Global Const $adChar = 129
Global Const $adVarChar = 200
Global Const $adLongVarChar = 201
Global Const $adWChar = 130
Global Const $adVarWChar = 202
Global Const $adLongVarWChar = 203
Global Const $adBinary = 128
Global Const $adVarBinary = 204
Global Const $adLongVarBinary = 205
Global Const $adChapter = 136
Global Const $adFileTime = 64
Global Const $adPropVariant = 138
Global Const $adVarNumeric = 139
Global Const $adArray = 8192
 ;FieldAttributeEnum
Global Const $adFldUnspecified = -1
Global Const $adFldMayDefer = 2
Global Const $adFldUpdatable = 4
Global Const $adFldUnknownUpdatable = 8
Global Const $adFldFixed = 16
Global Const $adFldIsNullable = 32
Global Const $adFldMayBeNull = 64
Global Const $adFldLong = 128
Global Const $adFldRowID = 256
Global Const $adFldRowVersion = 512
Global Const $adFldCacheDeferred = 4096
Global Const $adFldIsChapter = 8192
Global Const $adFldNegativeScale = 16384
Global Const $adFldKeyColumn = 32768
Global Const $adFldIsRowURL = 65536
Global Const $adFldIsDefaultStream = 131072
Global Const $adFldIsCollection = 262144
 ;EditModeEnum
Global Const $adEditNone = 0
Global Const $adEditInProgress = 1
Global Const $adEditAdd = 2
Global Const $adEditDelete = 4
 ;RecordStatusEnum
Global Const $adRecOK = 0
Global Const $adRecNew = 1
Global Const $adRecModified = 2
Global Const $adRecDeleted = 4
Global Const $adRecUnmodified = 8
Global Const $adRecInvalid = 16
Global Const $adRecMultipleChanges = 64
Global Const $adRecPendingChanges = 128
Global Const $adRecCanceled = 256
Global Const $adRecCantRelease = 1024
Global Const $adRecConcurrencyViolation = 2048
Global Const $adRecIntegrityViolation = 4096
Global Const $adRecMaxChangesExceeded = 8192
Global Const $adRecObjectOpen = 16384
Global Const $adRecOutOfMemory = 32768
Global Const $adRecPermissionDenied = 65536
Global Const $adRecSchemaViolation = 131072
Global Const $adRecDBDeleted = 262144
 ;GetRowsOptionEnum
Global Const $adGetRowsRest = -1
 ;PositionEnum
Global Const $adPosUnknown = -1
Global Const $adPosBOF = -2
Global Const $adPosEOF = -3
 ;BookmarkEnum
Global Const $adBookmarkCurrent = 0
Global Const $adBookmarkFirst = 1
Global Const $adBookmarkLast = 2
 ;MarshalOptionsEnum
Global Const $adMarshalAll = 0
Global Const $adMarshalModifiedOnly = 1
 ;AffectEnum
Global Const $adAffectCurrent = 1
Global Const $adAffectGroup = 2
Global Const $adAffectAll = 3
Global Const $adAffectAllChapters = 4
 ;ResyncEnum
Global Const $adResyncUnderlyingValues = 1
Global Const $adResyncAllValues = 2
 ;CompareEnum
Global Const $adCompareLessThan = 0
Global Const $adCompareEqual = 1
Global Const $adCompareGreaterThan = 2
Global Const $adCompareNotEqual = 3
Global Const $adCompareNotComparable = 4
 ;FilterGroupEnum
Global Const $adFilterNone = 0
Global Const $adFilterPendingRecords = 1
Global Const $adFilterAffectedRecords = 2
Global Const $adFilterFetchedRecords = 3
Global Const $adFilterPredicate = 4
Global Const $adFilterConflictingRecords = 5
 ;SearchDirection
Global Const $adSearchForward = 1
Global Const $adSearchBackward = -1
 ;PersistFormatEnum
Global Const $adPersistADTG = 0
Global Const $adPersistXML = 1
 ;StringFormatEnum
Global Const $adClipString = 2
 ;ConnectPromptEnum
Global Const $adPromptAlways = 1
Global Const $adPromptComplete = 2
Global Const $adPromptCompleteRequired = 3
Global Const $adPromptNever = 4
 ;ConnectModeEnum
Global Const $adModeUnknown = 0
Global Const $adModeRead = 1
Global Const $adModeWrite = 2
Global Const $adModeReadWrite = 3
Global Const $adModeShareDenyRead = 4
Global Const $adModeShareDenyWrite = 8
Global Const $adModeShareExclusive = 12
Global Const $adModeShareDenyNone = 16
Global Const $adModeRecursive = 4194304
 ;RecordCreateOptionsEnum
Global Const $adCreateCollection = 8192
Global Const $adCreateStructDoc = -2147483648
Global Const $adCreateNonCollection = 0
Global Const $adOpenIfExists = 33554432
Global Const $adCreateOverwrite = 67108864
Global Const $adFailIfNotExists = -1
 ;RecordOpenOptionsEnum
Global Const $adOpenRecordUnspecified = -1
Global Const $adOpenSource = 8388608
Global Const $adOpenAsync = 4096
Global Const $adDelayFetchStream = 16384
Global Const $adDelayFetchFields = 32768
 ;IsolationLevelEnum
Global Const $adXactUnspecified = -1
Global Const $adXactChaos = 16
Global Const $adXactReadUncommitted = 256
Global Const $adXactBrowse = 256
Global Const $adXactCursorStability = 4096
Global Const $adXactReadCommitted = 4096
Global Const $adXactRepeatableRead = 65536
Global Const $adXactSerializable = 1048576
Global Const $adXactIsolated = 1048576
 ;XactAttributeEnum
Global Const $adXactCommitRetaining = 131072
Global Const $adXactAbortRetaining = 262144
Global Const $adXactAsyncPhaseOne = 524288
Global Const $adXactSyncPhaseOne = 1048576
 ;PropertyAttributesEnum
Global Const $adPropNotSupported = 0
Global Const $adPropRequired = 1
Global Const $adPropOptional = 2
Global Const $adPropRead = 512
Global Const $adPropWrite = 1024
 ;ErrorValueEnum
Global Const $adErrProviderFailed = 3000
Global Const $adErrInvalidArgument = 3001
Global Const $adErrOpeningFile = 3002
Global Const $adErrReadFile = 3003
Global Const $adErrWriteFile = 3004
Global Const $adErrNoCurrentRecord = 3021
Global Const $adErrIllegalOperation = 3219
Global Const $adErrCantChangeProvider = 3220
Global Const $adErrInTransaction = 3246
Global Const $adErrFeatureNotAvailable = 3251
Global Const $adErrItemNotFound = 3265
Global Const $adErrObjectInCollection = 3367
Global Const $adErrObjectNotSet = 3420
Global Const $adErrDataConversion = 3421
Global Const $adErrObjectClosed = 3704
Global Const $adErrObjectOpen = 3705
Global Const $adErrProviderNotFound = 3706
Global Const $adErrBoundToCommand = 3707
Global Const $adErrInvalidParamInfo = 3708
Global Const $adErrInvalidConnection = 3709
Global Const $adErrNotReentrant = 3710
Global Const $adErrStillExecuting = 3711
Global Const $adErrOperationCancelled = 3712
Global Const $adErrStillConnecting = 3713
Global Const $adErrInvalidTransaction = 3714
Global Const $adErrNotExecuting = 3715
Global Const $adErrUnsafeOperation = 3716
Global Const $adwrnSecurityDialog = 3717
Global Const $adwrnSecurityDialogHeader = 3718
Global Const $adErrIntegrityViolation = 3719
Global Const $adErrPermissionDenied = 3720
Global Const $adErrDataOverflow = 3721
Global Const $adErrSchemaViolation = 3722
Global Const $adErrSignMismatch = 3723
Global Const $adErrCantConvertvalue = 3724
Global Const $adErrCantCreate = 3725
Global Const $adErrColumnNotOnThisRow = 3726
Global Const $adErrURLDoesNotExist = 3727
Global Const $adErrTreePermissionDenied = 3728
Global Const $adErrInvalidURL = 3729
Global Const $adErrResourceLocked = 3730
Global Const $adErrResourceExists = 3731
Global Const $adErrCannotComplete = 3732
Global Const $adErrVolumeNotFound = 3733
Global Const $adErrOutOfSpace = 3734
Global Const $adErrResourceOutOfScope = 3735
Global Const $adErrUnavailable = 3736
Global Const $adErrURLNamedRowDoesNotExist = 3737
Global Const $adErrDelResOutOfScope = 3738
Global Const $adErrPropInvalidColumn = 3739
Global Const $adErrPropInvalidOption = 3740
Global Const $adErrPropInvalidValue = 3741
Global Const $adErrPropConflicting = 3742
Global Const $adErrPropNotAllSettable = 3743
Global Const $adErrPropNotSet = 3744
Global Const $adErrPropNotSettable = 3745
Global Const $adErrPropNotSupported = 3746
Global Const $adErrCatalogNotSet = 3747
Global Const $adErrCantChangeConnection = 3748
Global Const $adErrFieldsUpdateFailed = 3749
Global Const $adErrDenyNotSupported = 3750
Global Const $adErrDenyTypeNotSupported = 3751
 ;ParameterAttributesEnum
Global Const $adParamSigned = 16
Global Const $adParamNullable = 64
Global Const $adParamLong = 128
 ;ParameterDirectionEnum
Global Const $adParamUnknown = 0
Global Const $adParamInput = 1
Global Const $adParamOutput = 2
Global Const $adParamInputOutput = 3
Global Const $adParamReturnValue = 4
 ;CommandTypeEnum
Global Const $adCmdUnspecified = -1
Global Const $adCmdUnknown = 8
Global Const $adCmdText = 1
Global Const $adCmdTable = 2
Global Const $adCmdStoredProc = 4
Global Const $adCmdFile = 256
Global Const $adCmdTableDirect = 512
 ;EventStatusEnum
Global Const $adStatusOK = 1
Global Const $adStatusErrorsOccurred = 2
Global Const $adStatusCantDeny = 3
Global Const $adStatusCancel = 4
Global Const $adStatusUnwantedEvent = 5
 ;EventReasonEnum
Global Const $adRsnAddNew = 1
Global Const $adRsnDelete = 2
Global Const $adRsnUpdate = 3
Global Const $adRsnUndoUpdate = 4
Global Const $adRsnUndoAddNew = 5
Global Const $adRsnUndoDelete = 6
Global Const $adRsnRequery = 7
Global Const $adRsnResynch = 8
Global Const $adRsnClose = 9
Global Const $adRsnMove = 10
Global Const $adRsnFirstChange = 11
Global Const $adRsnMoveFirst = 12
Global Const $adRsnMoveNext = 13
Global Const $adRsnMovePrevious = 14
Global Const $adRsnMoveLast = 15
 ;SchemaEnum
Global Const $adSchemaProviderSpecific = -1
Global Const $adSchemaAsserts = 0
Global Const $adSchemaCatalogs = 1
Global Const $adSchemaCharacterSets = 2
Global Const $adSchemaCollations = 3
Global Const $adSchemaColumns = 4
Global Const $adSchemaCheckConstraints = 5
Global Const $adSchemaConstraintColumnUsage = 6
Global Const $adSchemaConstraintTableUsage = 7
Global Const $adSchemaKeyColumnUsage = 8
Global Const $adSchemaReferentialContraints = 9
Global Const $adSchemaReferentialConstraints = 9
Global Const $adSchemaTableConstraints = 10
Global Const $adSchemaColumnsDomainUsage = 11
Global Const $adSchemaIndexes = 12
Global Const $adSchemaColumnPrivileges = 13
Global Const $adSchemaTablePrivileges = 14
Global Const $adSchemaUsagePrivileges = 15
Global Const $adSchemaProcedures = 16
Global Const $adSchemaSchemata = 17
Global Const $adSchemaSQLLanguages = 18
Global Const $adSchemaStatistics = 19
Global Const $adSchemaTables = 20
Global Const $adSchemaTranslations = 21
Global Const $adSchemaProviderTypes = 22
Global Const $adSchemaViews = 23
Global Const $adSchemaViewColumnUsage = 24
Global Const $adSchemaViewTableUsage = 25
Global Const $adSchemaProcedureParameters = 26
Global Const $adSchemaForeignKeys = 27
Global Const $adSchemaPrimaryKeys = 28
Global Const $adSchemaProcedureColumns = 29
Global Const $adSchemaDBInfoKeywords = 30
Global Const $adSchemaDBInfoLiterals = 31
Global Const $adSchemaCubes = 32
Global Const $adSchemaDimensions = 33
Global Const $adSchemaHierarchies = 34
Global Const $adSchemaLevels = 35
Global Const $adSchemaMeasures = 36
Global Const $adSchemaProperties = 37
Global Const $adSchemaMembers = 38
Global Const $adSchemaTrustees = 39
 ;FieldStatusEnum
Global Const $adFieldOK = 0
Global Const $adFieldCantConvertValue = 2
Global Const $adFieldIsNull = 3
Global Const $adFieldTruncated = 4
Global Const $adFieldSignMismatch = 5
Global Const $adFieldDataOverflow = 6
Global Const $adFieldCantCreate = 7
Global Const $adFieldUnavailable = 8
Global Const $adFieldPermissionDenied = 9
Global Const $adFieldIntegrityViolation = 10
Global Const $adFieldSchemaViolation = 11
Global Const $adFieldBadStatus = 12
Global Const $adFieldDefault = 13
Global Const $adFieldIgnore = 15
Global Const $adFieldDoesNotExist = 16
Global Const $adFieldInvalidURL = 17
Global Const $adFieldResourceLocked = 18
Global Const $adFieldResourceExists = 19
Global Const $adFieldCannotComplete = 20
Global Const $adFieldVolumeNotFound = 21
Global Const $adFieldOutOfSpace = 22
Global Const $adFieldCannotDeleteSource = 23
Global Const $adFieldReadOnly = 24
Global Const $adFieldResourceOutOfScope = 25
Global Const $adFieldAlreadyExists = 26
Global Const $adFieldPendingInsert = 65536
Global Const $adFieldPendingDelete = 131072
Global Const $adFieldPendingChange = 262144
Global Const $adFieldPendingUnknown = 524288
Global Const $adFieldPendingUnknownDelete = 1048576
 ;SeekEnum
Global Const $adSeekFirstEQ = 1
Global Const $adSeekLastEQ = 2
Global Const $adSeekAfterEQ = 4
Global Const $adSeekAfter = 8
Global Const $adSeekBeforeEQ = 16
Global Const $adSeekBefore = 32
 ;ADCPROP_UPDATECRITERIA_ENUM
Global Const $adCriteriaKey = 0
Global Const $adCriteriaAllCols = 1
Global Const $adCriteriaUpdCols = 2
Global Const $adCriteriaTimeStamp = 3
 ;ADCPROP_ASYNCTHREADPRIORITY_ENUM
Global Const $adPriorityLowest = 1
Global Const $adPriorityBelowNormal = 2
Global Const $adPriorityNormal = 3
Global Const $adPriorityAboveNormal = 4
Global Const $adPriorityHighest = 5
 ;ADCPROP_AUTORECALC_ENUM
Global Const $adRecalcUpFront = 0
Global Const $adRecalcAlways = 1
 ;ADCPROP_UPDATERESYNC_ENUM
Global Const $adResyncNone = 0
Global Const $adResyncAutoIncrement = 1
Global Const $adResyncConflicts = 2
Global Const $adResyncUpdates = 4
Global Const $adResyncInserts = 8
Global Const $adResyncAll = 15
 ;MoveRecordOptionsEnum
Global Const $adMoveUnspecified = -1
Global Const $adMoveOverWrite = 1
Global Const $adMoveDontUpdateLinks = 2
Global Const $adMoveAllowEmulation = 4
 ;CopyRecordOptionsEnum
Global Const $adCopyUnspecified = -1
Global Const $adCopyOverWrite = 1
Global Const $adCopyAllowEmulation = 4
Global Const $adCopyNonRecursive = 2
 ;StreamTypeEnum
Global Const $adTypeBinary = 1
Global Const $adTypeText = 2
 ;LineSeparatorEnum
Global Const $adLF = 10
Global Const $adCR = 13
Global Const $adCRLF = -1
 ;StreamOpenOptionsEnum
Global Const $adOpenStreamUnspecified = -1
Global Const $adOpenStreamAsync = 1
Global Const $adOpenStreamFromRecord = 4
 ;StreamWriteEnum
Global Const $adWriteChar = 0
Global Const $adWriteLine = 1
Global Const $stWriteChar = 0
Global Const $stWriteLine = 1
 ;SaveOptionsEnum
Global Const $adSaveCreateNotExist = 1
Global Const $adSaveCreateOverWrite = 2
 ;FieldEnum
Global Const $adDefaultStream = -1
Global Const $adRecordURL = -2
 ;StreamReadEnum
Global Const $adReadAll = -1
Global Const $adReadLine = -2
 ;RecordTypeEnum
Global Const $adSimpleRecord = 0
Global Const $adCollectionRecord = 1
Global Const $adStructDoc = 2


Func _adoProvider()
   Local $oProvider = "Microsoft.Jet.OLEDB.4.0; "
   Local $objCheck = ObjCreate("Access.application")
   If IsObj($objCheck) Then
      Local $oVersion = $objCheck.Version
      If StringLeft($oVersion, 2) == "12" Then $oProvider="Microsoft.ACE.OLEDB.12.0; "
   EndIf
   Return $oProvider
EndFunc