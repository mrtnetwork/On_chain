import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class TriggerSmartContract extends TronBaseContract {
  /// Create a new [TriggerSmartContract] instance by parsing a JSON map.
  factory TriggerSmartContract.fromJson(Map<String, dynamic> json) {
    return TriggerSmartContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      contractAddress: TronAddress(json.valueAs("contract_address")),

      data: json.valueAsBytes("data"),
      callTokenValue: json.valueAsBigInt("call_token_value"),
      callValue: json.valueAsBigInt("call_value"),
      tokenId: json.valueAsBigInt("token_id"),
    );
  }

  /// Create a new [TriggerSmartContract] instance with specified parameters.
  TriggerSmartContract({
    required this.ownerAddress,
    required this.contractAddress,
    this.callValue,
    List<int>? data,
    this.callTokenValue,
    this.tokenId,
  }) : data = BytesUtils.tryToBytes(data, unmodifiable: true);
  factory TriggerSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return TriggerSmartContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      contractAddress: TronAddress.fromBytes(decode.getField(2)),
      callValue: decode.getField(3),
      data: decode.getField(4),
      callTokenValue: decode.getField(5),
      tokenId: decode.getField(6),
    );
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Contract address
  final TronAddress contractAddress;

  /// The amount of TRX passed into the contract
  final BigInt? callValue;

  /// Operating parameters
  final List<int>? data;

  /// The amount of TRC-10 transferred into the contract
  final BigInt? callTokenValue;

  /// TRC-10 token id
  final BigInt? tokenId;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  List get values => [
    ownerAddress,
    contractAddress,
    callValue,
    data,
    callTokenValue,
    tokenId,
  ];

  /// Convert the [TriggerSmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'contract_address': contractAddress.toAddress(visible),
      'data': BytesUtils.tryToHexString(data),
      'call_value': callValue?.toString(),
      'call_token_value': callTokenValue?.toString(),
      'token_id': tokenId?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [TriggerSmartContract] object to its string representation.
  @override
  String toString() {
    return 'TriggerSmartContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.triggerSmartContract;

  @override
  BigInt get trxAmount => callValue ?? BigInt.zero;
}
