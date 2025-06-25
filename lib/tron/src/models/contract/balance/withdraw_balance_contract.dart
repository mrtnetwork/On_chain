import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class WithdrawBalanceContract extends TronBaseContract {
  /// Create a new [WithdrawBalanceContract] instance by parsing a JSON map.
  factory WithdrawBalanceContract.fromJson(Map<String, dynamic> json) {
    return WithdrawBalanceContract(
      ownerAddress: TronAddress(json['owner_address']),
    );
  }

  /// Create a new [WithdrawBalanceContract] instance with specified parameters.
  WithdrawBalanceContract({required this.ownerAddress});
  factory WithdrawBalanceContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return WithdrawBalanceContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)));
  }
  @override
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [ownerAddress];

  /// Convert the [WithdrawBalanceContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {'owner_address': ownerAddress.toAddress(visible)};
  }

  /// Convert the [WithdrawBalanceContract] object to its string representation.
  @override
  String toString() {
    return 'WithdrawBalanceContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.withdrawBalanceContract;
}
