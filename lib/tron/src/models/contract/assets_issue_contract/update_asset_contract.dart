import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Update basic TRC10 token information.
class UpdateAssetContract extends TronBaseContract {
  /// Create a new [UpdateAssetContract] instance by parsing a JSON map.
  factory UpdateAssetContract.fromJson(Map<String, dynamic> json) {
    return UpdateAssetContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      description: OnChainUtils.parseBytes(
          value: json['description'], name: 'description'),
      url: OnChainUtils.parseBytes(value: json['url'], name: 'url'),
      newLimit:
          OnChainUtils.parseBigInt(value: json['new_limit'], name: 'new_limit'),
      newPublicLimit: OnChainUtils.parseBigInt(
          value: json['new_public_limit'], name: 'new_public_limit'),
    );
  }

  /// Create a new [UpdateAssetContract] instance with specified parameters.
  UpdateAssetContract(
      {required this.ownerAddress,
      List<int>? description,
      List<int>? url,
      this.newLimit,
      this.newPublicLimit})
      : url = BytesUtils.tryToBytes(url, unmodifiable: true),
        description = BytesUtils.tryToBytes(description, unmodifiable: true);
  factory UpdateAssetContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UpdateAssetContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        description: decode.getField(2),
        url: decode.getField(3),
        newLimit: decode.getField(4),
        newPublicLimit: decode.getField(5));
  }

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Description
  final List<int>? description;

  /// Token's website Url
  final List<int>? url;

  /// The limit of Bandwidth point which each caller can consume
  final BigInt? newLimit;

  /// The limit of Bandwidth point which all caller can consume
  final BigInt? newPublicLimit;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [ownerAddress, description, url, newLimit, newPublicLimit];

  /// Convert the [UpdateAssetContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'description': StringUtils.tryDecode(description),
      'url': StringUtils.tryDecode(url),
      'new_limit': newLimit?.toString(),
      'new_public_limit': newPublicLimit?.toString()
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [UpdateAssetContract] object to its string representation.
  @override
  String toString() {
    return 'UpdateAssetContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateAssetContract;
}
