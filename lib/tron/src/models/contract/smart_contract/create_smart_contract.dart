import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Deploys a contract
class CreateSmartContract extends TronBaseContract {
  /// Create a new [CreateSmartContract] instance by parsing a JSON map.
  factory CreateSmartContract.fromJson(Map<String, dynamic> json) {
    return CreateSmartContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      newContract: SmartContract.fromJson(
        json.valueEnsureAsMap<String, dynamic>("new_contract"),
      ),
      callTokenValue: json.valueAsBigInt("call_token_value"),
      tokenId: json.valueAsBigInt("token_id"),
    );
  }

  /// Create a new [CreateSmartContract] instance with specified parameters.
  CreateSmartContract({
    required this.ownerAddress,
    required this.newContract,
    BigInt? callTokenValue,
    this.tokenId,
  }) : callTokenValue = callTokenValue == BigInt.zero ? null : callTokenValue;
  factory CreateSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return CreateSmartContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      newContract: SmartContract.deserialize(decode.getField(2)),
      callTokenValue: decode.getField(3),
      tokenId: decode.getField(4),
    );
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Deployed contract data, the fields contained in it
  final SmartContract newContract;

  /// The amount of TRC-10 transferred into the contract
  final BigInt? callTokenValue;

  /// TRC-10 token id
  final BigInt? tokenId;

  /// Convert the [CreateSmartContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'new_contract': newContract.toJson(visible: visible),
      'call_token_value': callTokenValue?.toString(),
      'token_id': tokenId?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, newContract, callTokenValue, tokenId];

  /// Convert the [CreateSmartContract] object to its string representation.
  @override
  String toString() {
    return 'CreateSmartContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.createSmartContract;

  @override
  BigInt get trxAmount => newContract.callValue ?? BigInt.zero;

  bool get hasTokenTransfer => callTokenValue != null && tokenId != null;
}
