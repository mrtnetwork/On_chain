import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';

/// Withdraw unfrozen balance in Stake2.0, the user can
/// call this API to get back their funds after executing /wallet/unfreezebalancev2
/// transaction and waiting N days, N is a network parameter
class WithdrawExpireUnfreezeContract extends TronBaseContract {
  /// Create a new [WithdrawExpireUnfreezeContract] instance by parsing a JSON map.
  factory WithdrawExpireUnfreezeContract.fromJson(Map<String, dynamic> json) {
    return WithdrawExpireUnfreezeContract(
      ownerAddress: TronAddress(json["owner_address"]),
    );
  }

  /// Create a new [WithdrawExpireUnfreezeContract] instance with specified parameters.
  WithdrawExpireUnfreezeContract({required this.ownerAddress});

  /// Account address
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [ownerAddress];

  /// Convert the [WithdrawExpireUnfreezeContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"owner_address": ownerAddress};
  }

  /// Convert the [WithdrawExpireUnfreezeContract] object to its string representation.
  @override
  String toString() {
    return 'WithdrawExpireUnfreezeContract{$toJson()}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.withdrawExpireUnfreezeContract;
}
