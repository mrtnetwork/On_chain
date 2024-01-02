import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/models/contract/smart_contract/abi_types.dart';
import 'package:on_chain/tron/models/contract/smart_contract/smart_contract_abi_entry_param.dart';

class SmartContractABIEntry extends TronProtocolBufferImpl {
  /// Create a new [SmartContractABIEntry] instance by parsing a JSON map.
  factory SmartContractABIEntry.fromJson(Map<String, dynamic> json) {
    return SmartContractABIEntry(
      type: SmartContractAbiEntryType.fromName(json["type"]),
      stateMutability:
          SmartContractAbiStateMutabilityType.fromName(json["stateMutability"]),
      anonymous: json["anonymous"],
      inputs: (json["inputs"] as List?)
          ?.map((e) => SmartContractBABIEntryParam.fromJson(e))
          .toList(),
      outputs: (json["outputs"] as List?)
          ?.map((e) => SmartContractBABIEntryParam.fromJson(e))
          .toList(),
      constant: json["constant"],
      name: json["name"],
      payable: json["payable"],
    );
  }

  /// Create a new [SmartContractABIEntry] instance with specified parameters.
  SmartContractABIEntry(
      {this.anonymous,
      this.constant,
      this.name,
      List<SmartContractBABIEntryParam>? inputs,
      List<SmartContractBABIEntryParam>? outputs,
      required this.type,
      this.payable,
      this.stateMutability})
      : inputs = inputs == null
            ? null
            : List<SmartContractBABIEntryParam>.unmodifiable(inputs),
        outputs = outputs == null
            ? null
            : List<SmartContractBABIEntryParam>.unmodifiable(outputs);
  final bool? anonymous;
  final bool? constant;
  final String? name;
  final List<SmartContractBABIEntryParam>? inputs;
  final List<SmartContractBABIEntryParam>? outputs;
  final SmartContractAbiEntryType type;
  final bool? payable;
  final SmartContractAbiStateMutabilityType? stateMutability;
  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6, 7, 8];
  @override
  List get values => [
        anonymous,
        constant,
        name,
        inputs,
        outputs,
        type,
        payable,
        stateMutability
      ];

  /// Convert the [SmartContractABIEntry] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "stateMutability": stateMutability?.name,
      "anonymous": anonymous,
      "inputs": inputs?.map((e) => e.toJson()).toList(),
      "outputs": outputs?.map((e) => e.toJson()).toList(),
      "constant": constant,
      "name": name,
      "payable": payable
    };
  }

  /// Convert the [SmartContractABIEntry] object to its string representation.
  @override
  String toString() {
    return "SmartContractABIEntry{${toJson()}}";
  }
}
