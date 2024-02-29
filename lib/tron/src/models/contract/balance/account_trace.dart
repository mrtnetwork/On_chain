import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class AccountTrace extends TronProtocolBufferImpl {
  /// Create a new [AccountTrace] instance with specified parameters.
  AccountTrace({this.balance, this.placeholder});

  /// Create a new [AccountTrace] instance by parsing a JSON map.
  factory AccountTrace.fromJson(Map<String, dynamic> json) {
    return AccountTrace(
      balance: BigintUtils.tryParse(json["balance"]),
      placeholder: BigintUtils.tryParse(json["placeholder"]),
    );
  }
  final BigInt? balance;
  final BigInt? placeholder;

  @override
  List<int> get fieldIds => [1, 99];

  @override
  List get values => [balance, placeholder];

  /// Convert the [AccountTrace] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "balance": balance?.toString(),
      "placeholder": placeholder?.toString(),
    };
  }

  /// Convert the [AccountTrace] object to its string representation.
  @override
  String toString() {
    return "AccountTrace{${toJson()}}";
  }
}
