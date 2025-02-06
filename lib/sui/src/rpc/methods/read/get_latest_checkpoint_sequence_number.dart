import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Return the sequence number of the latest checkpoint that has been executed
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getlatestcheckpointsequencenumber)
class SuiRequestGetLatestCheckpointSequenceNumber
    extends SuiRequest<String, String> {
  const SuiRequestGetLatestCheckpointSequenceNumber();

  @override
  String get method => 'sui_getLatestCheckpointSequenceNumber';

  @override
  List<dynamic> toJson() {
    return [];
  }
}
