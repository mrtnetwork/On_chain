import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

class WitnessCreateContract extends TronBaseContract {
  /// Create a new [WitnessCreateContract] instance by parsing a JSON map.
  factory WitnessCreateContract.fromJson(Map<String, dynamic> json) {
    return WitnessCreateContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      url: OnChainUtils.parseBytes(value: json['url'], name: 'url'),
    );
  }
  factory WitnessCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return WitnessCreateContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        url: decode.getField(2));
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
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
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
