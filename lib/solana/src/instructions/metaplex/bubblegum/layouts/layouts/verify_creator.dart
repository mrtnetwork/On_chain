import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';

class MetaplexBubblegumVerifyCreatorLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final List<int> dataHash;
  final List<int> creatorHash;
  final BigInt nonce;
  final int index;
  final MetaData message;
  MetaplexBubblegumVerifyCreatorLayout(
      {required List<int> root,
      required List<int> dataHash,
      required List<int> creatorHash,
      required this.nonce,
      required this.index,
      required this.message})
      : root = root.asImmutableBytes,
        dataHash = dataHash.asImmutableBytes,
        creatorHash = creatorHash.asImmutableBytes;

  factory MetaplexBubblegumVerifyCreatorLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.verifyCreator.insturction);
    return MetaplexBubblegumVerifyCreatorLayout(
        root: decode['root'],
        dataHash: decode['dataHash'],
        creatorHash: decode['creatorHash'],
        nonce: decode['nonce'],
        index: decode['index'],
        message: MetaData.fromJson(decode['metaData']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.blob(32, property: 'root'),
    LayoutConst.blob(32, property: 'dataHash'),
    LayoutConst.blob(32, property: 'creatorHash'),
    LayoutConst.u64(property: 'nonce'),
    LayoutConst.u32(property: 'index'),
    MetaData.staticLayout
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.verifyCreator;

  @override
  Map<String, dynamic> serialize() {
    return {
      'root': root,
      'dataHash': dataHash,
      'creatorHash': creatorHash,
      'nonce': nonce,
      'index': index,
      'metaData': message.serialize()
    };
  }
}
