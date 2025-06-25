import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Unstake some TRX staked in Stake2.0,
/// release the corresponding amount of bandwidth or energy,
/// and voting rights (TP)
class UnfreezeBalanceV2Contract extends TronBaseContract {
  /// Create a new [UnfreezeBalanceV2Contract] instance by parsing a JSON map.
  factory UnfreezeBalanceV2Contract.fromJson(Map<String, dynamic> json) {
    return UnfreezeBalanceV2Contract(
        ownerAddress: OnChainUtils.parseTronAddress(
            value: json['owner_address'], name: 'owner_address'),
        unfreezeBalance: OnChainUtils.parseBigInt(
            value: json['unfreeze_balance'], name: 'unfreeze_balance'),
        resource: ResourceCode.fromName(
            OnChainUtils.parseString(value: json['resource'], name: 'resource'),
            orElse: ResourceCode.bandWidth));
  }
  factory UnfreezeBalanceV2Contract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return UnfreezeBalanceV2Contract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        resource: decode
            .getResult(3)
            ?.castTo<ResourceCode, int>((e) => ResourceCode.fromValue(e)),
        unfreezeBalance: decode.getField(2));
  }

  /// Create a new [UnfreezeBalanceV2Contract] instance with specified parameters.
  UnfreezeBalanceV2Contract(
      {required this.ownerAddress,
      required this.unfreezeBalance,
      this.resource});

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Unstake amount, unit is sun
  final BigInt unfreezeBalance;

  /// Resource type
  final ResourceCode? resource;

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [
        ownerAddress,
        unfreezeBalance,
        resource == ResourceCode.bandWidth ? null : resource,
      ];

  /// Convert the [UnfreezeBalanceV2Contract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'unfreeze_balance': unfreezeBalance.toString(),
      'resource': resource?.name
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [UnfreezeBalanceV2Contract] object to its string representation.
  @override
  String toString() {
    return 'UnfreezeBalanceV2Contract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.unfreezeBalanceV2Contract;
}
