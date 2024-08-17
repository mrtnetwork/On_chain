import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// This interface has been deprecated, please use FreezeBalanceV2 to stake TRX to obtain resources.
class FreezeBalanceContract extends TronBaseContract {
  /// Create a new [FreezeBalanceContract] instance by parsing a JSON map.
  factory FreezeBalanceContract.fromJson(Map<String, dynamic> json) {
    return FreezeBalanceContract(
      ownerAddress: TronAddress(json["owner_address"]),
      frozenBalance: BigintUtils.tryParse(json["frozen_balance"]),
      frozenDuration: BigintUtils.tryParse(json["frozen_balance"]),
      resource: ResourceCode.fromName(json["resource"]),
      receiverAddress: json["receiver_address"] == null
          ? null
          : TronAddress(json["receiver_address"]),
    );
  }
  factory FreezeBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return FreezeBalanceContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      frozenBalance: decode.getField(2),
      frozenDuration: decode.getField(3),
      resource: ResourceCode.fromValue(decode.getField(10),
          orElse: ResourceCode.bandWidth),
      receiverAddress: decode
          .getResult(15)
          ?.castTo<TronAddress, List<int>>((e) => TronAddress.fromBytes(e)),
    );
  }

  /// Create a new [FreezeBalanceContract] instance with specified parameters.
  FreezeBalanceContract(
      {required this.ownerAddress,
      this.frozenBalance,
      this.frozenDuration,
      this.resource,
      this.receiverAddress});

  /// Owner address
  final TronAddress ownerAddress;

  /// TRX stake amount
  final BigInt? frozenBalance;

  /// Lock-up duration for this stake,
  /// now the value can only be 3 days.
  /// It is not allowed to unstake within 3 days after the stake.
  /// You can unstake TRX after the 3 lock-up days
  final BigInt? frozenDuration;

  /// TRX stake type, 'BANDWIDTH' or 'ENERGY'
  final ResourceCode? resource;

  /// the address that will receive the resource
  final TronAddress? receiverAddress;

  @override
  List<int> get fieldIds => [1, 2, 3, 10, 15];

  @override
  List get values =>
      [ownerAddress, frozenBalance, frozenDuration, resource, receiverAddress];

  /// Convert the [FreezeBalanceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "frozen_balance": frozenBalance?.toString(),
      "frozen_duration": frozenDuration?.toString(),
      "resource": resource?.name,
      "receiver_address": receiverAddress?.toString(),
    };
  }

  /// Convert the [FreezeBalanceContract] object to its string representation.
  @override
  String toString() {
    return "FreezeBalanceContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.freezeBalanceContract;
}
