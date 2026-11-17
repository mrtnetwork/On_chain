import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/common.dart"
    as protocol_common;
import "package:on_chain/tron/src/proto_messages/protocol/src/discover.dart"
    as protocol_discover;
import "package:on_chain/tron/src/proto_messages/protocol/src/api.dart"
    as protocol_api;

/// Specify the name of the package that generated the Java file
/// Specify the class name of the generated Java file
enum TronAccountType implements ProtoEnumVariant {
  normal(0, 'Normal'),
  assetIssue(1, 'AssetIssue'),
  contract(2, 'Contract');

  const TronAccountType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronAccountType fromValue(int? value) {
    value ??= 0;
    return TronAccountType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronAccountType found for the given value. $value",
                details: {
                  "name": "TronAccountType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronAccountType from(Object? value) {
    value ??= 0;
    return TronAccountType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronAccountType found for the given value. $value",
                details: {
                  "name": "TronAccountType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronProposalState implements ProtoEnumVariant {
  pending(0, 'PENDING'),
  disapproved(1, 'DISAPPROVED'),
  approved(2, 'APPROVED'),
  canceled(3, 'CANCELED');

  const TronProposalState(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronProposalState fromValue(int? value) {
    value ??= 0;
    return TronProposalState.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronProposalState found for the given value. $value",
                details: {
                  "name": "TronProposalState",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronProposalState from(Object? value) {
    value ??= 0;
    return TronProposalState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronProposalState found for the given value. $value",
                details: {
                  "name": "TronProposalState",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronMarketOrderState implements ProtoEnumVariant {
  active(0, 'ACTIVE'),
  inactive(1, 'INACTIVE'),
  canceled(2, 'CANCELED');

  const TronMarketOrderState(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronMarketOrderState fromValue(int? value) {
    value ??= 0;
    return TronMarketOrderState.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronMarketOrderState found for the given value. $value",
                details: {
                  "name": "TronMarketOrderState",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronMarketOrderState from(Object? value) {
    value ??= 0;
    return TronMarketOrderState.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronMarketOrderState found for the given value. $value",
                details: {
                  "name": "TronMarketOrderState",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronPermissionPermissionType implements ProtoEnumVariant {
  owner(0, 'Owner'),
  witness(1, 'Witness'),
  active(2, 'Active');

  const TronPermissionPermissionType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronPermissionPermissionType fromValue(int? value) {
    value ??= 0;
    return TronPermissionPermissionType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPermissionPermissionType found for the given value. $value",
                details: {
                  "name": "TronPermissionPermissionType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronPermissionPermissionType from(Object? value) {
    value ??= 0;
    return TronPermissionPermissionType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPermissionPermissionType found for the given value. $value",
                details: {
                  "name": "TronPermissionPermissionType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionContractContractType implements ProtoEnumVariant {
  accountCreateContract(0, 'AccountCreateContract'),
  transferContract(1, 'TransferContract'),
  transferAssetContract(2, 'TransferAssetContract'),
  voteAssetContract(3, 'VoteAssetContract'),
  voteWitnessContract(4, 'VoteWitnessContract'),
  witnessCreateContract(5, 'WitnessCreateContract'),
  assetIssueContract(6, 'AssetIssueContract'),
  witnessUpdateContract(8, 'WitnessUpdateContract'),
  participateAssetIssueContract(9, 'ParticipateAssetIssueContract'),
  accountUpdateContract(10, 'AccountUpdateContract'),
  freezeBalanceContract(11, 'FreezeBalanceContract'),
  unfreezeBalanceContract(12, 'UnfreezeBalanceContract'),
  withdrawBalanceContract(13, 'WithdrawBalanceContract'),
  unfreezeAssetContract(14, 'UnfreezeAssetContract'),
  updateAssetContract(15, 'UpdateAssetContract'),
  proposalCreateContract(16, 'ProposalCreateContract'),
  proposalApproveContract(17, 'ProposalApproveContract'),
  proposalDeleteContract(18, 'ProposalDeleteContract'),
  setAccountIdContract(19, 'SetAccountIdContract'),
  customContract(20, 'CustomContract'),
  createSmartContract(30, 'CreateSmartContract'),
  triggerSmartContract(31, 'TriggerSmartContract'),
  getContract(32, 'GetContract'),
  updateSettingContract(33, 'UpdateSettingContract'),
  exchangeCreateContract(41, 'ExchangeCreateContract'),
  exchangeInjectContract(42, 'ExchangeInjectContract'),
  exchangeWithdrawContract(43, 'ExchangeWithdrawContract'),
  exchangeTransactionContract(44, 'ExchangeTransactionContract'),
  updateEnergyLimitContract(45, 'UpdateEnergyLimitContract'),
  accountPermissionUpdateContract(46, 'AccountPermissionUpdateContract'),
  clearABIContract(48, 'ClearABIContract'),
  updateBrokerageContract(49, 'UpdateBrokerageContract'),
  shieldedTransferContract(51, 'ShieldedTransferContract'),
  marketSellAssetContract(52, 'MarketSellAssetContract'),
  marketCancelOrderContract(53, 'MarketCancelOrderContract'),
  freezeBalanceV2Contract(54, 'FreezeBalanceV2Contract'),
  unfreezeBalanceV2Contract(55, 'UnfreezeBalanceV2Contract'),
  withdrawExpireUnfreezeContract(56, 'WithdrawExpireUnfreezeContract'),
  delegateResourceContract(57, 'DelegateResourceContract'),
  unDelegateResourceContract(58, 'UnDelegateResourceContract'),
  cancelAllUnfreezeV2Contract(59, 'CancelAllUnfreezeV2Contract');

  const TronTransactionContractContractType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionContractContractType fromValue(int? value) {
    value ??= 0;
    return TronTransactionContractContractType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionContractContractType found for the given value. $value",
                details: {
                  "name": "TronTransactionContractContractType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionContractContractType from(Object? value) {
    value ??= 0;
    return TronTransactionContractContractType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionContractContractType found for the given value. $value",
                details: {
                  "name": "TronTransactionContractContractType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionResultcode implements ProtoEnumVariant {
  sucess(0, 'SUCESS'),
  failed(1, 'FAILED');

  const TronTransactionResultcode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionResultcode fromValue(int? value) {
    value ??= 0;
    return TronTransactionResultcode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionResultcode found for the given value. $value",
                details: {
                  "name": "TronTransactionResultcode",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionResultcode from(Object? value) {
    value ??= 0;
    return TronTransactionResultcode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionResultcode found for the given value. $value",
                details: {
                  "name": "TronTransactionResultcode",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionResultcontractResult implements ProtoEnumVariant {
  default_(0, 'DEFAULT'),
  success(1, 'SUCCESS'),
  revert(2, 'REVERT'),
  badJumpDestination(3, 'BAD_JUMP_DESTINATION'),
  outOfMemory(4, 'OUT_OF_MEMORY'),
  precompiledContract(5, 'PRECOMPILED_CONTRACT'),
  stackTooSmall(6, 'STACK_TOO_SMALL'),
  stackTooLarge(7, 'STACK_TOO_LARGE'),
  illegalOperation(8, 'ILLEGAL_OPERATION'),
  stackOverflow(9, 'STACK_OVERFLOW'),
  outOfEnergy(10, 'OUT_OF_ENERGY'),
  outOfTime(11, 'OUT_OF_TIME'),
  jvmStackOverFlow(12, 'JVM_STACK_OVER_FLOW'),
  unknown(13, 'UNKNOWN'),
  transferFailed(14, 'TRANSFER_FAILED'),
  invalidCode(15, 'INVALID_CODE');

  const TronTransactionResultcontractResult(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionResultcontractResult fromValue(int? value) {
    value ??= 0;
    return TronTransactionResultcontractResult.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionResultcontractResult found for the given value. $value",
                details: {
                  "name": "TronTransactionResultcontractResult",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionResultcontractResult from(Object? value) {
    value ??= 0;
    return TronTransactionResultcontractResult.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionResultcontractResult found for the given value. $value",
                details: {
                  "name": "TronTransactionResultcontractResult",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionInfocode implements ProtoEnumVariant {
  sucess(0, 'SUCESS'),
  failed(1, 'FAILED');

  const TronTransactionInfocode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionInfocode fromValue(int? value) {
    value ??= 0;
    return TronTransactionInfocode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionInfocode found for the given value. $value",
                details: {
                  "name": "TronTransactionInfocode",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionInfocode from(Object? value) {
    value ??= 0;
    return TronTransactionInfocode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionInfocode found for the given value. $value",
                details: {
                  "name": "TronTransactionInfocode",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronBlockInventoryType implements ProtoEnumVariant {
  sync_(0, 'SYNC'),
  advtise(1, 'ADVTISE'),
  fetch(2, 'FETCH');

  const TronBlockInventoryType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronBlockInventoryType fromValue(int? value) {
    value ??= 0;
    return TronBlockInventoryType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronBlockInventoryType found for the given value. $value",
                details: {
                  "name": "TronBlockInventoryType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronBlockInventoryType from(Object? value) {
    value ??= 0;
    return TronBlockInventoryType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronBlockInventoryType found for the given value. $value",
                details: {
                  "name": "TronBlockInventoryType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronInventoryInventoryType implements ProtoEnumVariant {
  trx(0, 'TRX'),
  block(1, 'BLOCK');

  const TronInventoryInventoryType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronInventoryInventoryType fromValue(int? value) {
    value ??= 0;
    return TronInventoryInventoryType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronInventoryInventoryType found for the given value. $value",
                details: {
                  "name": "TronInventoryInventoryType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronInventoryInventoryType from(Object? value) {
    value ??= 0;
    return TronInventoryInventoryType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronInventoryInventoryType found for the given value. $value",
                details: {
                  "name": "TronInventoryInventoryType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronItemsItemType implements ProtoEnumVariant {
  err(0, 'ERR'),
  trx(1, 'TRX'),
  block(2, 'BLOCK'),
  blockheader(3, 'BLOCKHEADER');

  const TronItemsItemType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronItemsItemType fromValue(int? value) {
    value ??= 0;
    return TronItemsItemType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronItemsItemType found for the given value. $value",
                details: {
                  "name": "TronItemsItemType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronItemsItemType from(Object? value) {
    value ??= 0;
    return TronItemsItemType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronItemsItemType found for the given value. $value",
                details: {
                  "name": "TronItemsItemType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronReasonCode implements ProtoEnumVariant {
  requested(0, 'REQUESTED'),
  badProtocol(2, 'BAD_PROTOCOL'),
  tooManyPeers(4, 'TOO_MANY_PEERS'),
  duplicatePeer(5, 'DUPLICATE_PEER'),
  incompatibleProtocol(6, 'INCOMPATIBLE_PROTOCOL'),
  randomElimination(7, 'RANDOM_ELIMINATION'),
  peerQuiting(8, 'PEER_QUITING'),
  unexpectedIdentity(9, 'UNEXPECTED_IDENTITY'),
  localIdentity(10, 'LOCAL_IDENTITY'),
  pingTimeout(11, 'PING_TIMEOUT'),
  userReason(16, 'USER_REASON'),
  reset(17, 'RESET'),
  syncFail(18, 'SYNC_FAIL'),
  fetchFail(19, 'FETCH_FAIL'),
  badTx(20, 'BAD_TX'),
  badBlock(21, 'BAD_BLOCK'),
  forked(22, 'FORKED'),
  unlinkable(23, 'UNLINKABLE'),
  incompatibleVersion(24, 'INCOMPATIBLE_VERSION'),
  incompatibleChain(25, 'INCOMPATIBLE_CHAIN'),
  timeOut(32, 'TIME_OUT'),
  connectFail(33, 'CONNECT_FAIL'),
  tooManyPeersWithSameIp(34, 'TOO_MANY_PEERS_WITH_SAME_IP'),
  lightNodeSyncFail(35, 'LIGHT_NODE_SYNC_FAIL'),
  belowThanMe(36, 'BELOW_THAN_ME'),
  notWitness(37, 'NOT_WITNESS'),
  noSuchMessage(38, 'NO_SUCH_MESSAGE'),
  unknown(255, 'UNKNOWN');

  const TronReasonCode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronReasonCode fromValue(int? value) {
    value ??= 0;
    return TronReasonCode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronReasonCode found for the given value. $value",
                details: {"name": "TronReasonCode", "value": value?.toString()},
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronReasonCode from(Object? value) {
    value ??= 0;
    return TronReasonCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronReasonCode found for the given value. $value",
                details: {"name": "TronReasonCode", "value": value?.toString()},
              ),
    );
  }
}

enum TronPBFTMessageMsgType implements ProtoEnumVariant {
  viewChange(0, 'VIEW_CHANGE'),
  request(1, 'REQUEST'),
  preprepare(2, 'PREPREPARE'),
  prepare(3, 'PREPARE'),
  commit(4, 'COMMIT');

  const TronPBFTMessageMsgType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronPBFTMessageMsgType fromValue(int? value) {
    value ??= 0;
    return TronPBFTMessageMsgType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPBFTMessageMsgType found for the given value. $value",
                details: {
                  "name": "TronPBFTMessageMsgType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronPBFTMessageMsgType from(Object? value) {
    value ??= 0;
    return TronPBFTMessageMsgType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPBFTMessageMsgType found for the given value. $value",
                details: {
                  "name": "TronPBFTMessageMsgType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronPBFTMessageDataType implements ProtoEnumVariant {
  block(0, 'BLOCK'),
  srl(1, 'SRL');

  const TronPBFTMessageDataType(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronPBFTMessageDataType fromValue(int? value) {
    value ??= 0;
    return TronPBFTMessageDataType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPBFTMessageDataType found for the given value. $value",
                details: {
                  "name": "TronPBFTMessageDataType",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronPBFTMessageDataType from(Object? value) {
    value ??= 0;
    return TronPBFTMessageDataType.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronPBFTMessageDataType found for the given value. $value",
                details: {
                  "name": "TronPBFTMessageDataType",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

/// AccountId, (name, address) use name, (null, address) use address, (name, null) use name,
class TronAccountId extends TronProtoMessage {
  final List<int>? name;

  final List<int>? address;

  const TronAccountId({this.name, this.address});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [name, address];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'name': config.encodeBinary(name),
      'address': config.encodeBinary(address),
    }.notNullValue;
  }

  factory TronAccountId.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountId(
      name: config.decodeBinary<List<int>?>(
        json.valueAs('name', normalizeKeyLookup: config.normalizeKeys),
      ),
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronAccountId.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountId(
      name: decode.getBytes<List<int>?>(1),
      address: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountId;
}

/// vote message
class TronVote extends TronProtoMessage {
  /// the super rep address
  final List<int>? voteAddress;

  /// the vote num to this super rep.
  final BigInt? voteCount;

  const TronVote({this.voteAddress, this.voteCount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [voteAddress, voteCount];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'vote_address': config.encodeBinary(voteAddress),
      'vote_count': config.encodeBigint(voteCount),
    }.notNullValue;
  }

  factory TronVote.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronVote(
      voteAddress: config.decodeBinary<List<int>?>(
        json.valueAs('vote_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      voteCount: json.valueAsBigInt<BigInt?>(
        'vote_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronVote.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronVote(
      voteAddress: decode.getBytes<List<int>?>(1),
      voteCount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolVote;
}

/// Proposal
class TronProposal extends TronProtoMessage {
  final BigInt? proposalId;

  final List<int>? proposerAddress;

  final Map<BigInt, BigInt> parameters;

  final BigInt? expirationTime;

  final BigInt? createTime;

  final List<List<int>> approvals;

  final TronProposalState? state;

  const TronProposal({
    this.proposalId,
    this.proposerAddress,
    this.parameters = const {},
    this.expirationTime,
    this.createTime,
    this.approvals = const [],
    this.state,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.map(
          fieldNumber: 3,
          keyType: ProtoFieldType.int64,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.enumType(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    proposalId,
    proposerAddress,
    parameters,
    expirationTime,
    createTime,
    approvals,
    state,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'proposal_id': config.encodeBigint(proposalId),
      'proposer_address': config.encodeBinary(proposerAddress),
      'parameters': config.encodeMap(
        parameters,
        (k, v) => MapEntry(config.encodeBigint(k), config.encodeBigint(v)),
      ),
      'expiration_time': config.encodeBigint(expirationTime),
      'create_time': config.encodeBigint(createTime),
      'approvals': approvals.map((e) => config.encodeBinary(e)).toList(),
      'state': config.encodeEnum(state),
    }.notNullValue;
  }

  factory TronProposal.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronProposal(
      proposalId: json.valueAsBigInt<BigInt?>(
        'proposal_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      proposerAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'proposer_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      parameters: config.decodeMap(
        json.valueAs('parameters', normalizeKeyLookup: config.normalizeKeys),
        (k, v) => MapEntry(
          JsonParser.valueAsBigInt<BigInt>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      expirationTime: json.valueAsBigInt<BigInt?>(
        'expiration_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      createTime: json.valueAsBigInt<BigInt?>(
        'create_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      approvals:
          (json.valueEnsureAsList<dynamic>(
            'approvals',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      state: json.valueTo<TronProposalState?, Object?>(
        key: 'state',
        parse: (v) => TronProposalState.from(v),
      ),
    );
  }

  factory TronProposal.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronProposal(
      proposalId: decode.getBigInt<BigInt?>(1),
      proposerAddress: decode.getBytes<List<int>?>(2),
      parameters: decode.getMap<BigInt, BigInt>(3),
      expirationTime: decode.getBigInt<BigInt?>(4),
      createTime: decode.getBigInt<BigInt?>(5),
      approvals: decode.getListOfBytes(6),
      state: decode.getEnum<TronProposalState?>(7, TronProposalState.values),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolProposal;
}

/// Exchange
class TronExchange extends TronProtoMessage {
  final BigInt? exchangeId;

  final List<int>? creatorAddress;

  final BigInt? createTime;

  final List<int>? firstTokenId;

  final BigInt? firstTokenBalance;

  final List<int>? secondTokenId;

  final BigInt? secondTokenBalance;

  const TronExchange({
    this.exchangeId,
    this.creatorAddress,
    this.createTime,
    this.firstTokenId,
    this.firstTokenBalance,
    this.secondTokenId,
    this.secondTokenBalance,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.int64(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    exchangeId,
    creatorAddress,
    createTime,
    firstTokenId,
    firstTokenBalance,
    secondTokenId,
    secondTokenBalance,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'exchange_id': config.encodeBigint(exchangeId),
      'creator_address': config.encodeBinary(creatorAddress),
      'create_time': config.encodeBigint(createTime),
      'first_token_id': config.encodeBinary(firstTokenId),
      'first_token_balance': config.encodeBigint(firstTokenBalance),
      'second_token_id': config.encodeBinary(secondTokenId),
      'second_token_balance': config.encodeBigint(secondTokenBalance),
    }.notNullValue;
  }

  factory TronExchange.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchange(
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      creatorAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'creator_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      createTime: json.valueAsBigInt<BigInt?>(
        'create_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      firstTokenId: config.decodeBinary<List<int>?>(
        json.valueAs(
          'first_token_id',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      firstTokenBalance: json.valueAsBigInt<BigInt?>(
        'first_token_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      secondTokenId: config.decodeBinary<List<int>?>(
        json.valueAs(
          'second_token_id',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      secondTokenBalance: json.valueAsBigInt<BigInt?>(
        'second_token_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronExchange.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchange(
      exchangeId: decode.getBigInt<BigInt?>(1),
      creatorAddress: decode.getBytes<List<int>?>(2),
      createTime: decode.getBigInt<BigInt?>(3),
      firstTokenId: decode.getBytes<List<int>?>(6),
      firstTokenBalance: decode.getBigInt<BigInt?>(7),
      secondTokenId: decode.getBytes<List<int>?>(8),
      secondTokenBalance: decode.getBigInt<BigInt?>(9),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchange;
}

/// market
class TronMarketOrder extends TronProtoMessage {
  final List<int>? orderId;

  final List<int>? ownerAddress;

  final BigInt? createTime;

  final List<int>? sellTokenId;

  final BigInt? sellTokenQuantity;

  final List<int>? buyTokenId;

  final BigInt? buyTokenQuantity;

  /// min to receive
  final BigInt? sellTokenQuantityRemain;

  /// When state != ACTIVE and sell_token_quantity_return !=0,
  /// it means that some sell tokens are returned to the account due to insufficient remaining amount
  final BigInt? sellTokenQuantityReturn;

  final TronMarketOrderState? state;

  final List<int>? prev;

  final List<int>? next;

  const TronMarketOrder({
    this.orderId,
    this.ownerAddress,
    this.createTime,
    this.sellTokenId,
    this.sellTokenQuantity,
    this.buyTokenId,
    this.buyTokenQuantity,
    this.sellTokenQuantityRemain,
    this.sellTokenQuantityReturn,
    this.state,
    this.prev,
    this.next,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.enumType(11),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.bytes(13),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    orderId,
    ownerAddress,
    createTime,
    sellTokenId,
    sellTokenQuantity,
    buyTokenId,
    buyTokenQuantity,
    sellTokenQuantityRemain,
    sellTokenQuantityReturn,
    state,
    prev,
    next,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'order_id': config.encodeBinary(orderId),
      'owner_address': config.encodeBinary(ownerAddress),
      'create_time': config.encodeBigint(createTime),
      'sell_token_id': config.encodeBinary(sellTokenId),
      'sell_token_quantity': config.encodeBigint(sellTokenQuantity),
      'buy_token_id': config.encodeBinary(buyTokenId),
      'buy_token_quantity': config.encodeBigint(buyTokenQuantity),
      'sell_token_quantity_remain': config.encodeBigint(
        sellTokenQuantityRemain,
      ),
      'sell_token_quantity_return': config.encodeBigint(
        sellTokenQuantityReturn,
      ),
      'state': config.encodeEnum(state),
      'prev': config.encodeBinary(prev),
      'next': config.encodeBinary(next),
    }.notNullValue;
  }

  factory TronMarketOrder.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrder(
      orderId: config.decodeBinary<List<int>?>(
        json.valueAs('order_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      createTime: json.valueAsBigInt<BigInt?>(
        'create_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sellTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('sell_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      sellTokenQuantity: json.valueAsBigInt<BigInt?>(
        'sell_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      buyTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('buy_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      buyTokenQuantity: json.valueAsBigInt<BigInt?>(
        'buy_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sellTokenQuantityRemain: json.valueAsBigInt<BigInt?>(
        'sell_token_quantity_remain',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sellTokenQuantityReturn: json.valueAsBigInt<BigInt?>(
        'sell_token_quantity_return',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      state: json.valueTo<TronMarketOrderState?, Object?>(
        key: 'state',
        parse: (v) => TronMarketOrderState.from(v),
      ),
      prev: config.decodeBinary<List<int>?>(
        json.valueAs('prev', normalizeKeyLookup: config.normalizeKeys),
      ),
      next: config.decodeBinary<List<int>?>(
        json.valueAs('next', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronMarketOrder.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrder(
      orderId: decode.getBytes<List<int>?>(1),
      ownerAddress: decode.getBytes<List<int>?>(2),
      createTime: decode.getBigInt<BigInt?>(3),
      sellTokenId: decode.getBytes<List<int>?>(4),
      sellTokenQuantity: decode.getBigInt<BigInt?>(5),
      buyTokenId: decode.getBytes<List<int>?>(6),
      buyTokenQuantity: decode.getBigInt<BigInt?>(7),
      sellTokenQuantityRemain: decode.getBigInt<BigInt?>(9),
      sellTokenQuantityReturn: decode.getBigInt<BigInt?>(10),
      state: decode.getEnum<TronMarketOrderState?>(
        11,
        TronMarketOrderState.values,
      ),
      prev: decode.getBytes<List<int>?>(12),
      next: decode.getBytes<List<int>?>(13),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrder;
}

class TronMarketOrderList extends TronProtoMessage {
  final List<TronMarketOrder> orders;

  const TronMarketOrderList({this.orders = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [orders];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'orders': orders.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMarketOrderList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrderList(
      orders:
          (json.valueEnsureAsList<dynamic>(
                'orders',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronMarketOrder, Object>(
                  value: e,
                  parse:
                      (v) => TronMarketOrder.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronMarketOrderList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrderList(
      orders:
          decode
              .getListOfBytes(1)
              .map((b) => TronMarketOrder.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrderList;
}

class TronMarketOrderPairList extends TronProtoMessage {
  final List<TronMarketOrderPair> orderPair;

  const TronMarketOrderPairList({this.orderPair = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [orderPair];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'orderPair': orderPair.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMarketOrderPairList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrderPairList(
      orderPair:
          (json.valueEnsureAsList<dynamic>(
                'orderPair',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronMarketOrderPair, Object>(
                  value: e,
                  parse:
                      (v) => TronMarketOrderPair.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronMarketOrderPairList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrderPairList(
      orderPair:
          decode
              .getListOfBytes(1)
              .map((b) => TronMarketOrderPair.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrderPairList;
}

class TronMarketOrderPair extends TronProtoMessage {
  final List<int>? sellTokenId;

  final List<int>? buyTokenId;

  const TronMarketOrderPair({this.sellTokenId, this.buyTokenId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [sellTokenId, buyTokenId];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'sell_token_id': config.encodeBinary(sellTokenId),
      'buy_token_id': config.encodeBinary(buyTokenId),
    }.notNullValue;
  }

  factory TronMarketOrderPair.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrderPair(
      sellTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('sell_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      buyTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('buy_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronMarketOrderPair.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrderPair(
      sellTokenId: decode.getBytes<List<int>?>(1),
      buyTokenId: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrderPair;
}

class TronMarketAccountOrder extends TronProtoMessage {
  final List<int>? ownerAddress;

  final List<List<int>> orders;

  /// order_id list
  final BigInt? count;

  /// active count
  final BigInt? totalCount;

  const TronMarketAccountOrder({
    this.ownerAddress,
    this.orders = const [],
    this.count,
    this.totalCount,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress, orders, count, totalCount];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': config.encodeBinary(ownerAddress),
      'orders': orders.map((e) => config.encodeBinary(e)).toList(),
      'count': config.encodeBigint(count),
      'total_count': config.encodeBigint(totalCount),
    }.notNullValue;
  }

  factory TronMarketAccountOrder.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketAccountOrder(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      orders:
          (json.valueEnsureAsList<dynamic>(
            'orders',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      count: json.valueAsBigInt<BigInt?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalCount: json.valueAsBigInt<BigInt?>(
        'total_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMarketAccountOrder.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketAccountOrder(
      ownerAddress: decode.getBytes<List<int>?>(1),
      orders: decode.getListOfBytes(2),
      count: decode.getBigInt<BigInt?>(3),
      totalCount: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketAccountOrder;
}

class TronMarketPrice extends TronProtoMessage {
  final BigInt? sellTokenQuantity;

  final BigInt? buyTokenQuantity;

  const TronMarketPrice({this.sellTokenQuantity, this.buyTokenQuantity});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [sellTokenQuantity, buyTokenQuantity];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'sell_token_quantity': config.encodeBigint(sellTokenQuantity),
      'buy_token_quantity': config.encodeBigint(buyTokenQuantity),
    }.notNullValue;
  }

  factory TronMarketPrice.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketPrice(
      sellTokenQuantity: json.valueAsBigInt<BigInt?>(
        'sell_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      buyTokenQuantity: json.valueAsBigInt<BigInt?>(
        'buy_token_quantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMarketPrice.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketPrice(
      sellTokenQuantity: decode.getBigInt<BigInt?>(1),
      buyTokenQuantity: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketPrice;
}

class TronMarketPriceList extends TronProtoMessage {
  final List<int>? sellTokenId;

  final List<int>? buyTokenId;

  final List<TronMarketPrice> prices;

  const TronMarketPriceList({
    this.sellTokenId,
    this.buyTokenId,
    this.prices = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [sellTokenId, buyTokenId, prices];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'sell_token_id': config.encodeBinary(sellTokenId),
      'buy_token_id': config.encodeBinary(buyTokenId),
      'prices': prices.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMarketPriceList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketPriceList(
      sellTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('sell_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      buyTokenId: config.decodeBinary<List<int>?>(
        json.valueAs('buy_token_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      prices:
          (json.valueEnsureAsList<dynamic>(
                'prices',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronMarketPrice, Object>(
                  value: e,
                  parse:
                      (v) => TronMarketPrice.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronMarketPriceList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketPriceList(
      sellTokenId: decode.getBytes<List<int>?>(1),
      buyTokenId: decode.getBytes<List<int>?>(2),
      prices:
          decode
              .getListOfBytes(3)
              .map((b) => TronMarketPrice.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketPriceList;
}

class TronMarketOrderIdList extends TronProtoMessage {
  final List<int>? head;

  final List<int>? tail;

  const TronMarketOrderIdList({this.head, this.tail});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [head, tail];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'head': config.encodeBinary(head),
      'tail': config.encodeBinary(tail),
    }.notNullValue;
  }

  factory TronMarketOrderIdList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrderIdList(
      head: config.decodeBinary<List<int>?>(
        json.valueAs('head', normalizeKeyLookup: config.normalizeKeys),
      ),
      tail: config.decodeBinary<List<int>?>(
        json.valueAs('tail', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronMarketOrderIdList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrderIdList(
      head: decode.getBytes<List<int>?>(1),
      tail: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrderIdList;
}

class TronChainParameters extends TronProtoMessage {
  final List<TronChainParametersChainParameter> chainParameter;

  const TronChainParameters({this.chainParameter = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [chainParameter];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'chainParameter':
          chainParameter.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronChainParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronChainParameters(
      chainParameter:
          (json.valueEnsureAsList<dynamic>(
                'chainParameter',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronChainParametersChainParameter,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronChainParametersChainParameter.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronChainParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronChainParameters(
      chainParameter:
          decode
              .getListOfBytes(1)
              .map((b) => TronChainParametersChainParameter.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolChainParameters;
}

class TronChainParametersChainParameter extends TronProtoMessage {
  final String? key;

  final BigInt? value;

  const TronChainParametersChainParameter({this.key, this.value});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [key, value];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'key': key, 'value': config.encodeBigint(value)}.notNullValue;
  }

  factory TronChainParametersChainParameter.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronChainParametersChainParameter(
      key: json.valueAsString<String?>(
        'key',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronChainParametersChainParameter.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronChainParametersChainParameter(
      key: decode.getString<String?>(1),
      value: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolChainParametersChainParameter;
}

/// Account
class TronAccount extends TronProtoMessage {
  /// the expire time
  /// account nick name
  final List<int>? accountName;

  final TronAccountType? type;

  /// the create address
  final List<int>? address;

  /// the trx balance
  final BigInt? balance;

  /// the votes
  final List<TronVote> votes;

  /// the other asset owned by this account
  final Map<String, BigInt> asset;

  /// the other asset owned by this account，key is assetId
  final Map<String, BigInt> assetV2;

  /// the frozen balance for bandwidth
  final List<TronAccountFrozen> frozen;

  /// bandwidth, get from frozen
  final BigInt? netUsage;

  /// Frozen balance provided by other accounts to this account
  final BigInt? acquiredDelegatedFrozenBalanceForBandwidth;

  /// Freeze and provide balances to other accounts
  final BigInt? delegatedFrozenBalanceForBandwidth;

  final BigInt? oldTronPower;

  final TronAccountFrozen? tronPower;

  final bool? assetOptimized;

  /// this account create time
  final BigInt? createTime;

  /// this last operation time, including transfer, voting and so on.
  final BigInt? latestOprationTime;

  /// witness block producing allowance
  final BigInt? allowance;

  /// last withdraw time
  final BigInt? latestWithdrawTime;

  /// not used so far
  final List<int>? code;

  final bool? isWitness;

  final bool? isCommittee;

  /// frozen asset(for asset issuer)
  final List<TronAccountFrozen> frozenSupply;

  /// asset_issued_name
  final List<int>? assetIssuedName;

  final List<int>? assetIssuedId;

  final Map<String, BigInt> latestAssetOperationTime;

  final Map<String, BigInt> latestAssetOperationTimeV2;

  final BigInt? freeNetUsage;

  final Map<String, BigInt> freeAssetNetUsage;

  final Map<String, BigInt> freeAssetNetUsageV2;

  final BigInt? latestConsumeTime;

  final BigInt? latestConsumeFreeTime;

  /// the identity of this account, case insensitive
  final List<int>? accountId;

  final BigInt? netWindowSize;

  final bool? netWindowOptimized;

  final TronAccountAccountResource? accountResource;

  final List<int>? codeHash;

  final protocol_contracts.TronPermission? ownerPermission;

  final protocol_contracts.TronPermission? witnessPermission;

  final List<protocol_contracts.TronPermission> activePermission;

  final List<TronAccountFreezeV2> frozenV2;

  final List<TronAccountUnFreezeV2> unfrozenV2;

  final BigInt? delegatedFrozenV2BalanceForBandwidth;

  final BigInt? acquiredDelegatedFrozenV2BalanceForBandwidth;

  const TronAccount({
    this.accountName,
    this.type,
    this.address,
    this.balance,
    this.votes = const [],
    this.asset = const {},
    this.assetV2 = const {},
    this.frozen = const [],
    this.netUsage,
    this.acquiredDelegatedFrozenBalanceForBandwidth,
    this.delegatedFrozenBalanceForBandwidth,
    this.oldTronPower,
    this.tronPower,
    this.assetOptimized,
    this.createTime,
    this.latestOprationTime,
    this.allowance,
    this.latestWithdrawTime,
    this.code,
    this.isWitness,
    this.isCommittee,
    this.frozenSupply = const [],
    this.assetIssuedName,
    this.assetIssuedId,
    this.latestAssetOperationTime = const {},
    this.latestAssetOperationTimeV2 = const {},
    this.freeNetUsage,
    this.freeAssetNetUsage = const {},
    this.freeAssetNetUsageV2 = const {},
    this.latestConsumeTime,
    this.latestConsumeFreeTime,
    this.accountId,
    this.netWindowSize,
    this.netWindowOptimized,
    this.accountResource,
    this.codeHash,
    this.ownerPermission,
    this.witnessPermission,
    this.activePermission = const [],
    this.frozenV2 = const [],
    this.unfrozenV2 = const [],
    this.delegatedFrozenV2BalanceForBandwidth,
    this.acquiredDelegatedFrozenV2BalanceForBandwidth,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 6,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 56,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(41),
        ProtoFieldConfig.int64(42),
        ProtoFieldConfig.int64(46),
        ProtoFieldConfig.message(47),
        ProtoFieldConfig.bool(60),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.int64(12),
        ProtoFieldConfig.bytes(13),
        ProtoFieldConfig.bool(14),
        ProtoFieldConfig.bool(15),
        ProtoFieldConfig.repeated(
          fieldNumber: 16,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(17),
        ProtoFieldConfig.bytes(57),
        ProtoFieldConfig.map(
          fieldNumber: 18,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 58,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int64(19),
        ProtoFieldConfig.map(
          fieldNumber: 20,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 59,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.bytes(23),
        ProtoFieldConfig.int64(24),
        ProtoFieldConfig.bool(25),
        ProtoFieldConfig.message(26),
        ProtoFieldConfig.bytes(30),
        ProtoFieldConfig.message(31),
        ProtoFieldConfig.message(32),
        ProtoFieldConfig.repeated(
          fieldNumber: 33,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 34,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 35,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(36),
        ProtoFieldConfig.int64(37),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    accountName,
    type,
    address,
    balance,
    votes,
    asset,
    assetV2,
    frozen,
    netUsage,
    acquiredDelegatedFrozenBalanceForBandwidth,
    delegatedFrozenBalanceForBandwidth,
    oldTronPower,
    tronPower,
    assetOptimized,
    createTime,
    latestOprationTime,
    allowance,
    latestWithdrawTime,
    code,
    isWitness,
    isCommittee,
    frozenSupply,
    assetIssuedName,
    assetIssuedId,
    latestAssetOperationTime,
    latestAssetOperationTimeV2,
    freeNetUsage,
    freeAssetNetUsage,
    freeAssetNetUsageV2,
    latestConsumeTime,
    latestConsumeFreeTime,
    accountId,
    netWindowSize,
    netWindowOptimized,
    accountResource,
    codeHash,
    ownerPermission,
    witnessPermission,
    activePermission,
    frozenV2,
    unfrozenV2,
    delegatedFrozenV2BalanceForBandwidth,
    acquiredDelegatedFrozenV2BalanceForBandwidth,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account_name': config.encodeBinary(accountName),
      'type': config.encodeEnum(type),
      'address': config.encodeBinary(address),
      'balance': config.encodeBigint(balance),
      'votes': votes.map((e) => config.encodeMessage(e)).toList(),
      'asset': config.encodeMap(
        asset,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'assetV2': config.encodeMap(
        assetV2,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'frozen': frozen.map((e) => config.encodeMessage(e)).toList(),
      'net_usage': config.encodeBigint(netUsage),
      'acquired_delegated_frozen_balance_for_bandwidth': config.encodeBigint(
        acquiredDelegatedFrozenBalanceForBandwidth,
      ),
      'delegated_frozen_balance_for_bandwidth': config.encodeBigint(
        delegatedFrozenBalanceForBandwidth,
      ),
      'old_tron_power': config.encodeBigint(oldTronPower),
      'tron_power': config.encodeMessage(tronPower),
      'asset_optimized': assetOptimized,
      'create_time': config.encodeBigint(createTime),
      'latest_opration_time': config.encodeBigint(latestOprationTime),
      'allowance': config.encodeBigint(allowance),
      'latest_withdraw_time': config.encodeBigint(latestWithdrawTime),
      'code': config.encodeBinary(code),
      'is_witness': isWitness,
      'is_committee': isCommittee,
      'frozen_supply':
          frozenSupply.map((e) => config.encodeMessage(e)).toList(),
      'asset_issued_name': config.encodeBinary(assetIssuedName),
      'asset_issued_ID': config.encodeBinary(assetIssuedId),
      'latest_asset_operation_time': config.encodeMap(
        latestAssetOperationTime,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'latest_asset_operation_timeV2': config.encodeMap(
        latestAssetOperationTimeV2,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'free_net_usage': config.encodeBigint(freeNetUsage),
      'free_asset_net_usage': config.encodeMap(
        freeAssetNetUsage,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'free_asset_net_usageV2': config.encodeMap(
        freeAssetNetUsageV2,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'latest_consume_time': config.encodeBigint(latestConsumeTime),
      'latest_consume_free_time': config.encodeBigint(latestConsumeFreeTime),
      'account_id': config.encodeBinary(accountId),
      'net_window_size': config.encodeBigint(netWindowSize),
      'net_window_optimized': netWindowOptimized,
      'account_resource': config.encodeMessage(accountResource),
      'codeHash': config.encodeBinary(codeHash),
      'owner_permission': config.encodeMessage(ownerPermission),
      'witness_permission': config.encodeMessage(witnessPermission),
      'active_permission':
          activePermission.map((e) => config.encodeMessage(e)).toList(),
      'frozenV2': frozenV2.map((e) => config.encodeMessage(e)).toList(),
      'unfrozenV2': unfrozenV2.map((e) => config.encodeMessage(e)).toList(),
      'delegated_frozenV2_balance_for_bandwidth': config.encodeBigint(
        delegatedFrozenV2BalanceForBandwidth,
      ),
      'acquired_delegated_frozenV2_balance_for_bandwidth': config.encodeBigint(
        acquiredDelegatedFrozenV2BalanceForBandwidth,
      ),
    }.notNullValue;
  }

  factory TronAccount.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccount(
      accountName: config.decodeBinary<List<int>?>(
        json.valueAs('account_name', normalizeKeyLookup: config.normalizeKeys),
      ),
      type: json.valueTo<TronAccountType?, Object?>(
        key: 'type',
        parse: (v) => TronAccountType.from(v),
      ),
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      votes:
          (json.valueEnsureAsList<dynamic>(
                'votes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronVote, Object>(
                  value: e,
                  parse:
                      (v) => TronVote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      asset: config.decodeMap(
        json.valueAs('asset', normalizeKeyLookup: config.normalizeKeys),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      assetV2: config.decodeMap(
        json.valueAs('assetV2', normalizeKeyLookup: config.normalizeKeys),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      frozen:
          (json.valueEnsureAsList<dynamic>(
                'frozen',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAccountFrozen, Object>(
                  value: e,
                  parse:
                      (v) => TronAccountFrozen.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      netUsage: json.valueAsBigInt<BigInt?>(
        'net_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      acquiredDelegatedFrozenBalanceForBandwidth: json.valueAsBigInt<BigInt?>(
        'acquired_delegated_frozen_balance_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delegatedFrozenBalanceForBandwidth: json.valueAsBigInt<BigInt?>(
        'delegated_frozen_balance_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      oldTronPower: json.valueAsBigInt<BigInt?>(
        'old_tron_power',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tronPower: json.valueTo<TronAccountFrozen?, Object>(
        key: 'tron_power',
        parse:
            (v) => TronAccountFrozen.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      assetOptimized: json.valueAsBool<bool?>(
        'asset_optimized',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      createTime: json.valueAsBigInt<BigInt?>(
        'create_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestOprationTime: json.valueAsBigInt<BigInt?>(
        'latest_opration_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowance: json.valueAsBigInt<BigInt?>(
        'allowance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestWithdrawTime: json.valueAsBigInt<BigInt?>(
        'latest_withdraw_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      code: config.decodeBinary<List<int>?>(
        json.valueAs('code', normalizeKeyLookup: config.normalizeKeys),
      ),
      isWitness: json.valueAsBool<bool?>(
        'is_witness',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isCommittee: json.valueAsBool<bool?>(
        'is_committee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozenSupply:
          (json.valueEnsureAsList<dynamic>(
                'frozen_supply',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAccountFrozen, Object>(
                  value: e,
                  parse:
                      (v) => TronAccountFrozen.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      assetIssuedName: config.decodeBinary<List<int>?>(
        json.valueAs(
          'asset_issued_name',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      assetIssuedId: config.decodeBinary<List<int>?>(
        json.valueAs(
          'asset_issued_ID',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      latestAssetOperationTime: config.decodeMap(
        json.valueAs(
          'latest_asset_operation_time',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      latestAssetOperationTimeV2: config.decodeMap(
        json.valueAs(
          'latest_asset_operation_timeV2',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      freeNetUsage: json.valueAsBigInt<BigInt?>(
        'free_net_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freeAssetNetUsage: config.decodeMap(
        json.valueAs(
          'free_asset_net_usage',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      freeAssetNetUsageV2: config.decodeMap(
        json.valueAs(
          'free_asset_net_usageV2',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      latestConsumeTime: json.valueAsBigInt<BigInt?>(
        'latest_consume_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestConsumeFreeTime: json.valueAsBigInt<BigInt?>(
        'latest_consume_free_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountId: config.decodeBinary<List<int>?>(
        json.valueAs('account_id', normalizeKeyLookup: config.normalizeKeys),
      ),
      netWindowSize: json.valueAsBigInt<BigInt?>(
        'net_window_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      netWindowOptimized: json.valueAsBool<bool?>(
        'net_window_optimized',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountResource: json.valueTo<TronAccountAccountResource?, Object>(
        key: 'account_resource',
        parse:
            (v) => TronAccountAccountResource.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      codeHash: config.decodeBinary<List<int>?>(
        json.valueAs('codeHash', normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerPermission: json.valueTo<protocol_contracts.TronPermission?, Object>(
        key: 'owner_permission',
        parse:
            (v) => protocol_contracts.TronPermission.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witnessPermission: json
          .valueTo<protocol_contracts.TronPermission?, Object>(
            key: 'witness_permission',
            parse:
                (v) => protocol_contracts.TronPermission.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      activePermission:
          (json.valueEnsureAsList<dynamic>(
                'active_permission',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronPermission,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronPermission.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      frozenV2:
          (json.valueEnsureAsList<dynamic>(
                'frozenV2',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAccountFreezeV2, Object>(
                  value: e,
                  parse:
                      (v) => TronAccountFreezeV2.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      unfrozenV2:
          (json.valueEnsureAsList<dynamic>(
                'unfrozenV2',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAccountUnFreezeV2, Object>(
                  value: e,
                  parse:
                      (v) => TronAccountUnFreezeV2.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      delegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt<BigInt?>(
        'delegated_frozenV2_balance_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      acquiredDelegatedFrozenV2BalanceForBandwidth: json.valueAsBigInt<BigInt?>(
        'acquired_delegated_frozenV2_balance_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccount.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccount(
      accountName: decode.getBytes<List<int>?>(1),
      type: decode.getEnum<TronAccountType?>(2, TronAccountType.values),
      address: decode.getBytes<List<int>?>(3),
      balance: decode.getBigInt<BigInt?>(4),
      votes:
          decode.getListOfBytes(5).map((b) => TronVote.deserialize(b)).toList(),
      asset: decode.getMap<String, BigInt>(6),
      assetV2: decode.getMap<String, BigInt>(56),
      frozen:
          decode
              .getListOfBytes(7)
              .map((b) => TronAccountFrozen.deserialize(b))
              .toList(),
      netUsage: decode.getBigInt<BigInt?>(8),
      acquiredDelegatedFrozenBalanceForBandwidth: decode.getBigInt<BigInt?>(41),
      delegatedFrozenBalanceForBandwidth: decode.getBigInt<BigInt?>(42),
      oldTronPower: decode.getBigInt<BigInt?>(46),
      tronPower: decode.messageTo<TronAccountFrozen?>(
        47,
        (b) => TronAccountFrozen.deserialize(b),
      ),
      assetOptimized: decode.getBool<bool?>(60),
      createTime: decode.getBigInt<BigInt?>(9),
      latestOprationTime: decode.getBigInt<BigInt?>(10),
      allowance: decode.getBigInt<BigInt?>(11),
      latestWithdrawTime: decode.getBigInt<BigInt?>(12),
      code: decode.getBytes<List<int>?>(13),
      isWitness: decode.getBool<bool?>(14),
      isCommittee: decode.getBool<bool?>(15),
      frozenSupply:
          decode
              .getListOfBytes(16)
              .map((b) => TronAccountFrozen.deserialize(b))
              .toList(),
      assetIssuedName: decode.getBytes<List<int>?>(17),
      assetIssuedId: decode.getBytes<List<int>?>(57),
      latestAssetOperationTime: decode.getMap<String, BigInt>(18),
      latestAssetOperationTimeV2: decode.getMap<String, BigInt>(58),
      freeNetUsage: decode.getBigInt<BigInt?>(19),
      freeAssetNetUsage: decode.getMap<String, BigInt>(20),
      freeAssetNetUsageV2: decode.getMap<String, BigInt>(59),
      latestConsumeTime: decode.getBigInt<BigInt?>(21),
      latestConsumeFreeTime: decode.getBigInt<BigInt?>(22),
      accountId: decode.getBytes<List<int>?>(23),
      netWindowSize: decode.getBigInt<BigInt?>(24),
      netWindowOptimized: decode.getBool<bool?>(25),
      accountResource: decode.messageTo<TronAccountAccountResource?>(
        26,
        (b) => TronAccountAccountResource.deserialize(b),
      ),
      codeHash: decode.getBytes<List<int>?>(30),
      ownerPermission: decode.messageTo<protocol_contracts.TronPermission?>(
        31,
        (b) => protocol_contracts.TronPermission.deserialize(b),
      ),
      witnessPermission: decode.messageTo<protocol_contracts.TronPermission?>(
        32,
        (b) => protocol_contracts.TronPermission.deserialize(b),
      ),
      activePermission:
          decode
              .getListOfBytes(33)
              .map((b) => protocol_contracts.TronPermission.deserialize(b))
              .toList(),
      frozenV2:
          decode
              .getListOfBytes(34)
              .map((b) => TronAccountFreezeV2.deserialize(b))
              .toList(),
      unfrozenV2:
          decode
              .getListOfBytes(35)
              .map((b) => TronAccountUnFreezeV2.deserialize(b))
              .toList(),
      delegatedFrozenV2BalanceForBandwidth: decode.getBigInt<BigInt?>(36),
      acquiredDelegatedFrozenV2BalanceForBandwidth: decode.getBigInt<BigInt?>(
        37,
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccount;
}

/// frozen balance
class TronAccountFrozen extends TronProtoMessage {
  final BigInt? frozenBalance;

  /// the frozen trx or asset balance
  final BigInt? expireTime;

  const TronAccountFrozen({this.frozenBalance, this.expireTime});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [frozenBalance, expireTime];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'frozen_balance': config.encodeBigint(frozenBalance),
      'expire_time': config.encodeBigint(expireTime),
    }.notNullValue;
  }

  factory TronAccountFrozen.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountFrozen(
      frozenBalance: json.valueAsBigInt<BigInt?>(
        'frozen_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expireTime: json.valueAsBigInt<BigInt?>(
        'expire_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountFrozen.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountFrozen(
      frozenBalance: decode.getBigInt<BigInt?>(1),
      expireTime: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountFrozen;
}

class TronAccountAccountResource extends TronProtoMessage {
  /// energy resource, get from frozen
  final BigInt? energyUsage;

  /// the frozen balance for energy
  final TronAccountFrozen? frozenBalanceForEnergy;

  final BigInt? latestConsumeTimeForEnergy;

  /// Frozen balance provided by other accounts to this account
  final BigInt? acquiredDelegatedFrozenBalanceForEnergy;

  /// Frozen balances provided to other accounts
  final BigInt? delegatedFrozenBalanceForEnergy;

  /// storage resource, get from market
  final BigInt? storageLimit;

  final BigInt? storageUsage;

  final BigInt? latestExchangeStorageTime;

  final BigInt? energyWindowSize;

  final BigInt? delegatedFrozenV2BalanceForEnergy;

  final BigInt? acquiredDelegatedFrozenV2BalanceForEnergy;

  final bool? energyWindowOptimized;

  const TronAccountAccountResource({
    this.energyUsage,
    this.frozenBalanceForEnergy,
    this.latestConsumeTimeForEnergy,
    this.acquiredDelegatedFrozenBalanceForEnergy,
    this.delegatedFrozenBalanceForEnergy,
    this.storageLimit,
    this.storageUsage,
    this.latestExchangeStorageTime,
    this.energyWindowSize,
    this.delegatedFrozenV2BalanceForEnergy,
    this.acquiredDelegatedFrozenV2BalanceForEnergy,
    this.energyWindowOptimized,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.bool(12),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    energyUsage,
    frozenBalanceForEnergy,
    latestConsumeTimeForEnergy,
    acquiredDelegatedFrozenBalanceForEnergy,
    delegatedFrozenBalanceForEnergy,
    storageLimit,
    storageUsage,
    latestExchangeStorageTime,
    energyWindowSize,
    delegatedFrozenV2BalanceForEnergy,
    acquiredDelegatedFrozenV2BalanceForEnergy,
    energyWindowOptimized,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'energy_usage': config.encodeBigint(energyUsage),
      'frozen_balance_for_energy': config.encodeMessage(frozenBalanceForEnergy),
      'latest_consume_time_for_energy': config.encodeBigint(
        latestConsumeTimeForEnergy,
      ),
      'acquired_delegated_frozen_balance_for_energy': config.encodeBigint(
        acquiredDelegatedFrozenBalanceForEnergy,
      ),
      'delegated_frozen_balance_for_energy': config.encodeBigint(
        delegatedFrozenBalanceForEnergy,
      ),
      'storage_limit': config.encodeBigint(storageLimit),
      'storage_usage': config.encodeBigint(storageUsage),
      'latest_exchange_storage_time': config.encodeBigint(
        latestExchangeStorageTime,
      ),
      'energy_window_size': config.encodeBigint(energyWindowSize),
      'delegated_frozenV2_balance_for_energy': config.encodeBigint(
        delegatedFrozenV2BalanceForEnergy,
      ),
      'acquired_delegated_frozenV2_balance_for_energy': config.encodeBigint(
        acquiredDelegatedFrozenV2BalanceForEnergy,
      ),
      'energy_window_optimized': energyWindowOptimized,
    }.notNullValue;
  }

  factory TronAccountAccountResource.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountAccountResource(
      energyUsage: json.valueAsBigInt<BigInt?>(
        'energy_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozenBalanceForEnergy: json.valueTo<TronAccountFrozen?, Object>(
        key: 'frozen_balance_for_energy',
        parse:
            (v) => TronAccountFrozen.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestConsumeTimeForEnergy: json.valueAsBigInt<BigInt?>(
        'latest_consume_time_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      acquiredDelegatedFrozenBalanceForEnergy: json.valueAsBigInt<BigInt?>(
        'acquired_delegated_frozen_balance_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delegatedFrozenBalanceForEnergy: json.valueAsBigInt<BigInt?>(
        'delegated_frozen_balance_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageLimit: json.valueAsBigInt<BigInt?>(
        'storage_limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      storageUsage: json.valueAsBigInt<BigInt?>(
        'storage_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestExchangeStorageTime: json.valueAsBigInt<BigInt?>(
        'latest_exchange_storage_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyWindowSize: json.valueAsBigInt<BigInt?>(
        'energy_window_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delegatedFrozenV2BalanceForEnergy: json.valueAsBigInt<BigInt?>(
        'delegated_frozenV2_balance_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      acquiredDelegatedFrozenV2BalanceForEnergy: json.valueAsBigInt<BigInt?>(
        'acquired_delegated_frozenV2_balance_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyWindowOptimized: json.valueAsBool<bool?>(
        'energy_window_optimized',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountAccountResource.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountAccountResource(
      energyUsage: decode.getBigInt<BigInt?>(1),
      frozenBalanceForEnergy: decode.messageTo<TronAccountFrozen?>(
        2,
        (b) => TronAccountFrozen.deserialize(b),
      ),
      latestConsumeTimeForEnergy: decode.getBigInt<BigInt?>(3),
      acquiredDelegatedFrozenBalanceForEnergy: decode.getBigInt<BigInt?>(4),
      delegatedFrozenBalanceForEnergy: decode.getBigInt<BigInt?>(5),
      storageLimit: decode.getBigInt<BigInt?>(6),
      storageUsage: decode.getBigInt<BigInt?>(7),
      latestExchangeStorageTime: decode.getBigInt<BigInt?>(8),
      energyWindowSize: decode.getBigInt<BigInt?>(9),
      delegatedFrozenV2BalanceForEnergy: decode.getBigInt<BigInt?>(10),
      acquiredDelegatedFrozenV2BalanceForEnergy: decode.getBigInt<BigInt?>(11),
      energyWindowOptimized: decode.getBool<bool?>(12),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountAccountResource;
}

class TronAccountFreezeV2 extends TronProtoMessage {
  final protocol_common.TronResourceCode? type;

  final BigInt? amount;

  const TronAccountFreezeV2({this.type, this.amount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [type, amount];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': config.encodeEnum(type),
      'amount': config.encodeBigint(amount),
    }.notNullValue;
  }

  factory TronAccountFreezeV2.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountFreezeV2(
      type: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'type',
        parse: (v) => protocol_common.TronResourceCode.from(v),
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountFreezeV2.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountFreezeV2(
      type: decode.getEnum<protocol_common.TronResourceCode?>(
        1,
        protocol_common.TronResourceCode.values,
      ),
      amount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountFreezeV2;
}

class TronAccountUnFreezeV2 extends TronProtoMessage {
  final protocol_common.TronResourceCode? type;

  final BigInt? unfreezeAmount;

  final BigInt? unfreezeExpireTime;

  const TronAccountUnFreezeV2({
    this.type,
    this.unfreezeAmount,
    this.unfreezeExpireTime,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [type, unfreezeAmount, unfreezeExpireTime];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': config.encodeEnum(type),
      'unfreeze_amount': config.encodeBigint(unfreezeAmount),
      'unfreeze_expire_time': config.encodeBigint(unfreezeExpireTime),
    }.notNullValue;
  }

  factory TronAccountUnFreezeV2.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountUnFreezeV2(
      type: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'type',
        parse: (v) => protocol_common.TronResourceCode.from(v),
      ),
      unfreezeAmount: json.valueAsBigInt<BigInt?>(
        'unfreeze_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unfreezeExpireTime: json.valueAsBigInt<BigInt?>(
        'unfreeze_expire_time',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountUnFreezeV2.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountUnFreezeV2(
      type: decode.getEnum<protocol_common.TronResourceCode?>(
        1,
        protocol_common.TronResourceCode.values,
      ),
      unfreezeAmount: decode.getBigInt<BigInt?>(3),
      unfreezeExpireTime: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountUnFreezeV2;
}

class TronDelegatedResource extends TronProtoMessage {
  final List<int>? from;

  final List<int>? to;

  final BigInt? frozenBalanceForBandwidth;

  final BigInt? frozenBalanceForEnergy;

  final BigInt? expireTimeForBandwidth;

  final BigInt? expireTimeForEnergy;

  const TronDelegatedResource({
    this.from,
    this.to,
    this.frozenBalanceForBandwidth,
    this.frozenBalanceForEnergy,
    this.expireTimeForBandwidth,
    this.expireTimeForEnergy,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    from,
    to,
    frozenBalanceForBandwidth,
    frozenBalanceForEnergy,
    expireTimeForBandwidth,
    expireTimeForEnergy,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeBinary(from),
      'to': config.encodeBinary(to),
      'frozen_balance_for_bandwidth': config.encodeBigint(
        frozenBalanceForBandwidth,
      ),
      'frozen_balance_for_energy': config.encodeBigint(frozenBalanceForEnergy),
      'expire_time_for_bandwidth': config.encodeBigint(expireTimeForBandwidth),
      'expire_time_for_energy': config.encodeBigint(expireTimeForEnergy),
    }.notNullValue;
  }

  factory TronDelegatedResource.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDelegatedResource(
      from: config.decodeBinary<List<int>?>(
        json.valueAs('from', normalizeKeyLookup: config.normalizeKeys),
      ),
      to: config.decodeBinary<List<int>?>(
        json.valueAs('to', normalizeKeyLookup: config.normalizeKeys),
      ),
      frozenBalanceForBandwidth: json.valueAsBigInt<BigInt?>(
        'frozen_balance_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozenBalanceForEnergy: json.valueAsBigInt<BigInt?>(
        'frozen_balance_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expireTimeForBandwidth: json.valueAsBigInt<BigInt?>(
        'expire_time_for_bandwidth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      expireTimeForEnergy: json.valueAsBigInt<BigInt?>(
        'expire_time_for_energy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDelegatedResource.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDelegatedResource(
      from: decode.getBytes<List<int>?>(1),
      to: decode.getBytes<List<int>?>(2),
      frozenBalanceForBandwidth: decode.getBigInt<BigInt?>(3),
      frozenBalanceForEnergy: decode.getBigInt<BigInt?>(4),
      expireTimeForBandwidth: decode.getBigInt<BigInt?>(5),
      expireTimeForEnergy: decode.getBigInt<BigInt?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDelegatedResource;
}

class TronAuthority extends TronProtoMessage {
  final TronAccountId? account;

  final List<int>? permissionName;

  const TronAuthority({this.account, this.permissionName});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [account, permissionName];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account': config.encodeMessage(account),
      'permission_name': config.encodeBinary(permissionName),
    }.notNullValue;
  }

  factory TronAuthority.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAuthority(
      account: json.valueTo<TronAccountId?, Object>(
        key: 'account',
        parse:
            (v) =>
                TronAccountId.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      permissionName: config.decodeBinary<List<int>?>(
        json.valueAs(
          'permission_name',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronAuthority.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAuthority(
      account: decode.messageTo<TronAccountId?>(
        1,
        (b) => TronAccountId.deserialize(b),
      ),
      permissionName: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAuthority;
}

/// Witness
class TronWitness extends TronProtoMessage {
  final List<int>? address;

  final BigInt? voteCount;

  final List<int>? pubKey;

  final String? url;

  final BigInt? totalProduced;

  final BigInt? totalMissed;

  final BigInt? latestBlockNum;

  final BigInt? latestSlotNum;

  final bool? isJobs;

  const TronWitness({
    this.address,
    this.voteCount,
    this.pubKey,
    this.url,
    this.totalProduced,
    this.totalMissed,
    this.latestBlockNum,
    this.latestSlotNum,
    this.isJobs,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.bool(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    address,
    voteCount,
    pubKey,
    url,
    totalProduced,
    totalMissed,
    latestBlockNum,
    latestSlotNum,
    isJobs,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': config.encodeBinary(address),
      'voteCount': config.encodeBigint(voteCount),
      'pubKey': config.encodeBinary(pubKey),
      'url': url,
      'totalProduced': config.encodeBigint(totalProduced),
      'totalMissed': config.encodeBigint(totalMissed),
      'latestBlockNum': config.encodeBigint(latestBlockNum),
      'latestSlotNum': config.encodeBigint(latestSlotNum),
      'isJobs': isJobs,
    }.notNullValue;
  }

  factory TronWitness.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWitness(
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      voteCount: json.valueAsBigInt<BigInt?>(
        'voteCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pubKey: config.decodeBinary<List<int>?>(
        json.valueAs('pubKey', normalizeKeyLookup: config.normalizeKeys),
      ),
      url: json.valueAsString<String?>(
        'url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalProduced: json.valueAsBigInt<BigInt?>(
        'totalProduced',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalMissed: json.valueAsBigInt<BigInt?>(
        'totalMissed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestBlockNum: json.valueAsBigInt<BigInt?>(
        'latestBlockNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latestSlotNum: json.valueAsBigInt<BigInt?>(
        'latestSlotNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isJobs: json.valueAsBool<bool?>(
        'isJobs',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronWitness.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWitness(
      address: decode.getBytes<List<int>?>(1),
      voteCount: decode.getBigInt<BigInt?>(2),
      pubKey: decode.getBytes<List<int>?>(3),
      url: decode.getString<String?>(4),
      totalProduced: decode.getBigInt<BigInt?>(5),
      totalMissed: decode.getBigInt<BigInt?>(6),
      latestBlockNum: decode.getBigInt<BigInt?>(7),
      latestSlotNum: decode.getBigInt<BigInt?>(8),
      isJobs: decode.getBool<bool?>(9),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWitness;
}

/// Vote Change
class TronVotes extends TronProtoMessage {
  final List<int>? address;

  final List<TronVote> oldVotes;

  final List<TronVote> newVotes;

  const TronVotes({
    this.address,
    this.oldVotes = const [],
    this.newVotes = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [address, oldVotes, newVotes];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': config.encodeBinary(address),
      'old_votes': oldVotes.map((e) => config.encodeMessage(e)).toList(),
      'new_votes': newVotes.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronVotes.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronVotes(
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      oldVotes:
          (json.valueEnsureAsList<dynamic>(
                'old_votes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronVote, Object>(
                  value: e,
                  parse:
                      (v) => TronVote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      newVotes:
          (json.valueEnsureAsList<dynamic>(
                'new_votes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronVote, Object>(
                  value: e,
                  parse:
                      (v) => TronVote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronVotes.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronVotes(
      address: decode.getBytes<List<int>?>(1),
      oldVotes:
          decode.getListOfBytes(2).map((b) => TronVote.deserialize(b)).toList(),
      newVotes:
          decode.getListOfBytes(3).map((b) => TronVote.deserialize(b)).toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolVotes;
}

/// Transcation
class TronTXOutput extends TronProtoMessage {
  final BigInt? value;

  final List<int>? pubKeyHash;

  const TronTXOutput({this.value, this.pubKeyHash});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [value, pubKeyHash];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'value': config.encodeBigint(value),
      'pubKeyHash': config.encodeBinary(pubKeyHash),
    }.notNullValue;
  }

  factory TronTXOutput.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTXOutput(
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pubKeyHash: config.decodeBinary<List<int>?>(
        json.valueAs('pubKeyHash', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronTXOutput.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTXOutput(
      value: decode.getBigInt<BigInt?>(1),
      pubKeyHash: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTXOutput;
}

class TronTXInput extends TronProtoMessage {
  final TronTXInputraw? rawData;

  final List<int>? signature;

  const TronTXInput({this.rawData, this.signature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(4)],
    );
  }

  @override
  List<Object?> get protoValues => [rawData, signature];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'raw_data': config.encodeMessage(rawData),
      'signature': config.encodeBinary(signature),
    }.notNullValue;
  }

  factory TronTXInput.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTXInput(
      rawData: json.valueTo<TronTXInputraw?, Object>(
        key: 'raw_data',
        parse:
            (v) =>
                TronTXInputraw.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronTXInput.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTXInput(
      rawData: decode.messageTo<TronTXInputraw?>(
        1,
        (b) => TronTXInputraw.deserialize(b),
      ),
      signature: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTXInput;
}

class TronTXInputraw extends TronProtoMessage {
  final List<int>? txID;

  final BigInt? vout;

  final List<int>? pubKey;

  const TronTXInputraw({this.txID, this.vout, this.pubKey});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [txID, vout, pubKey];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'txID': config.encodeBinary(txID),
      'vout': config.encodeBigint(vout),
      'pubKey': config.encodeBinary(pubKey),
    }.notNullValue;
  }

  factory TronTXInputraw.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTXInputraw(
      txID: config.decodeBinary<List<int>?>(
        json.valueAs('txID', normalizeKeyLookup: config.normalizeKeys),
      ),
      vout: json.valueAsBigInt<BigInt?>(
        'vout',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pubKey: config.decodeBinary<List<int>?>(
        json.valueAs('pubKey', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronTXInputraw.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTXInputraw(
      txID: decode.getBytes<List<int>?>(1),
      vout: decode.getBigInt<BigInt?>(2),
      pubKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTXInputRaw;
}

class TronTXOutputs extends TronProtoMessage {
  final List<TronTXOutput> outputs;

  const TronTXOutputs({this.outputs = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [outputs];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'outputs': outputs.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTXOutputs.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTXOutputs(
      outputs:
          (json.valueEnsureAsList<dynamic>(
                'outputs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTXOutput, Object>(
                  value: e,
                  parse:
                      (v) => TronTXOutput.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTXOutputs.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTXOutputs(
      outputs:
          decode
              .getListOfBytes(1)
              .map((b) => TronTXOutput.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTXOutputs;
}

class TronResourceReceipt extends TronProtoMessage {
  final BigInt? energyUsage;

  final BigInt? energyFee;

  final BigInt? originEnergyUsage;

  final BigInt? energyUsageTotal;

  final BigInt? netUsage;

  final BigInt? netFee;

  final TronTransactionResultcontractResult? result;

  final BigInt? energyPenaltyTotal;

  const TronResourceReceipt({
    this.energyUsage,
    this.energyFee,
    this.originEnergyUsage,
    this.energyUsageTotal,
    this.netUsage,
    this.netFee,
    this.result,
    this.energyPenaltyTotal,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.enumType(7),
        ProtoFieldConfig.int64(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    energyUsage,
    energyFee,
    originEnergyUsage,
    energyUsageTotal,
    netUsage,
    netFee,
    result,
    energyPenaltyTotal,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'energy_usage': config.encodeBigint(energyUsage),
      'energy_fee': config.encodeBigint(energyFee),
      'origin_energy_usage': config.encodeBigint(originEnergyUsage),
      'energy_usage_total': config.encodeBigint(energyUsageTotal),
      'net_usage': config.encodeBigint(netUsage),
      'net_fee': config.encodeBigint(netFee),
      'result': config.encodeEnum(result),
      'energy_penalty_total': config.encodeBigint(energyPenaltyTotal),
    }.notNullValue;
  }

  factory TronResourceReceipt.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronResourceReceipt(
      energyUsage: json.valueAsBigInt<BigInt?>(
        'energy_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyFee: json.valueAsBigInt<BigInt?>(
        'energy_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      originEnergyUsage: json.valueAsBigInt<BigInt?>(
        'origin_energy_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyUsageTotal: json.valueAsBigInt<BigInt?>(
        'energy_usage_total',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      netUsage: json.valueAsBigInt<BigInt?>(
        'net_usage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      netFee: json.valueAsBigInt<BigInt?>(
        'net_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      result: json.valueTo<TronTransactionResultcontractResult?, Object?>(
        key: 'result',
        parse: (v) => TronTransactionResultcontractResult.from(v),
      ),
      energyPenaltyTotal: json.valueAsBigInt<BigInt?>(
        'energy_penalty_total',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronResourceReceipt.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronResourceReceipt(
      energyUsage: decode.getBigInt<BigInt?>(1),
      energyFee: decode.getBigInt<BigInt?>(2),
      originEnergyUsage: decode.getBigInt<BigInt?>(3),
      energyUsageTotal: decode.getBigInt<BigInt?>(4),
      netUsage: decode.getBigInt<BigInt?>(5),
      netFee: decode.getBigInt<BigInt?>(6),
      result: decode.getEnum<TronTransactionResultcontractResult?>(
        7,
        TronTransactionResultcontractResult.values,
      ),
      energyPenaltyTotal: decode.getBigInt<BigInt?>(8),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolResourceReceipt;
}

class TronMarketOrderDetail extends TronProtoMessage {
  final List<int>? makerOrderId;

  final List<int>? takerOrderId;

  final BigInt? fillSellQuantity;

  final BigInt? fillBuyQuantity;

  const TronMarketOrderDetail({
    this.makerOrderId,
    this.takerOrderId,
    this.fillSellQuantity,
    this.fillBuyQuantity,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    makerOrderId,
    takerOrderId,
    fillSellQuantity,
    fillBuyQuantity,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'makerOrderId': config.encodeBinary(makerOrderId),
      'takerOrderId': config.encodeBinary(takerOrderId),
      'fillSellQuantity': config.encodeBigint(fillSellQuantity),
      'fillBuyQuantity': config.encodeBigint(fillBuyQuantity),
    }.notNullValue;
  }

  factory TronMarketOrderDetail.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMarketOrderDetail(
      makerOrderId: config.decodeBinary<List<int>?>(
        json.valueAs('makerOrderId', normalizeKeyLookup: config.normalizeKeys),
      ),
      takerOrderId: config.decodeBinary<List<int>?>(
        json.valueAs('takerOrderId', normalizeKeyLookup: config.normalizeKeys),
      ),
      fillSellQuantity: json.valueAsBigInt<BigInt?>(
        'fillSellQuantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fillBuyQuantity: json.valueAsBigInt<BigInt?>(
        'fillBuyQuantity',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMarketOrderDetail.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMarketOrderDetail(
      makerOrderId: decode.getBytes<List<int>?>(1),
      takerOrderId: decode.getBytes<List<int>?>(2),
      fillSellQuantity: decode.getBigInt<BigInt?>(3),
      fillBuyQuantity: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMarketOrderDetail;
}

class TronTransactionResult extends TronProtoMessage {
  /// please fill in the order according to the serial number
  final BigInt? fee;

  final TronTransactionResultcode? ret;

  final TronTransactionResultcontractResult? contractRet;

  final String? assetIssueID;

  final BigInt? withdrawAmount;

  final BigInt? unfreezeAmount;

  final BigInt? exchangeReceivedAmount;

  final BigInt? exchangeInjectAnotherAmount;

  final BigInt? exchangeWithdrawAnotherAmount;

  final BigInt? exchangeId;

  final BigInt? shieldedTransactionFee;

  final List<int>? orderId;

  final List<TronMarketOrderDetail> orderDetails;

  final BigInt? withdrawExpireAmount;

  final Map<String, BigInt> cancelUnfreezeV2Amount;

  const TronTransactionResult({
    this.fee,
    this.ret,
    this.contractRet,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails = const [],
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.enumType(3),
        ProtoFieldConfig.string(14),
        ProtoFieldConfig.int64(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.int64(18),
        ProtoFieldConfig.int64(19),
        ProtoFieldConfig.int64(20),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.bytes(25),
        ProtoFieldConfig.repeated(
          fieldNumber: 26,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(27),
        ProtoFieldConfig.map(
          fieldNumber: 28,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    fee,
    ret,
    contractRet,
    assetIssueID,
    withdrawAmount,
    unfreezeAmount,
    exchangeReceivedAmount,
    exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount,
    exchangeId,
    shieldedTransactionFee,
    orderId,
    orderDetails,
    withdrawExpireAmount,
    cancelUnfreezeV2Amount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'fee': config.encodeBigint(fee),
      'ret': config.encodeEnum(ret),
      'contractRet': config.encodeEnum(contractRet),
      'assetIssueID': assetIssueID,
      'withdraw_amount': config.encodeBigint(withdrawAmount),
      'unfreeze_amount': config.encodeBigint(unfreezeAmount),
      'exchange_received_amount': config.encodeBigint(exchangeReceivedAmount),
      'exchange_inject_another_amount': config.encodeBigint(
        exchangeInjectAnotherAmount,
      ),
      'exchange_withdraw_another_amount': config.encodeBigint(
        exchangeWithdrawAnotherAmount,
      ),
      'exchange_id': config.encodeBigint(exchangeId),
      'shielded_transaction_fee': config.encodeBigint(shieldedTransactionFee),
      'orderId': config.encodeBinary(orderId),
      'orderDetails': orderDetails.map((e) => config.encodeMessage(e)).toList(),
      'withdraw_expire_amount': config.encodeBigint(withdrawExpireAmount),
      'cancel_unfreezeV2_amount': config.encodeMap(
        cancelUnfreezeV2Amount,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
    }.notNullValue;
  }

  factory TronTransactionResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionResult(
      fee: json.valueAsBigInt<BigInt?>(
        'fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ret: json.valueTo<TronTransactionResultcode?, Object?>(
        key: 'ret',
        parse: (v) => TronTransactionResultcode.from(v),
      ),
      contractRet: json.valueTo<TronTransactionResultcontractResult?, Object?>(
        key: 'contractRet',
        parse: (v) => TronTransactionResultcontractResult.from(v),
      ),
      assetIssueID: json.valueAsString<String?>(
        'assetIssueID',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      withdrawAmount: json.valueAsBigInt<BigInt?>(
        'withdraw_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unfreezeAmount: json.valueAsBigInt<BigInt?>(
        'unfreeze_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeReceivedAmount: json.valueAsBigInt<BigInt?>(
        'exchange_received_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeInjectAnotherAmount: json.valueAsBigInt<BigInt?>(
        'exchange_inject_another_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt<BigInt?>(
        'exchange_withdraw_another_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTransactionFee: json.valueAsBigInt<BigInt?>(
        'shielded_transaction_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      orderId: config.decodeBinary<List<int>?>(
        json.valueAs('orderId', normalizeKeyLookup: config.normalizeKeys),
      ),
      orderDetails:
          (json.valueEnsureAsList<dynamic>(
                'orderDetails',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronMarketOrderDetail, Object>(
                  value: e,
                  parse:
                      (v) => TronMarketOrderDetail.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      withdrawExpireAmount: json.valueAsBigInt<BigInt?>(
        'withdraw_expire_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cancelUnfreezeV2Amount: config.decodeMap(
        json.valueAs(
          'cancel_unfreezeV2_amount',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
    );
  }

  factory TronTransactionResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionResult(
      fee: decode.getBigInt<BigInt?>(1),
      ret: decode.getEnum<TronTransactionResultcode?>(
        2,
        TronTransactionResultcode.values,
      ),
      contractRet: decode.getEnum<TronTransactionResultcontractResult?>(
        3,
        TronTransactionResultcontractResult.values,
      ),
      assetIssueID: decode.getString<String?>(14),
      withdrawAmount: decode.getBigInt<BigInt?>(15),
      unfreezeAmount: decode.getBigInt<BigInt?>(16),
      exchangeReceivedAmount: decode.getBigInt<BigInt?>(18),
      exchangeInjectAnotherAmount: decode.getBigInt<BigInt?>(19),
      exchangeWithdrawAnotherAmount: decode.getBigInt<BigInt?>(20),
      exchangeId: decode.getBigInt<BigInt?>(21),
      shieldedTransactionFee: decode.getBigInt<BigInt?>(22),
      orderId: decode.getBytes<List<int>?>(25),
      orderDetails:
          decode
              .getListOfBytes(26)
              .map((b) => TronMarketOrderDetail.deserialize(b))
              .toList(),
      withdrawExpireAmount: decode.getBigInt<BigInt?>(27),
      cancelUnfreezeV2Amount: decode.getMap<String, BigInt>(28),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionResult;
}

class TronTransactionInfo extends TronProtoMessage {
  final List<int>? id;

  final BigInt? fee;

  final BigInt? blockNumber;

  final BigInt? blockTimeStamp;

  final List<List<int>> contractResult;

  final List<int>? contractAddress;

  final TronResourceReceipt? receipt;

  final List<TronTransactionInfoLog> log;

  final TronTransactionInfocode? result;

  final List<int>? resMessage;

  final String? assetIssueID;

  final BigInt? withdrawAmount;

  final BigInt? unfreezeAmount;

  final List<TronInternalTransaction> internalTransactions;

  final BigInt? exchangeReceivedAmount;

  final BigInt? exchangeInjectAnotherAmount;

  final BigInt? exchangeWithdrawAnotherAmount;

  final BigInt? exchangeId;

  final BigInt? shieldedTransactionFee;

  final List<int>? orderId;

  final List<TronMarketOrderDetail> orderDetails;

  final BigInt? packingFee;

  final BigInt? withdrawExpireAmount;

  final Map<String, BigInt> cancelUnfreezeV2Amount;

  const TronTransactionInfo({
    this.id,
    this.fee,
    this.blockNumber,
    this.blockTimeStamp,
    this.contractResult = const [],
    this.contractAddress,
    this.receipt,
    this.log = const [],
    this.result,
    this.resMessage,
    this.assetIssueID,
    this.withdrawAmount,
    this.unfreezeAmount,
    this.internalTransactions = const [],
    this.exchangeReceivedAmount,
    this.exchangeInjectAnotherAmount,
    this.exchangeWithdrawAnotherAmount,
    this.exchangeId,
    this.shieldedTransactionFee,
    this.orderId,
    this.orderDetails = const [],
    this.packingFee,
    this.withdrawExpireAmount,
    this.cancelUnfreezeV2Amount = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.enumType(9),
        ProtoFieldConfig.bytes(10),
        ProtoFieldConfig.string(14),
        ProtoFieldConfig.int64(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.repeated(
          fieldNumber: 17,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(18),
        ProtoFieldConfig.int64(19),
        ProtoFieldConfig.int64(20),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.bytes(25),
        ProtoFieldConfig.repeated(
          fieldNumber: 26,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(27),
        ProtoFieldConfig.int64(28),
        ProtoFieldConfig.map(
          fieldNumber: 29,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    id,
    fee,
    blockNumber,
    blockTimeStamp,
    contractResult,
    contractAddress,
    receipt,
    log,
    result,
    resMessage,
    assetIssueID,
    withdrawAmount,
    unfreezeAmount,
    internalTransactions,
    exchangeReceivedAmount,
    exchangeInjectAnotherAmount,
    exchangeWithdrawAnotherAmount,
    exchangeId,
    shieldedTransactionFee,
    orderId,
    orderDetails,
    packingFee,
    withdrawExpireAmount,
    cancelUnfreezeV2Amount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'id': config.encodeBinary(id),
      'fee': config.encodeBigint(fee),
      'blockNumber': config.encodeBigint(blockNumber),
      'blockTimeStamp': config.encodeBigint(blockTimeStamp),
      'contractResult':
          contractResult.map((e) => config.encodeBinary(e)).toList(),
      'contract_address': config.encodeBinary(contractAddress),
      'receipt': config.encodeMessage(receipt),
      'log': log.map((e) => config.encodeMessage(e)).toList(),
      'result': config.encodeEnum(result),
      'resMessage': config.encodeBinary(resMessage),
      'assetIssueID': assetIssueID,
      'withdraw_amount': config.encodeBigint(withdrawAmount),
      'unfreeze_amount': config.encodeBigint(unfreezeAmount),
      'internal_transactions':
          internalTransactions.map((e) => config.encodeMessage(e)).toList(),
      'exchange_received_amount': config.encodeBigint(exchangeReceivedAmount),
      'exchange_inject_another_amount': config.encodeBigint(
        exchangeInjectAnotherAmount,
      ),
      'exchange_withdraw_another_amount': config.encodeBigint(
        exchangeWithdrawAnotherAmount,
      ),
      'exchange_id': config.encodeBigint(exchangeId),
      'shielded_transaction_fee': config.encodeBigint(shieldedTransactionFee),
      'orderId': config.encodeBinary(orderId),
      'orderDetails': orderDetails.map((e) => config.encodeMessage(e)).toList(),
      'packingFee': config.encodeBigint(packingFee),
      'withdraw_expire_amount': config.encodeBigint(withdrawExpireAmount),
      'cancel_unfreezeV2_amount': config.encodeMap(
        cancelUnfreezeV2Amount,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
    }.notNullValue;
  }

  factory TronTransactionInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionInfo(
      id: config.decodeBinary<List<int>?>(
        json.valueAs('id', normalizeKeyLookup: config.normalizeKeys),
      ),
      fee: json.valueAsBigInt<BigInt?>(
        'fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockNumber: json.valueAsBigInt<BigInt?>(
        'blockNumber',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockTimeStamp: json.valueAsBigInt<BigInt?>(
        'blockTimeStamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractResult:
          (json.valueEnsureAsList<dynamic>(
            'contractResult',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      contractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      receipt: json.valueTo<TronResourceReceipt?, Object>(
        key: 'receipt',
        parse:
            (v) => TronResourceReceipt.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      log:
          (json.valueEnsureAsList<dynamic>(
                'log',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTransactionInfoLog, Object>(
                  value: e,
                  parse:
                      (v) => TronTransactionInfoLog.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      result: json.valueTo<TronTransactionInfocode?, Object?>(
        key: 'result',
        parse: (v) => TronTransactionInfocode.from(v),
      ),
      resMessage: config.decodeBinary<List<int>?>(
        json.valueAs('resMessage', normalizeKeyLookup: config.normalizeKeys),
      ),
      assetIssueID: json.valueAsString<String?>(
        'assetIssueID',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      withdrawAmount: json.valueAsBigInt<BigInt?>(
        'withdraw_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unfreezeAmount: json.valueAsBigInt<BigInt?>(
        'unfreeze_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      internalTransactions:
          (json.valueEnsureAsList<dynamic>(
                'internal_transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronInternalTransaction, Object>(
                  value: e,
                  parse:
                      (v) => TronInternalTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      exchangeReceivedAmount: json.valueAsBigInt<BigInt?>(
        'exchange_received_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeInjectAnotherAmount: json.valueAsBigInt<BigInt?>(
        'exchange_inject_another_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeWithdrawAnotherAmount: json.valueAsBigInt<BigInt?>(
        'exchange_withdraw_another_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      exchangeId: json.valueAsBigInt<BigInt?>(
        'exchange_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTransactionFee: json.valueAsBigInt<BigInt?>(
        'shielded_transaction_fee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      orderId: config.decodeBinary<List<int>?>(
        json.valueAs('orderId', normalizeKeyLookup: config.normalizeKeys),
      ),
      orderDetails:
          (json.valueEnsureAsList<dynamic>(
                'orderDetails',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronMarketOrderDetail, Object>(
                  value: e,
                  parse:
                      (v) => TronMarketOrderDetail.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      packingFee: json.valueAsBigInt<BigInt?>(
        'packingFee',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      withdrawExpireAmount: json.valueAsBigInt<BigInt?>(
        'withdraw_expire_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cancelUnfreezeV2Amount: config.decodeMap(
        json.valueAs(
          'cancel_unfreezeV2_amount',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
    );
  }

  factory TronTransactionInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionInfo(
      id: decode.getBytes<List<int>?>(1),
      fee: decode.getBigInt<BigInt?>(2),
      blockNumber: decode.getBigInt<BigInt?>(3),
      blockTimeStamp: decode.getBigInt<BigInt?>(4),
      contractResult: decode.getListOfBytes(5),
      contractAddress: decode.getBytes<List<int>?>(6),
      receipt: decode.messageTo<TronResourceReceipt?>(
        7,
        (b) => TronResourceReceipt.deserialize(b),
      ),
      log:
          decode
              .getListOfBytes(8)
              .map((b) => TronTransactionInfoLog.deserialize(b))
              .toList(),
      result: decode.getEnum<TronTransactionInfocode?>(
        9,
        TronTransactionInfocode.values,
      ),
      resMessage: decode.getBytes<List<int>?>(10),
      assetIssueID: decode.getString<String?>(14),
      withdrawAmount: decode.getBigInt<BigInt?>(15),
      unfreezeAmount: decode.getBigInt<BigInt?>(16),
      internalTransactions:
          decode
              .getListOfBytes(17)
              .map((b) => TronInternalTransaction.deserialize(b))
              .toList(),
      exchangeReceivedAmount: decode.getBigInt<BigInt?>(18),
      exchangeInjectAnotherAmount: decode.getBigInt<BigInt?>(19),
      exchangeWithdrawAnotherAmount: decode.getBigInt<BigInt?>(20),
      exchangeId: decode.getBigInt<BigInt?>(21),
      shieldedTransactionFee: decode.getBigInt<BigInt?>(22),
      orderId: decode.getBytes<List<int>?>(25),
      orderDetails:
          decode
              .getListOfBytes(26)
              .map((b) => TronMarketOrderDetail.deserialize(b))
              .toList(),
      packingFee: decode.getBigInt<BigInt?>(27),
      withdrawExpireAmount: decode.getBigInt<BigInt?>(28),
      cancelUnfreezeV2Amount: decode.getMap<String, BigInt>(29),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionInfo;
}

class TronTransactionInfoLog extends TronProtoMessage {
  final List<int>? address;

  final List<List<int>> topics;

  final List<int>? data;

  const TronTransactionInfoLog({
    this.address,
    this.topics = const [],
    this.data,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [address, topics, data];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': config.encodeBinary(address),
      'topics': topics.map((e) => config.encodeBinary(e)).toList(),
      'data': config.encodeBinary(data),
    }.notNullValue;
  }

  factory TronTransactionInfoLog.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionInfoLog(
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      topics:
          (json.valueEnsureAsList<dynamic>(
            'topics',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronTransactionInfoLog.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionInfoLog(
      address: decode.getBytes<List<int>?>(1),
      topics: decode.getListOfBytes(2),
      data: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionInfoLog;
}

class TronTransactionRet extends TronProtoMessage {
  final BigInt? blockNumber;

  final BigInt? blockTimeStamp;

  final List<TronTransactionInfo> transactioninfo;

  const TronTransactionRet({
    this.blockNumber,
    this.blockTimeStamp,
    this.transactioninfo = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    blockNumber,
    blockTimeStamp,
    transactioninfo,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'blockNumber': config.encodeBigint(blockNumber),
      'blockTimeStamp': config.encodeBigint(blockTimeStamp),
      'transactioninfo':
          transactioninfo.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTransactionRet.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionRet(
      blockNumber: json.valueAsBigInt<BigInt?>(
        'blockNumber',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockTimeStamp: json.valueAsBigInt<BigInt?>(
        'blockTimeStamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactioninfo:
          (json.valueEnsureAsList<dynamic>(
                'transactioninfo',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTransactionInfo, Object>(
                  value: e,
                  parse:
                      (v) => TronTransactionInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTransactionRet.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionRet(
      blockNumber: decode.getBigInt<BigInt?>(1),
      blockTimeStamp: decode.getBigInt<BigInt?>(2),
      transactioninfo:
          decode
              .getListOfBytes(3)
              .map((b) => TronTransactionInfo.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionRet;
}

class TronTransactions extends TronProtoMessage {
  final List<protocol_contracts.TronTransaction> transactions;

  const TronTransactions({this.transactions = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transactions];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTransactions.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactions(
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronTransaction,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTransactions.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactions(
      transactions:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_contracts.TronTransaction.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactions;
}

class TronBlockHeader extends TronProtoMessage {
  final TronBlockHeaderraw? rawData;

  final List<int>? witnessSignature;

  const TronBlockHeader({this.rawData, this.witnessSignature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [rawData, witnessSignature];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'raw_data': config.encodeMessage(rawData),
      'witness_signature': config.encodeBinary(witnessSignature),
    }.notNullValue;
  }

  factory TronBlockHeader.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockHeader(
      rawData: json.valueTo<TronBlockHeaderraw?, Object>(
        key: 'raw_data',
        parse:
            (v) => TronBlockHeaderraw.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witnessSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'witness_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronBlockHeader.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockHeader(
      rawData: decode.messageTo<TronBlockHeaderraw?>(
        1,
        (b) => TronBlockHeaderraw.deserialize(b),
      ),
      witnessSignature: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockHeader;
}

class TronBlockHeaderraw extends TronProtoMessage {
  final BigInt? timestamp;

  final List<int>? txTrieRoot;

  final List<int>? parentHash;

  /// bytes nonce = 5;
  /// bytes difficulty = 6;
  final BigInt? number;

  final BigInt? witnessId;

  final List<int>? witnessAddress;

  final int? version;

  final List<int>? accountStateRoot;

  const TronBlockHeaderraw({
    this.timestamp,
    this.txTrieRoot,
    this.parentHash,
    this.number,
    this.witnessId,
    this.witnessAddress,
    this.version,
    this.accountStateRoot,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.bytes(9),
        ProtoFieldConfig.int32(10),
        ProtoFieldConfig.bytes(11),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    timestamp,
    txTrieRoot,
    parentHash,
    number,
    witnessId,
    witnessAddress,
    version,
    accountStateRoot,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'timestamp': config.encodeBigint(timestamp),
      'txTrieRoot': config.encodeBinary(txTrieRoot),
      'parentHash': config.encodeBinary(parentHash),
      'number': config.encodeBigint(number),
      'witness_id': config.encodeBigint(witnessId),
      'witness_address': config.encodeBinary(witnessAddress),
      'version': version,
      'accountStateRoot': config.encodeBinary(accountStateRoot),
    }.notNullValue;
  }

  factory TronBlockHeaderraw.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockHeaderraw(
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txTrieRoot: config.decodeBinary<List<int>?>(
        json.valueAs('txTrieRoot', normalizeKeyLookup: config.normalizeKeys),
      ),
      parentHash: config.decodeBinary<List<int>?>(
        json.valueAs('parentHash', normalizeKeyLookup: config.normalizeKeys),
      ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witnessId: json.valueAsBigInt<BigInt?>(
        'witness_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witnessAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'witness_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      accountStateRoot: config.decodeBinary<List<int>?>(
        json.valueAs(
          'accountStateRoot',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronBlockHeaderraw.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockHeaderraw(
      timestamp: decode.getBigInt<BigInt?>(1),
      txTrieRoot: decode.getBytes<List<int>?>(2),
      parentHash: decode.getBytes<List<int>?>(3),
      number: decode.getBigInt<BigInt?>(7),
      witnessId: decode.getBigInt<BigInt?>(8),
      witnessAddress: decode.getBytes<List<int>?>(9),
      version: decode.getInt<int?>(10),
      accountStateRoot: decode.getBytes<List<int>?>(11),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockHeaderRaw;
}

/// block
class TronBlock extends TronProtoMessage {
  final List<protocol_contracts.TronTransaction> transactions;

  final TronBlockHeader? blockHeader;

  const TronBlock({this.transactions = const [], this.blockHeader});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transactions, blockHeader];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
      'block_header': config.encodeMessage(blockHeader),
    }.notNullValue;
  }

  factory TronBlock.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlock(
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronTransaction,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      blockHeader: json.valueTo<TronBlockHeader?, Object>(
        key: 'block_header',
        parse:
            (v) =>
                TronBlockHeader.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBlock.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlock(
      transactions:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_contracts.TronTransaction.deserialize(b))
              .toList(),
      blockHeader: decode.messageTo<TronBlockHeader?>(
        2,
        (b) => TronBlockHeader.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlock;
}

class TronChainInventory extends TronProtoMessage {
  final List<TronChainInventoryBlockId> ids;

  final BigInt? remainNum;

  const TronChainInventory({this.ids = const [], this.remainNum});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ids, remainNum];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ids': ids.map((e) => config.encodeMessage(e)).toList(),
      'remain_num': config.encodeBigint(remainNum),
    }.notNullValue;
  }

  factory TronChainInventory.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronChainInventory(
      ids:
          (json.valueEnsureAsList<dynamic>(
                'ids',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronChainInventoryBlockId, Object>(
                  value: e,
                  parse:
                      (v) => TronChainInventoryBlockId.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      remainNum: json.valueAsBigInt<BigInt?>(
        'remain_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronChainInventory.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronChainInventory(
      ids:
          decode
              .getListOfBytes(1)
              .map((b) => TronChainInventoryBlockId.deserialize(b))
              .toList(),
      remainNum: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolChainInventory;
}

class TronChainInventoryBlockId extends TronProtoMessage {
  final List<int>? hash;

  final BigInt? number;

  const TronChainInventoryBlockId({this.hash, this.number});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [hash, number];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'hash': config.encodeBinary(hash),
      'number': config.encodeBigint(number),
    }.notNullValue;
  }

  factory TronChainInventoryBlockId.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronChainInventoryBlockId(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronChainInventoryBlockId.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronChainInventoryBlockId(
      hash: decode.getBytes<List<int>?>(1),
      number: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolChainInventoryBlockId;
}

/// Inventory
class TronBlockInventory extends TronProtoMessage {
  final List<TronBlockInventoryBlockId> ids;

  final TronBlockInventoryType? type;

  const TronBlockInventory({this.ids = const [], this.type});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.enumType(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ids, type];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ids': ids.map((e) => config.encodeMessage(e)).toList(),
      'type': config.encodeEnum(type),
    }.notNullValue;
  }

  factory TronBlockInventory.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockInventory(
      ids:
          (json.valueEnsureAsList<dynamic>(
                'ids',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronBlockInventoryBlockId, Object>(
                  value: e,
                  parse:
                      (v) => TronBlockInventoryBlockId.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      type: json.valueTo<TronBlockInventoryType?, Object?>(
        key: 'type',
        parse: (v) => TronBlockInventoryType.from(v),
      ),
    );
  }

  factory TronBlockInventory.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockInventory(
      ids:
          decode
              .getListOfBytes(1)
              .map((b) => TronBlockInventoryBlockId.deserialize(b))
              .toList(),
      type: decode.getEnum<TronBlockInventoryType?>(
        2,
        TronBlockInventoryType.values,
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockInventory;
}

class TronBlockInventoryBlockId extends TronProtoMessage {
  final List<int>? hash;

  final BigInt? number;

  const TronBlockInventoryBlockId({this.hash, this.number});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [hash, number];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'hash': config.encodeBinary(hash),
      'number': config.encodeBigint(number),
    }.notNullValue;
  }

  factory TronBlockInventoryBlockId.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockInventoryBlockId(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBlockInventoryBlockId.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockInventoryBlockId(
      hash: decode.getBytes<List<int>?>(1),
      number: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockInventoryBlockId;
}

class TronInventory extends TronProtoMessage {
  final TronInventoryInventoryType? type;

  final List<List<int>> ids;

  const TronInventory({this.type, this.ids = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [type, ids];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': config.encodeEnum(type),
      'ids': ids.map((e) => config.encodeBinary(e)).toList(),
    }.notNullValue;
  }

  factory TronInventory.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronInventory(
      type: json.valueTo<TronInventoryInventoryType?, Object?>(
        key: 'type',
        parse: (v) => TronInventoryInventoryType.from(v),
      ),
      ids:
          (json.valueEnsureAsList<dynamic>(
            'ids',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory TronInventory.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronInventory(
      type: decode.getEnum<TronInventoryInventoryType?>(
        1,
        TronInventoryInventoryType.values,
      ),
      ids: decode.getListOfBytes(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolInventory;
}

class TronItems extends TronProtoMessage {
  final TronItemsItemType? type;

  final List<TronBlock> blocks;

  final List<TronBlockHeader> blockHeaders;

  final List<protocol_contracts.TronTransaction> transactions;

  const TronItems({
    this.type,
    this.blocks = const [],
    this.blockHeaders = const [],
    this.transactions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [type, blocks, blockHeaders, transactions];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': config.encodeEnum(type),
      'blocks': blocks.map((e) => config.encodeMessage(e)).toList(),
      'block_headers':
          blockHeaders.map((e) => config.encodeMessage(e)).toList(),
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronItems.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronItems(
      type: json.valueTo<TronItemsItemType?, Object?>(
        key: 'type',
        parse: (v) => TronItemsItemType.from(v),
      ),
      blocks:
          (json.valueEnsureAsList<dynamic>(
                'blocks',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronBlock, Object>(
                  value: e,
                  parse:
                      (v) => TronBlock.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      blockHeaders:
          (json.valueEnsureAsList<dynamic>(
                'block_headers',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronBlockHeader, Object>(
                  value: e,
                  parse:
                      (v) => TronBlockHeader.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronTransaction,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronItems.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronItems(
      type: decode.getEnum<TronItemsItemType?>(1, TronItemsItemType.values),
      blocks:
          decode
              .getListOfBytes(2)
              .map((b) => TronBlock.deserialize(b))
              .toList(),
      blockHeaders:
          decode
              .getListOfBytes(3)
              .map((b) => TronBlockHeader.deserialize(b))
              .toList(),
      transactions:
          decode
              .getListOfBytes(4)
              .map((b) => protocol_contracts.TronTransaction.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolItems;
}

/// DynamicProperties
class TronDynamicProperties extends TronProtoMessage {
  final BigInt? lastSolidityBlockNum;

  const TronDynamicProperties({this.lastSolidityBlockNum});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [lastSolidityBlockNum];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'last_solidity_block_num': config.encodeBigint(lastSolidityBlockNum),
    }.notNullValue;
  }

  factory TronDynamicProperties.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDynamicProperties(
      lastSolidityBlockNum: json.valueAsBigInt<BigInt?>(
        'last_solidity_block_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDynamicProperties.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDynamicProperties(
      lastSolidityBlockNum: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDynamicProperties;
}

class TronDisconnectMessage extends TronProtoMessage {
  final TronReasonCode? reason;

  const TronDisconnectMessage({this.reason});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1)],
    );
  }

  @override
  List<Object?> get protoValues => [reason];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'reason': config.encodeEnum(reason)}.notNullValue;
  }

  factory TronDisconnectMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDisconnectMessage(
      reason: json.valueTo<TronReasonCode?, Object?>(
        key: 'reason',
        parse: (v) => TronReasonCode.from(v),
      ),
    );
  }

  factory TronDisconnectMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDisconnectMessage(
      reason: decode.getEnum<TronReasonCode?>(1, TronReasonCode.values),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDisconnectMessage;
}

class TronHelloMessage extends TronProtoMessage {
  final protocol_discover.TronEndpoint? from;

  final int? version;

  final BigInt? timestamp;

  final TronHelloMessageBlockId? genesisBlockId;

  final TronHelloMessageBlockId? solidBlockId;

  final TronHelloMessageBlockId? headBlockId;

  final List<int>? address;

  final List<int>? signature;

  final int? nodeType;

  final BigInt? lowestBlockNum;

  final List<int>? codeVersion;

  const TronHelloMessage({
    this.from,
    this.version,
    this.timestamp,
    this.genesisBlockId,
    this.solidBlockId,
    this.headBlockId,
    this.address,
    this.signature,
    this.nodeType,
    this.lowestBlockNum,
    this.codeVersion,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.int32(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.bytes(11),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    from,
    version,
    timestamp,
    genesisBlockId,
    solidBlockId,
    headBlockId,
    address,
    signature,
    nodeType,
    lowestBlockNum,
    codeVersion,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'from': config.encodeMessage(from),
      'version': version,
      'timestamp': config.encodeBigint(timestamp),
      'genesisBlockId': config.encodeMessage(genesisBlockId),
      'solidBlockId': config.encodeMessage(solidBlockId),
      'headBlockId': config.encodeMessage(headBlockId),
      'address': config.encodeBinary(address),
      'signature': config.encodeBinary(signature),
      'nodeType': nodeType,
      'lowestBlockNum': config.encodeBigint(lowestBlockNum),
      'codeVersion': config.encodeBinary(codeVersion),
    }.notNullValue;
  }

  factory TronHelloMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronHelloMessage(
      from: json.valueTo<protocol_discover.TronEndpoint?, Object>(
        key: 'from',
        parse:
            (v) => protocol_discover.TronEndpoint.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      genesisBlockId: json.valueTo<TronHelloMessageBlockId?, Object>(
        key: 'genesisBlockId',
        parse:
            (v) => TronHelloMessageBlockId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      solidBlockId: json.valueTo<TronHelloMessageBlockId?, Object>(
        key: 'solidBlockId',
        parse:
            (v) => TronHelloMessageBlockId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headBlockId: json.valueTo<TronHelloMessageBlockId?, Object>(
        key: 'headBlockId',
        parse:
            (v) => TronHelloMessageBlockId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      address: config.decodeBinary<List<int>?>(
        json.valueAs('address', normalizeKeyLookup: config.normalizeKeys),
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      nodeType: json.valueAsInt<int?>(
        'nodeType',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lowestBlockNum: json.valueAsBigInt<BigInt?>(
        'lowestBlockNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      codeVersion: config.decodeBinary<List<int>?>(
        json.valueAs('codeVersion', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronHelloMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronHelloMessage(
      from: decode.messageTo<protocol_discover.TronEndpoint?>(
        1,
        (b) => protocol_discover.TronEndpoint.deserialize(b),
      ),
      version: decode.getInt<int?>(2),
      timestamp: decode.getBigInt<BigInt?>(3),
      genesisBlockId: decode.messageTo<TronHelloMessageBlockId?>(
        4,
        (b) => TronHelloMessageBlockId.deserialize(b),
      ),
      solidBlockId: decode.messageTo<TronHelloMessageBlockId?>(
        5,
        (b) => TronHelloMessageBlockId.deserialize(b),
      ),
      headBlockId: decode.messageTo<TronHelloMessageBlockId?>(
        6,
        (b) => TronHelloMessageBlockId.deserialize(b),
      ),
      address: decode.getBytes<List<int>?>(7),
      signature: decode.getBytes<List<int>?>(8),
      nodeType: decode.getInt<int?>(9),
      lowestBlockNum: decode.getBigInt<BigInt?>(10),
      codeVersion: decode.getBytes<List<int>?>(11),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolHelloMessage;
}

class TronHelloMessageBlockId extends TronProtoMessage {
  final List<int>? hash;

  final BigInt? number;

  const TronHelloMessageBlockId({this.hash, this.number});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [hash, number];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'hash': config.encodeBinary(hash),
      'number': config.encodeBigint(number),
    }.notNullValue;
  }

  factory TronHelloMessageBlockId.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronHelloMessageBlockId(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronHelloMessageBlockId.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronHelloMessageBlockId(
      hash: decode.getBytes<List<int>?>(1),
      number: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolHelloMessageBlockId;
}

class TronInternalTransaction extends TronProtoMessage {
  /// internalTransaction identity, the root InternalTransaction hash
  /// should equals to root transaction id.
  final List<int>? hash;

  /// the one send trx (TBD: or token) via function
  final List<int>? callerAddress;

  /// the one recieve trx (TBD: or token) via function
  final List<int>? transferToAddress;

  final List<TronInternalTransactionCallValueInfo> callValueInfo;

  final List<int>? note;

  final bool? rejected;

  final String? extra;

  const TronInternalTransaction({
    this.hash,
    this.callerAddress,
    this.transferToAddress,
    this.callValueInfo = const [],
    this.note,
    this.rejected,
    this.extra,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bool(6),
        ProtoFieldConfig.string(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    hash,
    callerAddress,
    transferToAddress,
    callValueInfo,
    note,
    rejected,
    extra,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'hash': config.encodeBinary(hash),
      'caller_address': config.encodeBinary(callerAddress),
      'transferTo_address': config.encodeBinary(transferToAddress),
      'callValueInfo':
          callValueInfo.map((e) => config.encodeMessage(e)).toList(),
      'note': config.encodeBinary(note),
      'rejected': rejected,
      'extra': extra,
    }.notNullValue;
  }

  factory TronInternalTransaction.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronInternalTransaction(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      callerAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'caller_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      transferToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transferTo_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      callValueInfo:
          (json.valueEnsureAsList<dynamic>(
                'callValueInfo',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronInternalTransactionCallValueInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronInternalTransactionCallValueInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      note: config.decodeBinary<List<int>?>(
        json.valueAs('note', normalizeKeyLookup: config.normalizeKeys),
      ),
      rejected: json.valueAsBool<bool?>(
        'rejected',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      extra: json.valueAsString<String?>(
        'extra',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronInternalTransaction.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronInternalTransaction(
      hash: decode.getBytes<List<int>?>(1),
      callerAddress: decode.getBytes<List<int>?>(2),
      transferToAddress: decode.getBytes<List<int>?>(3),
      callValueInfo:
          decode
              .getListOfBytes(4)
              .map((b) => TronInternalTransactionCallValueInfo.deserialize(b))
              .toList(),
      note: decode.getBytes<List<int>?>(5),
      rejected: decode.getBool<bool?>(6),
      extra: decode.getString<String?>(7),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolInternalTransaction;
}

class TronInternalTransactionCallValueInfo extends TronProtoMessage {
  /// trx (TBD: or token) value
  final BigInt? callValue;

  /// TBD: tokenName, trx should be empty
  final String? tokenId;

  const TronInternalTransactionCallValueInfo({this.callValue, this.tokenId});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.string(2)],
    );
  }

  @override
  List<Object?> get protoValues => [callValue, tokenId];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'callValue': config.encodeBigint(callValue),
      'tokenId': tokenId,
    }.notNullValue;
  }

  factory TronInternalTransactionCallValueInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronInternalTransactionCallValueInfo(
      callValue: json.valueAsBigInt<BigInt?>(
        'callValue',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tokenId: json.valueAsString<String?>(
        'tokenId',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronInternalTransactionCallValueInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronInternalTransactionCallValueInfo(
      callValue: decode.getBigInt<BigInt?>(1),
      tokenId: decode.getString<String?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolInternalTransactionCallValueInfo;
}

class TronDelegatedResourceAccountIndex extends TronProtoMessage {
  final List<int>? account;

  final List<List<int>> fromAccounts;

  final List<List<int>> toAccounts;

  final BigInt? timestamp;

  const TronDelegatedResourceAccountIndex({
    this.account,
    this.fromAccounts = const [],
    this.toAccounts = const [],
    this.timestamp,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.int64(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    account,
    fromAccounts,
    toAccounts,
    timestamp,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account': config.encodeBinary(account),
      'fromAccounts': fromAccounts.map((e) => config.encodeBinary(e)).toList(),
      'toAccounts': toAccounts.map((e) => config.encodeBinary(e)).toList(),
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronDelegatedResourceAccountIndex.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDelegatedResourceAccountIndex(
      account: config.decodeBinary<List<int>?>(
        json.valueAs('account', normalizeKeyLookup: config.normalizeKeys),
      ),
      fromAccounts:
          (json.valueEnsureAsList<dynamic>(
            'fromAccounts',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      toAccounts:
          (json.valueEnsureAsList<dynamic>(
            'toAccounts',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDelegatedResourceAccountIndex.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDelegatedResourceAccountIndex(
      account: decode.getBytes<List<int>?>(1),
      fromAccounts: decode.getListOfBytes(2),
      toAccounts: decode.getListOfBytes(3),
      timestamp: decode.getBigInt<BigInt?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDelegatedResourceAccountIndex;
}

class TronNodeInfo extends TronProtoMessage {
  final BigInt? beginSyncNum;

  final String? block;

  final String? solidityBlock;

  /// connect information
  final int? currentConnectCount;

  final int? activeConnectCount;

  final int? passiveConnectCount;

  final BigInt? totalFlow;

  final List<TronNodeInfoPeerInfo> peerInfoList;

  final TronNodeInfoConfigNodeInfo? configNodeInfo;

  final TronNodeInfoMachineInfo? machineInfo;

  final Map<String, String> cheatWitnessInfoMap;

  const TronNodeInfo({
    this.beginSyncNum,
    this.block,
    this.solidityBlock,
    this.currentConnectCount,
    this.activeConnectCount,
    this.passiveConnectCount,
    this.totalFlow,
    this.peerInfoList = const [],
    this.configNodeInfo,
    this.machineInfo,
    this.cheatWitnessInfoMap = const {},
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.int32(6),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.map(
          fieldNumber: 11,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    beginSyncNum,
    block,
    solidityBlock,
    currentConnectCount,
    activeConnectCount,
    passiveConnectCount,
    totalFlow,
    peerInfoList,
    configNodeInfo,
    machineInfo,
    cheatWitnessInfoMap,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'beginSyncNum': config.encodeBigint(beginSyncNum),
      'block': block,
      'solidityBlock': solidityBlock,
      'currentConnectCount': currentConnectCount,
      'activeConnectCount': activeConnectCount,
      'passiveConnectCount': passiveConnectCount,
      'totalFlow': config.encodeBigint(totalFlow),
      'peerInfoList': peerInfoList.map((e) => config.encodeMessage(e)).toList(),
      'configNodeInfo': config.encodeMessage(configNodeInfo),
      'machineInfo': config.encodeMessage(machineInfo),
      'cheatWitnessInfoMap': cheatWitnessInfoMap,
    }.notNullValue;
  }

  factory TronNodeInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfo(
      beginSyncNum: json.valueAsBigInt<BigInt?>(
        'beginSyncNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      block: json.valueAsString<String?>(
        'block',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      solidityBlock: json.valueAsString<String?>(
        'solidityBlock',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      currentConnectCount: json.valueAsInt<int?>(
        'currentConnectCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      activeConnectCount: json.valueAsInt<int?>(
        'activeConnectCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      passiveConnectCount: json.valueAsInt<int?>(
        'passiveConnectCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalFlow: json.valueAsBigInt<BigInt?>(
        'totalFlow',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      peerInfoList:
          (json.valueEnsureAsList<dynamic>(
                'peerInfoList',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronNodeInfoPeerInfo, Object>(
                  value: e,
                  parse:
                      (v) => TronNodeInfoPeerInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      configNodeInfo: json.valueTo<TronNodeInfoConfigNodeInfo?, Object>(
        key: 'configNodeInfo',
        parse:
            (v) => TronNodeInfoConfigNodeInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      machineInfo: json.valueTo<TronNodeInfoMachineInfo?, Object>(
        key: 'machineInfo',
        parse:
            (v) => TronNodeInfoMachineInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cheatWitnessInfoMap: config.decodeMap(
        json.valueAs(
          'cheatWitnessInfoMap',
          normalizeKeyLookup: config.normalizeKeys,
        ),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsString<String>(v),
        ),
      ),
    );
  }

  factory TronNodeInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfo(
      beginSyncNum: decode.getBigInt<BigInt?>(1),
      block: decode.getString<String?>(2),
      solidityBlock: decode.getString<String?>(3),
      currentConnectCount: decode.getInt<int?>(4),
      activeConnectCount: decode.getInt<int?>(5),
      passiveConnectCount: decode.getInt<int?>(6),
      totalFlow: decode.getBigInt<BigInt?>(7),
      peerInfoList:
          decode
              .getListOfBytes(8)
              .map((b) => TronNodeInfoPeerInfo.deserialize(b))
              .toList(),
      configNodeInfo: decode.messageTo<TronNodeInfoConfigNodeInfo?>(
        9,
        (b) => TronNodeInfoConfigNodeInfo.deserialize(b),
      ),
      machineInfo: decode.messageTo<TronNodeInfoMachineInfo?>(
        10,
        (b) => TronNodeInfoMachineInfo.deserialize(b),
      ),
      cheatWitnessInfoMap: decode.getMap<String, String>(11),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfo;
}

class TronNodeInfoPeerInfo extends TronProtoMessage {
  final String? lastSyncBlock;

  final BigInt? remainNum;

  final BigInt? lastBlockUpdateTime;

  final bool? syncFlag;

  final BigInt? headBlockTimeWeBothHave;

  final bool? needSyncFromPeer;

  final bool? needSyncFromUs;

  final String? host;

  final int? port;

  final String? nodeId;

  final BigInt? connectTime;

  final double? avgLatency;

  final int? syncToFetchSize;

  final BigInt? syncToFetchSizePeekNum;

  final int? syncBlockRequestedSize;

  final BigInt? unFetchSynNum;

  final int? blockInPorcSize;

  final String? headBlockWeBothHave;

  final bool? isActive;

  final int? score;

  final int? nodeCount;

  final BigInt? inFlow;

  final int? disconnectTimes;

  final String? localDisconnectReason;

  final String? remoteDisconnectReason;

  const TronNodeInfoPeerInfo({
    this.lastSyncBlock,
    this.remainNum,
    this.lastBlockUpdateTime,
    this.syncFlag,
    this.headBlockTimeWeBothHave,
    this.needSyncFromPeer,
    this.needSyncFromUs,
    this.host,
    this.port,
    this.nodeId,
    this.connectTime,
    this.avgLatency,
    this.syncToFetchSize,
    this.syncToFetchSizePeekNum,
    this.syncBlockRequestedSize,
    this.unFetchSynNum,
    this.blockInPorcSize,
    this.headBlockWeBothHave,
    this.isActive,
    this.score,
    this.nodeCount,
    this.inFlow,
    this.disconnectTimes,
    this.localDisconnectReason,
    this.remoteDisconnectReason,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.bool(6),
        ProtoFieldConfig.bool(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.int32(9),
        ProtoFieldConfig.string(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.double(12),
        ProtoFieldConfig.int32(13),
        ProtoFieldConfig.int64(14),
        ProtoFieldConfig.int32(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.int32(17),
        ProtoFieldConfig.string(18),
        ProtoFieldConfig.bool(19),
        ProtoFieldConfig.int32(20),
        ProtoFieldConfig.int32(21),
        ProtoFieldConfig.int64(22),
        ProtoFieldConfig.int32(23),
        ProtoFieldConfig.string(24),
        ProtoFieldConfig.string(25),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    lastSyncBlock,
    remainNum,
    lastBlockUpdateTime,
    syncFlag,
    headBlockTimeWeBothHave,
    needSyncFromPeer,
    needSyncFromUs,
    host,
    port,
    nodeId,
    connectTime,
    avgLatency,
    syncToFetchSize,
    syncToFetchSizePeekNum,
    syncBlockRequestedSize,
    unFetchSynNum,
    blockInPorcSize,
    headBlockWeBothHave,
    isActive,
    score,
    nodeCount,
    inFlow,
    disconnectTimes,
    localDisconnectReason,
    remoteDisconnectReason,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'lastSyncBlock': lastSyncBlock,
      'remainNum': config.encodeBigint(remainNum),
      'lastBlockUpdateTime': config.encodeBigint(lastBlockUpdateTime),
      'syncFlag': syncFlag,
      'headBlockTimeWeBothHave': config.encodeBigint(headBlockTimeWeBothHave),
      'needSyncFromPeer': needSyncFromPeer,
      'needSyncFromUs': needSyncFromUs,
      'host': host,
      'port': port,
      'nodeId': nodeId,
      'connectTime': config.encodeBigint(connectTime),
      'avgLatency': avgLatency,
      'syncToFetchSize': syncToFetchSize,
      'syncToFetchSizePeekNum': config.encodeBigint(syncToFetchSizePeekNum),
      'syncBlockRequestedSize': syncBlockRequestedSize,
      'unFetchSynNum': config.encodeBigint(unFetchSynNum),
      'blockInPorcSize': blockInPorcSize,
      'headBlockWeBothHave': headBlockWeBothHave,
      'isActive': isActive,
      'score': score,
      'nodeCount': nodeCount,
      'inFlow': config.encodeBigint(inFlow),
      'disconnectTimes': disconnectTimes,
      'localDisconnectReason': localDisconnectReason,
      'remoteDisconnectReason': remoteDisconnectReason,
    }.notNullValue;
  }

  factory TronNodeInfoPeerInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfoPeerInfo(
      lastSyncBlock: json.valueAsString<String?>(
        'lastSyncBlock',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      remainNum: json.valueAsBigInt<BigInt?>(
        'remainNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lastBlockUpdateTime: json.valueAsBigInt<BigInt?>(
        'lastBlockUpdateTime',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      syncFlag: json.valueAsBool<bool?>(
        'syncFlag',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headBlockTimeWeBothHave: json.valueAsBigInt<BigInt?>(
        'headBlockTimeWeBothHave',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      needSyncFromPeer: json.valueAsBool<bool?>(
        'needSyncFromPeer',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      needSyncFromUs: json.valueAsBool<bool?>(
        'needSyncFromUs',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      host: json.valueAsString<String?>(
        'host',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      port: json.valueAsInt<int?>(
        'port',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeId: json.valueAsString<String?>(
        'nodeId',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      connectTime: json.valueAsBigInt<BigInt?>(
        'connectTime',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      avgLatency: json.valueAsDouble<double?>(
        'avgLatency',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      syncToFetchSize: json.valueAsInt<int?>(
        'syncToFetchSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      syncToFetchSizePeekNum: json.valueAsBigInt<BigInt?>(
        'syncToFetchSizePeekNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      syncBlockRequestedSize: json.valueAsInt<int?>(
        'syncBlockRequestedSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      unFetchSynNum: json.valueAsBigInt<BigInt?>(
        'unFetchSynNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockInPorcSize: json.valueAsInt<int?>(
        'blockInPorcSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headBlockWeBothHave: json.valueAsString<String?>(
        'headBlockWeBothHave',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isActive: json.valueAsBool<bool?>(
        'isActive',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      score: json.valueAsInt<int?>(
        'score',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeCount: json.valueAsInt<int?>(
        'nodeCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      inFlow: json.valueAsBigInt<BigInt?>(
        'inFlow',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      disconnectTimes: json.valueAsInt<int?>(
        'disconnectTimes',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      localDisconnectReason: json.valueAsString<String?>(
        'localDisconnectReason',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      remoteDisconnectReason: json.valueAsString<String?>(
        'remoteDisconnectReason',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNodeInfoPeerInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfoPeerInfo(
      lastSyncBlock: decode.getString<String?>(1),
      remainNum: decode.getBigInt<BigInt?>(2),
      lastBlockUpdateTime: decode.getBigInt<BigInt?>(3),
      syncFlag: decode.getBool<bool?>(4),
      headBlockTimeWeBothHave: decode.getBigInt<BigInt?>(5),
      needSyncFromPeer: decode.getBool<bool?>(6),
      needSyncFromUs: decode.getBool<bool?>(7),
      host: decode.getString<String?>(8),
      port: decode.getInt<int?>(9),
      nodeId: decode.getString<String?>(10),
      connectTime: decode.getBigInt<BigInt?>(11),
      avgLatency: decode.getDouble<double?>(12),
      syncToFetchSize: decode.getInt<int?>(13),
      syncToFetchSizePeekNum: decode.getBigInt<BigInt?>(14),
      syncBlockRequestedSize: decode.getInt<int?>(15),
      unFetchSynNum: decode.getBigInt<BigInt?>(16),
      blockInPorcSize: decode.getInt<int?>(17),
      headBlockWeBothHave: decode.getString<String?>(18),
      isActive: decode.getBool<bool?>(19),
      score: decode.getInt<int?>(20),
      nodeCount: decode.getInt<int?>(21),
      inFlow: decode.getBigInt<BigInt?>(22),
      disconnectTimes: decode.getInt<int?>(23),
      localDisconnectReason: decode.getString<String?>(24),
      remoteDisconnectReason: decode.getString<String?>(25),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfoPeerInfo;
}

class TronNodeInfoConfigNodeInfo extends TronProtoMessage {
  final String? codeVersion;

  final String? p2pVersion;

  final int? listenPort;

  final bool? discoverEnable;

  final int? activeNodeSize;

  final int? passiveNodeSize;

  final int? sendNodeSize;

  final int? maxConnectCount;

  final int? sameIpMaxConnectCount;

  final int? backupListenPort;

  final int? backupMemberSize;

  final int? backupPriority;

  final int? dbVersion;

  final int? minParticipationRate;

  final bool? supportConstant;

  final double? minTimeRatio;

  final double? maxTimeRatio;

  final BigInt? allowCreationOfContracts;

  final BigInt? allowAdaptiveEnergy;

  const TronNodeInfoConfigNodeInfo({
    this.codeVersion,
    this.p2pVersion,
    this.listenPort,
    this.discoverEnable,
    this.activeNodeSize,
    this.passiveNodeSize,
    this.sendNodeSize,
    this.maxConnectCount,
    this.sameIpMaxConnectCount,
    this.backupListenPort,
    this.backupMemberSize,
    this.backupPriority,
    this.dbVersion,
    this.minParticipationRate,
    this.supportConstant,
    this.minTimeRatio,
    this.maxTimeRatio,
    this.allowCreationOfContracts,
    this.allowAdaptiveEnergy,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.bool(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.int32(6),
        ProtoFieldConfig.int32(7),
        ProtoFieldConfig.int32(8),
        ProtoFieldConfig.int32(9),
        ProtoFieldConfig.int32(10),
        ProtoFieldConfig.int32(11),
        ProtoFieldConfig.int32(12),
        ProtoFieldConfig.int32(13),
        ProtoFieldConfig.int32(14),
        ProtoFieldConfig.bool(15),
        ProtoFieldConfig.double(16),
        ProtoFieldConfig.double(17),
        ProtoFieldConfig.int64(18),
        ProtoFieldConfig.int64(19),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    codeVersion,
    p2pVersion,
    listenPort,
    discoverEnable,
    activeNodeSize,
    passiveNodeSize,
    sendNodeSize,
    maxConnectCount,
    sameIpMaxConnectCount,
    backupListenPort,
    backupMemberSize,
    backupPriority,
    dbVersion,
    minParticipationRate,
    supportConstant,
    minTimeRatio,
    maxTimeRatio,
    allowCreationOfContracts,
    allowAdaptiveEnergy,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'codeVersion': codeVersion,
      'p2pVersion': p2pVersion,
      'listenPort': listenPort,
      'discoverEnable': discoverEnable,
      'activeNodeSize': activeNodeSize,
      'passiveNodeSize': passiveNodeSize,
      'sendNodeSize': sendNodeSize,
      'maxConnectCount': maxConnectCount,
      'sameIpMaxConnectCount': sameIpMaxConnectCount,
      'backupListenPort': backupListenPort,
      'backupMemberSize': backupMemberSize,
      'backupPriority': backupPriority,
      'dbVersion': dbVersion,
      'minParticipationRate': minParticipationRate,
      'supportConstant': supportConstant,
      'minTimeRatio': minTimeRatio,
      'maxTimeRatio': maxTimeRatio,
      'allowCreationOfContracts': config.encodeBigint(allowCreationOfContracts),
      'allowAdaptiveEnergy': config.encodeBigint(allowAdaptiveEnergy),
    }.notNullValue;
  }

  factory TronNodeInfoConfigNodeInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfoConfigNodeInfo(
      codeVersion: json.valueAsString<String?>(
        'codeVersion',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      p2pVersion: json.valueAsString<String?>(
        'p2pVersion',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      listenPort: json.valueAsInt<int?>(
        'listenPort',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      discoverEnable: json.valueAsBool<bool?>(
        'discoverEnable',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      activeNodeSize: json.valueAsInt<int?>(
        'activeNodeSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      passiveNodeSize: json.valueAsInt<int?>(
        'passiveNodeSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sendNodeSize: json.valueAsInt<int?>(
        'sendNodeSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxConnectCount: json.valueAsInt<int?>(
        'maxConnectCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      sameIpMaxConnectCount: json.valueAsInt<int?>(
        'sameIpMaxConnectCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      backupListenPort: json.valueAsInt<int?>(
        'backupListenPort',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      backupMemberSize: json.valueAsInt<int?>(
        'backupMemberSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      backupPriority: json.valueAsInt<int?>(
        'backupPriority',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      dbVersion: json.valueAsInt<int?>(
        'dbVersion',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minParticipationRate: json.valueAsInt<int?>(
        'minParticipationRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      supportConstant: json.valueAsBool<bool?>(
        'supportConstant',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      minTimeRatio: json.valueAsDouble<double?>(
        'minTimeRatio',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxTimeRatio: json.valueAsDouble<double?>(
        'maxTimeRatio',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowCreationOfContracts: json.valueAsBigInt<BigInt?>(
        'allowCreationOfContracts',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      allowAdaptiveEnergy: json.valueAsBigInt<BigInt?>(
        'allowAdaptiveEnergy',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNodeInfoConfigNodeInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfoConfigNodeInfo(
      codeVersion: decode.getString<String?>(1),
      p2pVersion: decode.getString<String?>(2),
      listenPort: decode.getInt<int?>(3),
      discoverEnable: decode.getBool<bool?>(4),
      activeNodeSize: decode.getInt<int?>(5),
      passiveNodeSize: decode.getInt<int?>(6),
      sendNodeSize: decode.getInt<int?>(7),
      maxConnectCount: decode.getInt<int?>(8),
      sameIpMaxConnectCount: decode.getInt<int?>(9),
      backupListenPort: decode.getInt<int?>(10),
      backupMemberSize: decode.getInt<int?>(11),
      backupPriority: decode.getInt<int?>(12),
      dbVersion: decode.getInt<int?>(13),
      minParticipationRate: decode.getInt<int?>(14),
      supportConstant: decode.getBool<bool?>(15),
      minTimeRatio: decode.getDouble<double?>(16),
      maxTimeRatio: decode.getDouble<double?>(17),
      allowCreationOfContracts: decode.getBigInt<BigInt?>(18),
      allowAdaptiveEnergy: decode.getBigInt<BigInt?>(19),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfoConfigNodeInfo;
}

class TronNodeInfoMachineInfo extends TronProtoMessage {
  final int? threadCount;

  final int? deadLockThreadCount;

  final int? cpuCount;

  final BigInt? totalMemory;

  final BigInt? freeMemory;

  final double? cpuRate;

  final String? javaVersion;

  final String? osName;

  final BigInt? jvmTotalMemory;

  final BigInt? jvmFreeMemory;

  final double? processCpuRate;

  final List<TronNodeInfoMachineInfoMemoryDescInfo> memoryDescInfoList;

  final List<TronNodeInfoMachineInfoDeadLockThreadInfo> deadLockThreadInfoList;

  const TronNodeInfoMachineInfo({
    this.threadCount,
    this.deadLockThreadCount,
    this.cpuCount,
    this.totalMemory,
    this.freeMemory,
    this.cpuRate,
    this.javaVersion,
    this.osName,
    this.jvmTotalMemory,
    this.jvmFreeMemory,
    this.processCpuRate,
    this.memoryDescInfoList = const [],
    this.deadLockThreadInfoList = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.double(6),
        ProtoFieldConfig.string(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.double(11),
        ProtoFieldConfig.repeated(
          fieldNumber: 12,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    threadCount,
    deadLockThreadCount,
    cpuCount,
    totalMemory,
    freeMemory,
    cpuRate,
    javaVersion,
    osName,
    jvmTotalMemory,
    jvmFreeMemory,
    processCpuRate,
    memoryDescInfoList,
    deadLockThreadInfoList,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'threadCount': threadCount,
      'deadLockThreadCount': deadLockThreadCount,
      'cpuCount': cpuCount,
      'totalMemory': config.encodeBigint(totalMemory),
      'freeMemory': config.encodeBigint(freeMemory),
      'cpuRate': cpuRate,
      'javaVersion': javaVersion,
      'osName': osName,
      'jvmTotalMemory': config.encodeBigint(jvmTotalMemory),
      'jvmFreeMemory': config.encodeBigint(jvmFreeMemory),
      'processCpuRate': processCpuRate,
      'memoryDescInfoList':
          memoryDescInfoList.map((e) => config.encodeMessage(e)).toList(),
      'deadLockThreadInfoList':
          deadLockThreadInfoList.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronNodeInfoMachineInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfoMachineInfo(
      threadCount: json.valueAsInt<int?>(
        'threadCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      deadLockThreadCount: json.valueAsInt<int?>(
        'deadLockThreadCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cpuCount: json.valueAsInt<int?>(
        'cpuCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalMemory: json.valueAsBigInt<BigInt?>(
        'totalMemory',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freeMemory: json.valueAsBigInt<BigInt?>(
        'freeMemory',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cpuRate: json.valueAsDouble<double?>(
        'cpuRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      javaVersion: json.valueAsString<String?>(
        'javaVersion',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      osName: json.valueAsString<String?>(
        'osName',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      jvmTotalMemory: json.valueAsBigInt<BigInt?>(
        'jvmTotalMemory',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      jvmFreeMemory: json.valueAsBigInt<BigInt?>(
        'jvmFreeMemory',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      processCpuRate: json.valueAsDouble<double?>(
        'processCpuRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      memoryDescInfoList:
          (json.valueEnsureAsList<dynamic>(
                'memoryDescInfoList',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronNodeInfoMachineInfoMemoryDescInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronNodeInfoMachineInfoMemoryDescInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      deadLockThreadInfoList:
          (json.valueEnsureAsList<dynamic>(
                'deadLockThreadInfoList',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronNodeInfoMachineInfoDeadLockThreadInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronNodeInfoMachineInfoDeadLockThreadInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronNodeInfoMachineInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfoMachineInfo(
      threadCount: decode.getInt<int?>(1),
      deadLockThreadCount: decode.getInt<int?>(2),
      cpuCount: decode.getInt<int?>(3),
      totalMemory: decode.getBigInt<BigInt?>(4),
      freeMemory: decode.getBigInt<BigInt?>(5),
      cpuRate: decode.getDouble<double?>(6),
      javaVersion: decode.getString<String?>(7),
      osName: decode.getString<String?>(8),
      jvmTotalMemory: decode.getBigInt<BigInt?>(9),
      jvmFreeMemory: decode.getBigInt<BigInt?>(10),
      processCpuRate: decode.getDouble<double?>(11),
      memoryDescInfoList:
          decode
              .getListOfBytes(12)
              .map((b) => TronNodeInfoMachineInfoMemoryDescInfo.deserialize(b))
              .toList(),
      deadLockThreadInfoList:
          decode
              .getListOfBytes(13)
              .map(
                (b) => TronNodeInfoMachineInfoDeadLockThreadInfo.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfoMachineInfo;
}

class TronNodeInfoMachineInfoMemoryDescInfo extends TronProtoMessage {
  final String? name;

  final BigInt? initSize;

  final BigInt? useSize;

  final BigInt? maxSize;

  final double? useRate;

  const TronNodeInfoMachineInfoMemoryDescInfo({
    this.name,
    this.initSize,
    this.useSize,
    this.maxSize,
    this.useRate,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.double(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [name, initSize, useSize, maxSize, useRate];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'name': name,
      'initSize': config.encodeBigint(initSize),
      'useSize': config.encodeBigint(useSize),
      'maxSize': config.encodeBigint(maxSize),
      'useRate': useRate,
    }.notNullValue;
  }

  factory TronNodeInfoMachineInfoMemoryDescInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfoMachineInfoMemoryDescInfo(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      initSize: json.valueAsBigInt<BigInt?>(
        'initSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      useSize: json.valueAsBigInt<BigInt?>(
        'useSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxSize: json.valueAsBigInt<BigInt?>(
        'maxSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      useRate: json.valueAsDouble<double?>(
        'useRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNodeInfoMachineInfoMemoryDescInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfoMachineInfoMemoryDescInfo(
      name: decode.getString<String?>(1),
      initSize: decode.getBigInt<BigInt?>(2),
      useSize: decode.getBigInt<BigInt?>(3),
      maxSize: decode.getBigInt<BigInt?>(4),
      useRate: decode.getDouble<double?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfoMachineInfoMemoryDescInfo;
}

class TronNodeInfoMachineInfoDeadLockThreadInfo extends TronProtoMessage {
  final String? name;

  final String? lockName;

  final String? lockOwner;

  final String? state;

  final BigInt? blockTime;

  final BigInt? waitTime;

  final String? stackTrace;

  const TronNodeInfoMachineInfoDeadLockThreadInfo({
    this.name,
    this.lockName,
    this.lockOwner,
    this.state,
    this.blockTime,
    this.waitTime,
    this.stackTrace,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.int64(6),
        ProtoFieldConfig.string(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    name,
    lockName,
    lockOwner,
    state,
    blockTime,
    waitTime,
    stackTrace,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'name': name,
      'lockName': lockName,
      'lockOwner': lockOwner,
      'state': state,
      'blockTime': config.encodeBigint(blockTime),
      'waitTime': config.encodeBigint(waitTime),
      'stackTrace': stackTrace,
    }.notNullValue;
  }

  factory TronNodeInfoMachineInfoDeadLockThreadInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeInfoMachineInfoDeadLockThreadInfo(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lockName: json.valueAsString<String?>(
        'lockName',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lockOwner: json.valueAsString<String?>(
        'lockOwner',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      state: json.valueAsString<String?>(
        'state',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockTime: json.valueAsBigInt<BigInt?>(
        'blockTime',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      waitTime: json.valueAsBigInt<BigInt?>(
        'waitTime',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      stackTrace: json.valueAsString<String?>(
        'stackTrace',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNodeInfoMachineInfoDeadLockThreadInfo.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeInfoMachineInfoDeadLockThreadInfo(
      name: decode.getString<String?>(1),
      lockName: decode.getString<String?>(2),
      lockOwner: decode.getString<String?>(3),
      state: decode.getString<String?>(4),
      blockTime: decode.getBigInt<BigInt?>(5),
      waitTime: decode.getBigInt<BigInt?>(6),
      stackTrace: decode.getString<String?>(7),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeInfoMachineInfoDeadLockThreadInfo;
}

class TronMetricsInfo extends TronProtoMessage {
  final BigInt? interval;

  final TronMetricsInfoNodeInfo? node;

  final TronMetricsInfoBlockChainInfo? blockchain;

  final TronMetricsInfoNetInfo? net;

  const TronMetricsInfo({this.interval, this.node, this.blockchain, this.net});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [interval, node, blockchain, net];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'interval': config.encodeBigint(interval),
      'node': config.encodeMessage(node),
      'blockchain': config.encodeMessage(blockchain),
      'net': config.encodeMessage(net),
    }.notNullValue;
  }

  factory TronMetricsInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfo(
      interval: json.valueAsBigInt<BigInt?>(
        'interval',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      node: json.valueTo<TronMetricsInfoNodeInfo?, Object>(
        key: 'node',
        parse:
            (v) => TronMetricsInfoNodeInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockchain: json.valueTo<TronMetricsInfoBlockChainInfo?, Object>(
        key: 'blockchain',
        parse:
            (v) => TronMetricsInfoBlockChainInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      net: json.valueTo<TronMetricsInfoNetInfo?, Object>(
        key: 'net',
        parse:
            (v) => TronMetricsInfoNetInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfo(
      interval: decode.getBigInt<BigInt?>(1),
      node: decode.messageTo<TronMetricsInfoNodeInfo?>(
        2,
        (b) => TronMetricsInfoNodeInfo.deserialize(b),
      ),
      blockchain: decode.messageTo<TronMetricsInfoBlockChainInfo?>(
        3,
        (b) => TronMetricsInfoBlockChainInfo.deserialize(b),
      ),
      net: decode.messageTo<TronMetricsInfoNetInfo?>(
        4,
        (b) => TronMetricsInfoNetInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfo;
}

class TronMetricsInfoNodeInfo extends TronProtoMessage {
  final String? ip;

  final int? nodeType;

  final String? version;

  final int? backupStatus;

  const TronMetricsInfoNodeInfo({
    this.ip,
    this.nodeType,
    this.version,
    this.backupStatus,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.int32(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ip, nodeType, version, backupStatus];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ip': ip,
      'nodeType': nodeType,
      'version': version,
      'backupStatus': backupStatus,
    }.notNullValue;
  }

  factory TronMetricsInfoNodeInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNodeInfo(
      ip: json.valueAsString<String?>(
        'ip',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nodeType: json.valueAsInt<int?>(
        'nodeType',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsString<String?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      backupStatus: json.valueAsInt<int?>(
        'backupStatus',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoNodeInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNodeInfo(
      ip: decode.getString<String?>(1),
      nodeType: decode.getInt<int?>(2),
      version: decode.getString<String?>(3),
      backupStatus: decode.getInt<int?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNodeInfo;
}

class TronMetricsInfoBlockChainInfo extends TronProtoMessage {
  final BigInt? headBlockNum;

  final BigInt? headBlockTimestamp;

  final String? headBlockHash;

  final int? forkCount;

  final int? failForkCount;

  final TronMetricsInfoRateInfo? blockProcessTime;

  final TronMetricsInfoRateInfo? tps;

  final int? transactionCacheSize;

  final TronMetricsInfoRateInfo? missedTransaction;

  final List<TronMetricsInfoBlockChainInfoWitness> witnesses;

  final BigInt? failProcessBlockNum;

  final String? failProcessBlockReason;

  final List<TronMetricsInfoBlockChainInfoDupWitness> dupWitness;

  const TronMetricsInfoBlockChainInfo({
    this.headBlockNum,
    this.headBlockTimestamp,
    this.headBlockHash,
    this.forkCount,
    this.failForkCount,
    this.blockProcessTime,
    this.tps,
    this.transactionCacheSize,
    this.missedTransaction,
    this.witnesses = const [],
    this.failProcessBlockNum,
    this.failProcessBlockReason,
    this.dupWitness = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.int32(8),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.repeated(
          fieldNumber: 10,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.string(12),
        ProtoFieldConfig.repeated(
          fieldNumber: 13,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    headBlockNum,
    headBlockTimestamp,
    headBlockHash,
    forkCount,
    failForkCount,
    blockProcessTime,
    tps,
    transactionCacheSize,
    missedTransaction,
    witnesses,
    failProcessBlockNum,
    failProcessBlockReason,
    dupWitness,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'headBlockNum': config.encodeBigint(headBlockNum),
      'headBlockTimestamp': config.encodeBigint(headBlockTimestamp),
      'headBlockHash': headBlockHash,
      'forkCount': forkCount,
      'failForkCount': failForkCount,
      'blockProcessTime': config.encodeMessage(blockProcessTime),
      'tps': config.encodeMessage(tps),
      'transactionCacheSize': transactionCacheSize,
      'missedTransaction': config.encodeMessage(missedTransaction),
      'witnesses': witnesses.map((e) => config.encodeMessage(e)).toList(),
      'failProcessBlockNum': config.encodeBigint(failProcessBlockNum),
      'failProcessBlockReason': failProcessBlockReason,
      'dupWitness': dupWitness.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMetricsInfoBlockChainInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoBlockChainInfo(
      headBlockNum: json.valueAsBigInt<BigInt?>(
        'headBlockNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headBlockTimestamp: json.valueAsBigInt<BigInt?>(
        'headBlockTimestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headBlockHash: json.valueAsString<String?>(
        'headBlockHash',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      forkCount: json.valueAsInt<int?>(
        'forkCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      failForkCount: json.valueAsInt<int?>(
        'failForkCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockProcessTime: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'blockProcessTime',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tps: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'tps',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactionCacheSize: json.valueAsInt<int?>(
        'transactionCacheSize',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      missedTransaction: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'missedTransaction',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      witnesses:
          (json.valueEnsureAsList<dynamic>(
                'witnesses',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronMetricsInfoBlockChainInfoWitness,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronMetricsInfoBlockChainInfoWitness.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      failProcessBlockNum: json.valueAsBigInt<BigInt?>(
        'failProcessBlockNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      failProcessBlockReason: json.valueAsString<String?>(
        'failProcessBlockReason',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      dupWitness:
          (json.valueEnsureAsList<dynamic>(
                'dupWitness',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronMetricsInfoBlockChainInfoDupWitness,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => TronMetricsInfoBlockChainInfoDupWitness.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronMetricsInfoBlockChainInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoBlockChainInfo(
      headBlockNum: decode.getBigInt<BigInt?>(1),
      headBlockTimestamp: decode.getBigInt<BigInt?>(2),
      headBlockHash: decode.getString<String?>(3),
      forkCount: decode.getInt<int?>(4),
      failForkCount: decode.getInt<int?>(5),
      blockProcessTime: decode.messageTo<TronMetricsInfoRateInfo?>(
        6,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      tps: decode.messageTo<TronMetricsInfoRateInfo?>(
        7,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      transactionCacheSize: decode.getInt<int?>(8),
      missedTransaction: decode.messageTo<TronMetricsInfoRateInfo?>(
        9,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      witnesses:
          decode
              .getListOfBytes(10)
              .map((b) => TronMetricsInfoBlockChainInfoWitness.deserialize(b))
              .toList(),
      failProcessBlockNum: decode.getBigInt<BigInt?>(11),
      failProcessBlockReason: decode.getString<String?>(12),
      dupWitness:
          decode
              .getListOfBytes(13)
              .map(
                (b) => TronMetricsInfoBlockChainInfoDupWitness.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoBlockChainInfo;
}

class TronMetricsInfoBlockChainInfoWitness extends TronProtoMessage {
  final String? address;

  final int? version;

  const TronMetricsInfoBlockChainInfoWitness({this.address, this.version});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [address, version];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'address': address, 'version': version}.notNullValue;
  }

  factory TronMetricsInfoBlockChainInfoWitness.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoBlockChainInfoWitness(
      address: json.valueAsString<String?>(
        'address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoBlockChainInfoWitness.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoBlockChainInfoWitness(
      address: decode.getString<String?>(1),
      version: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoBlockChainInfoWitness;
}

class TronMetricsInfoBlockChainInfoDupWitness extends TronProtoMessage {
  final String? address;

  final BigInt? blockNum;

  final int? count;

  const TronMetricsInfoBlockChainInfoDupWitness({
    this.address,
    this.blockNum,
    this.count,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int32(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [address, blockNum, count];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'address': address,
      'blockNum': config.encodeBigint(blockNum),
      'count': count,
    }.notNullValue;
  }

  factory TronMetricsInfoBlockChainInfoDupWitness.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoBlockChainInfoDupWitness(
      address: json.valueAsString<String?>(
        'address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockNum: json.valueAsBigInt<BigInt?>(
        'blockNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      count: json.valueAsInt<int?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoBlockChainInfoDupWitness.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoBlockChainInfoDupWitness(
      address: decode.getString<String?>(1),
      blockNum: decode.getBigInt<BigInt?>(2),
      count: decode.getInt<int?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoBlockChainInfoDupWitness;
}

class TronMetricsInfoRateInfo extends TronProtoMessage {
  final BigInt? count;

  final double? meanRate;

  final double? oneMinuteRate;

  final double? fiveMinuteRate;

  final double? fifteenMinuteRate;

  const TronMetricsInfoRateInfo({
    this.count,
    this.meanRate,
    this.oneMinuteRate,
    this.fiveMinuteRate,
    this.fifteenMinuteRate,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.double(2),
        ProtoFieldConfig.double(3),
        ProtoFieldConfig.double(4),
        ProtoFieldConfig.double(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    count,
    meanRate,
    oneMinuteRate,
    fiveMinuteRate,
    fifteenMinuteRate,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'count': config.encodeBigint(count),
      'meanRate': meanRate,
      'oneMinuteRate': oneMinuteRate,
      'fiveMinuteRate': fiveMinuteRate,
      'fifteenMinuteRate': fifteenMinuteRate,
    }.notNullValue;
  }

  factory TronMetricsInfoRateInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoRateInfo(
      count: json.valueAsBigInt<BigInt?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      meanRate: json.valueAsDouble<double?>(
        'meanRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      oneMinuteRate: json.valueAsDouble<double?>(
        'oneMinuteRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fiveMinuteRate: json.valueAsDouble<double?>(
        'fiveMinuteRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      fifteenMinuteRate: json.valueAsDouble<double?>(
        'fifteenMinuteRate',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoRateInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoRateInfo(
      count: decode.getBigInt<BigInt?>(1),
      meanRate: decode.getDouble<double?>(2),
      oneMinuteRate: decode.getDouble<double?>(3),
      fiveMinuteRate: decode.getDouble<double?>(4),
      fifteenMinuteRate: decode.getDouble<double?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoRateInfo;
}

class TronMetricsInfoNetInfo extends TronProtoMessage {
  final int? errorProtoCount;

  final TronMetricsInfoNetInfoApiInfo? api;

  final int? connectionCount;

  final int? validConnectionCount;

  final TronMetricsInfoRateInfo? tcpInTraffic;

  final TronMetricsInfoRateInfo? tcpOutTraffic;

  final int? disconnectionCount;

  final List<TronMetricsInfoNetInfoDisconnectionDetailInfo> disconnectionDetail;

  final TronMetricsInfoRateInfo? udpInTraffic;

  final TronMetricsInfoRateInfo? udpOutTraffic;

  final TronMetricsInfoNetInfoLatencyInfo? latency;

  const TronMetricsInfoNetInfo({
    this.errorProtoCount,
    this.api,
    this.connectionCount,
    this.validConnectionCount,
    this.tcpInTraffic,
    this.tcpOutTraffic,
    this.disconnectionCount,
    this.disconnectionDetail = const [],
    this.udpInTraffic,
    this.udpOutTraffic,
    this.latency,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.int32(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.message(10),
        ProtoFieldConfig.message(11),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    errorProtoCount,
    api,
    connectionCount,
    validConnectionCount,
    tcpInTraffic,
    tcpOutTraffic,
    disconnectionCount,
    disconnectionDetail,
    udpInTraffic,
    udpOutTraffic,
    latency,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'errorProtoCount': errorProtoCount,
      'api': config.encodeMessage(api),
      'connectionCount': connectionCount,
      'validConnectionCount': validConnectionCount,
      'tcpInTraffic': config.encodeMessage(tcpInTraffic),
      'tcpOutTraffic': config.encodeMessage(tcpOutTraffic),
      'disconnectionCount': disconnectionCount,
      'disconnectionDetail':
          disconnectionDetail.map((e) => config.encodeMessage(e)).toList(),
      'udpInTraffic': config.encodeMessage(udpInTraffic),
      'udpOutTraffic': config.encodeMessage(udpOutTraffic),
      'latency': config.encodeMessage(latency),
    }.notNullValue;
  }

  factory TronMetricsInfoNetInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfo(
      errorProtoCount: json.valueAsInt<int?>(
        'errorProtoCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      api: json.valueTo<TronMetricsInfoNetInfoApiInfo?, Object>(
        key: 'api',
        parse:
            (v) => TronMetricsInfoNetInfoApiInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      connectionCount: json.valueAsInt<int?>(
        'connectionCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      validConnectionCount: json.valueAsInt<int?>(
        'validConnectionCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tcpInTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'tcpInTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      tcpOutTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'tcpOutTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      disconnectionCount: json.valueAsInt<int?>(
        'disconnectionCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      disconnectionDetail:
          (json.valueEnsureAsList<dynamic>(
                'disconnectionDetail',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronMetricsInfoNetInfoDisconnectionDetailInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          TronMetricsInfoNetInfoDisconnectionDetailInfo.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
      udpInTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'udpInTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      udpOutTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'udpOutTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      latency: json.valueTo<TronMetricsInfoNetInfoLatencyInfo?, Object>(
        key: 'latency',
        parse:
            (v) => TronMetricsInfoNetInfoLatencyInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoNetInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfo(
      errorProtoCount: decode.getInt<int?>(1),
      api: decode.messageTo<TronMetricsInfoNetInfoApiInfo?>(
        2,
        (b) => TronMetricsInfoNetInfoApiInfo.deserialize(b),
      ),
      connectionCount: decode.getInt<int?>(3),
      validConnectionCount: decode.getInt<int?>(4),
      tcpInTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        5,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      tcpOutTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        6,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      disconnectionCount: decode.getInt<int?>(7),
      disconnectionDetail:
          decode
              .getListOfBytes(8)
              .map(
                (b) =>
                    TronMetricsInfoNetInfoDisconnectionDetailInfo.deserialize(
                      b,
                    ),
              )
              .toList(),
      udpInTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        9,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      udpOutTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        10,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      latency: decode.messageTo<TronMetricsInfoNetInfoLatencyInfo?>(
        11,
        (b) => TronMetricsInfoNetInfoLatencyInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNetInfo;
}

class TronMetricsInfoNetInfoApiInfo extends TronProtoMessage {
  final TronMetricsInfoRateInfo? qps;

  final TronMetricsInfoRateInfo? failQps;

  final TronMetricsInfoRateInfo? outTraffic;

  final List<TronMetricsInfoNetInfoApiInfoApiDetailInfo> detail;

  const TronMetricsInfoNetInfoApiInfo({
    this.qps,
    this.failQps,
    this.outTraffic,
    this.detail = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [qps, failQps, outTraffic, detail];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'qps': config.encodeMessage(qps),
      'failQps': config.encodeMessage(failQps),
      'outTraffic': config.encodeMessage(outTraffic),
      'detail': detail.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMetricsInfoNetInfoApiInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfoApiInfo(
      qps: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'qps',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      failQps: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'failQps',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      outTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'outTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      detail:
          (json.valueEnsureAsList<dynamic>(
                'detail',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronMetricsInfoNetInfoApiInfoApiDetailInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          TronMetricsInfoNetInfoApiInfoApiDetailInfo.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
    );
  }

  factory TronMetricsInfoNetInfoApiInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfoApiInfo(
      qps: decode.messageTo<TronMetricsInfoRateInfo?>(
        1,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      failQps: decode.messageTo<TronMetricsInfoRateInfo?>(
        2,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      outTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        3,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      detail:
          decode
              .getListOfBytes(4)
              .map(
                (b) =>
                    TronMetricsInfoNetInfoApiInfoApiDetailInfo.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNetInfoApiInfo;
}

class TronMetricsInfoNetInfoApiInfoApiDetailInfo extends TronProtoMessage {
  final String? name;

  final TronMetricsInfoRateInfo? qps;

  final TronMetricsInfoRateInfo? failQps;

  final TronMetricsInfoRateInfo? outTraffic;

  const TronMetricsInfoNetInfoApiInfoApiDetailInfo({
    this.name,
    this.qps,
    this.failQps,
    this.outTraffic,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [name, qps, failQps, outTraffic];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'name': name,
      'qps': config.encodeMessage(qps),
      'failQps': config.encodeMessage(failQps),
      'outTraffic': config.encodeMessage(outTraffic),
    }.notNullValue;
  }

  factory TronMetricsInfoNetInfoApiInfoApiDetailInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfoApiInfoApiDetailInfo(
      name: json.valueAsString<String?>(
        'name',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      qps: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'qps',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      failQps: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'failQps',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      outTraffic: json.valueTo<TronMetricsInfoRateInfo?, Object>(
        key: 'outTraffic',
        parse:
            (v) => TronMetricsInfoRateInfo.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoNetInfoApiInfoApiDetailInfo.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfoApiInfoApiDetailInfo(
      name: decode.getString<String?>(1),
      qps: decode.messageTo<TronMetricsInfoRateInfo?>(
        2,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      failQps: decode.messageTo<TronMetricsInfoRateInfo?>(
        3,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
      outTraffic: decode.messageTo<TronMetricsInfoRateInfo?>(
        4,
        (b) => TronMetricsInfoRateInfo.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNetInfoApiInfoApiDetailInfo;
}

class TronMetricsInfoNetInfoDisconnectionDetailInfo extends TronProtoMessage {
  final String? reason;

  final int? count;

  const TronMetricsInfoNetInfoDisconnectionDetailInfo({
    this.reason,
    this.count,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [reason, count];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'reason': reason, 'count': count}.notNullValue;
  }

  factory TronMetricsInfoNetInfoDisconnectionDetailInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfoDisconnectionDetailInfo(
      reason: json.valueAsString<String?>(
        'reason',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      count: json.valueAsInt<int?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoNetInfoDisconnectionDetailInfo.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfoDisconnectionDetailInfo(
      reason: decode.getString<String?>(1),
      count: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNetInfoDisconnectionDetailInfo;
}

class TronMetricsInfoNetInfoLatencyInfo extends TronProtoMessage {
  final int? top99;

  final int? top95;

  final int? top75;

  final int? totalCount;

  final int? delay1S;

  final int? delay2S;

  final int? delay3S;

  final List<TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo> detail;

  const TronMetricsInfoNetInfoLatencyInfo({
    this.top99,
    this.top95,
    this.top75,
    this.totalCount,
    this.delay1S,
    this.delay2S,
    this.delay3S,
    this.detail = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.int32(6),
        ProtoFieldConfig.int32(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    top99,
    top95,
    top75,
    totalCount,
    delay1S,
    delay2S,
    delay3S,
    detail,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'top99': top99,
      'top95': top95,
      'top75': top75,
      'totalCount': totalCount,
      'delay1S': delay1S,
      'delay2S': delay2S,
      'delay3S': delay3S,
      'detail': detail.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronMetricsInfoNetInfoLatencyInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfoLatencyInfo(
      top99: json.valueAsInt<int?>(
        'top99',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      top95: json.valueAsInt<int?>(
        'top95',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      top75: json.valueAsInt<int?>(
        'top75',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalCount: json.valueAsInt<int?>(
        'totalCount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay1S: json.valueAsInt<int?>(
        'delay1S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay2S: json.valueAsInt<int?>(
        'delay2S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay3S: json.valueAsInt<int?>(
        'delay3S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      detail:
          (json.valueEnsureAsList<dynamic>(
                'detail',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) =>
                          TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                ),
              )
              .toList(),
    );
  }

  factory TronMetricsInfoNetInfoLatencyInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfoLatencyInfo(
      top99: decode.getInt<int?>(1),
      top95: decode.getInt<int?>(2),
      top75: decode.getInt<int?>(3),
      totalCount: decode.getInt<int?>(4),
      delay1S: decode.getInt<int?>(5),
      delay2S: decode.getInt<int?>(6),
      delay3S: decode.getInt<int?>(7),
      detail:
          decode
              .getListOfBytes(8)
              .map(
                (b) =>
                    TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo.deserialize(
                      b,
                    ),
              )
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMetricsInfoNetInfoLatencyInfo;
}

class TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo
    extends TronProtoMessage {
  final String? witness;

  final int? top99;

  final int? top95;

  final int? top75;

  final int? count;

  final int? delay1S;

  final int? delay2S;

  final int? delay3S;

  const TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo({
    this.witness,
    this.top99,
    this.top95,
    this.top75,
    this.count,
    this.delay1S,
    this.delay2S,
    this.delay3S,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1),
        ProtoFieldConfig.int32(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.int32(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.int32(6),
        ProtoFieldConfig.int32(7),
        ProtoFieldConfig.int32(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    witness,
    top99,
    top95,
    top75,
    count,
    delay1S,
    delay2S,
    delay3S,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'witness': witness,
      'top99': top99,
      'top95': top95,
      'top75': top75,
      'count': count,
      'delay1S': delay1S,
      'delay2S': delay2S,
      'delay3S': delay3S,
    }.notNullValue;
  }

  factory TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo(
      witness: json.valueAsString<String?>(
        'witness',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      top99: json.valueAsInt<int?>(
        'top99',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      top95: json.valueAsInt<int?>(
        'top95',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      top75: json.valueAsInt<int?>(
        'top75',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      count: json.valueAsInt<int?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay1S: json.valueAsInt<int?>(
        'delay1S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay2S: json.valueAsInt<int?>(
        'delay2S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      delay3S: json.valueAsInt<int?>(
        'delay3S',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMetricsInfoNetInfoLatencyInfoLatencyDetailInfo(
      witness: decode.getString<String?>(1),
      top99: decode.getInt<int?>(2),
      top95: decode.getInt<int?>(3),
      top75: decode.getInt<int?>(4),
      count: decode.getInt<int?>(5),
      delay1S: decode.getInt<int?>(6),
      delay2S: decode.getInt<int?>(7),
      delay3S: decode.getInt<int?>(8),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolMetricsInfoNetInfoLatencyInfoLatencyDetailInfo;
}

class TronPBFTMessage extends TronProtoMessage {
  final TronPBFTMessageRaw? rawData;

  final List<int>? signature;

  const TronPBFTMessage({this.rawData, this.signature});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [rawData, signature];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'raw_data': config.encodeMessage(rawData),
      'signature': config.encodeBinary(signature),
    }.notNullValue;
  }

  factory TronPBFTMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPBFTMessage(
      rawData: json.valueTo<TronPBFTMessageRaw?, Object>(
        key: 'raw_data',
        parse:
            (v) => TronPBFTMessageRaw.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronPBFTMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPBFTMessage(
      rawData: decode.messageTo<TronPBFTMessageRaw?>(
        1,
        (b) => TronPBFTMessageRaw.deserialize(b),
      ),
      signature: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPBFTMessage;
}

class TronPBFTMessageRaw extends TronProtoMessage {
  final TronPBFTMessageMsgType? msgType;

  final TronPBFTMessageDataType? dataType;

  final BigInt? viewN;

  final BigInt? epoch;

  final List<int>? data;

  const TronPBFTMessageRaw({
    this.msgType,
    this.dataType,
    this.viewN,
    this.epoch,
    this.data,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.bytes(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [msgType, dataType, viewN, epoch, data];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'msg_type': config.encodeEnum(msgType),
      'data_type': config.encodeEnum(dataType),
      'view_n': config.encodeBigint(viewN),
      'epoch': config.encodeBigint(epoch),
      'data': config.encodeBinary(data),
    }.notNullValue;
  }

  factory TronPBFTMessageRaw.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPBFTMessageRaw(
      msgType: json.valueTo<TronPBFTMessageMsgType?, Object?>(
        key: 'msg_type',
        parse: (v) => TronPBFTMessageMsgType.from(v),
      ),
      dataType: json.valueTo<TronPBFTMessageDataType?, Object?>(
        key: 'data_type',
        parse: (v) => TronPBFTMessageDataType.from(v),
      ),
      viewN: json.valueAsBigInt<BigInt?>(
        'view_n',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronPBFTMessageRaw.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPBFTMessageRaw(
      msgType: decode.getEnum<TronPBFTMessageMsgType?>(
        1,
        TronPBFTMessageMsgType.values,
      ),
      dataType: decode.getEnum<TronPBFTMessageDataType?>(
        2,
        TronPBFTMessageDataType.values,
      ),
      viewN: decode.getBigInt<BigInt?>(3),
      epoch: decode.getBigInt<BigInt?>(4),
      data: decode.getBytes<List<int>?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPBFTMessageRaw;
}

class TronPBFTCommitResult extends TronProtoMessage {
  final List<int>? data;

  final List<List<int>> signature;

  const TronPBFTCommitResult({this.data, this.signature = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [data, signature];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'data': config.encodeBinary(data),
      'signature': signature.map((e) => config.encodeBinary(e)).toList(),
    }.notNullValue;
  }

  factory TronPBFTCommitResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPBFTCommitResult(
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
      signature:
          (json.valueEnsureAsList<dynamic>(
            'signature',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory TronPBFTCommitResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPBFTCommitResult(
      data: decode.getBytes<List<int>?>(1),
      signature: decode.getListOfBytes(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPBFTCommitResult;
}

class TronSrl extends TronProtoMessage {
  final List<List<int>> srAddress;

  const TronSrl({this.srAddress = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [srAddress];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'srAddress': srAddress.map((e) => config.encodeBinary(e)).toList(),
    }.notNullValue;
  }

  factory TronSrl.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSrl(
      srAddress:
          (json.valueEnsureAsList<dynamic>(
            'srAddress',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory TronSrl.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSrl(srAddress: decode.getListOfBytes(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSrl;
}

class TronWalletGetAccount extends TronProtoMessage
    with ITronProtoServiceMessage<TronAccount> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccount;

  const TronWalletGetAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAccount;
  @override
  TronAccount onServiceResponse(List<int> bytes) {
    return TronAccount.deserialize(bytes);
  }

  @override
  TronAccount onServiceResponseJson(Map<String, dynamic> json) {
    return TronAccount.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAccountById extends TronProtoMessage
    with ITronProtoServiceMessage<TronAccount> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccountById;

  const TronWalletGetAccountById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccountById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccountById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAccountById;
  @override
  TronAccount onServiceResponse(List<int> bytes) {
    return TronAccount.deserialize(bytes);
  }

  @override
  TronAccount onServiceResponseJson(Map<String, dynamic> json) {
    return TronAccount.fromJson(json, config: jsonConfig);
  }
}

class TronWalletBroadcastTransaction extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronReturn> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTransaction? broadcastTransaction;

  const TronWalletBroadcastTransaction({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.broadcastTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      broadcastTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => broadcastTransaction?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(broadcastTransaction) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletBroadcastTransaction;
  @override
  protocol_api.TronReturn onServiceResponse(List<int> bytes) {
    return protocol_api.TronReturn.deserialize(bytes);
  }

  @override
  protocol_api.TronReturn onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_api.TronReturn.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetMarketPriceByPair extends TronProtoMessage
    with ITronProtoServiceMessage<TronMarketPriceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronMarketOrderPair? getMarketPriceByPair;

  const TronWalletGetMarketPriceByPair({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketPriceByPair,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketPriceByPair?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketPriceByPair?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketPriceByPair) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMarketPriceByPair;
  @override
  TronMarketPriceList onServiceResponse(List<int> bytes) {
    return TronMarketPriceList.deserialize(bytes);
  }

  @override
  TronMarketPriceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronMarketPriceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetMarketOrderListByPair extends TronProtoMessage
    with ITronProtoServiceMessage<TronMarketOrderList> {
  final TronProtoJsonConfig jsonConfig;

  final TronMarketOrderPair? getMarketOrderListByPair;

  const TronWalletGetMarketOrderListByPair({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderListByPair,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderListByPair?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderListByPair?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderListByPair) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMarketOrderListByPair;
  @override
  TronMarketOrderList onServiceResponse(List<int> bytes) {
    return TronMarketOrderList.deserialize(bytes);
  }

  @override
  TronMarketOrderList onServiceResponseJson(Map<String, dynamic> json) {
    return TronMarketOrderList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAssetIssueByAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAssetIssueByAccount;

  const TronWalletGetAssetIssueByAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueByAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueByAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueByAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueByAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAssetIssueByAccount;
  @override
  protocol_api.TronAssetIssueList onServiceResponse(List<int> bytes) {
    return protocol_api.TronAssetIssueList.deserialize(bytes);
  }

  @override
  protocol_api.TronAssetIssueList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAccountNet extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronAccountNetMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccountNet;

  const TronWalletGetAccountNet({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccountNet,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountNet?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountNet?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccountNet) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAccountNet;
  @override
  protocol_api.TronAccountNetMessage onServiceResponse(List<int> bytes) {
    return protocol_api.TronAccountNetMessage.deserialize(bytes);
  }

  @override
  protocol_api.TronAccountNetMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronAccountNetMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetAccountResource extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_contracts.TronAccountResourceMessage
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccountResource;

  const TronWalletGetAccountResource({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccountResource,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountResource?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountResource?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccountResource) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAccountResource;
  @override
  protocol_contracts.TronAccountResourceMessage onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_contracts.TronAccountResourceMessage.deserialize(bytes);
  }

  @override
  protocol_contracts.TronAccountResourceMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronAccountResourceMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetTransactionSignWeight extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionSignWeight> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTransaction? getTransactionSignWeight;

  const TronWalletGetTransactionSignWeight({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionSignWeight,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionSignWeight?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionSignWeight?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionSignWeight) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionSignWeight;
  @override
  protocol_api.TronTransactionSignWeight onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionSignWeight.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionSignWeight onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionSignWeight.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetTransactionApprovedList extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionApprovedList> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTransaction? getTransactionApprovedList;

  const TronWalletGetTransactionApprovedList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionApprovedList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionApprovedList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionApprovedList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionApprovedList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionApprovedList;
  @override
  protocol_api.TronTransactionApprovedList onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionApprovedList.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionApprovedList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionApprovedList.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetShieldTransactionHash extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final protocol_contracts.TronTransaction? getShieldTransactionHash;

  const TronWalletGetShieldTransactionHash({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getShieldTransactionHash,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getShieldTransactionHash?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getShieldTransactionHash?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getShieldTransactionHash) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetShieldTransactionHash;
  @override
  protocol_api.TronBytesMessage onServiceResponse(List<int> bytes) {
    return protocol_api.TronBytesMessage.deserialize(bytes);
  }

  @override
  protocol_api.TronBytesMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateCommonTransaction extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_api.TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// end for shieldedTransaction
  final protocol_contracts.TronTransaction? createCommonTransaction;

  const TronWalletCreateCommonTransaction({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createCommonTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createCommonTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createCommonTransaction?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createCommonTransaction) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateCommonTransaction;
  @override
  protocol_api.TronTransactionExtention onServiceResponse(List<int> bytes) {
    return protocol_api.TronTransactionExtention.deserialize(bytes);
  }

  @override
  protocol_api.TronTransactionExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_api.TronTransactionExtention.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetAccount extends TronProtoMessage
    with ITronProtoServiceMessage<TronAccount> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccount;

  const TronWalletSolidityGetAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAccount;
  @override
  TronAccount onServiceResponse(List<int> bytes) {
    return TronAccount.deserialize(bytes);
  }

  @override
  TronAccount onServiceResponseJson(Map<String, dynamic> json) {
    return TronAccount.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetAccountById extends TronProtoMessage
    with ITronProtoServiceMessage<TronAccount> {
  final TronProtoJsonConfig jsonConfig;

  final TronAccount? getAccountById;

  const TronWalletSolidityGetAccountById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAccountById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAccountById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAccountById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAccountById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAccountById;
  @override
  TronAccount onServiceResponse(List<int> bytes) {
    return TronAccount.deserialize(bytes);
  }

  @override
  TronAccount onServiceResponseJson(Map<String, dynamic> json) {
    return TronAccount.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMarketPriceByPair extends TronProtoMessage
    with ITronProtoServiceMessage<TronMarketPriceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronMarketOrderPair? getMarketPriceByPair;

  const TronWalletSolidityGetMarketPriceByPair({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketPriceByPair,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketPriceByPair?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketPriceByPair?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketPriceByPair) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMarketPriceByPair;
  @override
  TronMarketPriceList onServiceResponse(List<int> bytes) {
    return TronMarketPriceList.deserialize(bytes);
  }

  @override
  TronMarketPriceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronMarketPriceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMarketOrderListByPair extends TronProtoMessage
    with ITronProtoServiceMessage<TronMarketOrderList> {
  final TronProtoJsonConfig jsonConfig;

  final TronMarketOrderPair? getMarketOrderListByPair;

  const TronWalletSolidityGetMarketOrderListByPair({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderListByPair,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderListByPair?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderListByPair?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderListByPair) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMarketOrderListByPair;
  @override
  TronMarketOrderList onServiceResponse(List<int> bytes) {
    return TronMarketOrderList.deserialize(bytes);
  }

  @override
  TronMarketOrderList onServiceResponseJson(Map<String, dynamic> json) {
    return TronMarketOrderList.fromJson(json, config: jsonConfig);
  }
}
