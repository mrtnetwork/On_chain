import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';

import 'smart_contract_abi_entry.dart';

class SmartContractABI extends TronProtocolBufferImpl {
  /// Create a new [SmartContractABI] instance with specified parameters.
  SmartContractABI({required List<SmartContractABIEntry> entrys})
      : entrys = List<SmartContractABIEntry>.unmodifiable(entrys);

  /// Create a new [SmartContractABI] instance by parsing a JSON map.
  factory SmartContractABI.fromJson(Map<String, dynamic> json) {
    return SmartContractABI(
        entrys: (json["entrys"] as List?)
                ?.map((e) => SmartContractABIEntry.fromJson(e))
                .toList() ??
            <SmartContractABIEntry>[]);
  }
  final List<SmartContractABIEntry> entrys;

  @override
  List<int> get fieldIds => [1];

  @override
  List get values => [entrys];

  /// Convert the [SmartContractABI] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {"entrys": entrys.map((e) => e.toJson()).toList()};
  }

  /// Convert the [SmartContractABI] object to its string representation.
  @override
  String toString() {
    return "SmartContractABI{${toJson()}}";
  }
}
