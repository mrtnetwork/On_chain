import 'package:blockchain_utils/binary/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/update_meta_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
        root: decode["root"],
        nonce: decode["nonce"],
        index: decode["index"],
        currentMetaData: MetaData.fromJson(decode["metaData"]),
        updateMetadata: UpdateMetaData.fromJson(decode["updateMetaData"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.blob(32, property: "root"),
    LayoutUtils.u64("nonce"),
    LayoutUtils.u32("index"),
    MetaData.staticLayout,
    UpdateMetaData.staticLayout
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.updateMetadata.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "root": root,
      "nonce": nonce,
      "index": index,
      "metaData": currentMetaData.serialize(),
      "updateMetaData": updateMetadata.serialize()
    };
  }
}
