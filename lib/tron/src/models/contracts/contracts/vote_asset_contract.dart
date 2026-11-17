import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

class TronVoteAssetContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final List<TronAddress> voteAddress;

  final bool? support;

  final int? count;

  const TronVoteAssetContract({
    required this.ownerAddress,
    this.voteAddress = const [],
    this.support,
    this.count,
  }) : super(TronTransactionContractContractType.voteAssetContract);

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
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.int32(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ownerAddress.toBytes(),
    voteAddress.map((e) => e.toBytes()).toList(),
    support,
    count,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'vote_address':
          voteAddress.map((e) => e.toAddress(config.visible)).toList(),
      'support': support,
      'count': count,
    }.notNullValue;
  }

  factory TronVoteAssetContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronVoteAssetContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      voteAddress:
          (json.valueEnsureAsList<String>(
            'vote_address',
            onMissing: () => [],
          )).map((e) => TronAddress(e)).toList(),
      support: json.valueAsBool<bool?>(
        'support',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      count: json.valueAsInt<int?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronVoteAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronVoteAssetContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      voteAddress: decode.getListOfBytes(2).map(TronAddress.fromBytes).toList(),
      support: decode.getBool<bool?>(3),
      count: decode.getInt<int?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolVoteAssetContract;
}
