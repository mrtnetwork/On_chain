import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/gumdrop/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

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
      : proof =
            List<List<int>>.unmodifiable(proof.map((e) => e.asImmutableBytes)),
        claimPrefix = claimPrefix.asImmutableBytes,
        resourceNonce = resourceNonce.asImmutableBytes;

  factory MetaplexGumdropProveClaimLayout.fromBuffer(List<int> data) {
    final decode = MetaplexGumdropProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexGumdropProgramInstruction.proveClaim.insturction);
    return MetaplexGumdropProveClaimLayout(
        claimPrefix: (decode['claimPrefix'] as List).cast(),
        claimBump: decode['claimBump'],
        resource: decode['resource'],
        resourceNonce: (decode['resourceNonce'] as List).cast(),
        index: decode['index'],
        amount: decode['amount'],
        claimantSecret: decode['claimantSecret'],
        proof: (decode['proof'] as List).cast());
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'instruction'),
        LayoutConst.vecU8(property: 'claimPrefix'),
        LayoutConst.u8(property: 'claimBump'),
        LayoutConst.u64(property: 'index'),
        LayoutConst.u64(property: 'amount'),
        SolanaLayoutUtils.publicKey('claimantSecret'),
        SolanaLayoutUtils.publicKey('resource'),
        LayoutConst.vecU8(property: 'resourceNonce'),
        LayoutConst.vec(LayoutConst.blob(32), property: 'proof'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexGumdropProgramInstruction get instruction =>
      MetaplexGumdropProgramInstruction.proveClaim;

  @override
  Map<String, dynamic> serialize() {
    return {
      'claimPrefix': claimPrefix,
      'claimBump': claimBump,
      'index': index,
      'amount': amount,
      'claimantSecret': claimantSecret,
      'resource': resource,
      'resourceNonce': resourceNonce,
      'proof': proof
    };
  }
}
