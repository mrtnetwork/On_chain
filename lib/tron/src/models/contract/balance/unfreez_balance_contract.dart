import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Unstake the TRX staked during Stake1.0, release the obtained bandwidth or energy and TP.
/// This operation will cause automatically cancel all votes.
class UnfreezeBalanceContract extends TronBaseContract {
  /// Create a new [UnfreezeBalanceContract] instance by parsing a JSON map.
  factory UnfreezeBalanceContract.fromJson(Map<String, dynamic> json) {
    return UnfreezeBalanceContract(
      ownerAddress: TronAddress(json['owner_address']),
      resource: ResourceCode.fromName(json['resource']),
      receiverAddress: json['receiver_address'] == null
          ? null
          : TronAddress(json['receiver_address']),
    );
  }
  factory UnfreezeBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UnfreezeBalanceContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        resource: decode
            .getResult(10)
            ?.castTo<ResourceCode, int>((e) => ResourceCode.fromValue(e)),
        receiverAddress: TronAddress.fromBytes(decode.getField(15)));
  }

  /// Create a new [UnfreezeBalanceContract] instance with specified parameters.
  UnfreezeBalanceContract(
      {required this.ownerAddress, this.resource, this.receiverAddress});

  /// Transaction initiator address
  @override
  final TronAddress ownerAddress;

  /// Resource type
  final ResourceCode? resource;

  /// Resource receiver address
  final TronAddress? receiverAddress;

  @override
  List<int> get fieldIds => [1, 10, 15];

  @override
  List get values =>
      [ownerAddress, resource?.value == 0 ? null : resource, receiverAddress];

  /// Convert the [UnfreezeBalanceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'resource': resource?.name,
      'receiver_address': receiverAddress?.toAddress(visible),
    };
  }

  /// Convert the [UnfreezeBalanceContract] object to its string representation.
  @override
  String toString() {
    return 'UnfreezeBalanceContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unfreezeBalanceContract;
}
