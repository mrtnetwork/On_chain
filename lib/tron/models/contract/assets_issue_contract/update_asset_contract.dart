import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Update basic TRC10 token information.
class UpdateAssetContract extends TronBaseContract {
  /// Create a new [UpdateAssetContract] instance by parsing a JSON map.
  factory UpdateAssetContract.fromJson(Map<String, dynamic> json) {
    return UpdateAssetContract(
      ownerAddress: TronAddress(json["owner_address"]),
      description: StringUtils.tryEncode(json['description']),
      url: StringUtils.tryEncode(json['url']),
      newLimit: BigintUtils.tryParse(json['new_limit']),
      newPublicLimit: BigintUtils.tryParse(json['new_public_limit']),
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

  /// Account address
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
      "owner_address": ownerAddress.toString(),
      "description": StringUtils.tryDecode(description),
      "url": StringUtils.tryDecode(url),
      "new_limit": newLimit?.toString(),
      "new_public_limit": newPublicLimit?.toString()
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [UpdateAssetContract] object to its string representation.
  @override
  String toString() {
    return "UpdateAssetContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.updateAssetContract;
}
