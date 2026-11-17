import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart"
    as sui_rpc_v2_signature;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// The committed to contents of a checkpoint.
class SuiCheckpointContents extends SuiProtoMessage {
  /// This CheckpointContents serialized as BCS.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

  /// The digest of this CheckpointContents.
  final String? digest;

  /// Version of this CheckpointContents
  final int? version;

  /// Set of transactions committed to in this checkpoint.
  final List<SuiCheckpointedTransactionInfo> transactions;

  const SuiCheckpointContents({
    this.bcs,
    this.digest,
    this.version,
    this.transactions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.int32(3, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [bcs, digest, version, transactions];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'bcs': config.encodeMessage(bcs),
      'digest': digest,
      'version': version,
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiCheckpointContents.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCheckpointContents(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      digest: json.valueAsString<String?>(
        'digest',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      version: json.valueAsInt<int?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) =>
                    JsonParser.valueTo<SuiCheckpointedTransactionInfo, Object>(
                      value: e,
                      parse:
                          (v) => SuiCheckpointedTransactionInfo.fromJson(
                            JsonParser.valueAs(v),
                            config: config,
                          ),
                    ),
              )
              .toList(),
    );
  }

  factory SuiCheckpointContents.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCheckpointContents(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        1,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      digest: decode.getString<String?>(2),
      version: decode.getInt<int?>(3),
      transactions:
          decode
              .getListOfBytes(4)
              .map((b) => SuiCheckpointedTransactionInfo.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CheckpointContents;
}

/// Transaction information committed to in a checkpoint.
class SuiCheckpointedTransactionInfo extends SuiProtoMessage {
  /// Digest of the transaction.
  final String? transaction;

  /// Digest of the effects.
  final String? effects;

  /// Set of user signatures that authorized the transaction.
  final List<sui_rpc_v2_signature.SuiUserSignature> signatures;

  /// The `AddressAliases` object version, if any, that was used to verify the
  /// UserSignature at the same position in `signatures`.
  ///
  /// This field is present when CheckpointContents.version is &gt;= 2.
  final List<SuiAddressAliasesVersion> addressAliasesVersions;

  const SuiCheckpointedTransactionInfo({
    this.transaction,
    this.effects,
    this.signatures = const [],
    this.addressAliasesVersions = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transaction,
    effects,
    signatures,
    addressAliasesVersions,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'transaction': transaction,
      'effects': effects,
      'signatures': signatures.map((e) => config.encodeMessage(e)).toList(),
      'address_aliases_versions':
          addressAliasesVersions.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiCheckpointedTransactionInfo.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCheckpointedTransactionInfo(
      transaction: json.valueAsString<String?>(
        'transaction',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      effects: json.valueAsString<String?>(
        'effects',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signatures:
          (json.valueEnsureAsList<dynamic>(
                'signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  sui_rpc_v2_signature.SuiUserSignature,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => sui_rpc_v2_signature.SuiUserSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      addressAliasesVersions:
          (json.valueEnsureAsList<dynamic>(
                'address_aliases_versions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiAddressAliasesVersion, Object>(
                  value: e,
                  parse:
                      (v) => SuiAddressAliasesVersion.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiCheckpointedTransactionInfo.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCheckpointedTransactionInfo(
      transaction: decode.getString<String?>(1),
      effects: decode.getString<String?>(2),
      signatures:
          decode
              .getListOfBytes(3)
              .map((b) => sui_rpc_v2_signature.SuiUserSignature.deserialize(b))
              .toList(),
      addressAliasesVersions:
          decode
              .getListOfBytes(4)
              .map((b) => SuiAddressAliasesVersion.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CheckpointedTransactionInfo;
}

class SuiAddressAliasesVersion extends SuiProtoMessage {
  final BigInt? version;

  const SuiAddressAliasesVersion({this.version});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.uint64(1, hasOptionalFlags: true)],
    );
  }

  @override
  List<Object?> get protoValues => [version];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'version': config.encodeBigint(version)};
  }

  factory SuiAddressAliasesVersion.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiAddressAliasesVersion(
      version: json.valueAsBigInt<BigInt?>(
        'version',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiAddressAliasesVersion.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAddressAliasesVersion(version: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2AddressAliasesVersion;
}
