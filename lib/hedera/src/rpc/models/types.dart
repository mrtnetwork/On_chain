// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.1.0
// Mirror Node REST API 0.159.2

import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Network entity ID in the format of `shard.realm.num`
typedef HederaMirrorTypesEntityId = String?;

/// RFC4648 no-padding base32 encoded account alias
typedef HederaMirrorTypesAlias = String?;

/// A Unix timestamp in seconds.nanoseconds format
typedef HederaMirrorTypesTimestampNullable = String?;

/// A network entity encoded as an EVM address in hex.
typedef HederaMirrorTypesEvmAddressNullable = String?;

typedef HederaMirrorTypesAccounts = List<HederaMirrorTypesAccountInfo>;

typedef HederaMirrorTypesEntityIdQuery = String;

/// A Unix timestamp in seconds.nanoseconds format
typedef HederaMirrorTypesTimestamp = String;

typedef HederaMirrorTypesStakingRewardTransfers =
    List<HederaMirrorTypesStakingRewardTransfer>;

typedef HederaMirrorTypesTransactions = List<HederaMirrorTypesTransaction>;

typedef HederaMirrorTypesTokenAirdrops = List<HederaMirrorTypesTokenAirdrop>;

typedef HederaMirrorTypesCryptoAllowances =
    List<HederaMirrorTypesCryptoAllowance>;

typedef HederaMirrorTypesTokenAllowances =
    List<HederaMirrorTypesTokenAllowance>;

typedef HederaMirrorTypesNftAllowances = List<HederaMirrorTypesNftAllowance>;

typedef HederaMirrorTypesBlocks = List<HederaMirrorTypesBlock>;

/// A network entity encoded as an EVM address in hex.
typedef HederaMirrorTypesEvmAddress = String;

typedef HederaMirrorTypesContracts = List<HederaMirrorTypesContract>;

typedef HederaMirrorTypesContractResults =
    List<HederaMirrorTypesContractResult>;

/// A list of hex encoded topics associated with this log event
typedef HederaMirrorTypesContractLogTopics = List<String>;

typedef HederaMirrorTypesContractResultLogs =
    List<HederaMirrorTypesContractResultLog>;

typedef HederaMirrorTypesContractResultStateChanges =
    List<HederaMirrorTypesContractResultStateChange>;

typedef HederaMirrorTypesContractActions =
    List<HederaMirrorTypesContractAction>;

typedef HederaMirrorTypesContractLogs = List<HederaMirrorTypesContractLog>;

typedef HederaMirrorTypesLogTopicQueryParam = List<String>;

typedef HederaMirrorTypesNetworkFees = List<HederaMirrorTypesNetworkFee>;

typedef HederaMirrorTypesServiceEndpoints =
    List<HederaMirrorTypesServiceEndpoint>;

typedef HederaMirrorTypesNetworkNodes = List<HederaMirrorTypesNetworkNode>;

typedef HederaMirrorTypesRegisteredServiceEndpoints =
    List<HederaMirrorTypesRegisteredServiceEndpoint>;

typedef HederaMirrorTypesRegisteredNodes =
    List<HederaMirrorTypesRegisteredNode>;

typedef HederaMirrorTypesSchedules = List<HederaMirrorTypesSchedule>;

typedef HederaMirrorTypesTransactionDetails =
    List<HederaMirrorTypesTransactionDetail>;

typedef HederaMirrorTypesTopicMessages = List<HederaMirrorTypesTopicMessage>;

typedef HederaMirrorTypesTokens = List<HederaMirrorTypesToken>;

typedef HederaMirrorTypesTokenDistribution =
    List<HederaMirrorTypesTokenDistributionItem>;

/// Account alias in the format of 'shard.realm.alias', 'realm.alias', or 'alias'. 'alias' is the RFC4648 no-padding base32 encoded string of the account's alias.
typedef HederaMirrorTypesAccountAlias = String;

typedef HederaMirrorTypesBloom = String?;

/// A hex encoded ethereum transaction hash.
typedef HederaMirrorTypesEthereumHash = String;

/// A network entity encoded as an EVM address in hex.
typedef HederaMirrorTypesEvmAddressWithShardRealm = String;

/// A hex encoded hedera transaction hash.
typedef HederaMirrorTypesHederaHash = String;

/// A positive number.
typedef HederaMirrorTypesPositiveNumber = BigInt;

/// A transaction id in string format.
typedef HederaMirrorTypesTransactionIdStr = String;

enum HederaMirrorTypesKeyType {
  eCDSASECP256K1,
  eD25519,
  protobufEncoded;

  static HederaMirrorTypesKeyType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'ECDSA_SECP256K1' => HederaMirrorTypesKeyType.eCDSASECP256K1,
      'ED25519' => HederaMirrorTypesKeyType.eD25519,
      'ProtobufEncoded' => HederaMirrorTypesKeyType.protobufEncoded,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesKeyType',
          reason: 'Unknown HederaMirrorTypesKeyType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesKeyType.eCDSASECP256K1 => 'ECDSA_SECP256K1',
    HederaMirrorTypesKeyType.eD25519 => 'ED25519',
    HederaMirrorTypesKeyType.protobufEncoded => 'ProtobufEncoded',
  };
}

enum HederaMirrorTypesOrder {
  asc,
  desc;

  static HederaMirrorTypesOrder fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'asc' => HederaMirrorTypesOrder.asc,
      'desc' => HederaMirrorTypesOrder.desc,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesOrder',
          reason: 'Unknown HederaMirrorTypesOrder: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesOrder.asc => 'asc',
    HederaMirrorTypesOrder.desc => 'desc',
  };
}

enum HederaMirrorTypesTransactionTypes {
  aTOMICBATCH,
  cONSENSUSCREATETOPIC,
  cONSENSUSDELETETOPIC,
  cONSENSUSSUBMITMESSAGE,
  cONSENSUSUPDATETOPIC,
  cONTRACTCALL,
  cONTRACTCREATEINSTANCE,
  cONTRACTDELETEINSTANCE,
  cONTRACTUPDATEINSTANCE,
  cRSPUBLICATION,
  cRYPTOADDLIVEHASH,
  cRYPTOAPPROVEALLOWANCE,
  cRYPTOCREATEACCOUNT,
  cRYPTODELETE,
  cRYPTODELETEALLOWANCE,
  cRYPTODELETELIVEHASH,
  cRYPTOTRANSFER,
  cRYPTOUPDATEACCOUNT,
  eTHEREUMTRANSACTION,
  fILEAPPEND,
  fILECREATE,
  fILEDELETE,
  fILEUPDATE,
  fREEZE,
  hINTSKEYPUBLICATION,
  hINTSPARTIALSIGNATURE,
  hINTSPREPROCESSINGVOTE,
  hISTORYPROOFKEYPUBLICATION,
  hISTORYPROOFSIGNATURE,
  hISTORYPROOFVOTE,
  hOOKSTORE,
  lEDGERIDPUBLICATION,
  mIGRATIONROOTHASHVOTE,
  nODECREATE,
  nODEDELETE,
  nODESTAKEUPDATE,
  nODEUPDATE,
  rEGISTEREDNODECREATE,
  rEGISTEREDNODEDELETE,
  rEGISTEREDNODEUPDATE,
  sCHEDULECREATE,
  sCHEDULEDELETE,
  sCHEDULESIGN,
  sTATESIGNATURETRANSACTION,
  sYSTEMDELETE,
  sYSTEMUNDELETE,
  tOKENAIRDROP,
  tOKENASSOCIATE,
  tOKENBURN,
  tOKENCANCELAIRDROP,
  tOKENCLAIMAIRDROP,
  tOKENCREATION,
  tOKENDELETION,
  tOKENDISSOCIATE,
  tOKENFEESCHEDULEUPDATE,
  tOKENFREEZE,
  tOKENGRANTKYC,
  tOKENMINT,
  tOKENPAUSE,
  tOKENREJECT,
  tOKENREVOKEKYC,
  tOKENUNFREEZE,
  tOKENUNPAUSE,
  tOKENUPDATE,
  tOKENUPDATENFTS,
  tOKENWIPE,
  uNCHECKEDSUBMIT,
  uTILPRNG;

  static HederaMirrorTypesTransactionTypes fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'ATOMICBATCH' => HederaMirrorTypesTransactionTypes.aTOMICBATCH,
      'CONSENSUSCREATETOPIC' =>
        HederaMirrorTypesTransactionTypes.cONSENSUSCREATETOPIC,
      'CONSENSUSDELETETOPIC' =>
        HederaMirrorTypesTransactionTypes.cONSENSUSDELETETOPIC,
      'CONSENSUSSUBMITMESSAGE' =>
        HederaMirrorTypesTransactionTypes.cONSENSUSSUBMITMESSAGE,
      'CONSENSUSUPDATETOPIC' =>
        HederaMirrorTypesTransactionTypes.cONSENSUSUPDATETOPIC,
      'CONTRACTCALL' => HederaMirrorTypesTransactionTypes.cONTRACTCALL,
      'CONTRACTCREATEINSTANCE' =>
        HederaMirrorTypesTransactionTypes.cONTRACTCREATEINSTANCE,
      'CONTRACTDELETEINSTANCE' =>
        HederaMirrorTypesTransactionTypes.cONTRACTDELETEINSTANCE,
      'CONTRACTUPDATEINSTANCE' =>
        HederaMirrorTypesTransactionTypes.cONTRACTUPDATEINSTANCE,
      'CRSPUBLICATION' => HederaMirrorTypesTransactionTypes.cRSPUBLICATION,
      'CRYPTOADDLIVEHASH' =>
        HederaMirrorTypesTransactionTypes.cRYPTOADDLIVEHASH,
      'CRYPTOAPPROVEALLOWANCE' =>
        HederaMirrorTypesTransactionTypes.cRYPTOAPPROVEALLOWANCE,
      'CRYPTOCREATEACCOUNT' =>
        HederaMirrorTypesTransactionTypes.cRYPTOCREATEACCOUNT,
      'CRYPTODELETE' => HederaMirrorTypesTransactionTypes.cRYPTODELETE,
      'CRYPTODELETEALLOWANCE' =>
        HederaMirrorTypesTransactionTypes.cRYPTODELETEALLOWANCE,
      'CRYPTODELETELIVEHASH' =>
        HederaMirrorTypesTransactionTypes.cRYPTODELETELIVEHASH,
      'CRYPTOTRANSFER' => HederaMirrorTypesTransactionTypes.cRYPTOTRANSFER,
      'CRYPTOUPDATEACCOUNT' =>
        HederaMirrorTypesTransactionTypes.cRYPTOUPDATEACCOUNT,
      'ETHEREUMTRANSACTION' =>
        HederaMirrorTypesTransactionTypes.eTHEREUMTRANSACTION,
      'FILEAPPEND' => HederaMirrorTypesTransactionTypes.fILEAPPEND,
      'FILECREATE' => HederaMirrorTypesTransactionTypes.fILECREATE,
      'FILEDELETE' => HederaMirrorTypesTransactionTypes.fILEDELETE,
      'FILEUPDATE' => HederaMirrorTypesTransactionTypes.fILEUPDATE,
      'FREEZE' => HederaMirrorTypesTransactionTypes.fREEZE,
      'HINTSKEYPUBLICATION' =>
        HederaMirrorTypesTransactionTypes.hINTSKEYPUBLICATION,
      'HINTSPARTIALSIGNATURE' =>
        HederaMirrorTypesTransactionTypes.hINTSPARTIALSIGNATURE,
      'HINTSPREPROCESSINGVOTE' =>
        HederaMirrorTypesTransactionTypes.hINTSPREPROCESSINGVOTE,
      'HISTORYPROOFKEYPUBLICATION' =>
        HederaMirrorTypesTransactionTypes.hISTORYPROOFKEYPUBLICATION,
      'HISTORYPROOFSIGNATURE' =>
        HederaMirrorTypesTransactionTypes.hISTORYPROOFSIGNATURE,
      'HISTORYPROOFVOTE' => HederaMirrorTypesTransactionTypes.hISTORYPROOFVOTE,
      'HOOKSTORE' => HederaMirrorTypesTransactionTypes.hOOKSTORE,
      'LEDGERIDPUBLICATION' =>
        HederaMirrorTypesTransactionTypes.lEDGERIDPUBLICATION,
      'MIGRATIONROOTHASHVOTE' =>
        HederaMirrorTypesTransactionTypes.mIGRATIONROOTHASHVOTE,
      'NODECREATE' => HederaMirrorTypesTransactionTypes.nODECREATE,
      'NODEDELETE' => HederaMirrorTypesTransactionTypes.nODEDELETE,
      'NODESTAKEUPDATE' => HederaMirrorTypesTransactionTypes.nODESTAKEUPDATE,
      'NODEUPDATE' => HederaMirrorTypesTransactionTypes.nODEUPDATE,
      'REGISTEREDNODECREATE' =>
        HederaMirrorTypesTransactionTypes.rEGISTEREDNODECREATE,
      'REGISTEREDNODEDELETE' =>
        HederaMirrorTypesTransactionTypes.rEGISTEREDNODEDELETE,
      'REGISTEREDNODEUPDATE' =>
        HederaMirrorTypesTransactionTypes.rEGISTEREDNODEUPDATE,
      'SCHEDULECREATE' => HederaMirrorTypesTransactionTypes.sCHEDULECREATE,
      'SCHEDULEDELETE' => HederaMirrorTypesTransactionTypes.sCHEDULEDELETE,
      'SCHEDULESIGN' => HederaMirrorTypesTransactionTypes.sCHEDULESIGN,
      'STATESIGNATURETRANSACTION' =>
        HederaMirrorTypesTransactionTypes.sTATESIGNATURETRANSACTION,
      'SYSTEMDELETE' => HederaMirrorTypesTransactionTypes.sYSTEMDELETE,
      'SYSTEMUNDELETE' => HederaMirrorTypesTransactionTypes.sYSTEMUNDELETE,
      'TOKENAIRDROP' => HederaMirrorTypesTransactionTypes.tOKENAIRDROP,
      'TOKENASSOCIATE' => HederaMirrorTypesTransactionTypes.tOKENASSOCIATE,
      'TOKENBURN' => HederaMirrorTypesTransactionTypes.tOKENBURN,
      'TOKENCANCELAIRDROP' =>
        HederaMirrorTypesTransactionTypes.tOKENCANCELAIRDROP,
      'TOKENCLAIMAIRDROP' =>
        HederaMirrorTypesTransactionTypes.tOKENCLAIMAIRDROP,
      'TOKENCREATION' => HederaMirrorTypesTransactionTypes.tOKENCREATION,
      'TOKENDELETION' => HederaMirrorTypesTransactionTypes.tOKENDELETION,
      'TOKENDISSOCIATE' => HederaMirrorTypesTransactionTypes.tOKENDISSOCIATE,
      'TOKENFEESCHEDULEUPDATE' =>
        HederaMirrorTypesTransactionTypes.tOKENFEESCHEDULEUPDATE,
      'TOKENFREEZE' => HederaMirrorTypesTransactionTypes.tOKENFREEZE,
      'TOKENGRANTKYC' => HederaMirrorTypesTransactionTypes.tOKENGRANTKYC,
      'TOKENMINT' => HederaMirrorTypesTransactionTypes.tOKENMINT,
      'TOKENPAUSE' => HederaMirrorTypesTransactionTypes.tOKENPAUSE,
      'TOKENREJECT' => HederaMirrorTypesTransactionTypes.tOKENREJECT,
      'TOKENREVOKEKYC' => HederaMirrorTypesTransactionTypes.tOKENREVOKEKYC,
      'TOKENUNFREEZE' => HederaMirrorTypesTransactionTypes.tOKENUNFREEZE,
      'TOKENUNPAUSE' => HederaMirrorTypesTransactionTypes.tOKENUNPAUSE,
      'TOKENUPDATE' => HederaMirrorTypesTransactionTypes.tOKENUPDATE,
      'TOKENUPDATENFTS' => HederaMirrorTypesTransactionTypes.tOKENUPDATENFTS,
      'TOKENWIPE' => HederaMirrorTypesTransactionTypes.tOKENWIPE,
      'UNCHECKEDSUBMIT' => HederaMirrorTypesTransactionTypes.uNCHECKEDSUBMIT,
      'UTILPRNG' => HederaMirrorTypesTransactionTypes.uTILPRNG,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTransactionTypes',
          reason: 'Unknown HederaMirrorTypesTransactionTypes: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTransactionTypes.aTOMICBATCH => 'ATOMICBATCH',
    HederaMirrorTypesTransactionTypes.cONSENSUSCREATETOPIC =>
      'CONSENSUSCREATETOPIC',
    HederaMirrorTypesTransactionTypes.cONSENSUSDELETETOPIC =>
      'CONSENSUSDELETETOPIC',
    HederaMirrorTypesTransactionTypes.cONSENSUSSUBMITMESSAGE =>
      'CONSENSUSSUBMITMESSAGE',
    HederaMirrorTypesTransactionTypes.cONSENSUSUPDATETOPIC =>
      'CONSENSUSUPDATETOPIC',
    HederaMirrorTypesTransactionTypes.cONTRACTCALL => 'CONTRACTCALL',
    HederaMirrorTypesTransactionTypes.cONTRACTCREATEINSTANCE =>
      'CONTRACTCREATEINSTANCE',
    HederaMirrorTypesTransactionTypes.cONTRACTDELETEINSTANCE =>
      'CONTRACTDELETEINSTANCE',
    HederaMirrorTypesTransactionTypes.cONTRACTUPDATEINSTANCE =>
      'CONTRACTUPDATEINSTANCE',
    HederaMirrorTypesTransactionTypes.cRSPUBLICATION => 'CRSPUBLICATION',
    HederaMirrorTypesTransactionTypes.cRYPTOADDLIVEHASH => 'CRYPTOADDLIVEHASH',
    HederaMirrorTypesTransactionTypes.cRYPTOAPPROVEALLOWANCE =>
      'CRYPTOAPPROVEALLOWANCE',
    HederaMirrorTypesTransactionTypes.cRYPTOCREATEACCOUNT =>
      'CRYPTOCREATEACCOUNT',
    HederaMirrorTypesTransactionTypes.cRYPTODELETE => 'CRYPTODELETE',
    HederaMirrorTypesTransactionTypes.cRYPTODELETEALLOWANCE =>
      'CRYPTODELETEALLOWANCE',
    HederaMirrorTypesTransactionTypes.cRYPTODELETELIVEHASH =>
      'CRYPTODELETELIVEHASH',
    HederaMirrorTypesTransactionTypes.cRYPTOTRANSFER => 'CRYPTOTRANSFER',
    HederaMirrorTypesTransactionTypes.cRYPTOUPDATEACCOUNT =>
      'CRYPTOUPDATEACCOUNT',
    HederaMirrorTypesTransactionTypes.eTHEREUMTRANSACTION =>
      'ETHEREUMTRANSACTION',
    HederaMirrorTypesTransactionTypes.fILEAPPEND => 'FILEAPPEND',
    HederaMirrorTypesTransactionTypes.fILECREATE => 'FILECREATE',
    HederaMirrorTypesTransactionTypes.fILEDELETE => 'FILEDELETE',
    HederaMirrorTypesTransactionTypes.fILEUPDATE => 'FILEUPDATE',
    HederaMirrorTypesTransactionTypes.fREEZE => 'FREEZE',
    HederaMirrorTypesTransactionTypes.hINTSKEYPUBLICATION =>
      'HINTSKEYPUBLICATION',
    HederaMirrorTypesTransactionTypes.hINTSPARTIALSIGNATURE =>
      'HINTSPARTIALSIGNATURE',
    HederaMirrorTypesTransactionTypes.hINTSPREPROCESSINGVOTE =>
      'HINTSPREPROCESSINGVOTE',
    HederaMirrorTypesTransactionTypes.hISTORYPROOFKEYPUBLICATION =>
      'HISTORYPROOFKEYPUBLICATION',
    HederaMirrorTypesTransactionTypes.hISTORYPROOFSIGNATURE =>
      'HISTORYPROOFSIGNATURE',
    HederaMirrorTypesTransactionTypes.hISTORYPROOFVOTE => 'HISTORYPROOFVOTE',
    HederaMirrorTypesTransactionTypes.hOOKSTORE => 'HOOKSTORE',
    HederaMirrorTypesTransactionTypes.lEDGERIDPUBLICATION =>
      'LEDGERIDPUBLICATION',
    HederaMirrorTypesTransactionTypes.mIGRATIONROOTHASHVOTE =>
      'MIGRATIONROOTHASHVOTE',
    HederaMirrorTypesTransactionTypes.nODECREATE => 'NODECREATE',
    HederaMirrorTypesTransactionTypes.nODEDELETE => 'NODEDELETE',
    HederaMirrorTypesTransactionTypes.nODESTAKEUPDATE => 'NODESTAKEUPDATE',
    HederaMirrorTypesTransactionTypes.nODEUPDATE => 'NODEUPDATE',
    HederaMirrorTypesTransactionTypes.rEGISTEREDNODECREATE =>
      'REGISTEREDNODECREATE',
    HederaMirrorTypesTransactionTypes.rEGISTEREDNODEDELETE =>
      'REGISTEREDNODEDELETE',
    HederaMirrorTypesTransactionTypes.rEGISTEREDNODEUPDATE =>
      'REGISTEREDNODEUPDATE',
    HederaMirrorTypesTransactionTypes.sCHEDULECREATE => 'SCHEDULECREATE',
    HederaMirrorTypesTransactionTypes.sCHEDULEDELETE => 'SCHEDULEDELETE',
    HederaMirrorTypesTransactionTypes.sCHEDULESIGN => 'SCHEDULESIGN',
    HederaMirrorTypesTransactionTypes.sTATESIGNATURETRANSACTION =>
      'STATESIGNATURETRANSACTION',
    HederaMirrorTypesTransactionTypes.sYSTEMDELETE => 'SYSTEMDELETE',
    HederaMirrorTypesTransactionTypes.sYSTEMUNDELETE => 'SYSTEMUNDELETE',
    HederaMirrorTypesTransactionTypes.tOKENAIRDROP => 'TOKENAIRDROP',
    HederaMirrorTypesTransactionTypes.tOKENASSOCIATE => 'TOKENASSOCIATE',
    HederaMirrorTypesTransactionTypes.tOKENBURN => 'TOKENBURN',
    HederaMirrorTypesTransactionTypes.tOKENCANCELAIRDROP =>
      'TOKENCANCELAIRDROP',
    HederaMirrorTypesTransactionTypes.tOKENCLAIMAIRDROP => 'TOKENCLAIMAIRDROP',
    HederaMirrorTypesTransactionTypes.tOKENCREATION => 'TOKENCREATION',
    HederaMirrorTypesTransactionTypes.tOKENDELETION => 'TOKENDELETION',
    HederaMirrorTypesTransactionTypes.tOKENDISSOCIATE => 'TOKENDISSOCIATE',
    HederaMirrorTypesTransactionTypes.tOKENFEESCHEDULEUPDATE =>
      'TOKENFEESCHEDULEUPDATE',
    HederaMirrorTypesTransactionTypes.tOKENFREEZE => 'TOKENFREEZE',
    HederaMirrorTypesTransactionTypes.tOKENGRANTKYC => 'TOKENGRANTKYC',
    HederaMirrorTypesTransactionTypes.tOKENMINT => 'TOKENMINT',
    HederaMirrorTypesTransactionTypes.tOKENPAUSE => 'TOKENPAUSE',
    HederaMirrorTypesTransactionTypes.tOKENREJECT => 'TOKENREJECT',
    HederaMirrorTypesTransactionTypes.tOKENREVOKEKYC => 'TOKENREVOKEKYC',
    HederaMirrorTypesTransactionTypes.tOKENUNFREEZE => 'TOKENUNFREEZE',
    HederaMirrorTypesTransactionTypes.tOKENUNPAUSE => 'TOKENUNPAUSE',
    HederaMirrorTypesTransactionTypes.tOKENUPDATE => 'TOKENUPDATE',
    HederaMirrorTypesTransactionTypes.tOKENUPDATENFTS => 'TOKENUPDATENFTS',
    HederaMirrorTypesTransactionTypes.tOKENWIPE => 'TOKENWIPE',
    HederaMirrorTypesTransactionTypes.uNCHECKEDSUBMIT => 'UNCHECKEDSUBMIT',
    HederaMirrorTypesTransactionTypes.uTILPRNG => 'UTILPRNG',
  };
}

