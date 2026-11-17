import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// The delta, or change, in balance for an address for a particular `Coin` type.
class SuiBalanceChange extends SuiProtoMessage {
  /// The account address that is affected by this balance change event.
  final String? address;

  /// The `Coin` type of this balance change event.
  final String? coinType;

  /// The amount or change in balance.
  final String? amount;

  const SuiBalanceChange({this.address, this.coinType, this.amount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [address, coinType, amount];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'address': address, 'coin_type': coinType, 'amount': amount};
  }

  factory SuiBalanceChange.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiBalanceChange(
      address: json.valueAsString<String?>(
        'address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      coinType: json.valueAsString<String?>(
        'coin_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsString<String?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiBalanceChange.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiBalanceChange(
      address: decode.getString<String?>(1),
      coinType: decode.getString<String?>(2),
      amount: decode.getString<String?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2BalanceChange;
}
