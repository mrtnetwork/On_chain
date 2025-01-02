import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/update_meta_data.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumUpdateMetadataLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final BigInt nonce;
  final int index;
  final MetaData currentMetaData;
  final UpdateMetaData updateMetadata;
  MetaplexBubblegumUpdateMetadataLayout(
      {required List<int> root,
      required this.nonce,
      required this.index,
      required this.currentMetaData,
      required this.updateMetadata})
      : root = BytesUtils.toBytes(root, unmodifiable: true);

  factory MetaplexBubblegumUpdateMetadataLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.updateMetadata.insturction);
    return MetaplexBubblegumUpdateMetadataLayout(
        root: decode['root'],
        nonce: decode['nonce'],
        index: decode['index'],
        currentMetaData: MetaData.fromJson(decode['metaData']),
        updateMetadata: UpdateMetaData.fromJson(decode['updateMetaData']));
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.blob(32, property: 'root'),
    LayoutConst.u64(property: 'nonce'),
    LayoutConst.u32(property: 'index'),
    MetaData.staticLayout,
    UpdateMetaData.staticLayout
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.updateMetadata;

  @override
  Map<String, dynamic> serialize() {
    return {
      'root': root,
      'nonce': nonce,
      'index': index,
      'metaData': currentMetaData.serialize(),
      'updateMetaData': updateMetadata.serialize()
    };
  }
}
