import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Delegate bandwidth or energy resources to other accounts in Stake2.0.
class DelegateResourceContract extends TronBaseContract {
  /// Create a new [DelegateResourceContract] instance by parsing a JSON map.
  factory DelegateResourceContract.fromJson(Map<String, dynamic> json) {
    return DelegateResourceContract(
        ownerAddress: OnChainUtils.parseTronAddress(
            value: json["owner_address"], name: "owner_address"),
        balance:
            OnChainUtils.parseBigInt(value: json["balance"], name: "balance"),
        receiverAddress: OnChainUtils.parseTronAddress(
            value: json["receiver_address"], name: "receiver_address"),
        lock: OnChainUtils.parseBoolean(value: json["lock"], name: "lock"),
        resource: ResourceCode.fromName(
            OnChainUtils.parseString(value: json["resource"], name: "resource"),
            orElse: ResourceCode.bandWidth),
        lockPeriod: OnChainUtils.parseBigInt(
            value: json["lock_period"], name: "lock_period"));
  }
  factory DelegateResourceContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return DelegateResourceContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        resource: decode.getResult(2)?.castTo<ResourceCode, int>(
            (e) => ResourceCode.fromValue(decode.getField(2))),
        balance: decode.getField(3),
        receiverAddress: TronAddress.fromBytes(decode.getField(4)),
        lock: decode.getField(5),
        lockPeriod: decode.getField(6));
  }

  /// Create a new [DelegateResourceContract] instance with specified parameters.
  DelegateResourceContract(
      {required this.ownerAddress,
      required this.balance,
      required this.receiverAddress,
      this.lock,
      this.resource,
      this.lockPeriod});

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Resource type
  final ResourceCode? resource;

  /// Resource delegate amount, the unit is sun
  final BigInt balance;

  /// Resource receiver address
  final TronAddress receiverAddress;

  /// Whether to lock the resource delegation, true means locked the delegation,
  /// the delegating cannot be canceled within the period specified by lock_period,
  /// false means non-locked, the resource delegating can be canceled at any time
  final bool? lock;

  /// Lock period, the unit is block interval(3 seconds).
  /// Only when lock is true, this field is valid. If the delegate lock period is 1 day,
  /// the lock_period is 28800.
  final BigInt? lockPeriod;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  List get values => [
        ownerAddress,

        /// its default value and null reduce transaction size (FEE)
        resource == ResourceCode.bandWidth ? null : resource,
        balance,
        receiverAddress,

        /// its default value and null reduce transaction size (FEE)
        lock == false ? null : lock,
        lockPeriod
      ];

  /// Convert the [DelegateResourceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "receiver_address": receiverAddress.toString(),
      "lock": lock,
      "lock_period": lockPeriod?.toString(),
      "balance": balance.toString(),
      "resource": resource?.name
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [DelegateResourceContract] object to its string representation.
  @override
  String toString() {
    return "DelegateResourceContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.delegateResourceContract;
}
