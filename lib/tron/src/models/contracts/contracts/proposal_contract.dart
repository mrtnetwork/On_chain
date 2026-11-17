import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronProposalApproveContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? proposalId;

  final bool? isAddApproval;

  const TronProposalApproveContract({
    required this.ownerAddress,
    this.proposalId,
    this.isAddApproval,
  }) : super(TronTransactionContractContractType.proposalApproveContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    proposalId,
    isAddApproval,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'proposal_id': config.encodeBigint(proposalId),
      'is_add_approval': isAddApproval,
    }.notNullValue;
  }

  factory TronProposalApproveContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronProposalApproveContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      proposalId: json.valueAsBigInt<BigInt?>(
        'proposal_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isAddApproval: json.valueAsBool<bool?>(
        'is_add_approval',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronProposalApproveContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronProposalApproveContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      proposalId: decode.getBigInt<BigInt?>(2),
      isAddApproval: decode.getBool<bool?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolProposalApproveContract;
}

/// add or remove approval
class TronProposalCreateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final Map<BigInt, BigInt> parameters;

  const TronProposalCreateContract({
    required this.ownerAddress,
    this.parameters = const {},
  }) : super(TronTransactionContractContractType.proposalCreateContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.map(
          fieldNumber: 2,
          keyType: ProtoFieldType.int64,
          valueType: ProtoFieldType.int64,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes(), parameters];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'parameters': parameters.map(
        (k, v) => MapEntry(config.encodeBigint(k), config.encodeBigint(v)),
      ),
    }.notNullValue;
  }

  factory TronProposalCreateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronProposalCreateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      parameters: (json.valueAsMap<Map<dynamic, dynamic>>(
        'parameters',
        normalizeKeyLookup: config.normalizeKeys,
      )).map(
        (k, v) => MapEntry(
          JsonParser.valueAsBigInt<BigInt>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
    );
  }

  factory TronProposalCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronProposalCreateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      parameters: decode.getMap<BigInt, BigInt>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolProposalCreateContract;
}

class TronProposalDeleteContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BigInt? proposalId;

  const TronProposalDeleteContract({
    required this.ownerAddress,
    this.proposalId,
  }) : super(TronTransactionContractContractType.proposalDeleteContract);

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
  List<Object?> get protoValues => [ownerAddress.toBytes(), proposalId];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'proposal_id': config.encodeBigint(proposalId),
    }.notNullValue;
  }

  factory TronProposalDeleteContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronProposalDeleteContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      proposalId: json.valueAsBigInt<BigInt?>(
        'proposal_id',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronProposalDeleteContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronProposalDeleteContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      proposalId: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolProposalDeleteContract;
}
