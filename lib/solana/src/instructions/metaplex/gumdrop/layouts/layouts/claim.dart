import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexGumdropClaimLayout extends MetaplexGumdropProgramLayout {
  final int bump;
  final BigInt index;
  final BigInt amount;
  final SolAddress claimantSecret;
  final List<List<int>> proof;
  MetaplexGumdropClaimLayout(
      {required this.bump,
      required this.index,
      required this.amount,
      required this.claimantSecret,
      required List<List<int>> proof})
      : proof = List<List<int>>.unmodifiable(
            proof.map((e) => BytesUtils.toBytes(e, unmodifiable: true)));

  factory MetaplexGumdropClaimLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction.claim.insturction);
    return MetaplexGumdropClaimLayout(
        bump: decode["bump"],
        index: decode["index"],
        amount: decode["amount"],
        claimantSecret: decode["claimantSecret"],
        proof: (decode["proof"] as List).cast());
  }

  /// Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("bump"),
    LayoutUtils.u64("index"),
    LayoutUtils.u64("amount"),
    LayoutUtils.publicKey("claimantSecret"),
    LayoutUtils.vec(LayoutUtils.blob(32), property: "proof"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexGumdropProgramInstruction.claim.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "bump": bump,
      "index": index,
      "amount": amount,
      "claimantSecret": claimantSecret,
      "proof": proof
    };
  }
}
