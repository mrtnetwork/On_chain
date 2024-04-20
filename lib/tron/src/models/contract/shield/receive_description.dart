import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class ReceiveDescription extends TronProtocolBufferImpl {
  /// Create a new [ReceiveDescription] instance by parsing a JSON map.
  factory ReceiveDescription.fromJson(Map<String, dynamic> json) {
    return ReceiveDescription(
      valueCommitment: BytesUtils.tryFromHexString(json["value_commitment"]),
      noteCommitment: BytesUtils.tryFromHexString(json["note_commitment"]),
      epk: BytesUtils.tryFromHexString(json["epk"]),
      cEnc: BytesUtils.tryFromHexString(json["c_enc"]),
      cOut: BytesUtils.tryFromHexString(json["c_out"]),
      zkproof: BytesUtils.tryFromHexString(json["zkproof"]),
    );
  }

  /// Create a new [ReceiveDescription] instance with specified parameters.
  ReceiveDescription(
      {List<int>? valueCommitment,
      List<int>? noteCommitment,
      List<int>? epk,
      List<int>? cEnc,
      List<int>? cOut,
      List<int>? zkproof})
      : valueCommitment =
            BytesUtils.tryToBytes(valueCommitment, unmodifiable: true),
        noteCommitment =
            BytesUtils.tryToBytes(noteCommitment, unmodifiable: true),
        epk = BytesUtils.tryToBytes(epk, unmodifiable: true),
        cEnc = BytesUtils.tryToBytes(cEnc, unmodifiable: true),
        cOut = BytesUtils.tryToBytes(cOut, unmodifiable: true),
        zkproof = BytesUtils.tryToBytes(zkproof, unmodifiable: true);
  factory ReceiveDescription.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ReceiveDescription(
        valueCommitment: decode.getField(1),
        noteCommitment: decode.getField(2),
        epk: decode.getField(3),
        cEnc: decode.getField(4),
        cOut: decode.getField(5),
        zkproof: decode.getField(6));
  }

  final List<int>? valueCommitment;
  final List<int>? noteCommitment;
  final List<int>? epk;
  final List<int>? cEnc;
  final List<int>? cOut;
  final List<int>? zkproof;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  List get values =>
      [valueCommitment, noteCommitment, epk, cEnc, cOut, zkproof];

  /// Convert the [ReceiveDescription] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "value_commitment": BytesUtils.tryToHexString(valueCommitment),
      "note_commitment": BytesUtils.tryToHexString(noteCommitment),
      "epk": BytesUtils.tryToHexString(epk),
      "c_enc": BytesUtils.tryToHexString(cEnc),
      "c_out": BytesUtils.tryToHexString(cOut),
      "zkproof": BytesUtils.tryToHexString(zkproof),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ReceiveDescription] object to its string representation.
  @override
  String toString() {
    return "ReceiveDescription{$toJson()}";
  }
}
