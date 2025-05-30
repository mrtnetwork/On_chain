import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumDelegateLayout extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final List<int> dataHash;
  final List<int> creatorHash;
  final BigInt nonce;
  final int index;
  MetaplexBubblegumDelegateLayout(
      {required List<int> root,
      required List<int> dataHash,
      required List<int> creatorHash,
      required this.nonce,
      required this.index})
      : root = BytesUtils.toBytes(root, unmodifiable: true),
        dataHash = BytesUtils.toBytes(dataHash, unmodifiable: true),
        creatorHash = BytesUtils.toBytes(creatorHash, unmodifiable: true);
  factory MetaplexBubblegumDelegateLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexBubblegumProgramInstruction.delegate.insturction);
    return MetaplexBubblegumDelegateLayout(
        root: decode['root'],
        dataHash: decode['dataHash'],
        creatorHash: decode['creatorHash'],
        nonce: decode['nonce'],
        index: decode['index']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.blob(32, property: 'root'),
    LayoutConst.blob(32, property: 'dataHash'),
    LayoutConst.blob(32, property: 'creatorHash'),
    LayoutConst.u64(property: 'nonce'),
    LayoutConst.u32(property: 'index'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.delegate;

  @override
  Map<String, dynamic> serialize() {
    return {
      'root': root,
      'dataHash': dataHash,
      'creatorHash': creatorHash,
      'nonce': nonce,
      'index': index
    };
  }
}
