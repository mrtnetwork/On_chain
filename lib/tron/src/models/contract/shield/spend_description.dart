import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class SpendDescription extends TronProtocolBufferImpl {
  /// Create a new [SpendDescription] instance by parsing a JSON map.
  factory SpendDescription.fromJson(Map<String, dynamic> json) {
    return SpendDescription(
      valueCommitment: BytesUtils.tryFromHexString(json['value_commitment']),
      anchor: BytesUtils.tryFromHexString(json['anchor']),
      nullifier: BytesUtils.tryFromHexString(json['nullifier']),
      rk: BytesUtils.tryFromHexString(json['rk']),
      zkproof: BytesUtils.tryFromHexString(json['zkproof']),
      spendAuthoritySignature:
          BytesUtils.tryFromHexString(json['spend_authority_signature']),
    );
  }

  /// Create a new [SpendDescription] instance with specified parameters.
  SpendDescription(
      {List<int>? valueCommitment,
      List<int>? anchor,
      List<int>? nullifier,
      List<int>? rk,
      List<int>? zkproof,
      List<int>? spendAuthoritySignature})
      : valueCommitment =
            BytesUtils.tryToBytes(valueCommitment, unmodifiable: true),
        anchor = BytesUtils.tryToBytes(anchor, unmodifiable: true),
        nullifier = BytesUtils.tryToBytes(nullifier, unmodifiable: true),
        rk = BytesUtils.tryToBytes(rk, unmodifiable: true),
        spendAuthoritySignature =
            BytesUtils.tryToBytes(spendAuthoritySignature, unmodifiable: true),
        zkproof = BytesUtils.tryToBytes(zkproof, unmodifiable: true);
  factory SpendDescription.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return SpendDescription(
        valueCommitment: decode.getField(1),
        anchor: decode.getField(2),
        nullifier: decode.getField(3),
        rk: decode.getField(4),
        zkproof: decode.getField(5),
        spendAuthoritySignature: decode.getField(6));
  }
  final List<int>? valueCommitment;
  final List<int>? anchor;
  final List<int>? nullifier;
  final List<int>? rk;
  final List<int>? zkproof;
  final List<int>? spendAuthoritySignature;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  List get values => [
        valueCommitment,
        anchor,
        nullifier,
        rk,
        zkproof,
        spendAuthoritySignature
      ];

  /// Convert the [SpendDescription] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'value_commitment': BytesUtils.tryToHexString(valueCommitment),
      'anchor': BytesUtils.tryToHexString(anchor),
      'nullifier': BytesUtils.tryToHexString(nullifier),
      'rk': BytesUtils.tryToHexString(rk),
      'zkproof': BytesUtils.tryToHexString(zkproof),
      'spend_authority_signature':
          BytesUtils.tryToHexString(spendAuthoritySignature),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [SpendDescription] object to its string representation.
  @override
  String toString() {
    return 'SpendDescription{$toJson()}';
  }
}
