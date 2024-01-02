import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/models/contract/transaction/any.dart';

import 'package:blockchain_utils/blockchain_utils.dart';

class TransactionContract extends TronProtocolBufferImpl {
  /// Create a new [TransactionContract] instance by parsing a JSON map.
  factory TransactionContract.fromJson(Map<String, dynamic> json) {
    final type = TransactionContractType.findByName(json["type"]);
    final any = Any.fromJson(json["parameter"]);
    final int? permissionId =
        IntUtils.tryParse(json["permission_id"] ?? json["Permission_id"]);
    return TransactionContract(
      type: type,
      parameter: any,
      permissionId: permissionId,
      provider: StringUtils.tryEncode(json["provider"]),
      contractName: StringUtils.tryEncode(json["contract_name"]),
    );
  }

  /// Create a new [TransactionContract] instance with specified parameters.
  TransactionContract(
      {required this.type,
      required this.parameter,
      List<int>? provider,
      List<int>? contractName,
      this.permissionId})
      : provider = BytesUtils.tryToBytes(provider, unmodifiable: true),
        contractName = BytesUtils.tryToBytes(contractName, unmodifiable: true);
  final TransactionContractType type;
  final Any parameter;
  final List<int>? provider;
  final List<int>? contractName;
  final int? permissionId;

  /// Convert the [TransactionContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "parameter": parameter.toJson(),
      "contract_name": StringUtils.tryDecode(contractName),
      "provider": StringUtils.tryDecode(provider),
      "Permission_id": permissionId
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [
        type.value == 0 ? null : type,
        parameter,
        provider,
        contractName,
        permissionId
      ];

  /// Convert the [TransactionContract] object to its string representation.
  @override
  String toString() {
    return "TransactionContract{${toJson()}}";
  }
}