/// The extension point this hook implements
enum HederaMirrorTypesHookExtensionPoint {
  aCCOUNTALLOWANCEHOOK;

  static HederaMirrorTypesHookExtensionPoint fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'ACCOUNT_ALLOWANCE_HOOK' =>
        HederaMirrorTypesHookExtensionPoint.aCCOUNTALLOWANCEHOOK,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesHookExtensionPoint',
          reason: 'Unknown HederaMirrorTypesHookExtensionPoint: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesHookExtensionPoint.aCCOUNTALLOWANCEHOOK =>
      'ACCOUNT_ALLOWANCE_HOOK',
  };
}

/// The type of the hook implementation
enum HederaMirrorTypesHookType {
  eVM;

  static HederaMirrorTypesHookType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'EVM' => HederaMirrorTypesHookType.eVM,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesHookType',
          reason: 'Unknown HederaMirrorTypesHookType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesHookType.eVM => 'EVM',
  };
}

/// The Freeze status of the account.
enum HederaMirrorTypesTokenRelationshipFreezeStatus {
  nOTAPPLICABLE,
  fROZEN,
  uNFROZEN;

  static HederaMirrorTypesTokenRelationshipFreezeStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'NOT_APPLICABLE' =>
        HederaMirrorTypesTokenRelationshipFreezeStatus.nOTAPPLICABLE,
      'FROZEN' => HederaMirrorTypesTokenRelationshipFreezeStatus.fROZEN,
      'UNFROZEN' => HederaMirrorTypesTokenRelationshipFreezeStatus.uNFROZEN,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTokenRelationshipFreezeStatus',
          reason:
              'Unknown HederaMirrorTypesTokenRelationshipFreezeStatus: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTokenRelationshipFreezeStatus.nOTAPPLICABLE =>
      'NOT_APPLICABLE',
    HederaMirrorTypesTokenRelationshipFreezeStatus.fROZEN => 'FROZEN',
    HederaMirrorTypesTokenRelationshipFreezeStatus.uNFROZEN => 'UNFROZEN',
  };
}

/// The KYC status of the account.
enum HederaMirrorTypesTokenRelationshipKycStatus {
  nOTAPPLICABLE,
  gRANTED,
  rEVOKED;

  static HederaMirrorTypesTokenRelationshipKycStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'NOT_APPLICABLE' =>
        HederaMirrorTypesTokenRelationshipKycStatus.nOTAPPLICABLE,
      'GRANTED' => HederaMirrorTypesTokenRelationshipKycStatus.gRANTED,
      'REVOKED' => HederaMirrorTypesTokenRelationshipKycStatus.rEVOKED,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTokenRelationshipKycStatus',
          reason: 'Unknown HederaMirrorTypesTokenRelationshipKycStatus: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTokenRelationshipKycStatus.nOTAPPLICABLE =>
      'NOT_APPLICABLE',
    HederaMirrorTypesTokenRelationshipKycStatus.gRANTED => 'GRANTED',
    HederaMirrorTypesTokenRelationshipKycStatus.rEVOKED => 'REVOKED',
  };
}

/// The type of the call operation
enum HederaMirrorTypesContractActionCallOperationType {
  cALL,
  cALLCODE,
  cREATE,
  cREATE2,
  dELEGATECALL,
  sTATICCALL,
  uNKNOWN;

  static HederaMirrorTypesContractActionCallOperationType fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'CALL' => HederaMirrorTypesContractActionCallOperationType.cALL,
      'CALLCODE' => HederaMirrorTypesContractActionCallOperationType.cALLCODE,
      'CREATE' => HederaMirrorTypesContractActionCallOperationType.cREATE,
      'CREATE2' => HederaMirrorTypesContractActionCallOperationType.cREATE2,
      'DELEGATECALL' =>
        HederaMirrorTypesContractActionCallOperationType.dELEGATECALL,
      'STATICCALL' =>
        HederaMirrorTypesContractActionCallOperationType.sTATICCALL,
      'UNKNOWN' => HederaMirrorTypesContractActionCallOperationType.uNKNOWN,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesContractActionCallOperationType',
          reason:
              'Unknown HederaMirrorTypesContractActionCallOperationType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesContractActionCallOperationType.cALL => 'CALL',
    HederaMirrorTypesContractActionCallOperationType.cALLCODE => 'CALLCODE',
    HederaMirrorTypesContractActionCallOperationType.cREATE => 'CREATE',
    HederaMirrorTypesContractActionCallOperationType.cREATE2 => 'CREATE2',
    HederaMirrorTypesContractActionCallOperationType.dELEGATECALL =>
      'DELEGATECALL',
    HederaMirrorTypesContractActionCallOperationType.sTATICCALL => 'STATICCALL',
    HederaMirrorTypesContractActionCallOperationType.uNKNOWN => 'UNKNOWN',
  };
}

/// The type of the call
enum HederaMirrorTypesContractActionCallType {
  nOACTION,
  cALL,
  cREATE,
  pRECOMPILE,
  sYSTEM;

  static HederaMirrorTypesContractActionCallType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'NO_ACTION' => HederaMirrorTypesContractActionCallType.nOACTION,
      'CALL' => HederaMirrorTypesContractActionCallType.cALL,
      'CREATE' => HederaMirrorTypesContractActionCallType.cREATE,
      'PRECOMPILE' => HederaMirrorTypesContractActionCallType.pRECOMPILE,
      'SYSTEM' => HederaMirrorTypesContractActionCallType.sYSTEM,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesContractActionCallType',
          reason: 'Unknown HederaMirrorTypesContractActionCallType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesContractActionCallType.nOACTION => 'NO_ACTION',
    HederaMirrorTypesContractActionCallType.cALL => 'CALL',
    HederaMirrorTypesContractActionCallType.cREATE => 'CREATE',
    HederaMirrorTypesContractActionCallType.pRECOMPILE => 'PRECOMPILE',
    HederaMirrorTypesContractActionCallType.sYSTEM => 'SYSTEM',
  };
}

/// The entity type of the caller
enum HederaMirrorTypesContractActionCallerType {
  aCCOUNT,
  cONTRACT;

  static HederaMirrorTypesContractActionCallerType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'ACCOUNT' => HederaMirrorTypesContractActionCallerType.aCCOUNT,
      'CONTRACT' => HederaMirrorTypesContractActionCallerType.cONTRACT,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesContractActionCallerType',
          reason: 'Unknown HederaMirrorTypesContractActionCallerType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesContractActionCallerType.aCCOUNT => 'ACCOUNT',
    HederaMirrorTypesContractActionCallerType.cONTRACT => 'CONTRACT',
  };
}

/// The type of the result data
enum HederaMirrorTypesContractActionResultDataType {
  oUTPUT,
  rEVERTREASON,
  eRROR;

  static HederaMirrorTypesContractActionResultDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'OUTPUT' => HederaMirrorTypesContractActionResultDataType.oUTPUT,
      'REVERT_REASON' =>
        HederaMirrorTypesContractActionResultDataType.rEVERTREASON,
      'ERROR' => HederaMirrorTypesContractActionResultDataType.eRROR,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesContractActionResultDataType',
          reason:
              'Unknown HederaMirrorTypesContractActionResultDataType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesContractActionResultDataType.oUTPUT => 'OUTPUT',
    HederaMirrorTypesContractActionResultDataType.rEVERTREASON =>
      'REVERT_REASON',
    HederaMirrorTypesContractActionResultDataType.eRROR => 'ERROR',
  };
}

/// Estimate solely based on the transaction's inherent properties or use network state.
enum HederaMirrorTypesFeeEstimateMode {
  iNTRINSIC,
  sTATE;

  static HederaMirrorTypesFeeEstimateMode fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'INTRINSIC' => HederaMirrorTypesFeeEstimateMode.iNTRINSIC,
      'STATE' => HederaMirrorTypesFeeEstimateMode.sTATE,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesFeeEstimateMode',
          reason: 'Unknown HederaMirrorTypesFeeEstimateMode: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesFeeEstimateMode.iNTRINSIC => 'INTRINSIC',
    HederaMirrorTypesFeeEstimateMode.sTATE => 'STATE',
  };
}

enum HederaMirrorTypesRegisteredBlockNodeApi {
  oTHER,
  sTATUS,
  pUBLISH,
  sUBSCRIBESTREAM,
  sTATEPROOF,
  uNRECOGNIZED;

  static HederaMirrorTypesRegisteredBlockNodeApi fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'OTHER' => HederaMirrorTypesRegisteredBlockNodeApi.oTHER,
      'STATUS' => HederaMirrorTypesRegisteredBlockNodeApi.sTATUS,
      'PUBLISH' => HederaMirrorTypesRegisteredBlockNodeApi.pUBLISH,
      'SUBSCRIBE_STREAM' =>
        HederaMirrorTypesRegisteredBlockNodeApi.sUBSCRIBESTREAM,
      'STATE_PROOF' => HederaMirrorTypesRegisteredBlockNodeApi.sTATEPROOF,
      'UNRECOGNIZED' => HederaMirrorTypesRegisteredBlockNodeApi.uNRECOGNIZED,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesRegisteredBlockNodeApi',
          reason: 'Unknown HederaMirrorTypesRegisteredBlockNodeApi: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesRegisteredBlockNodeApi.oTHER => 'OTHER',
    HederaMirrorTypesRegisteredBlockNodeApi.sTATUS => 'STATUS',
    HederaMirrorTypesRegisteredBlockNodeApi.pUBLISH => 'PUBLISH',
    HederaMirrorTypesRegisteredBlockNodeApi.sUBSCRIBESTREAM =>
      'SUBSCRIBE_STREAM',
    HederaMirrorTypesRegisteredBlockNodeApi.sTATEPROOF => 'STATE_PROOF',
    HederaMirrorTypesRegisteredBlockNodeApi.uNRECOGNIZED => 'UNRECOGNIZED',
  };
}

/// Registered node type.
enum HederaMirrorTypesRegisteredNodeType {
  bLOCKNODE,
  gENERALSERVICE,
  mIRRORNODE,
  rPCRELAY;

  static HederaMirrorTypesRegisteredNodeType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'BLOCK_NODE' => HederaMirrorTypesRegisteredNodeType.bLOCKNODE,
      'GENERAL_SERVICE' => HederaMirrorTypesRegisteredNodeType.gENERALSERVICE,
      'MIRROR_NODE' => HederaMirrorTypesRegisteredNodeType.mIRRORNODE,
      'RPC_RELAY' => HederaMirrorTypesRegisteredNodeType.rPCRELAY,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesRegisteredNodeType',
          reason: 'Unknown HederaMirrorTypesRegisteredNodeType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesRegisteredNodeType.bLOCKNODE => 'BLOCK_NODE',
    HederaMirrorTypesRegisteredNodeType.gENERALSERVICE => 'GENERAL_SERVICE',
    HederaMirrorTypesRegisteredNodeType.mIRRORNODE => 'MIRROR_NODE',
    HederaMirrorTypesRegisteredNodeType.rPCRELAY => 'RPC_RELAY',
  };
}

enum HederaMirrorTypesScheduleSignatureType {
  cONTRACT,
  eD25519,
  rSA3072,
  eCDSA384,
  eCDSASECP256K1,
  uNKNOWN;

  static HederaMirrorTypesScheduleSignatureType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'CONTRACT' => HederaMirrorTypesScheduleSignatureType.cONTRACT,
      'ED25519' => HederaMirrorTypesScheduleSignatureType.eD25519,
      'RSA_3072' => HederaMirrorTypesScheduleSignatureType.rSA3072,
      'ECDSA_384' => HederaMirrorTypesScheduleSignatureType.eCDSA384,
      'ECDSA_SECP256K1' =>
        HederaMirrorTypesScheduleSignatureType.eCDSASECP256K1,
      'UNKNOWN' => HederaMirrorTypesScheduleSignatureType.uNKNOWN,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesScheduleSignatureType',
          reason: 'Unknown HederaMirrorTypesScheduleSignatureType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesScheduleSignatureType.cONTRACT => 'CONTRACT',
    HederaMirrorTypesScheduleSignatureType.eD25519 => 'ED25519',
    HederaMirrorTypesScheduleSignatureType.rSA3072 => 'RSA_3072',
    HederaMirrorTypesScheduleSignatureType.eCDSA384 => 'ECDSA_384',
    HederaMirrorTypesScheduleSignatureType.eCDSASECP256K1 => 'ECDSA_SECP256K1',
    HederaMirrorTypesScheduleSignatureType.uNKNOWN => 'UNKNOWN',
  };
}

enum HederaMirrorTypesResult {
  success,
  fail;

  static HederaMirrorTypesResult fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'success' => HederaMirrorTypesResult.success,
      'fail' => HederaMirrorTypesResult.fail,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesResult',
          reason: 'Unknown HederaMirrorTypesResult: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesResult.success => 'success',
    HederaMirrorTypesResult.fail => 'fail',
  };
}

enum HederaMirrorTypesType {
  credit,
  debit;

  static HederaMirrorTypesType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'credit' => HederaMirrorTypesType.credit,
      'debit' => HederaMirrorTypesType.debit,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesType',
          reason: 'Unknown HederaMirrorTypesType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesType.credit => 'credit',
    HederaMirrorTypesType.debit => 'debit',
  };
}

enum HederaMirrorTypesTokenInfoPauseStatus {
  nOTAPPLICABLE,
  pAUSED,
  uNPAUSED;

  static HederaMirrorTypesTokenInfoPauseStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'NOT_APPLICABLE' => HederaMirrorTypesTokenInfoPauseStatus.nOTAPPLICABLE,
      'PAUSED' => HederaMirrorTypesTokenInfoPauseStatus.pAUSED,
      'UNPAUSED' => HederaMirrorTypesTokenInfoPauseStatus.uNPAUSED,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTokenInfoPauseStatus',
          reason: 'Unknown HederaMirrorTypesTokenInfoPauseStatus: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTokenInfoPauseStatus.nOTAPPLICABLE => 'NOT_APPLICABLE',
    HederaMirrorTypesTokenInfoPauseStatus.pAUSED => 'PAUSED',
    HederaMirrorTypesTokenInfoPauseStatus.uNPAUSED => 'UNPAUSED',
  };
}

enum HederaMirrorTypesTokenInfoSupplyType {
  fINITE,
  iNFINITE;

  static HederaMirrorTypesTokenInfoSupplyType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'FINITE' => HederaMirrorTypesTokenInfoSupplyType.fINITE,
      'INFINITE' => HederaMirrorTypesTokenInfoSupplyType.iNFINITE,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTokenInfoSupplyType',
          reason: 'Unknown HederaMirrorTypesTokenInfoSupplyType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTokenInfoSupplyType.fINITE => 'FINITE',
    HederaMirrorTypesTokenInfoSupplyType.iNFINITE => 'INFINITE',
  };
}

enum HederaMirrorTypesTokenInfoType {
  fUNGIBLECOMMON,
  nONFUNGIBLEUNIQUE;

  static HederaMirrorTypesTokenInfoType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return switch (value) {
      'FUNGIBLE_COMMON' => HederaMirrorTypesTokenInfoType.fUNGIBLECOMMON,
      'NON_FUNGIBLE_UNIQUE' => HederaMirrorTypesTokenInfoType.nONFUNGIBLEUNIQUE,
      _ =>
        throw OnChainErrors.hederaPlugin(
          'HederaMirrorTypesTokenInfoType',
          reason: 'Unknown HederaMirrorTypesTokenInfoType: $json',
        ),
    };
  }

  String toJson() => switch (this) {
    HederaMirrorTypesTokenInfoType.fUNGIBLECOMMON => 'FUNGIBLE_COMMON',
    HederaMirrorTypesTokenInfoType.nONFUNGIBLEUNIQUE => 'NON_FUNGIBLE_UNIQUE',
  };
}

class HederaMirrorTypesBalanceTokensItem {
  final HederaMirrorTypesEntityId tokenId;
  final BigInt? balance;

  const HederaMirrorTypesBalanceTokensItem({this.tokenId, this.balance});

  factory HederaMirrorTypesBalanceTokensItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesBalanceTokensItem(
      tokenId: json.valueAsString('token_id'),
      balance: json.valueAsBigInt('balance'),
    );
  }

  Map<String, dynamic> toJson() => {'token_id': tokenId, 'balance': balance};
}

class HederaMirrorTypesBalance {
  final HederaMirrorTypesTimestampNullable timestamp;
  final BigInt? balance;
  final List<HederaMirrorTypesBalanceTokensItem> tokens;

  const HederaMirrorTypesBalance({
    this.timestamp,
    this.balance,
    required this.tokens,
  });

  factory HederaMirrorTypesBalance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesBalance(
      timestamp: json.valueAsString('timestamp'),
      balance: json.valueAsBigInt('balance'),
      tokens:
          json
              .valueEnsureAsList<Map<String, dynamic>>('tokens')
              .map((e) => HederaMirrorTypesBalanceTokensItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'balance': balance,
    'tokens': tokens.map((e) => e.toJson()).toList(),
  };
}

/// The public key which controls access to various network entities.
class HederaMirrorTypesKey {
  final HederaMirrorTypesKeyType? type;
  final String? key;

  const HederaMirrorTypesKey({this.type, this.key});

  factory HederaMirrorTypesKey.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesKey(
      type:
          json.hasValue('_type')
              ? HederaMirrorTypesKeyType.fromJson(json['_type'])
              : null,
      key: json.valueAsString('key'),
    );
  }

  Map<String, dynamic> toJson() => {'_type': type?.toJson(), 'key': key};
}

class HederaMirrorTypesAccountInfo {
  final HederaMirrorTypesEntityId account;
  final HederaMirrorTypesAlias alias;
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesBalance? balance;
  final HederaMirrorTypesTimestampNullable createdTimestamp;

  /// Whether the account declines receiving a staking reward
  final bool declineReward;
  final HederaMirrorTypesEvmAddressNullable delegationAddress;
  final bool? deleted;
  final BigInt? ethereumNonce;
  final HederaMirrorTypesEvmAddressNullable evmAddress;
  final HederaMirrorTypesTimestampNullable expiryTimestamp;
  final HederaMirrorTypesKey? key;
  final int? maxAutomaticTokenAssociations;
  final String? memo;

  /// The pending reward in tinybars the account will receive in the next reward payout. Note the value is updated
  final BigInt? pendingReward;
  final bool? receiverSigRequired;
  final String? stakedAccountId;

  /// The id of the node to which this account is staking
  final BigInt? stakedNodeId;
  final String? stakePeriodStart;

  /// Recent transactions involving this account (single-account lookup only).
  final List<HederaMirrorTypesTransaction>? transactions;

  /// Pagination links for the embedded transactions.
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesAccountInfo({
    this.account,
    this.alias,
    this.autoRenewPeriod,
    this.balance,
    this.createdTimestamp,
    required this.declineReward,
    this.delegationAddress,
    this.deleted,
    this.ethereumNonce,
    this.evmAddress,
    this.expiryTimestamp,
    this.key,
    this.maxAutomaticTokenAssociations,
    this.memo,
    this.pendingReward,
    this.receiverSigRequired,
    this.stakedAccountId,
    this.stakedNodeId,
    this.stakePeriodStart,
    this.transactions,
    this.links,
  });

