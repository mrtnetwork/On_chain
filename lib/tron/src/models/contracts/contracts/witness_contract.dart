import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

class TronVoteWitnessContractVote extends TronProtoMessage {
  final TronAddress? voteAddress;

  final BigInt? voteCount;

  const TronVoteWitnessContractVote({this.voteAddress, this.voteCount});

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
      'vote_address': voteAddress?.toAddress(config.visible),
      'vote_count': config.encodeBigint(voteCount),
    }.notNullValue;
  }

  factory TronVoteWitnessContractVote.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronVoteWitnessContractVote(
      voteAddress: json.valueTo<TronAddress?, String>(
        key: "vote_address",
        parse: TronAddress.new,
        normalizeKeyLookup: config.normalizeKeys,
      ),
      voteCount: json.valueAsBigInt<BigInt?>(
        'vote_count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronVoteWitnessContractVote.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronVoteWitnessContractVote(
      voteAddress: decode.bytesTo<TronAddress?>(1, TronAddress.fromBytes),
      voteCount: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolVoteWitnessContractVote;
}

class TronWitnessCreateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? url;

  TronWitnessCreateContract({required this.ownerAddress, List<int>? url})
    : url = url?.asImmutableBytes,
      super(TronTransactionContractContractType.witnessCreateContract);

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
  List<Object?> get protoValues => [ownerAddress.toBytes(), url];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'url': config.encodeBinary(url),
    }.notNullValue;
  }

  factory TronWitnessCreateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWitnessCreateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      url: json.valueAsBytes<List<int>?>(
        'url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronWitnessCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWitnessCreateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      url: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWitnessCreateContract;
}

class TronWitnessUpdateContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final BuBytes? updateUrl;

  TronWitnessUpdateContract({required this.ownerAddress, List<int>? updateUrl})
    : updateUrl = updateUrl?.asImmutableBytes,
      super(TronTransactionContractContractType.witnessUpdateContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(12)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes(), updateUrl];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'update_url': config.encodeBinary(updateUrl),
    }.notNullValue;
  }

  factory TronWitnessUpdateContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWitnessUpdateContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      updateUrl: json.valueAsBytes<List<int>?>(
        'update_url',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronWitnessUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWitnessUpdateContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      updateUrl: decode.getBytes<List<int>?>(12),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWitnessUpdateContract;
}

class TronVoteWitnessContract extends ITronContract {
  @override
  final TronAddress ownerAddress;

  final List<TronVoteWitnessContractVote> votes;

  final bool? support;

  const TronVoteWitnessContract({
    required this.ownerAddress,
    this.votes = const [],
    this.support,
  }) : super(TronTransactionContractContractType.voteWitnessContract);

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
        ProtoFieldConfig.bool(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress.toBytes(), votes, support];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': ownerAddress.toAddress(config.visible),
      'votes': votes.map(config.encodeMessage).toList(),
      'support': support,
    }.notNullValue;
  }

  factory TronVoteWitnessContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronVoteWitnessContract(
      ownerAddress: TronAddress(
        json.valueAsString(
          "owner_address",
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      votes:
          (json.valueEnsureAsList<dynamic>(
                'votes',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronVoteWitnessContractVote,
                  Map<String, dynamic>
                >(
                  value: e,
                  parse: (v) => TronVoteWitnessContractVote.fromJson(v),
                ),
              )
              .toList(),
      support: json.valueAsBool<bool?>(
        'support',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronVoteWitnessContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronVoteWitnessContract(
      ownerAddress: TronAddress.fromBytes(decode.getBytes<List<int>>(1)),
      votes:
          decode
              .getListOfBytes(2)
              .map((b) => TronVoteWitnessContractVote.deserialize(b))
              .toList(),
      support: decode.getBool<bool?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolVoteWitnessContract;
}
