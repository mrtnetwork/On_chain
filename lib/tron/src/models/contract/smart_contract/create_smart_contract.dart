import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/smart_contract/smart_contract.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Deploys a contract
class CreateSmartContract extends TronBaseContract {
  /// Create a new [CreateSmartContract] instance by parsing a JSON map.
  factory CreateSmartContract.fromJson(Map<String, dynamic> json) {
    return CreateSmartContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      newContract: SmartContract.fromJson(OnChainUtils.parseMap(
          value: json['new_contract'],
          name: 'new_contract',
          throwOnNull: true)!),
      callTokenValue: OnChainUtils.parseBigInt(
          value: json['call_token_value'], name: 'call_token_value'),
      tokenId:
          OnChainUtils.parseBigInt(value: json['token_id'], name: 'token_id'),
    );
  }

  /// Create a new [CreateSmartContract] instance with specified parameters.
  CreateSmartContract(
      {required this.ownerAddress,
      required this.newContract,
      this.callTokenValue,
      this.tokenId});
  factory CreateSmartContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return CreateSmartContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        newContract: SmartContract.deserialize(decode.getField(2)),
        callTokenValue: decode.getField(3),
        tokenId: decode.getField(4));
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
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'new_contract': newContract.toJson(),
      'call_token_value': callTokenValue?.toString(),
      'token_id': tokenId?.toString()
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
