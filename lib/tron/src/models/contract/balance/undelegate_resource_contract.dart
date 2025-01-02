import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Cancel the delegation of bandwidth or energy resources to other accounts in Stake2.0
class UnDelegateResourceContract extends TronBaseContract {
  /// Create a new [UnDelegateResourceContract] instance by parsing a JSON map.
  factory UnDelegateResourceContract.fromJson(Map<String, dynamic> json) {
    return UnDelegateResourceContract(
        ownerAddress: TronAddress(json['owner_address']),
        balance: BigintUtils.parse(json['balance']),
        receiverAddress: TronAddress(json['receiver_address']),
        resource: ResourceCode.fromName(json['resource']));
  }

  /// Create a new [UnDelegateResourceContract] instance with specified parameters.
  UnDelegateResourceContract({
    required this.ownerAddress,
    required this.balance,
    required this.receiverAddress,
    this.resource,
  });

  factory UnDelegateResourceContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UnDelegateResourceContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        balance: decode.getField(3),
        resource: decode
            .getResult(2)
            ?.castTo<ResourceCode, int>((e) => ResourceCode.fromValue(e)),
        receiverAddress: TronAddress.fromBytes(decode.getField(4)));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Resource type
  final ResourceCode? resource;

  /// The number of canceled delegate resource shares, the unit is sun
  final BigInt balance;

  /// Resource receiving address
  final TronAddress receiverAddress;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [
        ownerAddress,
        resource == ResourceCode.bandWidth ? null : resource,
        balance,
        receiverAddress
      ];

  /// Convert the [UnDelegateResourceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'receiver_address': receiverAddress.toString(),
      'balance': balance.toString(),
      'resource': resource?.name
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [UnDelegateResourceContract] object to its string representation.
  @override
  String toString() {
    return 'UnDelegateResourceContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unDelegateResourceContract;
}
