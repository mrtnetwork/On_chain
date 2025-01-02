import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/account_id.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class Authority extends TronProtocolBufferImpl {
  /// Create a new [Authority] instance by parsing a JSON map.
  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
        account: json['account'] == null
            ? null
            : AccountId.fromJson(json['account']),
        permissionName: StringUtils.tryEncode(json['permission_name']));
  }
  factory Authority.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return Authority(
        account: decode
            .getResult(1)
            ?.castTo<AccountId, List<int>>((e) => AccountId.deserialize(e)),
        permissionName: decode.getField(2));
  }

  /// Factory method to create a new [Authority] instance with specified parameters.
  Authority({
    this.account,
    List<int>? permissionName,
  }) : permissionName =
            BytesUtils.tryToBytes(permissionName, unmodifiable: true);

  /// Account ID
  final AccountId? account;

  /// Permission name
  final List<int>? permissionName;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [account, permissionName];

  /// Convert the [Authority] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'account': account?.toJson(),
      'permission_name': StringUtils.tryDecode(permissionName)
    };
  }

  /// Convert the [Authority] object to its string representation.
  @override
  String toString() {
    return 'Authority{${toJson()}}';
  }
}
