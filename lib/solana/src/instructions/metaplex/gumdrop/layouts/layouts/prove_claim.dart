import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexGumdropProveClaimLayout extends MetaplexGumdropProgramLayout {
  final List<int> claimPrefix;
  final int claimBump;
  final BigInt index;
  final BigInt amount;
  final SolAddress claimantSecret;
  final SolAddress resource;
  final List<int> resourceNonce;
  final List<List<int>> proof;
  MetaplexGumdropProveClaimLayout(
      {required this.claimBump,
      required List<int> claimPrefix,
      required this.resource,
      required List<int> resourceNonce,
      required this.index,
      required this.amount,
      required this.claimantSecret,
      required List<List<int>> proof})
      : proof = List<List<int>>.unmodifiable(
            proof.map((e) => BytesUtils.toBytes(e, unmodifiable: true))),
        claimPrefix = BytesUtils.toBytes(claimPrefix, unmodifiable: true),
        resourceNonce = BytesUtils.toBytes(resourceNonce, unmodifiable: true);

  factory MetaplexGumdropProveClaimLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction.proveClaim.insturction);
    return MetaplexGumdropProveClaimLayout(
        claimPrefix: (decode["claimPrefix"] as List).cast(),
        claimBump: decode["claimBump"],
        resource: decode["resource"],
        resourceNonce: (decode["resourceNonce"] as List).cast(),
        index: decode["index"],
        amount: decode["amount"],
        claimantSecret: decode["claimantSecret"],
        proof: (decode["proof"] as List).cast());
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.vecU8("claimPrefix"),
    LayoutUtils.u8("claimBump"),
    LayoutUtils.u64("index"),
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("claimantSecret"),
    LayoutUtils.publicKey("resource"),
    LayoutUtils.vecU8("resourceNonce"),
    LayoutUtils.vec(LayoutUtils.blob(32), property: "proof"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.proveClaim.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "claimPrefix": claimPrefix,
      "claimBump": claimBump,
      "index": index,
      "amount": amount,
      "claimantSecret": claimantSecret,
      "resource": resource,
      "resourceNonce": resourceNonce,
      "proof": proof
    };
  }
}