  factory HederaMirrorTypesAccountInfo.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesAccountInfo(
      account: json.valueAsString('account'),
      alias: json.valueAsString('alias'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      balance: json.valueTo<HederaMirrorTypesBalance?, Map<String, dynamic>>(
        key: 'balance',
        parse: (v) => HederaMirrorTypesBalance.fromJson(v),
      ),
      createdTimestamp: json.valueAsString('created_timestamp'),
      declineReward: json.valueAsBool('decline_reward'),
      delegationAddress: json.valueAsString('delegation_address'),
      deleted: json.valueAsBool('deleted'),
      ethereumNonce: json.valueAsBigInt('ethereum_nonce'),
      evmAddress: json.valueAsString('evm_address'),
      expiryTimestamp: json.valueAsString('expiry_timestamp'),
      key: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      maxAutomaticTokenAssociations: json.valueAsInt(
        'max_automatic_token_associations',
      ),
      memo: json.valueAsString('memo'),
      pendingReward: json.valueAsBigInt('pending_reward'),
      receiverSigRequired: json.valueAsBool('receiver_sig_required'),
      stakedAccountId: json.valueAsString('staked_account_id'),
      stakedNodeId: json.valueAsBigInt('staked_node_id'),
      stakePeriodStart: json.valueAsString('stake_period_start'),
      transactions:
          json.hasValue('transactions')
              ? (json['transactions'] as List)
                  .map(
                    (e) => HederaMirrorTypesTransaction.fromJson(
                      (e as Map).cast<String, dynamic>(),
                    ),
                  )
                  .toList()
              : null,
      links:
          json.hasValue('links')
              ? HederaMirrorTypesLinks.fromJson(
                (json['links'] as Map).cast<String, dynamic>(),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'alias': alias,
    'auto_renew_period': autoRenewPeriod,
    'balance': balance?.toJson(),
    'created_timestamp': createdTimestamp,
    'decline_reward': declineReward,
    'delegation_address': delegationAddress,
    'deleted': deleted,
    'ethereum_nonce': ethereumNonce,
    'evm_address': evmAddress,
    'expiry_timestamp': expiryTimestamp,
    'key': key?.toJson(),
    'max_automatic_token_associations': maxAutomaticTokenAssociations,
    'memo': memo,
    'pending_reward': pendingReward,
    'receiver_sig_required': receiverSigRequired,
    'staked_account_id': stakedAccountId,
    'staked_node_id': stakedNodeId,
    'stake_period_start': stakePeriodStart,
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesLinks {
  final String? next;

  const HederaMirrorTypesLinks({this.next});

  factory HederaMirrorTypesLinks.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesLinks(next: json.valueAsString('next'));
  }

  Map<String, dynamic> toJson() => {'next': next};
}

/// GET /api/v1/accounts (response)
class HederaMirrorTypesAccountsResponse {
  final HederaMirrorTypesAccounts accounts;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesAccountsResponse({
    required this.accounts,
    required this.links,
  });

  factory HederaMirrorTypesAccountsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesAccountsResponse(
      accounts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('accounts')
              .map((e) => HederaMirrorTypesAccountInfo.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'accounts': accounts.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

class HederaMirrorTypesCustomFeeLimit {
  final HederaMirrorTypesEntityId accountId;
  final BigInt? amount;
  final HederaMirrorTypesEntityId denominatingTokenId;

  const HederaMirrorTypesCustomFeeLimit({
    this.accountId,
    this.amount,
    this.denominatingTokenId,
  });

  factory HederaMirrorTypesCustomFeeLimit.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesCustomFeeLimit(
      accountId: json.valueAsString('account_id'),
      amount: json.valueAsBigInt('amount'),
      denominatingTokenId: json.valueAsString('denominating_token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'amount': amount,
    'denominating_token_id': denominatingTokenId,
  };
}

class HederaMirrorTypesTransactionNftTransfersItem {
  final bool isApproval;
  final HederaMirrorTypesEntityId receiverAccountId;
  final HederaMirrorTypesEntityId senderAccountId;
  final BigInt serialNumber;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesTransactionNftTransfersItem({
    required this.isApproval,
    this.receiverAccountId,
    this.senderAccountId,
    required this.serialNumber,
    this.tokenId,
  });

  factory HederaMirrorTypesTransactionNftTransfersItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionNftTransfersItem(
      isApproval: json.valueAsBool('is_approval'),
      receiverAccountId: json.valueAsString('receiver_account_id'),
      senderAccountId: json.valueAsString('sender_account_id'),
      serialNumber: json.valueAsBigInt('serial_number'),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'is_approval': isApproval,
    'receiver_account_id': receiverAccountId,
    'sender_account_id': senderAccountId,
    'serial_number': serialNumber,
    'token_id': tokenId,
  };
}

/// A staking reward transfer
class HederaMirrorTypesStakingRewardTransfer {
  final HederaMirrorTypesEntityId account;

  /// The number of tinybars awarded
  final BigInt amount;

  const HederaMirrorTypesStakingRewardTransfer({
    this.account,
    required this.amount,
  });

  factory HederaMirrorTypesStakingRewardTransfer.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesStakingRewardTransfer(
      account: json.valueAsString('account'),
      amount: json.valueAsBigInt('amount'),
    );
  }

  Map<String, dynamic> toJson() => {'account': account, 'amount': amount};
}

class HederaMirrorTypesTransactionTokenTransfersItem {
  final HederaMirrorTypesEntityId tokenId;
  final HederaMirrorTypesEntityId account;
  final BigInt amount;
  final bool? isApproval;

  const HederaMirrorTypesTransactionTokenTransfersItem({
    this.tokenId,
    this.account,
    required this.amount,
    this.isApproval,
  });

  factory HederaMirrorTypesTransactionTokenTransfersItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionTokenTransfersItem(
      tokenId: json.valueAsString('token_id'),
      account: json.valueAsString('account'),
      amount: json.valueAsBigInt('amount'),
      isApproval: json.valueAsBool('is_approval'),
    );
  }

  Map<String, dynamic> toJson() => {
    'token_id': tokenId,
    'account': account,
    'amount': amount,
    'is_approval': isApproval,
  };
}

class HederaMirrorTypesTransactionTransfersItem {
  final HederaMirrorTypesEntityId account;
  final BigInt amount;
  final bool? isApproval;

  const HederaMirrorTypesTransactionTransfersItem({
    this.account,
    required this.amount,
    this.isApproval,
  });

  factory HederaMirrorTypesTransactionTransfersItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionTransfersItem(
      account: json.valueAsString('account'),
      amount: json.valueAsBigInt('amount'),
      isApproval: json.valueAsBool('is_approval'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'amount': amount,
    'is_approval': isApproval,
  };
}

class HederaMirrorTypesTransaction {
  final HederaMirrorTypesKey? batchKey;
  final String? bytes;
  final BigInt? chargedTxFee;
  final HederaMirrorTypesTimestamp? consensusTimestamp;
  final HederaMirrorTypesEntityId entityId;

  /// Whether the transaction used high-volume entity creation throttles and pricing per HIP-1313
  final bool? highVolume;

  /// The multiplier applied to the transaction fee when high-volume pricing was in effect per HIP-1313, scaled by 1000 (e.g. 1000 = 1x, 4000 = 4x). A value of 0 means high-volume pricing was not applied. Null for pre-HIP-1313 transactions.
  final BigInt? highVolumePricingMultiplier;
  final List<HederaMirrorTypesCustomFeeLimit>? maxCustomFees;
  final String? maxFee;
  final String? memoBase64;
  final HederaMirrorTypesTransactionTypes? name;
  final List<HederaMirrorTypesTransactionNftTransfersItem>? nftTransfers;
  final HederaMirrorTypesEntityId node;
  final int? nonce;
  final HederaMirrorTypesTimestampNullable parentConsensusTimestamp;
  final String? result;
  final bool? scheduled;
  final HederaMirrorTypesStakingRewardTransfers? stakingRewardTransfers;
  final List<HederaMirrorTypesTransactionTokenTransfersItem>? tokenTransfers;
  final String? transactionHash;
  final String? transactionId;
  final List<HederaMirrorTypesTransactionTransfersItem>? transfers;
  final String? validDurationSeconds;
  final HederaMirrorTypesTimestamp? validStartTimestamp;

  const HederaMirrorTypesTransaction({
    this.batchKey,
    this.bytes,
    this.chargedTxFee,
    this.consensusTimestamp,
    this.entityId,
    this.highVolume,
    this.highVolumePricingMultiplier,
    this.maxCustomFees,
    this.maxFee,
    this.memoBase64,
    this.name,
    this.nftTransfers,
    this.node,
    this.nonce,
    this.parentConsensusTimestamp,
    this.result,
    this.scheduled,
    this.stakingRewardTransfers,
    this.tokenTransfers,
    this.transactionHash,
    this.transactionId,
    this.transfers,
    this.validDurationSeconds,
    this.validStartTimestamp,
  });

  factory HederaMirrorTypesTransaction.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTransaction(
      batchKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'batch_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      bytes: json.valueAsString('bytes'),
      chargedTxFee: json.valueAsBigInt('charged_tx_fee'),
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      entityId: json.valueAsString('entity_id'),
      highVolume: json.valueAsBool('high_volume'),
      highVolumePricingMultiplier: json.valueAsBigInt(
        'high_volume_pricing_multiplier',
      ),
      maxCustomFees:
          json.hasValue('max_custom_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('max_custom_fees')
                  .map((e) => HederaMirrorTypesCustomFeeLimit.fromJson(e))
                  .toList()
              : null,
      maxFee: json.valueAsString('max_fee'),
      memoBase64: json.valueAsString('memo_base64'),
      name:
          json.hasValue('name')
              ? HederaMirrorTypesTransactionTypes.fromJson(json['name'])
              : null,
      nftTransfers:
          json.hasValue('nft_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionNftTransfersItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      node: json.valueAsString('node'),
      nonce: json.valueAsInt('nonce'),
      parentConsensusTimestamp: json.valueAsString(
        'parent_consensus_timestamp',
      ),
      result: json.valueAsString('result'),
      scheduled: json.valueAsBool('scheduled'),
      stakingRewardTransfers:
          json.hasValue('staking_reward_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'staking_reward_transfers',
                  )
                  .map(
                    (e) => HederaMirrorTypesStakingRewardTransfer.fromJson(e),
                  )
                  .toList()
              : null,
      tokenTransfers:
          json.hasValue('token_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('token_transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionTokenTransfersItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      transactionHash: json.valueAsString('transaction_hash'),
      transactionId: json.valueAsString('transaction_id'),
      transfers:
          json.hasValue('transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionTransfersItem.fromJson(e),
                  )
                  .toList()
              : null,
      validDurationSeconds: json.valueAsString('valid_duration_seconds'),
      validStartTimestamp: json.valueAsString('valid_start_timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_key': batchKey?.toJson(),
    'bytes': bytes,
    'charged_tx_fee': chargedTxFee,
    'consensus_timestamp': consensusTimestamp,
    'entity_id': entityId,
    'high_volume': highVolume,
    'high_volume_pricing_multiplier': highVolumePricingMultiplier,
    'max_custom_fees': maxCustomFees?.map((e) => e.toJson()).toList(),
    'max_fee': maxFee,
    'memo_base64': memoBase64,
    'name': name?.toJson(),
    'nft_transfers': nftTransfers?.map((e) => e.toJson()).toList(),
    'node': node,
    'nonce': nonce,
    'parent_consensus_timestamp': parentConsensusTimestamp,
    'result': result,
    'scheduled': scheduled,
    'staking_reward_transfers':
        stakingRewardTransfers?.map((e) => e.toJson()).toList(),
    'token_transfers': tokenTransfers?.map((e) => e.toJson()).toList(),
    'transaction_hash': transactionHash,
    'transaction_id': transactionId,
    'transfers': transfers?.map((e) => e.toJson()).toList(),
    'valid_duration_seconds': validDurationSeconds,
    'valid_start_timestamp': validStartTimestamp,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress} (response)
class HederaMirrorTypesAccountBalanceTransactions {
  final HederaMirrorTypesEntityId account;
  final HederaMirrorTypesAlias alias;
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesBalance? balance;
  final HederaMirrorTypesTimestampNullable createdTimestamp;

  /// Whether the account declines receiving a staking reward
  final bool declineReward;
  final HederaMirrorTypesEvmAddressNullable delegationAddress;
  final bool? deleted;
  final BigInt? ethereumNonce;
  final HederaMirrorTypesEvmAddressNullable evmAddress;
  final HederaMirrorTypesTimestampNullable expiryTimestamp;
  final HederaMirrorTypesKey? key;
  final int? maxAutomaticTokenAssociations;
  final String? memo;

  /// The pending reward in tinybars the account will receive in the next reward payout. Note the value is updated
  final BigInt? pendingReward;
  final bool? receiverSigRequired;
  final String? stakedAccountId;

  /// The id of the node to which this account is staking
  final BigInt? stakedNodeId;
  final String? stakePeriodStart;
  final HederaMirrorTypesTransactions transactions;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesAccountBalanceTransactions({
    this.account,
    this.alias,
    this.autoRenewPeriod,
    this.balance,
    this.createdTimestamp,
    required this.declineReward,
    this.delegationAddress,
    this.deleted,
    this.ethereumNonce,
    this.evmAddress,
    this.expiryTimestamp,
    this.key,
    this.maxAutomaticTokenAssociations,
    this.memo,
    this.pendingReward,
    this.receiverSigRequired,
    this.stakedAccountId,
    this.stakedNodeId,
    this.stakePeriodStart,
    required this.transactions,
    required this.links,
  });

  factory HederaMirrorTypesAccountBalanceTransactions.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesAccountBalanceTransactions(
      account: json.valueAsString('account'),
      alias: json.valueAsString('alias'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      balance: json.valueTo<HederaMirrorTypesBalance?, Map<String, dynamic>>(
        key: 'balance',
        parse: (v) => HederaMirrorTypesBalance.fromJson(v),
      ),
      createdTimestamp: json.valueAsString('created_timestamp'),
      declineReward: json.valueAsBool('decline_reward'),
      delegationAddress: json.valueAsString('delegation_address'),
      deleted: json.valueAsBool('deleted'),
      ethereumNonce: json.valueAsBigInt('ethereum_nonce'),
      evmAddress: json.valueAsString('evm_address'),
      expiryTimestamp: json.valueAsString('expiry_timestamp'),
      key: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      maxAutomaticTokenAssociations: json.valueAsInt(
        'max_automatic_token_associations',
      ),
      memo: json.valueAsString('memo'),
      pendingReward: json.valueAsBigInt('pending_reward'),
      receiverSigRequired: json.valueAsBool('receiver_sig_required'),
      stakedAccountId: json.valueAsString('staked_account_id'),
      stakedNodeId: json.valueAsBigInt('staked_node_id'),
      stakePeriodStart: json.valueAsString('stake_period_start'),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => HederaMirrorTypesTransaction.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'alias': alias,
    'auto_renew_period': autoRenewPeriod,
    'balance': balance?.toJson(),
    'created_timestamp': createdTimestamp,
    'decline_reward': declineReward,
    'delegation_address': delegationAddress,
    'deleted': deleted,
    'ethereum_nonce': ethereumNonce,
    'evm_address': evmAddress,
    'expiry_timestamp': expiryTimestamp,
    'key': key?.toJson(),
    'max_automatic_token_associations': maxAutomaticTokenAssociations,
    'memo': memo,
    'pending_reward': pendingReward,
    'receiver_sig_required': receiverSigRequired,
    'staked_account_id': stakedAccountId,
    'staked_node_id': stakedNodeId,
    'stake_period_start': stakePeriodStart,
    'transactions': transactions.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

/// A timestamp range an entity is valid for
class HederaMirrorTypesTimestampRangeNullable {
  final String? from;
  final String? to;

  const HederaMirrorTypesTimestampRangeNullable({this.from, this.to});

  factory HederaMirrorTypesTimestampRangeNullable.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTimestampRangeNullable(
      from: json.valueAsString('from'),
      to: json.valueAsString('to'),
    );
  }

  Map<String, dynamic> toJson() => {'from': from, 'to': to};
}

class HederaMirrorTypesHook {
  final HederaMirrorTypesKey? adminKey;

  /// The contract entity that contains the hook's executing bytecode
  final HederaMirrorTypesEntityId contractId;

  /// The consensus timestamp when the hook was created
  final HederaMirrorTypesTimestampNullable createdTimestamp;

  /// Whether the hook has been deleted
  final bool deleted;

  /// The extension point this hook implements
  final HederaMirrorTypesHookExtensionPoint extensionPoint;

  /// The unique identifier for the hook within the owner's scope
  final BigInt hookId;

  /// The entity that owns the hook
  final HederaMirrorTypesEntityId ownerId;
  final HederaMirrorTypesTimestampRangeNullable? timestampRange;

  /// The type of the hook implementation
  final HederaMirrorTypesHookType type;

  const HederaMirrorTypesHook({
    this.adminKey,
    this.contractId,
    this.createdTimestamp,
    required this.deleted,
    required this.extensionPoint,
    required this.hookId,
    this.ownerId,
    this.timestampRange,
    required this.type,
  });

  factory HederaMirrorTypesHook.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesHook(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      contractId: json.valueAsString('contract_id'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      deleted: json.valueAsBool('deleted'),
      extensionPoint: HederaMirrorTypesHookExtensionPoint.fromJson(
        json['extension_point'],
      ),
      hookId: json.valueAsBigInt('hook_id'),
      ownerId: json.valueAsString('owner_id'),
      timestampRange: json.valueTo<
        HederaMirrorTypesTimestampRangeNullable?,
        Map<String, dynamic>
      >(
        key: 'timestamp_range',
        parse: (v) => HederaMirrorTypesTimestampRangeNullable.fromJson(v),
      ),
      type: HederaMirrorTypesHookType.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'contract_id': contractId,
    'created_timestamp': createdTimestamp,
    'deleted': deleted,
    'extension_point': extensionPoint.toJson(),
    'hook_id': hookId,
    'owner_id': ownerId,
    'timestamp_range': timestampRange?.toJson(),
    'type': type.toJson(),
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/hooks (response)
class HederaMirrorTypesHooksResponse {
  final List<HederaMirrorTypesHook> hooks;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesHooksResponse({
    required this.hooks,
    required this.links,
  });

  factory HederaMirrorTypesHooksResponse.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesHooksResponse(
      hooks:
          json
              .valueEnsureAsList<Map<String, dynamic>>('hooks')
              .map((e) => HederaMirrorTypesHook.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'hooks': hooks.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

class HederaMirrorTypesHookStorage {
  final String key;
  final String? value;
  final HederaMirrorTypesTimestamp timestamp;

  const HederaMirrorTypesHookStorage({
    required this.key,
    this.value,
    required this.timestamp,
  });

  factory HederaMirrorTypesHookStorage.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesHookStorage(
      key: json.valueAsString('key'),
      value: json.valueAsString('value'),
      timestamp: json.valueAsString('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
    'timestamp': timestamp,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/hooks/{hookId}/storage (response)
class HederaMirrorTypesHooksStorageResponse {
  /// The unique identifier of the hook within the owner's scope
  final BigInt hookId;
  final HederaMirrorTypesLinks links;
  final String? ownerId;
  final List<HederaMirrorTypesHookStorage> storage;

  const HederaMirrorTypesHooksStorageResponse({
    required this.hookId,
    required this.links,
    this.ownerId,
    required this.storage,
  });

  factory HederaMirrorTypesHooksStorageResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesHooksStorageResponse(
      hookId: json.valueAsBigInt('hook_id'),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
      ownerId: json.valueAsString('owner_id'),
      storage:
          json
              .valueEnsureAsList<Map<String, dynamic>>('storage')
              .map((e) => HederaMirrorTypesHookStorage.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'hook_id': hookId,
    'links': links.toJson(),
    'owner_id': ownerId,
    'storage': storage.map((e) => e.toJson()).toList(),
  };
}

/// GET /api/v1/tokens/{tokenId}/nfts/{serialNumber} (response)
class HederaMirrorTypesNft {
  final HederaMirrorTypesEntityId accountId;
  final HederaMirrorTypesTimestampNullable createdTimestamp;
  final HederaMirrorTypesEntityId delegatingSpender;

  /// whether the nft or the token it belongs to has been deleted
  final bool? deleted;

  /// Arbitrary binary data associated with this NFT encoded in base64.
  final String? metadata;
  final HederaMirrorTypesTimestampNullable modifiedTimestamp;
  final BigInt? serialNumber;
  final HederaMirrorTypesEntityId spender;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesNft({
    this.accountId,
    this.createdTimestamp,
    this.delegatingSpender,
    this.deleted,
    this.metadata,
    this.modifiedTimestamp,
    this.serialNumber,
    this.spender,
    this.tokenId,
  });

  factory HederaMirrorTypesNft.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesNft(
      accountId: json.valueAsString('account_id'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      delegatingSpender: json.valueAsString('delegating_spender'),
      deleted: json.valueAsBool('deleted'),
      metadata: json.valueAsString('metadata'),
      modifiedTimestamp: json.valueAsString('modified_timestamp'),
      serialNumber: json.valueAsBigInt('serial_number'),
      spender: json.valueAsString('spender'),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'created_timestamp': createdTimestamp,
    'delegating_spender': delegatingSpender,
    'deleted': deleted,
    'metadata': metadata,
    'modified_timestamp': modifiedTimestamp,
    'serial_number': serialNumber,
    'spender': spender,
    'token_id': tokenId,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/nfts (response)
/// GET /api/v1/tokens/{tokenId}/nfts (response)
class HederaMirrorTypesNfts {
  final List<HederaMirrorTypesNft>? nfts;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesNfts({this.nfts, this.links});

  factory HederaMirrorTypesNfts.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesNfts(
      nfts:
          json.hasValue('nfts')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nfts')
                  .map((e) => HederaMirrorTypesNft.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'nfts': nfts?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesStakingReward {
  final HederaMirrorTypesEntityId accountId;

  /// The number of tinybars awarded
  final BigInt amount;
  final HederaMirrorTypesTimestamp timestamp;

  const HederaMirrorTypesStakingReward({
    this.accountId,
    required this.amount,
    required this.timestamp,
  });

  factory HederaMirrorTypesStakingReward.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesStakingReward(
      accountId: json.valueAsString('account_id'),
      amount: json.valueAsBigInt('amount'),
      timestamp: json.valueAsString('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'amount': amount,
    'timestamp': timestamp,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/rewards (response)
class HederaMirrorTypesStakingRewardsResponse {
  final List<HederaMirrorTypesStakingReward>? rewards;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesStakingRewardsResponse({this.rewards, this.links});

  factory HederaMirrorTypesStakingRewardsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesStakingRewardsResponse(
      rewards:
          json.hasValue('rewards')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('rewards')
                  .map((e) => HederaMirrorTypesStakingReward.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'rewards': rewards?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesTokenRelationship {
  /// Specifies if the relationship is implicitly/explicitly associated.
  final bool? automaticAssociation;

  /// For FUNGIBLE_COMMON, the balance that the account holds in the smallest denomination. For NON_FUNGIBLE_UNIQUE, the number of NFTs held by the account.
  final BigInt balance;
  final HederaMirrorTypesTimestampNullable createdTimestamp;
  final BigInt? decimals;

  /// The Freeze status of the account.
  final HederaMirrorTypesTokenRelationshipFreezeStatus? freezeStatus;

  /// The KYC status of the account.
  final HederaMirrorTypesTokenRelationshipKycStatus kycStatus;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesTokenRelationship({
    this.automaticAssociation,
    required this.balance,
    this.createdTimestamp,
    this.decimals,
    this.freezeStatus,
    required this.kycStatus,
    this.tokenId,
  });

  factory HederaMirrorTypesTokenRelationship.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenRelationship(
      automaticAssociation: json.valueAsBool('automatic_association'),
      balance: json.valueAsBigInt('balance'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      decimals: json.valueAsBigInt('decimals'),
      freezeStatus:
          json.hasValue('freeze_status')
              ? HederaMirrorTypesTokenRelationshipFreezeStatus.fromJson(
                json['freeze_status'],
              )
              : null,
      kycStatus: HederaMirrorTypesTokenRelationshipKycStatus.fromJson(
        json['kyc_status'],
      ),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'automatic_association': automaticAssociation,
    'balance': balance,
    'created_timestamp': createdTimestamp,
    'decimals': decimals,
    'freeze_status': freezeStatus?.toJson(),
    'kyc_status': kycStatus.toJson(),
    'token_id': tokenId,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/tokens (response)
class HederaMirrorTypesTokenRelationshipResponse {
  final List<HederaMirrorTypesTokenRelationship>? tokens;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTokenRelationshipResponse({this.tokens, this.links});

  factory HederaMirrorTypesTokenRelationshipResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenRelationshipResponse(
      tokens:
          json.hasValue('tokens')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('tokens')
                  .map((e) => HederaMirrorTypesTokenRelationship.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'tokens': tokens?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// A timestamp range an entity is valid for
class HederaMirrorTypesTimestampRange {
  final String? from;
  final String? to;

  const HederaMirrorTypesTimestampRange({this.from, this.to});

  factory HederaMirrorTypesTimestampRange.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTimestampRange(
      from: json.valueAsString('from'),
      to: json.valueAsString('to'),
    );
  }

  Map<String, dynamic> toJson() => {'from': from, 'to': to};
}

class HederaMirrorTypesTokenAirdrop {
  final BigInt amount;
  final HederaMirrorTypesEntityId receiverId;
  final HederaMirrorTypesEntityId senderId;
  final BigInt? serialNumber;
  final HederaMirrorTypesTimestampRange timestamp;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesTokenAirdrop({
    required this.amount,
    this.receiverId,
    this.senderId,
    this.serialNumber,
    required this.timestamp,
    this.tokenId,
  });

  factory HederaMirrorTypesTokenAirdrop.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTokenAirdrop(
      amount: json.valueAsBigInt('amount'),
      receiverId: json.valueAsString('receiver_id'),
      senderId: json.valueAsString('sender_id'),
      serialNumber: json.valueAsBigInt('serial_number'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'receiver_id': receiverId,
    'sender_id': senderId,
    'serial_number': serialNumber,
    'timestamp': timestamp.toJson(),
    'token_id': tokenId,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/outstanding (response)
/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/pending (response)
class HederaMirrorTypesTokenAirdropsResponse {
  final HederaMirrorTypesTokenAirdrops? airdrops;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTokenAirdropsResponse({this.airdrops, this.links});

  factory HederaMirrorTypesTokenAirdropsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenAirdropsResponse(
      airdrops:
          json.hasValue('airdrops')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('airdrops')
                  .map((e) => HederaMirrorTypesTokenAirdrop.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'airdrops': airdrops?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesCryptoAllowance {
  /// The amount remaining of the original amount granted in tinybars.
  final BigInt? amount;

  /// The granted amount of the spender's allowance in tinybars.
  final BigInt? amountGranted;
  final HederaMirrorTypesEntityId owner;
  final HederaMirrorTypesEntityId spender;
  final HederaMirrorTypesTimestampRange? timestamp;

  const HederaMirrorTypesCryptoAllowance({
    this.amount,
    this.amountGranted,
    this.owner,
    this.spender,
    this.timestamp,
  });

  factory HederaMirrorTypesCryptoAllowance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesCryptoAllowance(
      amount: json.valueAsBigInt('amount'),
      amountGranted: json.valueAsBigInt('amount_granted'),
      owner: json.valueAsString('owner'),
      spender: json.valueAsString('spender'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'amount_granted': amountGranted,
    'owner': owner,
    'spender': spender,
    'timestamp': timestamp?.toJson(),
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/crypto (response)
class HederaMirrorTypesCryptoAllowancesResponse {
  final HederaMirrorTypesCryptoAllowances? allowances;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesCryptoAllowancesResponse({
    this.allowances,
    this.links,
  });

  factory HederaMirrorTypesCryptoAllowancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesCryptoAllowancesResponse(
      allowances:
          json.hasValue('allowances')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('allowances')
                  .map((e) => HederaMirrorTypesCryptoAllowance.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'allowances': allowances?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesTokenAllowance {
  /// The amount remaining of the original amount granted.
  final BigInt? amount;

  /// The granted amount of the spender's allowance.
  final BigInt? amountGranted;
  final HederaMirrorTypesEntityId owner;
  final HederaMirrorTypesEntityId spender;
  final HederaMirrorTypesTimestampRange? timestamp;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesTokenAllowance({
    this.amount,
    this.amountGranted,
    this.owner,
    this.spender,
    this.timestamp,
    this.tokenId,
  });

  factory HederaMirrorTypesTokenAllowance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTokenAllowance(
      amount: json.valueAsBigInt('amount'),
      amountGranted: json.valueAsBigInt('amount_granted'),
      owner: json.valueAsString('owner'),
      spender: json.valueAsString('spender'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'amount_granted': amountGranted,
    'owner': owner,
    'spender': spender,
    'timestamp': timestamp?.toJson(),
    'token_id': tokenId,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/tokens (response)
class HederaMirrorTypesTokenAllowancesResponse {
  final HederaMirrorTypesTokenAllowances? allowances;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTokenAllowancesResponse({this.allowances, this.links});

  factory HederaMirrorTypesTokenAllowancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenAllowancesResponse(
      allowances:
          json.hasValue('allowances')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('allowances')
                  .map((e) => HederaMirrorTypesTokenAllowance.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'allowances': allowances?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesNftAllowance {
  /// A boolean value indicating if the spender has the allowance to spend all NFTs owned by the given owner
  final bool approvedForAll;
  final HederaMirrorTypesEntityId owner;
  final HederaMirrorTypesEntityId spender;
  final HederaMirrorTypesTimestampRange timestamp;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesNftAllowance({
    required this.approvedForAll,
    this.owner,
    this.spender,
    required this.timestamp,
    this.tokenId,
  });

  factory HederaMirrorTypesNftAllowance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesNftAllowance(
      approvedForAll: json.valueAsBool('approved_for_all'),
      owner: json.valueAsString('owner'),
      spender: json.valueAsString('spender'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'approved_for_all': approvedForAll,
    'owner': owner,
    'spender': spender,
    'timestamp': timestamp.toJson(),
    'token_id': tokenId,
  };
}

/// GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/nfts (response)
class HederaMirrorTypesNftAllowancesResponse {
  final HederaMirrorTypesNftAllowances? allowances;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesNftAllowancesResponse({this.allowances, this.links});

  factory HederaMirrorTypesNftAllowancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNftAllowancesResponse(
      allowances:
          json.hasValue('allowances')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('allowances')
                  .map((e) => HederaMirrorTypesNftAllowance.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'allowances': allowances?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesTokenBalance {
  final HederaMirrorTypesEntityId tokenId;
  final BigInt balance;

  const HederaMirrorTypesTokenBalance({this.tokenId, required this.balance});

  factory HederaMirrorTypesTokenBalance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTokenBalance(
      tokenId: json.valueAsString('token_id'),
      balance: json.valueAsBigInt('balance'),
    );
  }

  Map<String, dynamic> toJson() => {'token_id': tokenId, 'balance': balance};
}

class HederaMirrorTypesAccountBalance {
  final HederaMirrorTypesEntityId account;
  final BigInt balance;
  final List<HederaMirrorTypesTokenBalance> tokens;

  const HederaMirrorTypesAccountBalance({
    this.account,
    required this.balance,
    required this.tokens,
  });

  factory HederaMirrorTypesAccountBalance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesAccountBalance(
      account: json.valueAsString('account'),
      balance: json.valueAsBigInt('balance'),
      tokens:
          json
              .valueEnsureAsList<Map<String, dynamic>>('tokens')
              .map((e) => HederaMirrorTypesTokenBalance.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'balance': balance,
    'tokens': tokens.map((e) => e.toJson()).toList(),
  };
}

/// GET /api/v1/balances (response)
class HederaMirrorTypesBalancesResponse {
  final HederaMirrorTypesTimestampNullable timestamp;
  final List<HederaMirrorTypesAccountBalance>? balances;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesBalancesResponse({
    this.timestamp,
    this.balances,
    this.links,
  });

  factory HederaMirrorTypesBalancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesBalancesResponse(
      timestamp: json.valueAsString('timestamp'),
      balances:
          json.hasValue('balances')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('balances')
                  .map((e) => HederaMirrorTypesAccountBalance.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'balances': balances?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// GET /api/v1/blocks/{hashOrNumber} (response)
class HederaMirrorTypesBlock {
  final int? count;
  final BigInt? gasUsed;
  final String? hapiVersion;
  final String? hash;

  /// A hex encoded 256-byte array with 0x prefix
  final String? logsBloom;
  final String? name;
  final int? number;
  final String? previousHash;
  final int? size;
  final HederaMirrorTypesTimestampRange? timestamp;

  const HederaMirrorTypesBlock({
    this.count,
    this.gasUsed,
    this.hapiVersion,
    this.hash,
    this.logsBloom,
    this.name,
    this.number,
    this.previousHash,
    this.size,
    this.timestamp,
  });

  factory HederaMirrorTypesBlock.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesBlock(
      count: json.valueAsInt('count'),
      gasUsed: json.valueAsBigInt('gas_used'),
      hapiVersion: json.valueAsString('hapi_version'),
      hash: json.valueAsString('hash'),
      logsBloom: json.valueAsString('logs_bloom'),
      name: json.valueAsString('name'),
      number: json.valueAsInt('number'),
      previousHash: json.valueAsString('previous_hash'),
      size: json.valueAsInt('size'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'gas_used': gasUsed,
    'hapi_version': hapiVersion,
    'hash': hash,
    'logs_bloom': logsBloom,
    'name': name,
    'number': number,
    'previous_hash': previousHash,
    'size': size,
    'timestamp': timestamp?.toJson(),
  };
}

/// GET /api/v1/blocks (response)
class HederaMirrorTypesBlocksResponse {
  final HederaMirrorTypesBlocks? blocks;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesBlocksResponse({this.blocks, this.links});

  factory HederaMirrorTypesBlocksResponse.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesBlocksResponse(
      blocks:
          json.hasValue('blocks')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('blocks')
                  .map((e) => HederaMirrorTypesBlock.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'blocks': blocks?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// POST /api/v1/contracts/call (response)
class HederaMirrorTypesContractCallResponse {
  /// Result in hexadecimal from executed contract call.
  final String? result;

  const HederaMirrorTypesContractCallResponse({this.result});

  factory HederaMirrorTypesContractCallResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractCallResponse(
      result: json.valueAsString('result'),
    );
  }

  Map<String, dynamic> toJson() => {'result': result};
}

/// POST /api/v1/contracts/call (request)
class HederaMirrorTypesContractCallRequest {
  /// Hexadecimal block number or the string "latest", "pending", "earliest". Defaults to "latest".
  final String? block;

  /// Hexadecimal method signature and encoded parameters. Up to 131072 bytes as at most 262146 hexadecimal digits including optional leading 0x.
  final String? data;

  /// Whether gas estimation is called. Defaults to false.
  final bool? estimate;

  /// The 20-byte hexadecimal EVM address the transaction is sent from.
  final String? from;

  /// Gas provided for the transaction execution. Defaults to 15000000.
  final BigInt? gas;

  /// Gas price used for each paid gas.
  final BigInt? gasPrice;

  /// The 20-byte hexadecimal EVM address the transaction is directed to.
  final String to;

  /// Value sent with this transaction. Defaults to 0.
  final BigInt? value;

  const HederaMirrorTypesContractCallRequest({
    this.block,
    this.data,
    this.estimate,
    this.from,
    this.gas,
    this.gasPrice,
    required this.to,
    this.value,
  });

  factory HederaMirrorTypesContractCallRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractCallRequest(
      block: json.valueAsString('block'),
      data: json.valueAsString('data'),
      estimate: json.valueAsBool('estimate'),
      from: json.valueAsString('from'),
      gas: json.valueAsBigInt('gas'),
      gasPrice: json.valueAsBigInt('gasPrice'),
      to: json.valueAsString('to'),
      value: json.valueAsBigInt('value'),
    );
  }

  Map<String, dynamic> toJson() => {
    'block': block,
    'data': data,
    'estimate': estimate,
    'from': from,
    'gas': gas,
    'gasPrice': gasPrice,
    'to': to,
    'value': value,
  };
}

class HederaMirrorTypesContract {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesEntityId autoRenewAccount;
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesEntityId contractId;
  final HederaMirrorTypesTimestampNullable createdTimestamp;
  final bool? deleted;
  final HederaMirrorTypesEvmAddress? evmAddress;
  final HederaMirrorTypesTimestampNullable expirationTimestamp;
  final HederaMirrorTypesEntityId fileId;
  final int? maxAutomaticTokenAssociations;
  final String? memo;

  /// The nonce of the contract
  final BigInt? nonce;
  final HederaMirrorTypesEntityId obtainerId;
  final bool? permanentRemoval;
  final HederaMirrorTypesEntityId proxyAccountId;
  final HederaMirrorTypesTimestampRange? timestamp;

  const HederaMirrorTypesContract({
    this.adminKey,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.contractId,
    this.createdTimestamp,
    this.deleted,
    this.evmAddress,
    this.expirationTimestamp,
    this.fileId,
    this.maxAutomaticTokenAssociations,
    this.memo,
    this.nonce,
    this.obtainerId,
    this.permanentRemoval,
    this.proxyAccountId,
    this.timestamp,
  });

  factory HederaMirrorTypesContract.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesContract(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      autoRenewAccount: json.valueAsString('auto_renew_account'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      contractId: json.valueAsString('contract_id'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      deleted: json.valueAsBool('deleted'),
      evmAddress: json.valueAsString('evm_address'),
      expirationTimestamp: json.valueAsString('expiration_timestamp'),
      fileId: json.valueAsString('file_id'),
      maxAutomaticTokenAssociations: json.valueAsInt(
        'max_automatic_token_associations',
      ),
      memo: json.valueAsString('memo'),
      nonce: json.valueAsBigInt('nonce'),
      obtainerId: json.valueAsString('obtainer_id'),
      permanentRemoval: json.valueAsBool('permanent_removal'),
      proxyAccountId: json.valueAsString('proxy_account_id'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'auto_renew_account': autoRenewAccount,
    'auto_renew_period': autoRenewPeriod,
    'contract_id': contractId,
    'created_timestamp': createdTimestamp,
    'deleted': deleted,
    'evm_address': evmAddress,
    'expiration_timestamp': expirationTimestamp,
    'file_id': fileId,
    'max_automatic_token_associations': maxAutomaticTokenAssociations,
    'memo': memo,
    'nonce': nonce,
    'obtainer_id': obtainerId,
    'permanent_removal': permanentRemoval,
    'proxy_account_id': proxyAccountId,
    'timestamp': timestamp?.toJson(),
  };
}

/// GET /api/v1/contracts (response)
class HederaMirrorTypesContractsResponse {
  final HederaMirrorTypesContracts? contracts;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesContractsResponse({this.contracts, this.links});

  factory HederaMirrorTypesContractsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractsResponse(
      contracts:
          json.hasValue('contracts')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('contracts')
                  .map((e) => HederaMirrorTypesContract.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'contracts': contracts?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// GET /api/v1/contracts/{contractIdOrAddress} (response)
class HederaMirrorTypesContractResponse {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesEntityId autoRenewAccount;
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesEntityId contractId;
  final HederaMirrorTypesTimestampNullable createdTimestamp;
  final bool? deleted;
  final HederaMirrorTypesEvmAddress? evmAddress;
  final HederaMirrorTypesTimestampNullable expirationTimestamp;
  final HederaMirrorTypesEntityId fileId;
  final int? maxAutomaticTokenAssociations;
  final String? memo;

  /// The nonce of the contract
  final BigInt? nonce;
  final HederaMirrorTypesEntityId obtainerId;
  final bool? permanentRemoval;
  final HederaMirrorTypesEntityId proxyAccountId;
  final HederaMirrorTypesTimestampRange? timestamp;

  /// The contract bytecode in hex during deployment
  final String? bytecode;

  /// The contract bytecode in hex after deployment
  final String? runtimeBytecode;

  const HederaMirrorTypesContractResponse({
    this.adminKey,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.contractId,
    this.createdTimestamp,
    this.deleted,
    this.evmAddress,
    this.expirationTimestamp,
    this.fileId,
    this.maxAutomaticTokenAssociations,
    this.memo,
    this.nonce,
    this.obtainerId,
    this.permanentRemoval,
    this.proxyAccountId,
    this.timestamp,
    this.bytecode,
    this.runtimeBytecode,
  });

  factory HederaMirrorTypesContractResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractResponse(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      autoRenewAccount: json.valueAsString('auto_renew_account'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      contractId: json.valueAsString('contract_id'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      deleted: json.valueAsBool('deleted'),
      evmAddress: json.valueAsString('evm_address'),
      expirationTimestamp: json.valueAsString('expiration_timestamp'),
      fileId: json.valueAsString('file_id'),
      maxAutomaticTokenAssociations: json.valueAsInt(
        'max_automatic_token_associations',
      ),
      memo: json.valueAsString('memo'),
      nonce: json.valueAsBigInt('nonce'),
      obtainerId: json.valueAsString('obtainer_id'),
      permanentRemoval: json.valueAsBool('permanent_removal'),
      proxyAccountId: json.valueAsString('proxy_account_id'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
      bytecode: json.valueAsString('bytecode'),
      runtimeBytecode: json.valueAsString('runtime_bytecode'),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'auto_renew_account': autoRenewAccount,
    'auto_renew_period': autoRenewPeriod,
    'contract_id': contractId,
    'created_timestamp': createdTimestamp,
    'deleted': deleted,
    'evm_address': evmAddress,
    'expiration_timestamp': expirationTimestamp,
    'file_id': fileId,
    'max_automatic_token_associations': maxAutomaticTokenAssociations,
    'memo': memo,
    'nonce': nonce,
    'obtainer_id': obtainerId,
    'permanent_removal': permanentRemoval,
    'proxy_account_id': proxyAccountId,
    'timestamp': timestamp?.toJson(),
    'bytecode': bytecode,
    'runtime_bytecode': runtimeBytecode,
  };
}

class HederaMirrorTypesAccessList {
  /// The hex encoded address of the accessed contract
  final String? address;

  /// The list of accessed hex encoded storage keys
  final List<String>? storageKeys;

  const HederaMirrorTypesAccessList({this.address, this.storageKeys});

  factory HederaMirrorTypesAccessList.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesAccessList(
      address: json.valueAsString('address'),
      storageKeys: json.valueAsList<List<String>?>('storage_keys'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'storage_keys': storageKeys,
  };
}

class HederaMirrorTypesAuthorizationList {
  /// The hex encoded address to be delegated to
  final String? address;

  /// The hex encoded chain id
  final String? chainId;

  /// The nonce of the authorization
  final BigInt? nonce;

  /// The hex encoded signature r value
  final String? r;

  /// The hex encoded signature s value
  final String? s;

  /// The hex encoded parity of the y-coordinate of the signature point
  final String? yParity;

  const HederaMirrorTypesAuthorizationList({
    this.address,
    this.chainId,
    this.nonce,
    this.r,
    this.s,
    this.yParity,
  });

  factory HederaMirrorTypesAuthorizationList.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesAuthorizationList(
      address: json.valueAsString('address'),
      chainId: json.valueAsString('chain_id'),
      nonce: json.valueAsBigInt('nonce'),
      r: json.valueAsString('r'),
      s: json.valueAsString('s'),
      yParity: json.valueAsString('y_parity'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'chain_id': chainId,
    'nonce': nonce,
    'r': r,
    's': s,
    'y_parity': yParity,
  };
}

class HederaMirrorTypesContractResult {
  /// The access list of the wrapped ethereum transaction
  final List<HederaMirrorTypesAccessList>? accessList;

  /// The hex encoded evm address of contract
  final String? address;

  /// The authorization list of the wrapped EIP-7702 ethereum transaction
  final List<HederaMirrorTypesAuthorizationList>? authorizationList;

  /// The amount sent to the function. When `hbar=true` (default), the value is in tinybars. When `hbar=false`, the value is in weibars.
  final BigInt? amount;

  /// The total amount of gas used in the block
  final BigInt? blockGasUsed;

  /// The hex encoded block (record file chain) hash
  final String? blockHash;

  /// The block height calculated as the number of record files starting from zero since network start.
  final BigInt? blockNumber;
  final String? bloom;

  /// The hex encoded result returned by the function
  final String? callResult;

  /// The hex encoded chain_id of the wrapped ethereum transaction
  final String? chainId;
  final HederaMirrorTypesEntityId contractId;

  /// The list of smart contracts that were created by the function call.
  final List<HederaMirrorTypesEntityId?>? createdContractIds;

  /// The message when an error occurs during smart contract execution
  final String? errorMessage;

  /// The hex encoded initcode of a failed contract create transaction
  final String? failedInitcode;
  final HederaMirrorTypesEvmAddressNullable from;

  /// The hex encoded parameters passed to the function
  final String? functionParameters;

  /// The units of consumed gas by the EVM to execute contract
  final BigInt? gasConsumed;

  /// The maximum units of gas allowed for contract execution
  final BigInt? gasLimit;

  /// The hex encoded gas_price of the wrapped ethereum transaction. When `hbar=true` (default), the value is converted to tinybars. When `hbar=false`, the value is in weibars.
  final String? gasPrice;

  /// The units of gas used to execute contract
  final BigInt? gasUsed;

  /// A hex encoded 32 byte hash and it is only populated for Ethereum transaction case
  final String? hash;

  /// The hex encoded max_fee_per_gas of the wrapped ethereum transaction. When `hbar=true` (default), the value is converted to tinybars. When `hbar=false`, the value is in weibars.
  final String? maxFeePerGas;

  /// The hex encoded max_priority_fee_per_gas of the wrapped ethereum transaction. When `hbar=true` (default), the value is converted to tinybars. When `hbar=false`, the value is in weibars.
  final String? maxPriorityFeePerGas;

  /// The nonce of the wrapped ethereum transaction
  final BigInt? nonce;

  /// The hex encoded signature_r of the wrapped ethereum transaction
  final String? r;

  /// The result of the transaction
  final String? result;

  /// The hex encoded signature_s of the wrapped ethereum transaction
  final String? s;

  /// The status of the transaction, 0x1 for a SUCCESS transaction and 0x0 for all else
  final String? status;
  final HederaMirrorTypesTimestamp? timestamp;
  final HederaMirrorTypesEvmAddressNullable to;

  /// The position of the transaction in the block
  final BigInt? transactionIndex;

  /// The type of the wrapped ethereum transaction, 0 (Pre-Eip1559) or 2 (Post-Eip1559)
  final int? type;

  /// The recovery_id of the wrapped ethereum transaction
  final int? v;

  const HederaMirrorTypesContractResult({
    this.accessList,
    this.address,
    this.authorizationList,
    this.amount,
    this.blockGasUsed,
    this.blockHash,
    this.blockNumber,
    this.bloom,
    this.callResult,
    this.chainId,
    this.contractId,
    this.createdContractIds,
    this.errorMessage,
    this.failedInitcode,
    this.from,
    this.functionParameters,
    this.gasConsumed,
    this.gasLimit,
    this.gasPrice,
    this.gasUsed,
    this.hash,
    this.maxFeePerGas,
    this.maxPriorityFeePerGas,
    this.nonce,
    this.r,
    this.result,
    this.s,
    this.status,
    this.timestamp,
    this.to,
    this.transactionIndex,
    this.type,
    this.v,
  });

  factory HederaMirrorTypesContractResult.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesContractResult(
      accessList:
          json.hasValue('access_list')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('access_list')
                  .map((e) => HederaMirrorTypesAccessList.fromJson(e))
                  .toList()
              : null,
      address: json.valueAsString('address'),
      authorizationList:
          json.hasValue('authorization_list')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('authorization_list')
                  .map((e) => HederaMirrorTypesAuthorizationList.fromJson(e))
                  .toList()
              : null,
      amount: json.valueAsBigInt('amount'),
      blockGasUsed: json.valueAsBigInt('block_gas_used'),
      blockHash: json.valueAsString('block_hash'),
      blockNumber: json.valueAsBigInt('block_number'),
      bloom: json.valueAsString('bloom'),
      callResult: json.valueAsString('call_result'),
      chainId: json.valueAsString('chain_id'),
      contractId: json.valueAsString('contract_id'),
      createdContractIds:
          json.hasValue('created_contract_ids')
              ? json
                  .valueEnsureAsList<dynamic>('created_contract_ids')
                  .map(
                    (e) =>
                        e == null ? null : JsonParser.valueAsString<String>(e),
                  )
                  .toList()
              : null,
      errorMessage: json.valueAsString('error_message'),
      failedInitcode: json.valueAsString('failed_initcode'),
      from: json.valueAsString('from'),
      functionParameters: json.valueAsString('function_parameters'),
      gasConsumed: json.valueAsBigInt('gas_consumed'),
      gasLimit: json.valueAsBigInt('gas_limit'),
      gasPrice: json.valueAsString('gas_price'),
      gasUsed: json.valueAsBigInt('gas_used'),
      hash: json.valueAsString('hash'),
      maxFeePerGas: json.valueAsString('max_fee_per_gas'),
      maxPriorityFeePerGas: json.valueAsString('max_priority_fee_per_gas'),
      nonce: json.valueAsBigInt('nonce'),
      r: json.valueAsString('r'),
      result: json.valueAsString('result'),
      s: json.valueAsString('s'),
      status: json.valueAsString('status'),
      timestamp: json.valueAsString('timestamp'),
      to: json.valueAsString('to'),
      transactionIndex: json.valueAsBigInt('transaction_index'),
      type: json.valueAsInt('type'),
      v: json.valueAsInt('v'),
    );
  }

  Map<String, dynamic> toJson() => {
    'access_list': accessList?.map((e) => e.toJson()).toList(),
    'address': address,
    'authorization_list': authorizationList?.map((e) => e.toJson()).toList(),
    'amount': amount,
    'block_gas_used': blockGasUsed,
    'block_hash': blockHash,
    'block_number': blockNumber,
    'bloom': bloom,
    'call_result': callResult,
    'chain_id': chainId,
    'contract_id': contractId,
    'created_contract_ids': createdContractIds,
    'error_message': errorMessage,
    'failed_initcode': failedInitcode,
    'from': from,
    'function_parameters': functionParameters,
    'gas_consumed': gasConsumed,
    'gas_limit': gasLimit,
    'gas_price': gasPrice,
    'gas_used': gasUsed,
    'hash': hash,
    'max_fee_per_gas': maxFeePerGas,
    'max_priority_fee_per_gas': maxPriorityFeePerGas,
    'nonce': nonce,
    'r': r,
    'result': result,
    's': s,
    'status': status,
    'timestamp': timestamp,
    'to': to,
    'transaction_index': transactionIndex,
    'type': type,
    'v': v,
  };
}

/// GET /api/v1/contracts/{contractIdOrAddress}/results (response)
/// GET /api/v1/contracts/results (response)
class HederaMirrorTypesContractResultsResponse {
  final HederaMirrorTypesContractResults? results;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesContractResultsResponse({this.results, this.links});

  factory HederaMirrorTypesContractResultsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractResultsResponse(
      results:
          json.hasValue('results')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('results')
                  .map((e) => HederaMirrorTypesContractResult.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'results': results?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesContractState {
  final HederaMirrorTypesEvmAddress address;
  final HederaMirrorTypesEntityId contractId;
  final HederaMirrorTypesTimestamp timestamp;

  /// The hex encoded storage slot.
  final String slot;

  /// The hex encoded value to the slot. `0x` implies no value written.
  final String value;

  const HederaMirrorTypesContractState({
    required this.address,
    this.contractId,
    required this.timestamp,
    required this.slot,
    required this.value,
  });

  factory HederaMirrorTypesContractState.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesContractState(
      address: json.valueAsString('address'),
      contractId: json.valueAsString('contract_id'),
      timestamp: json.valueAsString('timestamp'),
      slot: json.valueAsString('slot'),
      value: json.valueAsString('value'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'contract_id': contractId,
    'timestamp': timestamp,
    'slot': slot,
    'value': value,
  };
}

/// GET /api/v1/contracts/{contractIdOrAddress}/state (response)
class HederaMirrorTypesContractStateResponse {
  final List<HederaMirrorTypesContractState>? state;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesContractStateResponse({this.state, this.links});

  factory HederaMirrorTypesContractStateResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractStateResponse(
      state:
          json.hasValue('state')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('state')
                  .map((e) => HederaMirrorTypesContractState.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'state': state?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesContractResultLog {
  /// The hex encoded EVM address of the contract
  final String? address;
  final String? bloom;
  final HederaMirrorTypesEntityId contractId;

  /// The hex encoded data of the contract log
  final String? data;

  /// The index of the contract log in the chain of logs for an execution
  final int? index;
  final HederaMirrorTypesContractLogTopics? topics;

  const HederaMirrorTypesContractResultLog({
    this.address,
    this.bloom,
    this.contractId,
    this.data,
    this.index,
    this.topics,
  });

  factory HederaMirrorTypesContractResultLog.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractResultLog(
      address: json.valueAsString('address'),
      bloom: json.valueAsString('bloom'),
      contractId: json.valueAsString('contract_id'),
      data: json.valueAsString('data'),
      index: json.valueAsInt('index'),
      topics: json.valueAsList<List<String>?>('topics'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'bloom': bloom,
    'contract_id': contractId,
    'data': data,
    'index': index,
    'topics': topics,
  };
}

class HederaMirrorTypesContractResultStateChange {
  final HederaMirrorTypesEvmAddress? address;
  final HederaMirrorTypesEntityId contractId;

  /// The hex encoded storage slot changed.
  final String? slot;

  /// The hex encoded value read from the storage slot.
  final String? valueRead;

  /// The hex encoded value written to the slot. `null` implies no value written.
  final String? valueWritten;

  const HederaMirrorTypesContractResultStateChange({
    this.address,
    this.contractId,
    this.slot,
    this.valueRead,
    this.valueWritten,
  });

  factory HederaMirrorTypesContractResultStateChange.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractResultStateChange(
      address: json.valueAsString('address'),
      contractId: json.valueAsString('contract_id'),
      slot: json.valueAsString('slot'),
      valueRead: json.valueAsString('value_read'),
      valueWritten: json.valueAsString('value_written'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'contract_id': contractId,
    'slot': slot,
    'value_read': valueRead,
    'value_written': valueWritten,
  };
}

/// GET /api/v1/contracts/{contractIdOrAddress}/results/{timestamp} (response)
/// GET /api/v1/contracts/results/{transactionIdOrHash} (response)
class HederaMirrorTypesContractResultDetails {
  /// The access list of the wrapped ethereum transaction
  final List<HederaMirrorTypesAccessList>? accessList;

  /// The hex encoded evm address of contract
  final String? address;

  /// The authorization list of the wrapped EIP-7702 ethereum transaction
  final List<HederaMirrorTypesAuthorizationList>? authorizationList;

  /// The amount sent to the function. When `hbar=true` (default), the value is in tinybars. When `hbar=false`, the value is in weibars.
  final BigInt? amount;

  /// The total amount of gas used in the block
  final BigInt? blockGasUsed;

  /// The hex encoded block (record file chain) hash
  final String? blockHash;

  /// The block height calculated as the number of record files starting from zero since network start.
  final BigInt? blockNumber;
  final String? bloom;

  /// The hex encoded result returned by the function
  final String? callResult;

  /// The hex encoded chain_id of the wrapped ethereum transaction
  final String? chainId;
  final HederaMirrorTypesEntityId contractId;

  /// The list of smart contracts that were created by the function call.
  final List<HederaMirrorTypesEntityId?>? createdContractIds;

  /// The message when an error occurs during smart contract execution
  final String? errorMessage;

  /// The hex encoded initcode of a failed contract create transaction
  final String? failedInitcode;
  final HederaMirrorTypesEvmAddressNullable from;

  /// The hex encoded parameters passed to the function
  final String? functionParameters;

  /// The units of consumed gas by the EVM to execute contract
  final BigInt? gasConsumed;

  /// The maximum units of gas allowed for contract execution
  final BigInt? gasLimit;

  /// The hex encoded gas_price of the wrapped ethereum transaction
  final String? gasPrice;

  /// The units of gas used to execute contract
  final BigInt? gasUsed;

  /// The hex encoded transaction hash
  final String? hash;

  /// The hex encoded max_fee_per_gas of the wrapped ethereum transaction
  final String? maxFeePerGas;

  /// The hex encoded max_priority_fee_per_gas of the wrapped ethereum transaction
  final String? maxPriorityFeePerGas;

  /// The nonce of the wrapped ethereum transaction
  final BigInt? nonce;

  /// The hex encoded signature_r of the wrapped ethereum transaction
  final String? r;

  /// The result of the transaction
  final String? result;

  /// The hex encoded signature_s of the wrapped ethereum transaction
  final String? s;

  /// The status of the transaction, 0x1 for a SUCCESS transaction and 0x0 for all else
  final String? status;
  final HederaMirrorTypesTimestamp? timestamp;
  final HederaMirrorTypesEvmAddressNullable to;

  /// The position of the transaction in the block
  final BigInt? transactionIndex;

  /// The type of the wrapped ethereum transaction, 0 (Pre-Eip1559) or 2 (Post-Eip1559)
  final int? type;

  /// The recovery_id of the wrapped ethereum transaction
  final int? v;
  final HederaMirrorTypesContractResultLogs? logs;
  final HederaMirrorTypesContractResultStateChanges? stateChanges;

  const HederaMirrorTypesContractResultDetails({
    this.accessList,
    this.address,
    this.authorizationList,
    this.amount,
    this.blockGasUsed,
    this.blockHash,
    this.blockNumber,
    this.bloom,
    this.callResult,
    this.chainId,
    this.contractId,
    this.createdContractIds,
    this.errorMessage,
    this.failedInitcode,
    this.from,
    this.functionParameters,
    this.gasConsumed,
    this.gasLimit,
    this.gasPrice,
    this.gasUsed,
    this.hash,
    this.maxFeePerGas,
    this.maxPriorityFeePerGas,
    this.nonce,
    this.r,
    this.result,
    this.s,
    this.status,
    this.timestamp,
    this.to,
    this.transactionIndex,
    this.type,
    this.v,
    this.logs,
    this.stateChanges,
  });

  factory HederaMirrorTypesContractResultDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractResultDetails(
      accessList:
          json.hasValue('access_list')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('access_list')
                  .map((e) => HederaMirrorTypesAccessList.fromJson(e))
                  .toList()
              : null,
      address: json.valueAsString('address'),
      authorizationList:
          json.hasValue('authorization_list')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('authorization_list')
                  .map((e) => HederaMirrorTypesAuthorizationList.fromJson(e))
                  .toList()
              : null,
      amount: json.valueAsBigInt('amount'),
      blockGasUsed: json.valueAsBigInt('block_gas_used'),
      blockHash: json.valueAsString('block_hash'),
      blockNumber: json.valueAsBigInt('block_number'),
      bloom: json.valueAsString('bloom'),
      callResult: json.valueAsString('call_result'),
      chainId: json.valueAsString('chain_id'),
      contractId: json.valueAsString('contract_id'),
      createdContractIds:
          json.hasValue('created_contract_ids')
              ? json
                  .valueEnsureAsList<dynamic>('created_contract_ids')
                  .map(
                    (e) =>
                        e == null ? null : JsonParser.valueAsString<String>(e),
                  )
                  .toList()
              : null,
      errorMessage: json.valueAsString('error_message'),
      failedInitcode: json.valueAsString('failed_initcode'),
      from: json.valueAsString('from'),
      functionParameters: json.valueAsString('function_parameters'),
      gasConsumed: json.valueAsBigInt('gas_consumed'),
      gasLimit: json.valueAsBigInt('gas_limit'),
      gasPrice: json.valueAsString('gas_price'),
      gasUsed: json.valueAsBigInt('gas_used'),
      hash: json.valueAsString('hash'),
      maxFeePerGas: json.valueAsString('max_fee_per_gas'),
      maxPriorityFeePerGas: json.valueAsString('max_priority_fee_per_gas'),
      nonce: json.valueAsBigInt('nonce'),
      r: json.valueAsString('r'),
      result: json.valueAsString('result'),
      s: json.valueAsString('s'),
      status: json.valueAsString('status'),
      timestamp: json.valueAsString('timestamp'),
      to: json.valueAsString('to'),
      transactionIndex: json.valueAsBigInt('transaction_index'),
      type: json.valueAsInt('type'),
      v: json.valueAsInt('v'),
      logs:
          json.hasValue('logs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('logs')
                  .map((e) => HederaMirrorTypesContractResultLog.fromJson(e))
                  .toList()
              : null,
      stateChanges:
          json.hasValue('state_changes')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('state_changes')
                  .map(
                    (e) =>
                        HederaMirrorTypesContractResultStateChange.fromJson(e),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'access_list': accessList?.map((e) => e.toJson()).toList(),
    'address': address,
    'authorization_list': authorizationList?.map((e) => e.toJson()).toList(),
    'amount': amount,
    'block_gas_used': blockGasUsed,
    'block_hash': blockHash,
    'block_number': blockNumber,
    'bloom': bloom,
    'call_result': callResult,
    'chain_id': chainId,
    'contract_id': contractId,
    'created_contract_ids': createdContractIds,
    'error_message': errorMessage,
    'failed_initcode': failedInitcode,
    'from': from,
    'function_parameters': functionParameters,
    'gas_consumed': gasConsumed,
    'gas_limit': gasLimit,
    'gas_price': gasPrice,
    'gas_used': gasUsed,
    'hash': hash,
    'max_fee_per_gas': maxFeePerGas,
    'max_priority_fee_per_gas': maxPriorityFeePerGas,
    'nonce': nonce,
    'r': r,
    'result': result,
    's': s,
    'status': status,
    'timestamp': timestamp,
    'to': to,
    'transaction_index': transactionIndex,
    'type': type,
    'v': v,
    'logs': logs?.map((e) => e.toJson()).toList(),
    'state_changes': stateChanges?.map((e) => e.toJson()).toList(),
  };
}

class HederaMirrorTypesContractAction {
  /// The nesting depth of the call
  final int? callDepth;

  /// The type of the call operation
  final HederaMirrorTypesContractActionCallOperationType? callOperationType;

  /// The type of the call
  final HederaMirrorTypesContractActionCallType? callType;
  final HederaMirrorTypesEntityId caller;

  /// The entity type of the caller
  final HederaMirrorTypesContractActionCallerType? callerType;

  /// The EVM address of the caller
  final String? from;

  /// Gas cost in tinybars
  final BigInt? gas;

  /// Gas used in tinybars
  final BigInt? gasUsed;

  /// The position of the action within the ordered list of actions
  final int? index;

  /// The hex encoded input data
  final String? input;
  final HederaMirrorTypesEntityId recipient;

  /// The entity type of the recipient
  final HederaMirrorTypesContractActionCallerType? recipientType;

  /// The hex encoded result data
  final String? resultData;

  /// The type of the result data
  final HederaMirrorTypesContractActionResultDataType? resultDataType;
  final HederaMirrorTypesTimestamp? timestamp;
  final HederaMirrorTypesEvmAddressNullable to;

  /// The value of the transaction in tinybars
  final BigInt? value;

  const HederaMirrorTypesContractAction({
    this.callDepth,
    this.callOperationType,
    this.callType,
    this.caller,
    this.callerType,
    this.from,
    this.gas,
    this.gasUsed,
    this.index,
    this.input,
    this.recipient,
    this.recipientType,
    this.resultData,
    this.resultDataType,
    this.timestamp,
    this.to,
    this.value,
  });

  factory HederaMirrorTypesContractAction.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesContractAction(
      callDepth: json.valueAsInt('call_depth'),
      callOperationType:
          json.hasValue('call_operation_type')
              ? HederaMirrorTypesContractActionCallOperationType.fromJson(
                json['call_operation_type'],
              )
              : null,
      callType:
          json.hasValue('call_type')
              ? HederaMirrorTypesContractActionCallType.fromJson(
                json['call_type'],
              )
              : null,
      caller: json.valueAsString('caller'),
      callerType:
          json.hasValue('caller_type')
              ? HederaMirrorTypesContractActionCallerType.fromJson(
                json['caller_type'],
              )
              : null,
      from: json.valueAsString('from'),
      gas: json.valueAsBigInt('gas'),
      gasUsed: json.valueAsBigInt('gas_used'),
      index: json.valueAsInt('index'),
      input: json.valueAsString('input'),
      recipient: json.valueAsString('recipient'),
      recipientType:
          json.hasValue('recipient_type')
              ? HederaMirrorTypesContractActionCallerType.fromJson(
                json['recipient_type'],
              )
              : null,
      resultData: json.valueAsString('result_data'),
      resultDataType:
          json.hasValue('result_data_type')
              ? HederaMirrorTypesContractActionResultDataType.fromJson(
                json['result_data_type'],
              )
              : null,
      timestamp: json.valueAsString('timestamp'),
      to: json.valueAsString('to'),
      value: json.valueAsBigInt('value'),
    );
  }

  Map<String, dynamic> toJson() => {
    'call_depth': callDepth,
    'call_operation_type': callOperationType?.toJson(),
    'call_type': callType?.toJson(),
    'caller': caller,
    'caller_type': callerType?.toJson(),
    'from': from,
    'gas': gas,
    'gas_used': gasUsed,
    'index': index,
    'input': input,
    'recipient': recipient,
    'recipient_type': recipientType?.toJson(),
    'result_data': resultData,
    'result_data_type': resultDataType?.toJson(),
    'timestamp': timestamp,
    'to': to,
    'value': value,
  };
}

/// GET /api/v1/contracts/results/{transactionIdOrHash}/actions (response)
class HederaMirrorTypesContractActionsResponse {
  final HederaMirrorTypesContractActions? actions;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesContractActionsResponse({this.actions, this.links});

  factory HederaMirrorTypesContractActionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractActionsResponse(
      actions:
          json.hasValue('actions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actions')
                  .map((e) => HederaMirrorTypesContractAction.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'actions': actions?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// Represents a struct/opcode log entry in a trace
class HederaMirrorTypesOpcode {
  /// The current call depth
  final int depth;

  /// The remaining gas
  final BigInt gas;

  /// The cost for executing op
  final BigInt gasCost;

  /// The EVM memory with items in hex
  final List<String>? memory;

  /// The opcode to execute
  final String op;

  /// The program counter
  final int pc;

  /// The revert reason in hex
  final String? reason;

  /// The EVM stack with items in hex
  final List<String>? stack;

  /// The storage slots (keys and values in hex) of the current contract which is read from and written to
  final Map<String, String>? storage;

  const HederaMirrorTypesOpcode({
    required this.depth,
    required this.gas,
    required this.gasCost,
    this.memory,
    required this.op,
    required this.pc,
    this.reason,
    this.stack,
    this.storage,
  });

  factory HederaMirrorTypesOpcode.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesOpcode(
      depth: json.valueAsInt('depth'),
      gas: json.valueAsBigInt('gas'),
      gasCost: json.valueAsBigInt('gas_cost'),
      memory: json.valueAsList<List<String>?>('memory'),
      op: json.valueAsString('op'),
      pc: json.valueAsInt('pc'),
      reason: json.valueAsString('reason'),
      stack: json.valueAsList<List<String>?>('stack'),
      storage:
          json.hasValue('storage')
              ? json
                  .valueEnsureAsMap<String, dynamic>('storage')
                  .map(
                    (k, v) => MapEntry(k, JsonParser.valueAsString<String>(v)),
                  )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'depth': depth,
    'gas': gas,
    'gas_cost': gasCost,
    'memory': memory,
    'op': op,
    'pc': pc,
    'reason': reason,
    'stack': stack,
    'storage': storage,
  };
}

/// GET /api/v1/contracts/results/{transactionIdOrHash}/opcodes (response)
class HederaMirrorTypesOpcodesResponse {
  /// The address of the transaction recipient in hex.
  final String address;
  final HederaMirrorTypesEntityId contractId;

  /// Whether the transaction failed to be completely processed.
  final bool failed;

  /// The gas used in tinybars
  final BigInt gas;

  /// The logs produced by the opcode logger
  final List<HederaMirrorTypesOpcode> opcodes;

  /// The returned data from the transaction in hex
  final String returnValue;

  const HederaMirrorTypesOpcodesResponse({
    required this.address,
    this.contractId,
    required this.failed,
    required this.gas,
    required this.opcodes,
    required this.returnValue,
  });

  factory HederaMirrorTypesOpcodesResponse.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesOpcodesResponse(
      address: json.valueAsString('address'),
      contractId: json.valueAsString('contract_id'),
      failed: json.valueAsBool('failed'),
      gas: json.valueAsBigInt('gas'),
      opcodes:
          json
              .valueEnsureAsList<Map<String, dynamic>>('opcodes')
              .map((e) => HederaMirrorTypesOpcode.fromJson(e))
              .toList(),
      returnValue: json.valueAsString('return_value'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'contract_id': contractId,
    'failed': failed,
    'gas': gas,
    'opcodes': opcodes.map((e) => e.toJson()).toList(),
    'return_value': returnValue,
  };
}

class HederaMirrorTypesContractLog {
  /// The hex encoded EVM address of the contract
  final String? address;
  final String? bloom;
  final HederaMirrorTypesEntityId contractId;

  /// The hex encoded data of the contract log
  final String? data;

  /// The index of the contract log in the chain of logs for an execution
  final int? index;
  final HederaMirrorTypesContractLogTopics? topics;

  /// The hex encoded block (record file chain) hash
  final String? blockHash;

  /// The block height calculated as the number of record files starting from zero since network start.
  final BigInt? blockNumber;
  final String? rootContractId;
  final HederaMirrorTypesTimestamp? timestamp;

  /// A hex encoded transaction hash
  final String? transactionHash;

  /// The position of the transaction in the block
  final int? transactionIndex;

  const HederaMirrorTypesContractLog({
    this.address,
    this.bloom,
    this.contractId,
    this.data,
    this.index,
    this.topics,
    this.blockHash,
    this.blockNumber,
    this.rootContractId,
    this.timestamp,
    this.transactionHash,
    this.transactionIndex,
  });

  factory HederaMirrorTypesContractLog.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesContractLog(
      address: json.valueAsString('address'),
      bloom: json.valueAsString('bloom'),
      contractId: json.valueAsString('contract_id'),
      data: json.valueAsString('data'),
      index: json.valueAsInt('index'),
      topics: json.valueAsList<List<String>?>('topics'),
      blockHash: json.valueAsString('block_hash'),
      blockNumber: json.valueAsBigInt('block_number'),
      rootContractId: json.valueAsString('root_contract_id'),
      timestamp: json.valueAsString('timestamp'),
      transactionHash: json.valueAsString('transaction_hash'),
      transactionIndex: json.valueAsInt('transaction_index'),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'bloom': bloom,
    'contract_id': contractId,
    'data': data,
    'index': index,
    'topics': topics,
    'block_hash': blockHash,
    'block_number': blockNumber,
    'root_contract_id': rootContractId,
    'timestamp': timestamp,
    'transaction_hash': transactionHash,
    'transaction_index': transactionIndex,
  };
}

/// GET /api/v1/contracts/{contractIdOrAddress}/results/logs (response)
/// GET /api/v1/contracts/results/logs (response)
class HederaMirrorTypesContractLogsResponse {
  final HederaMirrorTypesContractLogs? logs;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesContractLogsResponse({this.logs, this.links});

  factory HederaMirrorTypesContractLogsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesContractLogsResponse(
      logs:
          json.hasValue('logs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('logs')
                  .map((e) => HederaMirrorTypesContractLog.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'logs': logs?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesExchangeRate {
  final int? centEquivalent;
  final BigInt? expirationTime;
  final int? hbarEquivalent;

  const HederaMirrorTypesExchangeRate({
    this.centEquivalent,
    this.expirationTime,
    this.hbarEquivalent,
  });

  factory HederaMirrorTypesExchangeRate.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesExchangeRate(
      centEquivalent: json.valueAsInt('cent_equivalent'),
      expirationTime: json.valueAsBigInt('expiration_time'),
      hbarEquivalent: json.valueAsInt('hbar_equivalent'),
    );
  }

  Map<String, dynamic> toJson() => {
    'cent_equivalent': centEquivalent,
    'expiration_time': expirationTime,
    'hbar_equivalent': hbarEquivalent,
  };
}

/// GET /api/v1/network/exchangerate (response)
class HederaMirrorTypesNetworkExchangeRateSetResponse {
  final HederaMirrorTypesExchangeRate? currentRate;
  final HederaMirrorTypesExchangeRate? nextRate;
  final HederaMirrorTypesTimestamp? timestamp;

  const HederaMirrorTypesNetworkExchangeRateSetResponse({
    this.currentRate,
    this.nextRate,
    this.timestamp,
  });

  factory HederaMirrorTypesNetworkExchangeRateSetResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkExchangeRateSetResponse(
      currentRate: json
          .valueTo<HederaMirrorTypesExchangeRate?, Map<String, dynamic>>(
            key: 'current_rate',
            parse: (v) => HederaMirrorTypesExchangeRate.fromJson(v),
          ),
      nextRate: json
          .valueTo<HederaMirrorTypesExchangeRate?, Map<String, dynamic>>(
            key: 'next_rate',
            parse: (v) => HederaMirrorTypesExchangeRate.fromJson(v),
          ),
      timestamp: json.valueAsString('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'current_rate': currentRate?.toJson(),
    'next_rate': nextRate?.toJson(),
    'timestamp': timestamp,
  };
}

class HederaMirrorTypesNetworkFee {
  /// gas cost in tinybars
  final BigInt? gas;

  /// type of the transaction
  final String? transactionType;

  const HederaMirrorTypesNetworkFee({this.gas, this.transactionType});

  factory HederaMirrorTypesNetworkFee.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesNetworkFee(
      gas: json.valueAsBigInt('gas'),
      transactionType: json.valueAsString('transaction_type'),
    );
  }

  Map<String, dynamic> toJson() => {
    'gas': gas,
    'transaction_type': transactionType,
  };
}

/// GET /api/v1/network/fees (response)
class HederaMirrorTypesNetworkFeesResponse {
  final HederaMirrorTypesNetworkFees? fees;
  final HederaMirrorTypesTimestamp? timestamp;

  const HederaMirrorTypesNetworkFeesResponse({this.fees, this.timestamp});

  factory HederaMirrorTypesNetworkFeesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkFeesResponse(
      fees:
          json.hasValue('fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('fees')
                  .map((e) => HederaMirrorTypesNetworkFee.fromJson(e))
                  .toList()
              : null,
      timestamp: json.valueAsString('timestamp'),
    );
  }

  Map<String, dynamic> toJson() => {
    'fees': fees?.map((e) => e.toJson()).toList(),
    'timestamp': timestamp,
  };
}

/// The network fee component which covers the cost of gossip, consensus, signature verifications, fee payment, and storage.
class HederaMirrorTypesFeeEstimateNetwork {
  /// Multiplied by the node fee to determine the total network fee.
  final int multiplier;

  /// The subtotal in tinycents for the network fee component which is calculated by multiplying the node subtotal by the network multiplier.
  final BigInt subtotal;

  const HederaMirrorTypesFeeEstimateNetwork({
    required this.multiplier,
    required this.subtotal,
  });

  factory HederaMirrorTypesFeeEstimateNetwork.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesFeeEstimateNetwork(
      multiplier: json.valueAsInt('multiplier'),
      subtotal: json.valueAsBigInt('subtotal'),
    );
  }

  Map<String, dynamic> toJson() => {
    'multiplier': multiplier,
    'subtotal': subtotal,
  };
}

/// The extra fee charged for the transaction.
class HederaMirrorTypesFeeExtra {
  /// The charged count of items as calculated by `max(0, count - included)`.
  final BigInt charged;

  /// The actual count of items received.
  final BigInt count;

  /// The fee price per unit in tinycents.
  final BigInt feePerUnit;

  /// The count of this "extra" that is included for free.
  final BigInt included;

  /// The unique name of this extra fee as defined in the fee schedule.
  final String name;

  /// The subtotal in tinycents for this extra fee. Calculated by multiplying the charged count by the fee_per_unit.
  final BigInt subtotal;

  const HederaMirrorTypesFeeExtra({
    required this.charged,
    required this.count,
    required this.feePerUnit,
    required this.included,
    required this.name,
    required this.subtotal,
  });

  factory HederaMirrorTypesFeeExtra.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesFeeExtra(
      charged: json.valueAsBigInt('charged'),
      count: json.valueAsBigInt('count'),
      feePerUnit: json.valueAsBigInt('fee_per_unit'),
      included: json.valueAsBigInt('included'),
      name: json.valueAsString('name'),
      subtotal: json.valueAsBigInt('subtotal'),
    );
  }

  Map<String, dynamic> toJson() => {
    'charged': charged,
    'count': count,
    'fee_per_unit': feePerUnit,
    'included': included,
    'name': name,
    'subtotal': subtotal,
  };
}

/// The node fee component which is to be paid to the node that submitted the transaction to the network. This fee exists to compensate the node for the work it performed to pre-check the transaction before submitting it, and incentivizes the node to accept new transactions from users.
class HederaMirrorTypesFeeEstimateResponseNode {
  /// The base fee price, in tinycents.
  final BigInt base_;

  /// The extra fees that apply for this fee component.
  final List<HederaMirrorTypesFeeExtra> extras;

  const HederaMirrorTypesFeeEstimateResponseNode({
    required this.base_,
    required this.extras,
  });

  factory HederaMirrorTypesFeeEstimateResponseNode.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesFeeEstimateResponseNode(
      base_: json.valueAsBigInt('base'),
      extras:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extras')
              .map((e) => HederaMirrorTypesFeeExtra.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'base': base_,
    'extras': extras.map((e) => e.toJson()).toList(),
  };
}

/// The response containing the estimated transaction fees.
///
/// POST /api/v1/network/fees (response)
class HederaMirrorTypesFeeEstimateResponse {
  /// The high-volume pricing multiplier per HIP-1313. A value of 1 indicates no high-volume pricing. A value greater than 1 applies when the transaction's highVolume flag is true and throttle utilization is non-zero.
  final BigInt highVolumeMultiplier;
  final HederaMirrorTypesFeeEstimateNetwork network;
  final HederaMirrorTypesFeeEstimateResponseNode node;
  final HederaMirrorTypesFeeEstimateResponseNode service;

  /// The sum of the network, node, and service subtotals in tinycents.
  final BigInt total;

  const HederaMirrorTypesFeeEstimateResponse({
    required this.highVolumeMultiplier,
    required this.network,
    required this.node,
    required this.service,
    required this.total,
  });

  factory HederaMirrorTypesFeeEstimateResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesFeeEstimateResponse(
      highVolumeMultiplier: json.valueAsBigInt('high_volume_multiplier'),
      network: json
          .valueTo<HederaMirrorTypesFeeEstimateNetwork, Map<String, dynamic>>(
            key: 'network',
            parse: (v) => HederaMirrorTypesFeeEstimateNetwork.fromJson(v),
          ),
      node: json.valueTo<
        HederaMirrorTypesFeeEstimateResponseNode,
        Map<String, dynamic>
      >(
        key: 'node',
        parse: (v) => HederaMirrorTypesFeeEstimateResponseNode.fromJson(v),
      ),
      service: json.valueTo<
        HederaMirrorTypesFeeEstimateResponseNode,
        Map<String, dynamic>
      >(
        key: 'service',
        parse: (v) => HederaMirrorTypesFeeEstimateResponseNode.fromJson(v),
      ),
      total: json.valueAsBigInt('total'),
    );
  }

  Map<String, dynamic> toJson() => {
    'high_volume_multiplier': highVolumeMultiplier,
    'network': network.toJson(),
    'node': node.toJson(),
    'service': service.toJson(),
    'total': total,
  };
}

class HederaMirrorTypesServiceEndpoint {
  final String domainName;
  final String ipAddressV4;
  final int port;

  const HederaMirrorTypesServiceEndpoint({
    required this.domainName,
    required this.ipAddressV4,
    required this.port,
  });

  factory HederaMirrorTypesServiceEndpoint.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesServiceEndpoint(
      domainName: json.valueAsString('domain_name'),
      ipAddressV4: json.valueAsString('ip_address_v4'),
      port: json.valueAsInt('port'),
    );
  }

  Map<String, dynamic> toJson() => {
    'domain_name': domainName,
    'ip_address_v4': ipAddressV4,
    'port': port,
  };
}

/// The timestamp range of the staking period
class HederaMirrorTypesNetworkNodeStakingPeriod {
  final String? from;
  final String? to;

  const HederaMirrorTypesNetworkNodeStakingPeriod({this.from, this.to});

  factory HederaMirrorTypesNetworkNodeStakingPeriod.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkNodeStakingPeriod(
      from: json.valueAsString('from'),
      to: json.valueAsString('to'),
    );
  }

  Map<String, dynamic> toJson() => {'from': from, 'to': to};
}

class HederaMirrorTypesNetworkNode {
  final HederaMirrorTypesKey? adminKey;
  final List<BigInt> associatedRegisteredNodes;

  /// Whether the node wants to receive staking rewards or not.
  final bool? declineReward;

  /// a memo associated with the address book
  final String? description;
  final HederaMirrorTypesEntityId fileId;
  final HederaMirrorTypesServiceEndpoint? grpcProxyEndpoint;

  /// The maximum stake (rewarded or not rewarded) this node can have as consensus weight
  final BigInt? maxStake;

  /// memo
  final String? memo;

  /// The minimum stake (rewarded or not rewarded) this node must reach before having non-zero consensus weight
  final BigInt? minStake;
  final HederaMirrorTypesEntityId nodeAccountId;

  /// An identifier for the node
  final BigInt nodeId;

  /// hex encoded hash of the node's TLS certificate
  final String? nodeCertHash;

  /// hex encoded X509 RSA public key used to verify stream file signature
  final String? publicKey;

  /// The total tinybars earned by this node per whole hbar in the last staking period
  final BigInt? rewardRateStart;
  final HederaMirrorTypesServiceEndpoints serviceEndpoints;

  /// The node consensus weight at the beginning of the staking period
  final BigInt? stake;

  /// The sum (balance + stakedToMe) for all accounts staked to this node with declineReward=true at the
  final BigInt? stakeNotRewarded;

  /// The sum (balance + staked) for all accounts staked to the node that are not declining rewards at the
  final BigInt? stakeRewarded;
  final HederaMirrorTypesNetworkNodeStakingPeriod? stakingPeriod;
  final HederaMirrorTypesTimestampRange timestamp;

  const HederaMirrorTypesNetworkNode({
    this.adminKey,
    required this.associatedRegisteredNodes,
    this.declineReward,
    this.description,
    this.fileId,
    this.grpcProxyEndpoint,
    this.maxStake,
    this.memo,
    this.minStake,
    this.nodeAccountId,
    required this.nodeId,
    this.nodeCertHash,
    this.publicKey,
    this.rewardRateStart,
    required this.serviceEndpoints,
    this.stake,
    this.stakeNotRewarded,
    this.stakeRewarded,
    this.stakingPeriod,
    required this.timestamp,
  });

  factory HederaMirrorTypesNetworkNode.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesNetworkNode(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      associatedRegisteredNodes: json.valueAsList<List<BigInt>>(
        'associated_registered_nodes',
      ),
      declineReward: json.valueAsBool('decline_reward'),
      description: json.valueAsString('description'),
      fileId: json.valueAsString('file_id'),
      grpcProxyEndpoint: json
          .valueTo<HederaMirrorTypesServiceEndpoint?, Map<String, dynamic>>(
            key: 'grpc_proxy_endpoint',
            parse: (v) => HederaMirrorTypesServiceEndpoint.fromJson(v),
          ),
      maxStake: json.valueAsBigInt('max_stake'),
      memo: json.valueAsString('memo'),
      minStake: json.valueAsBigInt('min_stake'),
      nodeAccountId: json.valueAsString('node_account_id'),
      nodeId: json.valueAsBigInt('node_id'),
      nodeCertHash: json.valueAsString('node_cert_hash'),
      publicKey: json.valueAsString('public_key'),
      rewardRateStart: json.valueAsBigInt('reward_rate_start'),
      serviceEndpoints:
          json
              .valueEnsureAsList<Map<String, dynamic>>('service_endpoints')
              .map((e) => HederaMirrorTypesServiceEndpoint.fromJson(e))
              .toList(),
      stake: json.valueAsBigInt('stake'),
      stakeNotRewarded: json.valueAsBigInt('stake_not_rewarded'),
      stakeRewarded: json.valueAsBigInt('stake_rewarded'),
      stakingPeriod: json.valueTo<
        HederaMirrorTypesNetworkNodeStakingPeriod?,
        Map<String, dynamic>
      >(
        key: 'staking_period',
        parse: (v) => HederaMirrorTypesNetworkNodeStakingPeriod.fromJson(v),
      ),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'associated_registered_nodes': associatedRegisteredNodes,
    'decline_reward': declineReward,
    'description': description,
    'file_id': fileId,
    'grpc_proxy_endpoint': grpcProxyEndpoint?.toJson(),
    'max_stake': maxStake,
    'memo': memo,
    'min_stake': minStake,
    'node_account_id': nodeAccountId,
    'node_id': nodeId,
    'node_cert_hash': nodeCertHash,
    'public_key': publicKey,
    'reward_rate_start': rewardRateStart,
    'service_endpoints': serviceEndpoints.map((e) => e.toJson()).toList(),
    'stake': stake,
    'stake_not_rewarded': stakeNotRewarded,
    'stake_rewarded': stakeRewarded,
    'staking_period': stakingPeriod?.toJson(),
    'timestamp': timestamp.toJson(),
  };
}

/// GET /api/v1/network/nodes (response)
class HederaMirrorTypesNetworkNodesResponse {
  final HederaMirrorTypesNetworkNodes nodes;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesNetworkNodesResponse({
    required this.nodes,
    required this.links,
  });

  factory HederaMirrorTypesNetworkNodesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkNodesResponse(
      nodes:
          json
              .valueEnsureAsList<Map<String, dynamic>>('nodes')
              .map((e) => HederaMirrorTypesNetworkNode.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'nodes': nodes.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

class HederaMirrorTypesRegisteredBlockNodeEndpoint {
  final List<HederaMirrorTypesRegisteredBlockNodeApi>? endpointApis;

  const HederaMirrorTypesRegisteredBlockNodeEndpoint({this.endpointApis});

  factory HederaMirrorTypesRegisteredBlockNodeEndpoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesRegisteredBlockNodeEndpoint(
      endpointApis:
          json.hasValue('endpoint_apis')
              ? json
                  .valueEnsureAsList<dynamic>('endpoint_apis')
                  .map(
                    (e) => HederaMirrorTypesRegisteredBlockNodeApi.fromJson(e),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'endpoint_apis': endpointApis?.map((e) => e.toJson()).toList(),
  };
}

class HederaMirrorTypesRegisteredGeneralServiceEndpoint {
  final String? description;

  const HederaMirrorTypesRegisteredGeneralServiceEndpoint({this.description});

  factory HederaMirrorTypesRegisteredGeneralServiceEndpoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesRegisteredGeneralServiceEndpoint(
      description: json.valueAsString('description'),
    );
  }

  Map<String, dynamic> toJson() => {'description': description};
}

class HederaMirrorTypesRegisteredMirrorNodeEndpoint {
  const HederaMirrorTypesRegisteredMirrorNodeEndpoint();

  factory HederaMirrorTypesRegisteredMirrorNodeEndpoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return const HederaMirrorTypesRegisteredMirrorNodeEndpoint();
  }

  Map<String, dynamic> toJson() => {};
}

class HederaMirrorTypesRegisteredRpcRelayEndpoint {
  const HederaMirrorTypesRegisteredRpcRelayEndpoint();

  factory HederaMirrorTypesRegisteredRpcRelayEndpoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return const HederaMirrorTypesRegisteredRpcRelayEndpoint();
  }

  Map<String, dynamic> toJson() => {};
}

class HederaMirrorTypesRegisteredServiceEndpoint {
  final HederaMirrorTypesRegisteredBlockNodeEndpoint blockNode;

  /// The DNS domain name of the service
  final String? domainName;
  final HederaMirrorTypesRegisteredGeneralServiceEndpoint generalService;

  /// The IP address of the service
  final String? ipAddress;
  final HederaMirrorTypesRegisteredMirrorNodeEndpoint mirrorNode;
  final int port;

  /// Whether the registered service endpoint requires TLS or not.
  final bool requiresTls;
  final HederaMirrorTypesRegisteredRpcRelayEndpoint rpcRelay;
  final HederaMirrorTypesRegisteredNodeType type;

  const HederaMirrorTypesRegisteredServiceEndpoint({
    required this.blockNode,
    this.domainName,
    required this.generalService,
    this.ipAddress,
    required this.mirrorNode,
    required this.port,
    required this.requiresTls,
    required this.rpcRelay,
    required this.type,
  });

  factory HederaMirrorTypesRegisteredServiceEndpoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesRegisteredServiceEndpoint(
      blockNode: json.valueTo<
        HederaMirrorTypesRegisteredBlockNodeEndpoint,
        Map<String, dynamic>
      >(
        key: 'block_node',
        parse: (v) => HederaMirrorTypesRegisteredBlockNodeEndpoint.fromJson(v),
      ),
      domainName: json.valueAsString('domain_name'),
      generalService: json.valueTo<
        HederaMirrorTypesRegisteredGeneralServiceEndpoint,
        Map<String, dynamic>
      >(
        key: 'general_service',
        parse:
            (v) =>
                HederaMirrorTypesRegisteredGeneralServiceEndpoint.fromJson(v),
      ),
      ipAddress: json.valueAsString('ip_address'),
      mirrorNode: json.valueTo<
        HederaMirrorTypesRegisteredMirrorNodeEndpoint,
        Map<String, dynamic>
      >(
        key: 'mirror_node',
        parse: (v) => HederaMirrorTypesRegisteredMirrorNodeEndpoint.fromJson(v),
      ),
      port: json.valueAsInt('port'),
      requiresTls: json.valueAsBool('requires_tls'),
      rpcRelay: json.valueTo<
        HederaMirrorTypesRegisteredRpcRelayEndpoint,
        Map<String, dynamic>
      >(
        key: 'rpc_relay',
        parse: (v) => HederaMirrorTypesRegisteredRpcRelayEndpoint.fromJson(v),
      ),
      type: HederaMirrorTypesRegisteredNodeType.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
    'block_node': blockNode.toJson(),
    'domain_name': domainName,
    'general_service': generalService.toJson(),
    'ip_address': ipAddress,
    'mirror_node': mirrorNode.toJson(),
    'port': port,
    'requires_tls': requiresTls,
    'rpc_relay': rpcRelay.toJson(),
    'type': type.toJson(),
  };
}

class HederaMirrorTypesRegisteredNode {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesTimestampNullable createdTimestamp;

  /// A short description of the node
  final String? description;

  /// An identifier for the registered node
  final BigInt registeredNodeId;
  final HederaMirrorTypesRegisteredServiceEndpoints serviceEndpoints;
  final HederaMirrorTypesTimestampRange timestamp;

  const HederaMirrorTypesRegisteredNode({
    this.adminKey,
    this.createdTimestamp,
    this.description,
    required this.registeredNodeId,
    required this.serviceEndpoints,
    required this.timestamp,
  });

  factory HederaMirrorTypesRegisteredNode.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesRegisteredNode(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      createdTimestamp: json.valueAsString('created_timestamp'),
      description: json.valueAsString('description'),
      registeredNodeId: json.valueAsBigInt('registered_node_id'),
      serviceEndpoints:
          json
              .valueEnsureAsList<Map<String, dynamic>>('service_endpoints')
              .map(
                (e) => HederaMirrorTypesRegisteredServiceEndpoint.fromJson(e),
              )
              .toList(),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'created_timestamp': createdTimestamp,
    'description': description,
    'registered_node_id': registeredNodeId,
    'service_endpoints': serviceEndpoints.map((e) => e.toJson()).toList(),
    'timestamp': timestamp.toJson(),
  };
}

/// GET /api/v1/network/registered-nodes (response)
class HederaMirrorTypesRegisteredNodesResponse {
  final HederaMirrorTypesRegisteredNodes registeredNodes;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesRegisteredNodesResponse({
    required this.registeredNodes,
    required this.links,
  });

  factory HederaMirrorTypesRegisteredNodesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesRegisteredNodesResponse(
      registeredNodes:
          json
              .valueEnsureAsList<Map<String, dynamic>>('registered_nodes')
              .map((e) => HederaMirrorTypesRegisteredNode.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'registered_nodes': registeredNodes.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

/// The timestamp range of the staking period
class HederaMirrorTypesNetworkStakeResponseStakingPeriod {
  final String? from;
  final String? to;

  const HederaMirrorTypesNetworkStakeResponseStakingPeriod({
    this.from,
    this.to,
  });

  factory HederaMirrorTypesNetworkStakeResponseStakingPeriod.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkStakeResponseStakingPeriod(
      from: json.valueAsString('from'),
      to: json.valueAsString('to'),
    );
  }

  Map<String, dynamic> toJson() => {'from': from, 'to': to};
}

/// GET /api/v1/network/stake (response)
class HederaMirrorTypesNetworkStakeResponse {
  /// The maximum amount of tinybar that can be staked for reward while still achieving
  final BigInt maxStakeRewarded;

  /// The maximum reward rate, in tinybars per whole hbar, that any account can receive in a day
  final BigInt maxStakingRewardRatePerHbar;

  /// The total tinybars to be paid as staking rewards in the ending period,
  final BigInt maxTotalReward;

  /// The fraction between zero and one of the network and service fees paid to the node reward account 0.0.801
  final double nodeRewardFeeFraction;

  /// The amount of the staking reward funds of account 0.0.800 reserved to pay pending
  final BigInt reservedStakingRewards;

  /// The unreserved tinybar balance of account 0.0.800 required to achieve the
  final BigInt rewardBalanceThreshold;

  /// The total amount staked to the network in tinybars the start of the current staking period
  final BigInt stakeTotal;
  final HederaMirrorTypesNetworkStakeResponseStakingPeriod stakingPeriod;

  /// The number of minutes in a staking period
  final BigInt stakingPeriodDuration;

  /// The number of staking periods for which the reward is stored for each node
  final BigInt stakingPeriodsStored;

  /// The fraction between zero and one of the network and service fees paid to the staking reward account 0.0.800
  final double stakingRewardFeeFraction;

  /// The total number of tinybars to be distributed as staking rewards each period
  final BigInt stakingRewardRate;

  /// The minimum balance of staking reward account 0.0.800 required to active rewards
  final BigInt stakingStartThreshold;

  /// The unreserved balance of account 0.0.800 at the close of the just-ending period;
  final BigInt unreservedStakingRewardBalance;

  const HederaMirrorTypesNetworkStakeResponse({
    required this.maxStakeRewarded,
    required this.maxStakingRewardRatePerHbar,
    required this.maxTotalReward,
    required this.nodeRewardFeeFraction,
    required this.reservedStakingRewards,
    required this.rewardBalanceThreshold,
    required this.stakeTotal,
    required this.stakingPeriod,
    required this.stakingPeriodDuration,
    required this.stakingPeriodsStored,
    required this.stakingRewardFeeFraction,
    required this.stakingRewardRate,
    required this.stakingStartThreshold,
    required this.unreservedStakingRewardBalance,
  });

  factory HederaMirrorTypesNetworkStakeResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkStakeResponse(
      maxStakeRewarded: json.valueAsBigInt('max_stake_rewarded'),
      maxStakingRewardRatePerHbar: json.valueAsBigInt(
        'max_staking_reward_rate_per_hbar',
      ),
      maxTotalReward: json.valueAsBigInt('max_total_reward'),
      nodeRewardFeeFraction: json.valueAsDouble('node_reward_fee_fraction'),
      reservedStakingRewards: json.valueAsBigInt('reserved_staking_rewards'),
      rewardBalanceThreshold: json.valueAsBigInt('reward_balance_threshold'),
      stakeTotal: json.valueAsBigInt('stake_total'),
      stakingPeriod: json.valueTo<
        HederaMirrorTypesNetworkStakeResponseStakingPeriod,
        Map<String, dynamic>
      >(
        key: 'staking_period',
        parse:
            (v) =>
                HederaMirrorTypesNetworkStakeResponseStakingPeriod.fromJson(v),
      ),
      stakingPeriodDuration: json.valueAsBigInt('staking_period_duration'),
      stakingPeriodsStored: json.valueAsBigInt('staking_periods_stored'),
      stakingRewardFeeFraction: json.valueAsDouble(
        'staking_reward_fee_fraction',
      ),
      stakingRewardRate: json.valueAsBigInt('staking_reward_rate'),
      stakingStartThreshold: json.valueAsBigInt('staking_start_threshold'),
      unreservedStakingRewardBalance: json.valueAsBigInt(
        'unreserved_staking_reward_balance',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'max_stake_rewarded': maxStakeRewarded,
    'max_staking_reward_rate_per_hbar': maxStakingRewardRatePerHbar,
    'max_total_reward': maxTotalReward,
    'node_reward_fee_fraction': nodeRewardFeeFraction,
    'reserved_staking_rewards': reservedStakingRewards,
    'reward_balance_threshold': rewardBalanceThreshold,
    'stake_total': stakeTotal,
    'staking_period': stakingPeriod.toJson(),
    'staking_period_duration': stakingPeriodDuration,
    'staking_periods_stored': stakingPeriodsStored,
    'staking_reward_fee_fraction': stakingRewardFeeFraction,
    'staking_reward_rate': stakingRewardRate,
    'staking_start_threshold': stakingStartThreshold,
    'unreserved_staking_reward_balance': unreservedStakingRewardBalance,
  };
}

/// GET /api/v1/network/supply (response)
class HederaMirrorTypesNetworkSupplyResponse {
  /// The network's released supply of hbars in tinybars
  final String? releasedSupply;
  final String? timestamp;

  /// The network's total supply of hbars in tinybars
  final String? totalSupply;

  const HederaMirrorTypesNetworkSupplyResponse({
    this.releasedSupply,
    this.timestamp,
    this.totalSupply,
  });

  factory HederaMirrorTypesNetworkSupplyResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNetworkSupplyResponse(
      releasedSupply: json.valueAsString('released_supply'),
      timestamp: json.valueAsString('timestamp'),
      totalSupply: json.valueAsString('total_supply'),
    );
  }

  Map<String, dynamic> toJson() => {
    'released_supply': releasedSupply,
    'timestamp': timestamp,
    'total_supply': totalSupply,
  };
}

class HederaMirrorTypesScheduleSignature {
  final HederaMirrorTypesTimestamp? consensusTimestamp;
  final String? publicKeyPrefix;
  final String? signature;
  final HederaMirrorTypesScheduleSignatureType? type;

  const HederaMirrorTypesScheduleSignature({
    this.consensusTimestamp,
    this.publicKeyPrefix,
    this.signature,
    this.type,
  });

  factory HederaMirrorTypesScheduleSignature.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesScheduleSignature(
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      publicKeyPrefix: json.valueAsString('public_key_prefix'),
      signature: json.valueAsString('signature'),
      type:
          json.hasValue('type')
              ? HederaMirrorTypesScheduleSignatureType.fromJson(json['type'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'consensus_timestamp': consensusTimestamp,
    'public_key_prefix': publicKeyPrefix,
    'signature': signature,
    'type': type?.toJson(),
  };
}

/// GET /api/v1/schedules/{scheduleId} (response)
class HederaMirrorTypesSchedule {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesTimestamp? consensusTimestamp;
  final HederaMirrorTypesEntityId creatorAccountId;
  final bool? deleted;
  final HederaMirrorTypesTimestampNullable executedTimestamp;
  final HederaMirrorTypesTimestampNullable expirationTime;
  final String? memo;
  final HederaMirrorTypesEntityId payerAccountId;
  final HederaMirrorTypesEntityId scheduleId;
  final List<HederaMirrorTypesScheduleSignature>? signatures;
  final String? transactionBody;
  final bool? waitForExpiry;

  const HederaMirrorTypesSchedule({
    this.adminKey,
    this.consensusTimestamp,
    this.creatorAccountId,
    this.deleted,
    this.executedTimestamp,
    this.expirationTime,
    this.memo,
    this.payerAccountId,
    this.scheduleId,
    this.signatures,
    this.transactionBody,
    this.waitForExpiry,
  });

  factory HederaMirrorTypesSchedule.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesSchedule(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      creatorAccountId: json.valueAsString('creator_account_id'),
      deleted: json.valueAsBool('deleted'),
      executedTimestamp: json.valueAsString('executed_timestamp'),
      expirationTime: json.valueAsString('expiration_time'),
      memo: json.valueAsString('memo'),
      payerAccountId: json.valueAsString('payer_account_id'),
      scheduleId: json.valueAsString('schedule_id'),
      signatures:
          json.hasValue('signatures')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('signatures')
                  .map((e) => HederaMirrorTypesScheduleSignature.fromJson(e))
                  .toList()
              : null,
      transactionBody: json.valueAsString('transaction_body'),
      waitForExpiry: json.valueAsBool('wait_for_expiry'),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'consensus_timestamp': consensusTimestamp,
    'creator_account_id': creatorAccountId,
    'deleted': deleted,
    'executed_timestamp': executedTimestamp,
    'expiration_time': expirationTime,
    'memo': memo,
    'payer_account_id': payerAccountId,
    'schedule_id': scheduleId,
    'signatures': signatures?.map((e) => e.toJson()).toList(),
    'transaction_body': transactionBody,
    'wait_for_expiry': waitForExpiry,
  };
}

/// GET /api/v1/schedules (response)
class HederaMirrorTypesSchedulesResponse {
  final HederaMirrorTypesSchedules? schedules;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesSchedulesResponse({this.schedules, this.links});

  factory HederaMirrorTypesSchedulesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesSchedulesResponse(
      schedules:
          json.hasValue('schedules')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('schedules')
                  .map((e) => HederaMirrorTypesSchedule.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'schedules': schedules?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// GET /api/v1/transactions (response)
class HederaMirrorTypesTransactionsResponse {
  final HederaMirrorTypesTransactions? transactions;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTransactionsResponse({this.transactions, this.links});

  factory HederaMirrorTypesTransactionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionsResponse(
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions')
                  .map((e) => HederaMirrorTypesTransaction.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesAssessedCustomFee {
  final BigInt? amount;
  final HederaMirrorTypesEntityId collectorAccountId;
  final List<HederaMirrorTypesEntityId?>? effectivePayerAccountIds;
  final HederaMirrorTypesEntityId tokenId;

  const HederaMirrorTypesAssessedCustomFee({
    this.amount,
    this.collectorAccountId,
    this.effectivePayerAccountIds,
    this.tokenId,
  });

  factory HederaMirrorTypesAssessedCustomFee.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesAssessedCustomFee(
      amount: json.valueAsBigInt('amount'),
      collectorAccountId: json.valueAsString('collector_account_id'),
      effectivePayerAccountIds:
          json.hasValue('effective_payer_account_ids')
              ? json
                  .valueEnsureAsList<dynamic>('effective_payer_account_ids')
                  .map(
                    (e) =>
                        e == null ? null : JsonParser.valueAsString<String>(e),
                  )
                  .toList()
              : null,
      tokenId: json.valueAsString('token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'collector_account_id': collectorAccountId,
    'effective_payer_account_ids': effectivePayerAccountIds,
    'token_id': tokenId,
  };
}

class HederaMirrorTypesTransactionDetail {
  final HederaMirrorTypesKey? batchKey;
  final String? bytes;
  final BigInt? chargedTxFee;
  final HederaMirrorTypesTimestamp? consensusTimestamp;
  final HederaMirrorTypesEntityId entityId;

  /// Whether the transaction used high-volume entity creation throttles and pricing per HIP-1313
  final bool? highVolume;

  /// The multiplier applied to the transaction fee when high-volume pricing was in effect per HIP-1313, scaled by 1000 (e.g. 1000 = 1x, 4000 = 4x). A value of 0 means high-volume pricing was not applied. Null for pre-HIP-1313 transactions.
  final BigInt? highVolumePricingMultiplier;
  final List<HederaMirrorTypesCustomFeeLimit>? maxCustomFees;
  final String? maxFee;
  final String? memoBase64;
  final HederaMirrorTypesTransactionTypes? name;
  final List<HederaMirrorTypesTransactionNftTransfersItem>? nftTransfers;
  final HederaMirrorTypesEntityId node;
  final int? nonce;
  final HederaMirrorTypesTimestampNullable parentConsensusTimestamp;
  final String? result;
  final bool? scheduled;
  final HederaMirrorTypesStakingRewardTransfers? stakingRewardTransfers;
  final List<HederaMirrorTypesTransactionTokenTransfersItem>? tokenTransfers;
  final String? transactionHash;
  final String? transactionId;
  final List<HederaMirrorTypesTransactionTransfersItem>? transfers;
  final String? validDurationSeconds;
  final HederaMirrorTypesTimestamp? validStartTimestamp;
  final List<HederaMirrorTypesAssessedCustomFee>? assessedCustomFees;

  const HederaMirrorTypesTransactionDetail({
    this.batchKey,
    this.bytes,
    this.chargedTxFee,
    this.consensusTimestamp,
    this.entityId,
    this.highVolume,
    this.highVolumePricingMultiplier,
    this.maxCustomFees,
    this.maxFee,
    this.memoBase64,
    this.name,
    this.nftTransfers,
    this.node,
    this.nonce,
    this.parentConsensusTimestamp,
    this.result,
    this.scheduled,
    this.stakingRewardTransfers,
    this.tokenTransfers,
    this.transactionHash,
    this.transactionId,
    this.transfers,
    this.validDurationSeconds,
    this.validStartTimestamp,
    this.assessedCustomFees,
  });

  factory HederaMirrorTypesTransactionDetail.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionDetail(
      batchKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'batch_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      bytes: json.valueAsString('bytes'),
      chargedTxFee: json.valueAsBigInt('charged_tx_fee'),
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      entityId: json.valueAsString('entity_id'),
      highVolume: json.valueAsBool('high_volume'),
      highVolumePricingMultiplier: json.valueAsBigInt(
        'high_volume_pricing_multiplier',
      ),
      maxCustomFees:
          json.hasValue('max_custom_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('max_custom_fees')
                  .map((e) => HederaMirrorTypesCustomFeeLimit.fromJson(e))
                  .toList()
              : null,
      maxFee: json.valueAsString('max_fee'),
      memoBase64: json.valueAsString('memo_base64'),
      name:
          json.hasValue('name')
              ? HederaMirrorTypesTransactionTypes.fromJson(json['name'])
              : null,
      nftTransfers:
          json.hasValue('nft_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionNftTransfersItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      node: json.valueAsString('node'),
      nonce: json.valueAsInt('nonce'),
      parentConsensusTimestamp: json.valueAsString(
        'parent_consensus_timestamp',
      ),
      result: json.valueAsString('result'),
      scheduled: json.valueAsBool('scheduled'),
      stakingRewardTransfers:
          json.hasValue('staking_reward_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'staking_reward_transfers',
                  )
                  .map(
                    (e) => HederaMirrorTypesStakingRewardTransfer.fromJson(e),
                  )
                  .toList()
              : null,
      tokenTransfers:
          json.hasValue('token_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('token_transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionTokenTransfersItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      transactionHash: json.valueAsString('transaction_hash'),
      transactionId: json.valueAsString('transaction_id'),
      transfers:
          json.hasValue('transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transfers')
                  .map(
                    (e) =>
                        HederaMirrorTypesTransactionTransfersItem.fromJson(e),
                  )
                  .toList()
              : null,
      validDurationSeconds: json.valueAsString('valid_duration_seconds'),
      validStartTimestamp: json.valueAsString('valid_start_timestamp'),
      assessedCustomFees:
          json.hasValue('assessed_custom_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'assessed_custom_fees',
                  )
                  .map((e) => HederaMirrorTypesAssessedCustomFee.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_key': batchKey?.toJson(),
    'bytes': bytes,
    'charged_tx_fee': chargedTxFee,
    'consensus_timestamp': consensusTimestamp,
    'entity_id': entityId,
    'high_volume': highVolume,
    'high_volume_pricing_multiplier': highVolumePricingMultiplier,
    'max_custom_fees': maxCustomFees?.map((e) => e.toJson()).toList(),
    'max_fee': maxFee,
    'memo_base64': memoBase64,
    'name': name?.toJson(),
    'nft_transfers': nftTransfers?.map((e) => e.toJson()).toList(),
    'node': node,
    'nonce': nonce,
    'parent_consensus_timestamp': parentConsensusTimestamp,
    'result': result,
    'scheduled': scheduled,
    'staking_reward_transfers':
        stakingRewardTransfers?.map((e) => e.toJson()).toList(),
    'token_transfers': tokenTransfers?.map((e) => e.toJson()).toList(),
    'transaction_hash': transactionHash,
    'transaction_id': transactionId,
    'transfers': transfers?.map((e) => e.toJson()).toList(),
    'valid_duration_seconds': validDurationSeconds,
    'valid_start_timestamp': validStartTimestamp,
    'assessed_custom_fees': assessedCustomFees?.map((e) => e.toJson()).toList(),
  };
}

/// GET /api/v1/transactions/{transactionId} (response)
class HederaMirrorTypesTransactionByIdResponse {
  final HederaMirrorTypesTransactionDetails? transactions;

  const HederaMirrorTypesTransactionByIdResponse({this.transactions});

  factory HederaMirrorTypesTransactionByIdResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTransactionByIdResponse(
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions')
                  .map((e) => HederaMirrorTypesTransactionDetail.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions?.map((e) => e.toJson()).toList(),
  };
}

class HederaMirrorTypesFixedCustomFee {
  final BigInt? amount;
  final HederaMirrorTypesEntityId collectorAccountId;
  final HederaMirrorTypesEntityId denominatingTokenId;

  const HederaMirrorTypesFixedCustomFee({
    this.amount,
    this.collectorAccountId,
    this.denominatingTokenId,
  });

  factory HederaMirrorTypesFixedCustomFee.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesFixedCustomFee(
      amount: json.valueAsBigInt('amount'),
      collectorAccountId: json.valueAsString('collector_account_id'),
      denominatingTokenId: json.valueAsString('denominating_token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'collector_account_id': collectorAccountId,
    'denominating_token_id': denominatingTokenId,
  };
}

/// Custom fees assessed for each message submitted to the topic
class HederaMirrorTypesConsensusCustomFees {
  final HederaMirrorTypesTimestamp? createdTimestamp;
  final List<HederaMirrorTypesFixedCustomFee>? fixedFees;

  const HederaMirrorTypesConsensusCustomFees({
    this.createdTimestamp,
    this.fixedFees,
  });

  factory HederaMirrorTypesConsensusCustomFees.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesConsensusCustomFees(
      createdTimestamp: json.valueAsString('created_timestamp'),
      fixedFees:
          json.hasValue('fixed_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('fixed_fees')
                  .map((e) => HederaMirrorTypesFixedCustomFee.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_timestamp': createdTimestamp,
    'fixed_fees': fixedFees?.map((e) => e.toJson()).toList(),
  };
}

/// GET /api/v1/topics/{topicId} (response)
class HederaMirrorTypesTopic {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesEntityId autoRenewAccount;

  /// The amount of time to attempt to extend the topic's lifetime after expiration.
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesTimestampNullable createdTimestamp;
  final HederaMirrorTypesConsensusCustomFees customFees;

  /// Whether the topic is deleted or not.
  final bool? deleted;

  /// Keys permitted to submit messages to the topic without paying custom fees
  final List<HederaMirrorTypesKey?> feeExemptKeyList;
  final HederaMirrorTypesKey? feeScheduleKey;

  /// The memo associated with the topic.
  final String memo;
  final HederaMirrorTypesKey? submitKey;
  final HederaMirrorTypesTimestampRange timestamp;
  final HederaMirrorTypesEntityId topicId;

  const HederaMirrorTypesTopic({
    this.adminKey,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.createdTimestamp,
    required this.customFees,
    this.deleted,
    required this.feeExemptKeyList,
    this.feeScheduleKey,
    required this.memo,
    this.submitKey,
    required this.timestamp,
    this.topicId,
  });

  factory HederaMirrorTypesTopic.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTopic(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      autoRenewAccount: json.valueAsString('auto_renew_account'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      customFees: json
          .valueTo<HederaMirrorTypesConsensusCustomFees, Map<String, dynamic>>(
            key: 'custom_fees',
            parse: (v) => HederaMirrorTypesConsensusCustomFees.fromJson(v),
          ),
      deleted: json.valueAsBool('deleted'),
      feeExemptKeyList:
          json
              .valueEnsureAsList<dynamic>('fee_exempt_key_list')
              .map(
                (e) =>
                    e == null
                        ? null
                        : HederaMirrorTypesKey.fromJson(
                          e as Map<String, dynamic>,
                        ),
              )
              .toList(),
      feeScheduleKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'fee_schedule_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      memo: json.valueAsString('memo'),
      submitKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'submit_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
      topicId: json.valueAsString('topic_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'auto_renew_account': autoRenewAccount,
    'auto_renew_period': autoRenewPeriod,
    'created_timestamp': createdTimestamp,
    'custom_fees': customFees.toJson(),
    'deleted': deleted,
    'fee_exempt_key_list': feeExemptKeyList.map((e) => e?.toJson()).toList(),
    'fee_schedule_key': feeScheduleKey?.toJson(),
    'memo': memo,
    'submit_key': submitKey?.toJson(),
    'timestamp': timestamp.toJson(),
    'topic_id': topicId,
  };
}

class HederaMirrorTypesTransactionId {
  final HederaMirrorTypesEntityId accountId;
  final int? nonce;
  final bool? scheduled;
  final HederaMirrorTypesTimestamp? transactionValidStart;

  const HederaMirrorTypesTransactionId({
    this.accountId,
    this.nonce,
    this.scheduled,
    this.transactionValidStart,
  });

  factory HederaMirrorTypesTransactionId.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTransactionId(
      accountId: json.valueAsString('account_id'),
      nonce: json.valueAsInt('nonce'),
      scheduled: json.valueAsBool('scheduled'),
      transactionValidStart: json.valueAsString('transaction_valid_start'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'nonce': nonce,
    'scheduled': scheduled,
    'transaction_valid_start': transactionValidStart,
  };
}

class HederaMirrorTypesChunkInfo {
  final HederaMirrorTypesTransactionId? initialTransactionId;
  final int? number;
  final int? total;

  const HederaMirrorTypesChunkInfo({
    this.initialTransactionId,
    this.number,
    this.total,
  });

  factory HederaMirrorTypesChunkInfo.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesChunkInfo(
      initialTransactionId: json
          .valueTo<HederaMirrorTypesTransactionId?, Map<String, dynamic>>(
            key: 'initial_transaction_id',
            parse: (v) => HederaMirrorTypesTransactionId.fromJson(v),
          ),
      number: json.valueAsInt('number'),
      total: json.valueAsInt('total'),
    );
  }

  Map<String, dynamic> toJson() => {
    'initial_transaction_id': initialTransactionId?.toJson(),
    'number': number,
    'total': total,
  };
}

/// GET /api/v1/topics/{topicId}/messages/{sequenceNumber} (response)
/// GET /api/v1/topics/messages/{timestamp} (response)
class HederaMirrorTypesTopicMessage {
  final HederaMirrorTypesChunkInfo? chunkInfo;
  final HederaMirrorTypesTimestamp consensusTimestamp;
  final String message;
  final HederaMirrorTypesEntityId payerAccountId;
  final String runningHash;
  final int runningHashVersion;
  final BigInt sequenceNumber;
  final HederaMirrorTypesEntityId topicId;

  const HederaMirrorTypesTopicMessage({
    this.chunkInfo,
    required this.consensusTimestamp,
    required this.message,
    this.payerAccountId,
    required this.runningHash,
    required this.runningHashVersion,
    required this.sequenceNumber,
    this.topicId,
  });

  factory HederaMirrorTypesTopicMessage.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTopicMessage(
      chunkInfo: json
          .valueTo<HederaMirrorTypesChunkInfo?, Map<String, dynamic>>(
            key: 'chunk_info',
            parse: (v) => HederaMirrorTypesChunkInfo.fromJson(v),
          ),
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      message: json.valueAsString('message'),
      payerAccountId: json.valueAsString('payer_account_id'),
      runningHash: json.valueAsString('running_hash'),
      runningHashVersion: json.valueAsInt('running_hash_version'),
      sequenceNumber: json.valueAsBigInt('sequence_number'),
      topicId: json.valueAsString('topic_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'chunk_info': chunkInfo?.toJson(),
    'consensus_timestamp': consensusTimestamp,
    'message': message,
    'payer_account_id': payerAccountId,
    'running_hash': runningHash,
    'running_hash_version': runningHashVersion,
    'sequence_number': sequenceNumber,
    'topic_id': topicId,
  };
}

/// GET /api/v1/topics/{topicId}/messages (response)
class HederaMirrorTypesTopicMessagesResponse {
  final HederaMirrorTypesTopicMessages? messages;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTopicMessagesResponse({this.messages, this.links});

  factory HederaMirrorTypesTopicMessagesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTopicMessagesResponse(
      messages:
          json.hasValue('messages')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('messages')
                  .map((e) => HederaMirrorTypesTopicMessage.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'messages': messages?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesToken {
  final HederaMirrorTypesKey? adminKey;
  final BigInt decimals;

  /// Arbitrary binary data associated with this token class encoded in base64.
  final String? metadata;
  final String name;
  final String symbol;
  final HederaMirrorTypesEntityId tokenId;
  final String type;

  const HederaMirrorTypesToken({
    this.adminKey,
    required this.decimals,
    this.metadata,
    required this.name,
    required this.symbol,
    this.tokenId,
    required this.type,
  });

  factory HederaMirrorTypesToken.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesToken(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      decimals: json.valueAsBigInt('decimals'),
      metadata: json.valueAsString('metadata'),
      name: json.valueAsString('name'),
      symbol: json.valueAsString('symbol'),
      tokenId: json.valueAsString('token_id'),
      type: json.valueAsString('type'),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'decimals': decimals,
    'metadata': metadata,
    'name': name,
    'symbol': symbol,
    'token_id': tokenId,
    'type': type,
  };
}

/// GET /api/v1/tokens (response)
class HederaMirrorTypesTokensResponse {
  final HederaMirrorTypesTokens? tokens;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTokensResponse({this.tokens, this.links});

  factory HederaMirrorTypesTokensResponse.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTokensResponse(
      tokens:
          json.hasValue('tokens')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('tokens')
                  .map((e) => HederaMirrorTypesToken.fromJson(e))
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'tokens': tokens?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

/// The key which can change the metadata of a token and individual NFTs.
class HederaMirrorTypesTokenInfoMetadataKey {
  final HederaMirrorTypesKeyType? type;
  final String? key;

  const HederaMirrorTypesTokenInfoMetadataKey({this.type, this.key});

  factory HederaMirrorTypesTokenInfoMetadataKey.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenInfoMetadataKey(
      type:
          json.hasValue('_type')
              ? HederaMirrorTypesKeyType.fromJson(json['_type'])
              : null,
      key: json.valueAsString('key'),
    );
  }

  Map<String, dynamic> toJson() => {'_type': type?.toJson(), 'key': key};
}

class HederaMirrorTypesFixedFee {
  final bool? allCollectorsAreExempt;
  final BigInt? amount;
  final HederaMirrorTypesEntityId collectorAccountId;
  final HederaMirrorTypesEntityId denominatingTokenId;

  const HederaMirrorTypesFixedFee({
    this.allCollectorsAreExempt,
    this.amount,
    this.collectorAccountId,
    this.denominatingTokenId,
  });

  factory HederaMirrorTypesFixedFee.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesFixedFee(
      allCollectorsAreExempt: json.valueAsBool('all_collectors_are_exempt'),
      amount: json.valueAsBigInt('amount'),
      collectorAccountId: json.valueAsString('collector_account_id'),
      denominatingTokenId: json.valueAsString('denominating_token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'all_collectors_are_exempt': allCollectorsAreExempt,
    'amount': amount,
    'collector_account_id': collectorAccountId,
    'denominating_token_id': denominatingTokenId,
  };
}

class HederaMirrorTypesFractionalFeeAmount {
  final BigInt? numerator;
  final BigInt? denominator;

  const HederaMirrorTypesFractionalFeeAmount({
    this.numerator,
    this.denominator,
  });

  factory HederaMirrorTypesFractionalFeeAmount.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesFractionalFeeAmount(
      numerator: json.valueAsBigInt('numerator'),
      denominator: json.valueAsBigInt('denominator'),
    );
  }

  Map<String, dynamic> toJson() => {
    'numerator': numerator,
    'denominator': denominator,
  };
}

class HederaMirrorTypesFractionalFee {
  final bool? allCollectorsAreExempt;
  final HederaMirrorTypesFractionalFeeAmount? amount;
  final HederaMirrorTypesEntityId collectorAccountId;
  final HederaMirrorTypesEntityId denominatingTokenId;
  final BigInt? maximum;
  final BigInt? minimum;
  final bool? netOfTransfers;

  const HederaMirrorTypesFractionalFee({
    this.allCollectorsAreExempt,
    this.amount,
    this.collectorAccountId,
    this.denominatingTokenId,
    this.maximum,
    this.minimum,
    this.netOfTransfers,
  });

  factory HederaMirrorTypesFractionalFee.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesFractionalFee(
      allCollectorsAreExempt: json.valueAsBool('all_collectors_are_exempt'),
      amount: json
          .valueTo<HederaMirrorTypesFractionalFeeAmount?, Map<String, dynamic>>(
            key: 'amount',
            parse: (v) => HederaMirrorTypesFractionalFeeAmount.fromJson(v),
          ),
      collectorAccountId: json.valueAsString('collector_account_id'),
      denominatingTokenId: json.valueAsString('denominating_token_id'),
      maximum: json.valueAsBigInt('maximum'),
      minimum: json.valueAsBigInt('minimum'),
      netOfTransfers: json.valueAsBool('net_of_transfers'),
    );
  }

  Map<String, dynamic> toJson() => {
    'all_collectors_are_exempt': allCollectorsAreExempt,
    'amount': amount?.toJson(),
    'collector_account_id': collectorAccountId,
    'denominating_token_id': denominatingTokenId,
    'maximum': maximum,
    'minimum': minimum,
    'net_of_transfers': netOfTransfers,
  };
}

class HederaMirrorTypesRoyaltyFeeFallbackFee {
  final BigInt? amount;
  final HederaMirrorTypesEntityId denominatingTokenId;

  const HederaMirrorTypesRoyaltyFeeFallbackFee({
    this.amount,
    this.denominatingTokenId,
  });

  factory HederaMirrorTypesRoyaltyFeeFallbackFee.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesRoyaltyFeeFallbackFee(
      amount: json.valueAsBigInt('amount'),
      denominatingTokenId: json.valueAsString('denominating_token_id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'denominating_token_id': denominatingTokenId,
  };
}

class HederaMirrorTypesRoyaltyFee {
  final bool? allCollectorsAreExempt;
  final HederaMirrorTypesFractionalFeeAmount? amount;
  final HederaMirrorTypesEntityId collectorAccountId;
  final HederaMirrorTypesRoyaltyFeeFallbackFee? fallbackFee;

  const HederaMirrorTypesRoyaltyFee({
    this.allCollectorsAreExempt,
    this.amount,
    this.collectorAccountId,
    this.fallbackFee,
  });

  factory HederaMirrorTypesRoyaltyFee.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesRoyaltyFee(
      allCollectorsAreExempt: json.valueAsBool('all_collectors_are_exempt'),
      amount: json
          .valueTo<HederaMirrorTypesFractionalFeeAmount?, Map<String, dynamic>>(
            key: 'amount',
            parse: (v) => HederaMirrorTypesFractionalFeeAmount.fromJson(v),
          ),
      collectorAccountId: json.valueAsString('collector_account_id'),
      fallbackFee: json.valueTo<
        HederaMirrorTypesRoyaltyFeeFallbackFee?,
        Map<String, dynamic>
      >(
        key: 'fallback_fee',
        parse: (v) => HederaMirrorTypesRoyaltyFeeFallbackFee.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'all_collectors_are_exempt': allCollectorsAreExempt,
    'amount': amount?.toJson(),
    'collector_account_id': collectorAccountId,
    'fallback_fee': fallbackFee?.toJson(),
  };
}

class HederaMirrorTypesCustomFees {
  final HederaMirrorTypesTimestamp? createdTimestamp;
  final List<HederaMirrorTypesFixedFee>? fixedFees;
  final List<HederaMirrorTypesFractionalFee>? fractionalFees;
  final List<HederaMirrorTypesRoyaltyFee>? royaltyFees;

  const HederaMirrorTypesCustomFees({
    this.createdTimestamp,
    this.fixedFees,
    this.fractionalFees,
    this.royaltyFees,
  });

  factory HederaMirrorTypesCustomFees.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesCustomFees(
      createdTimestamp: json.valueAsString('created_timestamp'),
      fixedFees:
          json.hasValue('fixed_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('fixed_fees')
                  .map((e) => HederaMirrorTypesFixedFee.fromJson(e))
                  .toList()
              : null,
      fractionalFees:
          json.hasValue('fractional_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('fractional_fees')
                  .map((e) => HederaMirrorTypesFractionalFee.fromJson(e))
                  .toList()
              : null,
      royaltyFees:
          json.hasValue('royalty_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('royalty_fees')
                  .map((e) => HederaMirrorTypesRoyaltyFee.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'created_timestamp': createdTimestamp,
    'fixed_fees': fixedFees?.map((e) => e.toJson()).toList(),
    'fractional_fees': fractionalFees?.map((e) => e.toJson()).toList(),
    'royalty_fees': royaltyFees?.map((e) => e.toJson()).toList(),
  };
}

/// GET /api/v1/tokens/{tokenId} (response)
class HederaMirrorTypesTokenInfo {
  final HederaMirrorTypesKey? adminKey;
  final HederaMirrorTypesEntityId autoRenewAccount;
  final BigInt? autoRenewPeriod;
  final HederaMirrorTypesTimestamp? createdTimestamp;
  final String? decimals;
  final bool? deleted;

  /// The token's expiration time in nanoseconds since the Unix epoch. Note that this encoding differs from other entity expiry timestamps (e.g., accounts) which use a seconds.nanoseconds string format. This inconsistency is a known issue retained for backwards compatibility.
  final BigInt? expiryTimestamp;
  final HederaMirrorTypesKey? feeScheduleKey;
  final bool? freezeDefault;
  final HederaMirrorTypesKey? freezeKey;
  final String? initialSupply;
  final HederaMirrorTypesKey? kycKey;
  final String? maxSupply;

  /// Arbitrary binary data associated with this token class encoded in base64.
  final String? metadata;
  final HederaMirrorTypesTokenInfoMetadataKey? metadataKey;
  final HederaMirrorTypesTimestamp? modifiedTimestamp;
  final String? name;
  final String? memo;
  final HederaMirrorTypesKey? pauseKey;
  final HederaMirrorTypesTokenInfoPauseStatus? pauseStatus;
  final HederaMirrorTypesKey? supplyKey;
  final HederaMirrorTypesTokenInfoSupplyType? supplyType;
  final String? symbol;
  final HederaMirrorTypesEntityId tokenId;
  final String? totalSupply;
  final HederaMirrorTypesEntityId treasuryAccountId;
  final HederaMirrorTypesTokenInfoType? type;
  final HederaMirrorTypesKey? wipeKey;
  final HederaMirrorTypesCustomFees? customFees;

  const HederaMirrorTypesTokenInfo({
    this.adminKey,
    this.autoRenewAccount,
    this.autoRenewPeriod,
    this.createdTimestamp,
    this.decimals,
    this.deleted,
    this.expiryTimestamp,
    this.feeScheduleKey,
    this.freezeDefault,
    this.freezeKey,
    this.initialSupply,
    this.kycKey,
    this.maxSupply,
    this.metadata,
    this.metadataKey,
    this.modifiedTimestamp,
    this.name,
    this.memo,
    this.pauseKey,
    this.pauseStatus,
    this.supplyKey,
    this.supplyType,
    this.symbol,
    this.tokenId,
    this.totalSupply,
    this.treasuryAccountId,
    this.type,
    this.wipeKey,
    this.customFees,
  });

  factory HederaMirrorTypesTokenInfo.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesTokenInfo(
      adminKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'admin_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      autoRenewAccount: json.valueAsString('auto_renew_account'),
      autoRenewPeriod: json.valueAsBigInt('auto_renew_period'),
      createdTimestamp: json.valueAsString('created_timestamp'),
      decimals: json.valueAsString('decimals'),
      deleted: json.valueAsBool('deleted'),
      expiryTimestamp: json.valueAsBigInt('expiry_timestamp'),
      feeScheduleKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'fee_schedule_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      freezeDefault: json.valueAsBool('freeze_default'),
      freezeKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'freeze_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      initialSupply: json.valueAsString('initial_supply'),
      kycKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'kyc_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      maxSupply: json.valueAsString('max_supply'),
      metadata: json.valueAsString('metadata'),
      metadataKey: json.valueTo<
        HederaMirrorTypesTokenInfoMetadataKey?,
        Map<String, dynamic>
      >(
        key: 'metadata_key',
        parse: (v) => HederaMirrorTypesTokenInfoMetadataKey.fromJson(v),
      ),
      modifiedTimestamp: json.valueAsString('modified_timestamp'),
      name: json.valueAsString('name'),
      memo: json.valueAsString('memo'),
      pauseKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'pause_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      pauseStatus:
          json.hasValue('pause_status')
              ? HederaMirrorTypesTokenInfoPauseStatus.fromJson(
                json['pause_status'],
              )
              : null,
      supplyKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'supply_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      supplyType:
          json.hasValue('supply_type')
              ? HederaMirrorTypesTokenInfoSupplyType.fromJson(
                json['supply_type'],
              )
              : null,
      symbol: json.valueAsString('symbol'),
      tokenId: json.valueAsString('token_id'),
      totalSupply: json.valueAsString('total_supply'),
      treasuryAccountId: json.valueAsString('treasury_account_id'),
      type:
          json.hasValue('type')
              ? HederaMirrorTypesTokenInfoType.fromJson(json['type'])
              : null,
      wipeKey: json.valueTo<HederaMirrorTypesKey?, Map<String, dynamic>>(
        key: 'wipe_key',
        parse: (v) => HederaMirrorTypesKey.fromJson(v),
      ),
      customFees: json
          .valueTo<HederaMirrorTypesCustomFees?, Map<String, dynamic>>(
            key: 'custom_fees',
            parse: (v) => HederaMirrorTypesCustomFees.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'admin_key': adminKey?.toJson(),
    'auto_renew_account': autoRenewAccount,
    'auto_renew_period': autoRenewPeriod,
    'created_timestamp': createdTimestamp,
    'decimals': decimals,
    'deleted': deleted,
    'expiry_timestamp': expiryTimestamp,
    'fee_schedule_key': feeScheduleKey?.toJson(),
    'freeze_default': freezeDefault,
    'freeze_key': freezeKey?.toJson(),
    'initial_supply': initialSupply,
    'kyc_key': kycKey?.toJson(),
    'max_supply': maxSupply,
    'metadata': metadata,
    'metadata_key': metadataKey?.toJson(),
    'modified_timestamp': modifiedTimestamp,
    'name': name,
    'memo': memo,
    'pause_key': pauseKey?.toJson(),
    'pause_status': pauseStatus?.toJson(),
    'supply_key': supplyKey?.toJson(),
    'supply_type': supplyType?.toJson(),
    'symbol': symbol,
    'token_id': tokenId,
    'total_supply': totalSupply,
    'treasury_account_id': treasuryAccountId,
    'type': type?.toJson(),
    'wipe_key': wipeKey?.toJson(),
    'custom_fees': customFees?.toJson(),
  };
}

class HederaMirrorTypesTokenDistributionItem {
  final HederaMirrorTypesEntityId account;
  final BigInt balance;
  final BigInt? decimals;

  const HederaMirrorTypesTokenDistributionItem({
    this.account,
    required this.balance,
    this.decimals,
  });

  factory HederaMirrorTypesTokenDistributionItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenDistributionItem(
      account: json.valueAsString('account'),
      balance: json.valueAsBigInt('balance'),
      decimals: json.valueAsBigInt('decimals'),
    );
  }

  Map<String, dynamic> toJson() => {
    'account': account,
    'balance': balance,
    'decimals': decimals,
  };
}

/// GET /api/v1/tokens/{tokenId}/balances (response)
class HederaMirrorTypesTokenBalancesResponse {
  final HederaMirrorTypesTimestampNullable timestamp;
  final HederaMirrorTypesTokenDistribution? balances;
  final HederaMirrorTypesLinks? links;

  const HederaMirrorTypesTokenBalancesResponse({
    this.timestamp,
    this.balances,
    this.links,
  });

  factory HederaMirrorTypesTokenBalancesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesTokenBalancesResponse(
      timestamp: json.valueAsString('timestamp'),
      balances:
          json.hasValue('balances')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('balances')
                  .map(
                    (e) => HederaMirrorTypesTokenDistributionItem.fromJson(e),
                  )
                  .toList()
              : null,
      links: json.valueTo<HederaMirrorTypesLinks?, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'balances': balances?.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
  };
}

class HederaMirrorTypesNftTransactionTransfer {
  final HederaMirrorTypesTimestamp consensusTimestamp;
  final bool isApproval;
  final int nonce;
  final HederaMirrorTypesEntityId receiverAccountId;
  final HederaMirrorTypesEntityId senderAccountId;
  final String transactionId;
  final HederaMirrorTypesTransactionTypes type;

  const HederaMirrorTypesNftTransactionTransfer({
    required this.consensusTimestamp,
    required this.isApproval,
    required this.nonce,
    this.receiverAccountId,
    this.senderAccountId,
    required this.transactionId,
    required this.type,
  });

  factory HederaMirrorTypesNftTransactionTransfer.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNftTransactionTransfer(
      consensusTimestamp: json.valueAsString('consensus_timestamp'),
      isApproval: json.valueAsBool('is_approval'),
      nonce: json.valueAsInt('nonce'),
      receiverAccountId: json.valueAsString('receiver_account_id'),
      senderAccountId: json.valueAsString('sender_account_id'),
      transactionId: json.valueAsString('transaction_id'),
      type: HederaMirrorTypesTransactionTypes.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
    'consensus_timestamp': consensusTimestamp,
    'is_approval': isApproval,
    'nonce': nonce,
    'receiver_account_id': receiverAccountId,
    'sender_account_id': senderAccountId,
    'transaction_id': transactionId,
    'type': type.toJson(),
  };
}

/// GET /api/v1/tokens/{tokenId}/nfts/{serialNumber}/transactions (response)
class HederaMirrorTypesNftTransactionHistory {
  final List<HederaMirrorTypesNftTransactionTransfer> transactions;
  final HederaMirrorTypesLinks links;

  const HederaMirrorTypesNftTransactionHistory({
    required this.transactions,
    required this.links,
  });

  factory HederaMirrorTypesNftTransactionHistory.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesNftTransactionHistory(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => HederaMirrorTypesNftTransactionTransfer.fromJson(e))
              .toList(),
      links: json.valueTo<HederaMirrorTypesLinks, Map<String, dynamic>>(
        key: 'links',
        parse: (v) => HederaMirrorTypesLinks.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'transactions': transactions.map((e) => e.toJson()).toList(),
    'links': links.toJson(),
  };
}

class HederaMirrorTypesAllowance {
  /// The amount remaining of the original amount granted.
  final BigInt? amount;

  /// The granted amount of the spender's allowance.
  final BigInt? amountGranted;
  final HederaMirrorTypesEntityId owner;
  final HederaMirrorTypesEntityId spender;
  final HederaMirrorTypesTimestampRange? timestamp;

  const HederaMirrorTypesAllowance({
    this.amount,
    this.amountGranted,
    this.owner,
    this.spender,
    this.timestamp,
  });

  factory HederaMirrorTypesAllowance.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesAllowance(
      amount: json.valueAsBigInt('amount'),
      amountGranted: json.valueAsBigInt('amount_granted'),
      owner: json.valueAsString('owner'),
      spender: json.valueAsString('spender'),
      timestamp: json
          .valueTo<HederaMirrorTypesTimestampRange?, Map<String, dynamic>>(
            key: 'timestamp',
            parse: (v) => HederaMirrorTypesTimestampRange.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'amount_granted': amountGranted,
    'owner': owner,
    'spender': spender,
    'timestamp': timestamp?.toJson(),
  };
}

class HederaMirrorTypesErrorStatusMessagesItem {
  /// Error message in hexadecimal
  final String? data;

  /// Detailed error message
  final String? detail;

  /// Error message
  final String? message;

  const HederaMirrorTypesErrorStatusMessagesItem({
    this.data,
    this.detail,
    this.message,
  });

  factory HederaMirrorTypesErrorStatusMessagesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HederaMirrorTypesErrorStatusMessagesItem(
      data: json.valueAsString('data'),
      detail: json.valueAsString('detail'),
      message: json.valueAsString('message'),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'detail': detail,
    'message': message,
  };
}

class HederaMirrorTypesErrorStatus {
  final List<HederaMirrorTypesErrorStatusMessagesItem>? messages;

  const HederaMirrorTypesErrorStatus({this.messages});

  factory HederaMirrorTypesErrorStatus.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesErrorStatus(
      messages:
          json.hasValue('messages')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('messages')
                  .map(
                    (e) => HederaMirrorTypesErrorStatusMessagesItem.fromJson(e),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'messages': messages?.map((e) => e.toJson()).toList(),
  };
}

/// POST /api/v1/contracts/call (response)
/// GET /api/v1/contracts/results/{transactionIdOrHash}/opcodes (response)
class HederaMirrorTypesError {
  final HederaMirrorTypesErrorStatus? status;

  const HederaMirrorTypesError({this.status});

  factory HederaMirrorTypesError.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesError(
      status: json.valueTo<HederaMirrorTypesErrorStatus?, Map<String, dynamic>>(
        key: '_status',
        parse: (v) => HederaMirrorTypesErrorStatus.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() => {'_status': status?.toJson()};
}

/// The fee estimate for the network component. Includes the base fee and any extras associated with it.
class HederaMirrorTypesFeeEstimate {
  /// The base fee price, in tinycents.
  final BigInt base_;

  /// The extra fees that apply for this fee component.
  final List<HederaMirrorTypesFeeExtra> extras;

  const HederaMirrorTypesFeeEstimate({
    required this.base_,
    required this.extras,
  });

  factory HederaMirrorTypesFeeEstimate.fromJson(Map<String, dynamic> json) {
    return HederaMirrorTypesFeeEstimate(
      base_: json.valueAsBigInt('base'),
      extras:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extras')
              .map((e) => HederaMirrorTypesFeeExtra.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'base': base_,
    'extras': extras.map((e) => e.toJson()).toList(),
  };
}
