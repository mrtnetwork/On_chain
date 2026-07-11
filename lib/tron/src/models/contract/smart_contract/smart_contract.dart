import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract_abi.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class SmartContract extends TronProtocolBufferImpl {
  /// Create a new [SmartContract] instance by parsing a JSON map.
  factory SmartContract.fromJson(Map<String, dynamic> json) {
    return SmartContract(
      originAddress: TronAddress(json.valueAs("origin_address")),
      bytecode: json.valueAsBytes("bytecode"),
      callValue: json.valueAsBigInt("call_value"),
      abi: json.valueTo<SmartContractABI?, Map<String, dynamic>>(
        key: "abi",
        parse: (e) => SmartContractABI.fromJson(e),
      ),
      consumeUserResourcePercent: json.valueAsBigInt(
        "consume_user_resource_percent",
      ),
      name: json.valueAs("name"),
      originEnergyLimit: json.valueAsBigInt("origin_energy_limit"),
      trxHash: json.valueAsBytes("trx_hash"),
      codeHash: json.valueAsBytes("code_hash"),
      version: json.valueAsInt("version"),
      contractAddress: json.valueTo<TronAddress?, String>(
        key: "contract_address",
        parse: (e) => TronAddress(e),
      ),
    );
  }
  factory SmartContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return SmartContract(
      originAddress: TronAddress.fromBytes(decode.getField(1)),
      bytecode: decode.getField(4),
      callValue: decode.getField(5),
      abi: decode
          .getResult(3)
          ?.castTo<SmartContractABI, List<int>>(
            (e) => SmartContractABI.deserialize(e),
          ),
      consumeUserResourcePercent: decode.getField(6),
      name: decode.getField(7),
      originEnergyLimit: decode.getField(8),
      trxHash: decode.getField(10),
      codeHash: decode.getField(9),
      version: decode.getField(11),
      contractAddress: decode
          .getResult(2)
          ?.castTo<TronAddress, List<int>>((e) => TronAddress.fromBytes(e)),
    );
  }

  /// Create a new [SmartContract] instance with specified parameters.
  SmartContract({
    required this.originAddress,
    this.contractAddress,
    required this.abi,
    required List<int> bytecode,
    this.callValue,
    this.consumeUserResourcePercent,
    this.name,
    this.originEnergyLimit,
    List<int>? codeHash,
    List<int>? trxHash,
    this.version,
  }) : bytecode = bytecode.asImmutableBytes,
       trxHash = trxHash?.asImmutableBytes,
       codeHash = codeHash?.asImmutableBytes;
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
    version,
  ];

  /// Convert the [SmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'origin_address': originAddress.toAddress(visible),
      'contract_address': contractAddress?.toAddress(visible),
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
