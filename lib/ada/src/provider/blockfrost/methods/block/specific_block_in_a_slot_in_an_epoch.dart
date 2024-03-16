import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the content of a requested block for a specific slot in an epoch.
/// https://blockfrost.dev/api/specific-block-in-a-slot-in-an-epoch
class BlockfrostRequestSpecificBlockInASlotInAnEpoch
    extends BlockforestRequestParam<ADABlockResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificBlockInASlotInAnEpoch(
      {required this.epochNumber, required this.slotNumber});

  /// Epoch for specific epoch slot.
  final int epochNumber;

  /// Slot position for requested block.
  final int slotNumber;

  /// Specific block in a slot in an epoch
  @override
  String get method => BlockfrostMethods.specificBlockInASlotInAnEpoch.url;

  @override
  List<String> get pathParameters =>
      [epochNumber.toString(), slotNumber.toString()];

  @override
  ADABlockResponse onResonse(Map<String, dynamic> result) {
    return ADABlockResponse.fromJson(result);
  }
}
