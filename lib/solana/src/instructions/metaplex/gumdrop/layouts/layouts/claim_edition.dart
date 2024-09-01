import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexGumdropClaimEditionLayout extends MetaplexGumdropProgramLayout {
  final int claimBump;
  final BigInt index;
  final BigInt amount;
  final BigInt edition;
  final SolAddress claimantSecret;
  final List<List<int>> proof;

  MetaplexGumdropClaimEditionLayout(
      {required this.claimBump,
      required this.index,
      required this.amount,
      required this.edition,
      required this.claimantSecret,
      required List<List<int>> proof})
      : proof = List<List<int>>.unmodifiable(
            proof.map((e) => BytesUtils.toBytes(e, unmodifiable: true)));

  factory MetaplexGumdropClaimEditionLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexGumdropProgramInstruction.claimEdition.insturction);
    return MetaplexGumdropClaimEditionLayout(
        claimBump: decode["claimBump"],
        index: decode["index"],
        amount: decode["amount"],
        edition: decode["edition"],
        claimantSecret: decode["claimantSecret"],
        proof: (decode["proof"] as List).cast());
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "claimBump"),
    LayoutConst.u64(property: "index"),
    LayoutConst.u64(property: "amount"),
    LayoutConst.u64(property: "edition"),
    SolanaLayoutUtils.publicKey("claimantSecret"),
    LayoutConst.vec(LayoutConst.blob(32), property: "proof"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.claimEdition;

  @override
  Map<String, dynamic> serialize() {
    return {
      "claimBump": claimBump,
      "index": index,
      "amount": amount,
      "edition": edition,
      "claimantSecret": claimantSecret,
      "proof": proof
    };
  }
}
