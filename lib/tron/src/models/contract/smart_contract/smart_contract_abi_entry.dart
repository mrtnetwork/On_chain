import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/abi_types.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract_abi_entry_param.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class SmartContractABIEntry extends TronProtocolBufferImpl {
  /// Create a new [SmartContractABIEntry] instance by parsing a JSON map.
  factory SmartContractABIEntry.fromJson(Map<String, dynamic> json) {
    return SmartContractABIEntry(
      anonymous: json.valueAs("anonymous"),
      type: SmartContractAbiEntryType.fromName(json.valueAs("type")),
      stateMutability:
          json.valueAs<String?>("stateMutability") == null
              ? null
              : SmartContractAbiStateMutabilityType.fromName(
                json['stateMutability'],
              ),
      inputs:
          json
              .valueAsList<List<Map<String, dynamic>>?>("inputs")
              ?.map((e) => SmartContractBABIEntryParam.fromJson(e))
              .toList(),
      outputs:
          json
              .valueAsList<List<Map<String, dynamic>>?>("outputs")
              ?.map((e) => SmartContractBABIEntryParam.fromJson(e))
              .toList(),
      constant: json.valueAs("constant"),
      name: json.valueAs("name"),
      payable: json.valueAs("payable"),
    );
  }

  /// Create a new [SmartContractABIEntry] instance with specified parameters.
  SmartContractABIEntry({
    this.anonymous,
    this.constant,
    this.name,
    List<SmartContractBABIEntryParam>? inputs,
    List<SmartContractBABIEntryParam>? outputs,
    required this.type,
    this.payable,
    this.stateMutability,
  }) : inputs = inputs?.emptyAsNull?.immutable,
       outputs = outputs?.emptyAsNull?.immutable;
  factory SmartContractABIEntry.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return SmartContractABIEntry(
      anonymous: decode.getField(1),
      constant: decode.getField(2),
      name: decode.getField(3),
      inputs:
          decode
              .getFields(4)
              .map((e) => SmartContractBABIEntryParam.deserialize(e))
              .toList(),
      outputs:
          decode
              .getFields(5)
              .map((e) => SmartContractBABIEntryParam.deserialize(e))
              .toList(),
      type: SmartContractAbiEntryType.fromValue(decode.getField(6)),
      payable: decode.getField(7),
      stateMutability:
          decode.getField<int?>(8) == null
              ? null
              : SmartContractAbiStateMutabilityType.fromValue(
                decode.getField(8),
              ),
    );
  }
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
    anonymous == false ? null : anonymous,
    constant,
    name,
    inputs,
    outputs,
    type,
    payable,
    stateMutability,
  ];

  /// Convert the [SmartContractABIEntry] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'stateMutability': stateMutability?.name,
      'anonymous': anonymous,
      'inputs': inputs?.map((e) => e.toJson()).toList(),
      'outputs': outputs?.map((e) => e.toJson()).toList(),
      'constant': constant,
      'name': name,
      'payable': payable,
    };
  }

  /// Convert the [SmartContractABIEntry] object to its string representation.
  @override
  String toString() {
    return 'SmartContractABIEntry{${toJson()}}';
  }
}
