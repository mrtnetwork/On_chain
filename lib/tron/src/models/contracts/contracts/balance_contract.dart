import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/proto_messages/protocol/src/common.dart"
    as protocol_common;
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronFreezeBalanceContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? frozenBalance;

  final BigInt? frozenDuration;

  final protocol_common.TronResourceCode? resource;

  final TronAddress? receiverAddress;

  const TronFreezeBalanceContract({
    required this.ownerAddress,
    this.receiverAddress,
    this.frozenBalance,
    this.frozenDuration,
    this.resource,
  }) : super(TronTransactionContractContractType.freezeBalanceContract);

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
        ProtoFieldConfig.enumType(10),
        ProtoFieldConfig.bytes(15),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    frozenBalance,
    frozenDuration,
    resource,
    receiverAddress?.toBytes(),
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'frozen_balance': config.encodeBigint(frozenBalance),
      'frozen_duration': config.encodeBigint(frozenDuration),
      'resource': resource?.protoName,
      'receiver_address': receiverAddress?.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronFreezeBalanceContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronFreezeBalanceContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      frozenBalance: json.valueAsBigInt<BigInt?>(
        'frozen_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      frozenDuration: json.valueAsBigInt<BigInt?>(
        'frozen_duration',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverAddress: json.valueTo<TronAddress?, String>(
        key: "receiver_address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronFreezeBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronFreezeBalanceContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      frozenBalance: decode.getBigInt<BigInt?>(2),
      frozenDuration: decode.getBigInt<BigInt?>(3),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        10,
        protocol_common.TronResourceCode.values,
      ),
      receiverAddress: decode.bytesTo(15, TronAddress.fromBytes),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolFreezeBalanceContract;
}

class TronUnfreezeBalanceContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final protocol_common.TronResourceCode? resource;

  final TronAddress? receiverAddress;

  const TronUnfreezeBalanceContract({
    required this.ownerAddress,
    this.resource,
    this.receiverAddress,
  }) : super(TronTransactionContractContractType.unfreezeBalanceContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.enumType(10),
        ProtoFieldConfig.bytes(15),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    resource,
    receiverAddress?.toBytes(),
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'resource': resource?.protoName,
      'receiver_address': receiverAddress?.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronUnfreezeBalanceContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUnfreezeBalanceContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverAddress: json.valueTo<TronAddress?, String>(
        key: 'receiver_address',
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUnfreezeBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUnfreezeBalanceContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        10,
        protocol_common.TronResourceCode.values,
      ),
      receiverAddress: decode.bytesTo<TronAddress?>(15, TronAddress.fromBytes),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUnfreezeBalanceContract;
}

class TronWithdrawBalanceContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  const TronWithdrawBalanceContract({required this.ownerAddress})
    : super(TronTransactionContractContractType.withdrawBalanceContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronWithdrawBalanceContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWithdrawBalanceContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronWithdrawBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWithdrawBalanceContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWithdrawBalanceContract;
}

class TronTransferContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final TronAddress toAddress;

  final BigInt? amount;

  @override
  BigInt get trxAmount => amount ?? super.trxAmount;

  const TronTransferContract({
    required this.ownerAddress,
    required this.toAddress,
    this.amount,
  }) : super(TronTransactionContractContractType.transferContract);

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    toAddress.toBytes(),
    amount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'to_address': toAddress.toAddress(config.visible),
      'amount': config.encodeBigint(amount),
    }.notNullValue;
  }

  factory TronTransferContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransferContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAddress: TronAddress(
        json.valueAsString(
          "to_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransferContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransferContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      toAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(2)),
      amount: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransferContract;
}

class TronFreezeBalanceV2Contract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? frozenBalance;

  final protocol_common.TronResourceCode? resource;

  const TronFreezeBalanceV2Contract({
    required this.ownerAddress,
    this.frozenBalance,
    this.resource,
  }) : super(TronTransactionContractContractType.freezeBalanceV2Contract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.enumType(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    frozenBalance,
    resource,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'frozen_balance': config.encodeBigint(frozenBalance),
      'resource': resource?.protoName,
    }.notNullValue;
  }

  factory TronFreezeBalanceV2Contract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronFreezeBalanceV2Contract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      frozenBalance: json.valueAsBigInt<BigInt?>(
        'frozen_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronFreezeBalanceV2Contract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronFreezeBalanceV2Contract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      frozenBalance: decode.getBigInt<BigInt?>(2),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        3,
        protocol_common.TronResourceCode.values,
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolFreezeBalanceV2Contract;
}

class TronUnfreezeBalanceV2Contract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? unfreezeBalance;

  final protocol_common.TronResourceCode? resource;

  const TronUnfreezeBalanceV2Contract({
    required this.ownerAddress,
    this.unfreezeBalance,
    this.resource,
  }) : super(TronTransactionContractContractType.unfreezeBalanceV2Contract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.enumType(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    unfreezeBalance,
    resource,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'unfreeze_balance': config.encodeBigint(unfreezeBalance),
      'resource': resource?.protoName,
    }.notNullValue;
  }

  factory TronUnfreezeBalanceV2Contract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUnfreezeBalanceV2Contract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      unfreezeBalance: json.valueAsBigInt<BigInt?>(
        'unfreeze_balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUnfreezeBalanceV2Contract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUnfreezeBalanceV2Contract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      unfreezeBalance: decode.getBigInt<BigInt?>(2),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        3,
        protocol_common.TronResourceCode.values,
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUnfreezeBalanceV2Contract;
}

class TronWithdrawExpireUnfreezeContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  const TronWithdrawExpireUnfreezeContract({required this.ownerAddress})
    : super(TronTransactionContractContractType.withdrawExpireUnfreezeContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronWithdrawExpireUnfreezeContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWithdrawExpireUnfreezeContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronWithdrawExpireUnfreezeContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWithdrawExpireUnfreezeContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWithdrawExpireUnfreezeContract;
}

class TronDelegateResourceContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final protocol_common.TronResourceCode? resource;

  final BigInt? balance;

  final TronAddress? receiverAddress;

  final bool? lock;

  final BigInt? lockPeriod;

  const TronDelegateResourceContract({
    required this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
    this.lock,
    this.lockPeriod,
  }) : super(TronTransactionContractContractType.delegateResourceContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bool(5),
        ProtoFieldConfig.int64(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    resource,
    balance,
    receiverAddress?.toBytes(),
    lock,
    lockPeriod,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'resource': resource?.protoName,
      'balance': config.encodeBigint(balance),
      'receiver_address': receiverAddress?.toAddress(config.visible),
      'lock': lock,
      'lock_period': config.encodeBigint(lockPeriod),
    }.notNullValue;
  }

  factory TronDelegateResourceContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDelegateResourceContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverAddress: json.valueTo<TronAddress?, String>(
        key: 'receiver_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lock: json.valueAsBool<bool?>(
        'lock',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      lockPeriod: json.valueAsBigInt<BigInt?>(
        'lock_period',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDelegateResourceContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDelegateResourceContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        2,
        protocol_common.TronResourceCode.values,
      ),
      balance: decode.getBigInt<BigInt?>(3),
      receiverAddress: decode.bytesTo<TronAddress?>(4, TronAddress.fromBytes),
      lock: decode.getBool<bool?>(5),
      lockPeriod: decode.getBigInt<BigInt?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDelegateResourceContract;
}

class TronUnDelegateResourceContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final protocol_common.TronResourceCode? resource;

  final BigInt? balance;

  final TronAddress? receiverAddress;

  const TronUnDelegateResourceContract({
    required this.ownerAddress,
    this.resource,
    this.balance,
    this.receiverAddress,
  }) : super(TronTransactionContractContractType.unDelegateResourceContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    resource,
    balance,
    receiverAddress?.toBytes(),
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'resource': resource?.protoName,
      'balance': config.encodeBigint(balance),
      'receiver_address': receiverAddress?.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronUnDelegateResourceContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronUnDelegateResourceContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      resource: json.valueTo<protocol_common.TronResourceCode?, Object?>(
        key: 'resource',
        parse: (v) => protocol_common.TronResourceCode.from(v),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      balance: json.valueAsBigInt<BigInt?>(
        'balance',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      receiverAddress: json.valueTo<TronAddress?, String>(
        key: 'receiver_address',

        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronUnDelegateResourceContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronUnDelegateResourceContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      resource: decode.getEnum<protocol_common.TronResourceCode?>(
        2,
        protocol_common.TronResourceCode.values,
      ),
      balance: decode.getBigInt<BigInt?>(3),
      receiverAddress: decode.bytesTo<TronAddress?>(4, TronAddress.fromBytes),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolUnDelegateResourceContract;
}

class TronCancelAllUnfreezeV2Contract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  const TronCancelAllUnfreezeV2Contract({required this.ownerAddress})
    : super(TronTransactionContractContractType.cancelAllUnfreezeV2Contract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes()];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
    }.notNullValue;
  }

  factory TronCancelAllUnfreezeV2Contract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCancelAllUnfreezeV2Contract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronCancelAllUnfreezeV2Contract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCancelAllUnfreezeV2Contract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCancelAllUnfreezeV2Contract;
}
