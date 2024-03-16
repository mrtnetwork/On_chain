import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the content of a requested block for a specific slot.
/// https://blockfrost.dev/api/specific-block-in-a-slot
class BlockfrostRequestSpecificBlockInASlot
    extends BlockforestRequestParam<ADABlockResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificBlockInASlot(this.slotNumber);

  /// Slot position for requested block.
  final int slotNumber;

  /// Specific block in a slot
  @override
  String get method => BlockfrostMethods.specificBlockInASlot.url;

  @override
  List<String> get pathParameters => [slotNumber.toString()];

  @override
  ADABlockResponse onResonse(Map<String, dynamic> result) {
    return ADABlockResponse.fromJson(result);
  }
}
