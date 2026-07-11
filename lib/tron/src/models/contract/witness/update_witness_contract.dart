import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class WitnessUpdateContract extends TronBaseContract {
  /// Create a new [WitnessUpdateContract] instance by parsing a JSON map.
  factory WitnessUpdateContract.fromJson(Map<String, dynamic> json) {
    return WitnessUpdateContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      updateUrl: json.valueAsBytes("update_url", encoding: StringEncoding.utf8),
    );
  }
  factory WitnessUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return WitnessUpdateContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      updateUrl: decode.getField(2),
    );
  }

  /// Create a new [WitnessUpdateContract] instance with specified parameters.
  WitnessUpdateContract({required this.ownerAddress, List<int>? updateUrl})
    : updateUrl = BytesUtils.tryToBytes(updateUrl, unmodifiable: true);
  @override
  final TronAddress ownerAddress;
  final List<int>? updateUrl;

  @override
  List<int> get fieldIds => [1, 12];

  @override
  List get values => [ownerAddress, updateUrl];

  /// Convert the [WitnessUpdateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'update_url': StringUtils.tryDecode(updateUrl),
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [WitnessUpdateContract] object to its string representation.
  @override
  String toString() {
    return 'WitnessUpdateContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.witnessUpdateContract;
}
