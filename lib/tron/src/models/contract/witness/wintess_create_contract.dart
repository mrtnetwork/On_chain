import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class WitnessCreateContract extends TronBaseContract {
  /// Create a new [WitnessCreateContract] instance by parsing a JSON map.
  factory WitnessCreateContract.fromJson(Map<String, dynamic> json) {
    return WitnessCreateContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      url: json.valueAsBytes("url", encoding: StringEncoding.utf8),
    );
  }
  factory WitnessCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return WitnessCreateContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      url: decode.getField(2),
    );
  }

  /// Create a new [WitnessCreateContract] instance with specified parameters.
  WitnessCreateContract({required this.ownerAddress, List<int>? url})
    : url = BytesUtils.tryToBytes(url, unmodifiable: true);
  @override
  final TronAddress ownerAddress;
  final List<int>? url;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, url];

  /// Convert the [WitnessCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'url': StringUtils.tryDecode(url),
    }..removeWhere((k, v) => v == null);
  }

  /// Convert the [WitnessCreateContract] object to its string representation.
  @override
  String toString() {
    return 'WitnessCreateContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.witnessCreateContract;
}
