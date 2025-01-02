import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract_abi.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class SmartContract extends TronProtocolBufferImpl {
  /// Create a new [SmartContract] instance by parsing a JSON map.
  factory SmartContract.fromJson(Map<String, dynamic> json) {
    return SmartContract(
        originAddress: OnChainUtils.parseTronAddress(
            value: json['origin_address'], name: 'origin_address'),
        bytecode:
            OnChainUtils.parseHex(value: json['bytecode'], name: 'bytecode'),
        callValue: OnChainUtils.parseBigInt(
            value: json['call_value'], name: 'call_value'),
        abi: OnChainUtils.parseMap<String, dynamic>(
                    value: json['abi'], name: 'abi', throwOnNull: false) ==
                null
            ? null
            : SmartContractABI.fromJson(json['abi']),
        consumeUserResourcePercent: OnChainUtils.parseBigInt(
            value: json['consume_user_resource_percent'],
            name: 'consume_user_resource_percent'),
        name: OnChainUtils.parseString(value: json['name'], name: 'name'),
        originEnergyLimit: OnChainUtils.parseBigInt(
            value: json['origin_energy_limit'], name: 'origin_energy_limit'),
        trxHash:
            OnChainUtils.parseHex(value: json['trx_hash'], name: 'trx_hash'),
        codeHash:
            OnChainUtils.parseHex(value: json['code_hash'], name: 'code_hash'),
        version: OnChainUtils.parseInt(value: json['version'], name: 'version'),
        contractAddress: OnChainUtils.parseTronAddress(
            value: json['contract_address'], name: 'contract_address'));
  }
  factory SmartContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return SmartContract(
        originAddress: TronAddress.fromBytes(decode.getField(1)),
        bytecode: decode.getField(4),
        callValue: decode.getField(5),
        abi: decode.getResult(3)?.castTo<SmartContractABI, List<int>>(
            (e) => SmartContractABI.deserialize(e)),
        consumeUserResourcePercent: decode.getField(6),
        name: decode.getField(7),
        originEnergyLimit: decode.getField(8),
        trxHash: decode.getField(10),
        codeHash: decode.getField(9),
        version: decode.getField(11),
        contractAddress: decode
            .getResult(2)
            ?.castTo<TronAddress, List<int>>((e) => TronAddress.fromBytes(e)));
  }

  /// Create a new [SmartContract] instance with specified parameters.
  SmartContract(
      {required this.originAddress,
      this.contractAddress,
      required this.abi,
      required List<int> bytecode,
      this.callValue,
      this.consumeUserResourcePercent,
      this.name,
      this.originEnergyLimit,
      List<int>? codeHash,
      List<int>? trxHash,
      this.version})
      : bytecode = BytesUtils.toBytes(bytecode, unmodifiable: true),
        trxHash = BytesUtils.tryToBytes(trxHash, unmodifiable: true),
        codeHash = BytesUtils.tryToBytes(codeHash, unmodifiable: true);
  final TronAddress originAddress;
  final TronAddress? contractAddress;
  final SmartContractABI? abi;
  final List<int> bytecode;
  final BigInt? callValue;
  final BigInt? consumeUserResourcePercent;
  final String? name;
  final BigInt? originEnergyLimit;
  final List<int>? codeHash;
  final List<int>? trxHash;
  final int? version;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  List get values => [
        originAddress,
        contractAddress,
        abi,
        bytecode,
        callValue,
        consumeUserResourcePercent == BigInt.zero
            ? null
            : consumeUserResourcePercent,
        name,
        originEnergyLimit,
        codeHash,
        trxHash,
        version
      ];

  /// Convert the [SmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'origin_address': originAddress.toString(),
      'contract_address': contractAddress?.toString(),
      'abi': abi?.toJson(),
      'bytecode': BytesUtils.toHexString(bytecode),
      'call_value': callValue?.toString(),
      'consume_user_resource_percent': consumeUserResourcePercent?.toString(),
      'name': name,
      'origin_energy_limit': originEnergyLimit?.toString(),
      'code_hash': BytesUtils.tryToHexString(codeHash),
      'trx_hash': BytesUtils.tryToHexString(trxHash),
      'version': version,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [SmartContract] object to its string representation.
  @override
  String toString() {
    return 'SmartContract{${toJson()}}';
  }
}
