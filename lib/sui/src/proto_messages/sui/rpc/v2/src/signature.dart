import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart"
    as sui_rpc_v2_bcs;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature_scheme.dart"
    as sui_rpc_v2_signature_scheme;
import "package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/jwk.dart"
    as sui_rpc_v2_jwk;

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// A signature from a user.
class SuiUserSignature extends SuiProtoMessage {
  /// This signature serialized as as BCS.
  ///
  /// When provided as input this will support both the form that is length
  /// prefixed as well as not length prefixed.
  final sui_rpc_v2_bcs.SuiBcs? bcs;

  /// The signature scheme of this signature.
  final sui_rpc_v2_signature_scheme.SuiSignatureScheme? scheme;

  /// Simple signature if scheme is ed25519 | secp256k1 | secp256r1.
  final SuiSimpleSignature? simple;

  /// The multisig aggregated signature if scheme is `MULTISIG`.
  final SuiMultisigAggregatedSignature? multisig;

  /// The zklogin authenticator if scheme is `ZKLOGIN`.
  final SuiZkLoginAuthenticator? zklogin;

  /// The passkey authenticator if scheme is `PASSKEY`.
  final SuiPasskeyAuthenticator? passkey;

  const SuiUserSignature({
    this.bcs,
    this.scheme,
    this.simple,
    this.multisig,
    this.zklogin,
    this.passkey,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.enumType(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    bcs,
    scheme,
    simple,
    multisig,
    zklogin,
    passkey,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'bcs': config.encodeMessage(bcs),
      'scheme': config.encodeEnum(scheme),
      'simple': config.encodeMessage(simple),
      'multisig': config.encodeMessage(multisig),
      'zklogin': config.encodeMessage(zklogin),
      'passkey': config.encodeMessage(passkey),
    };
  }

  factory SuiUserSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiUserSignature(
      bcs: json.valueTo<sui_rpc_v2_bcs.SuiBcs?, Object>(
        key: 'bcs',
        parse:
            (v) => sui_rpc_v2_bcs.SuiBcs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      scheme: json
          .valueTo<sui_rpc_v2_signature_scheme.SuiSignatureScheme?, Object?>(
            key: 'scheme',
            parse:
                (v) => sui_rpc_v2_signature_scheme.SuiSignatureScheme.from(v),
          ),
      simple: json.valueTo<SuiSimpleSignature?, Object>(
        key: 'simple',
        parse:
            (v) => SuiSimpleSignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      multisig: json.valueTo<SuiMultisigAggregatedSignature?, Object>(
        key: 'multisig',
        parse:
            (v) => SuiMultisigAggregatedSignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      zklogin: json.valueTo<SuiZkLoginAuthenticator?, Object>(
        key: 'zklogin',
        parse:
            (v) => SuiZkLoginAuthenticator.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      passkey: json.valueTo<SuiPasskeyAuthenticator?, Object>(
        key: 'passkey',
        parse:
            (v) => SuiPasskeyAuthenticator.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiUserSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiUserSignature(
      bcs: decode.messageTo<sui_rpc_v2_bcs.SuiBcs?>(
        1,
        (b) => sui_rpc_v2_bcs.SuiBcs.deserialize(b),
      ),
      scheme: decode.getEnum<sui_rpc_v2_signature_scheme.SuiSignatureScheme?>(
        2,
        sui_rpc_v2_signature_scheme.SuiSignatureScheme.values,
      ),
      simple: decode.messageTo<SuiSimpleSignature?>(
        3,
        (b) => SuiSimpleSignature.deserialize(b),
      ),
      multisig: decode.messageTo<SuiMultisigAggregatedSignature?>(
        4,
        (b) => SuiMultisigAggregatedSignature.deserialize(b),
      ),
      zklogin: decode.messageTo<SuiZkLoginAuthenticator?>(
        5,
        (b) => SuiZkLoginAuthenticator.deserialize(b),
      ),
      passkey: decode.messageTo<SuiPasskeyAuthenticator?>(
        6,
        (b) => SuiPasskeyAuthenticator.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2UserSignature;
}

/// Either an ed25519, secp256k1 or secp256r1 signature
class SuiSimpleSignature extends SuiProtoMessage {
  /// The signature scheme of this signature.
  final sui_rpc_v2_signature_scheme.SuiSignatureScheme? scheme;

  /// Signature bytes
  final BuBytes? signature;

  /// Public key bytes
  final BuBytes? publicKey;

  SuiSimpleSignature({this.scheme, List<int>? signature, List<int>? publicKey})
    : signature = signature?.asImmutableBytes,
      publicKey = publicKey?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [scheme, signature, publicKey];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'scheme': config.encodeEnum(scheme),
      'signature': config.encodeBinary(signature),
      'public_key': config.encodeBinary(publicKey),
    };
  }

  factory SuiSimpleSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiSimpleSignature(
      scheme: json
          .valueTo<sui_rpc_v2_signature_scheme.SuiSignatureScheme?, Object?>(
            key: 'scheme',
            parse:
                (v) => sui_rpc_v2_signature_scheme.SuiSignatureScheme.from(v),
          ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      publicKey: config.decodeBinary<List<int>?>(
        json.valueAs('public_key', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory SuiSimpleSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSimpleSignature(
      scheme: decode.getEnum<sui_rpc_v2_signature_scheme.SuiSignatureScheme?>(
        1,
        sui_rpc_v2_signature_scheme.SuiSignatureScheme.values,
      ),
      signature: decode.getBytes<List<int>?>(2),
      publicKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2SimpleSignature;
}

/// Public key equivalent for zklogin authenticators.
class SuiZkLoginPublicIdentifier extends SuiProtoMessage {
  final String? iss;

  /// base10 encoded Bn254FieldElement
  final String? addressSeed;

  const SuiZkLoginPublicIdentifier({this.iss, this.addressSeed});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [iss, addressSeed];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'iss': iss, 'address_seed': addressSeed};
  }

  factory SuiZkLoginPublicIdentifier.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiZkLoginPublicIdentifier(
      iss: json.valueAsString<String?>(
        'iss',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      addressSeed: json.valueAsString<String?>(
        'address_seed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiZkLoginPublicIdentifier.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiZkLoginPublicIdentifier(
      iss: decode.getString<String?>(1),
      addressSeed: decode.getString<String?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ZkLoginPublicIdentifier;
}

/// Set of valid public keys for multisig committee members.
class SuiMultisigMemberPublicKey extends SuiProtoMessage {
  /// The signature scheme of this public key.
  final sui_rpc_v2_signature_scheme.SuiSignatureScheme? scheme;

  /// Public key bytes if scheme is ed25519 | secp256k1 | secp256r1 | passkey.
  final BuBytes? publicKey;

  /// A zklogin public identifier if scheme is zklogin.
  final SuiZkLoginPublicIdentifier? zklogin;

  SuiMultisigMemberPublicKey({this.scheme, List<int>? publicKey, this.zklogin})
    : publicKey = publicKey?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [scheme, publicKey, zklogin];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'scheme': config.encodeEnum(scheme),
      'public_key': config.encodeBinary(publicKey),
      'zklogin': config.encodeMessage(zklogin),
    };
  }

  factory SuiMultisigMemberPublicKey.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMultisigMemberPublicKey(
      scheme: json
          .valueTo<sui_rpc_v2_signature_scheme.SuiSignatureScheme?, Object?>(
            key: 'scheme',
            parse:
                (v) => sui_rpc_v2_signature_scheme.SuiSignatureScheme.from(v),
          ),
      publicKey: config.decodeBinary<List<int>?>(
        json.valueAs('public_key', normalizeKeyLookup: config.normalizeKeys),
      ),
      zklogin: json.valueTo<SuiZkLoginPublicIdentifier?, Object>(
        key: 'zklogin',
        parse:
            (v) => SuiZkLoginPublicIdentifier.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMultisigMemberPublicKey.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMultisigMemberPublicKey(
      scheme: decode.getEnum<sui_rpc_v2_signature_scheme.SuiSignatureScheme?>(
        1,
        sui_rpc_v2_signature_scheme.SuiSignatureScheme.values,
      ),
      publicKey: decode.getBytes<List<int>?>(2),
      zklogin: decode.messageTo<SuiZkLoginPublicIdentifier?>(
        3,
        (b) => SuiZkLoginPublicIdentifier.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MultisigMemberPublicKey;
}

/// A member in a multisig committee.
class SuiMultisigMember extends SuiProtoMessage {
  /// The public key of the committee member.
  final SuiMultisigMemberPublicKey? publicKey;

  /// The weight of this member's signature.
  final int? weight;

  const SuiMultisigMember({this.publicKey, this.weight});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [publicKey, weight];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'public_key': config.encodeMessage(publicKey), 'weight': weight};
  }

  factory SuiMultisigMember.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMultisigMember(
      publicKey: json.valueTo<SuiMultisigMemberPublicKey?, Object>(
        key: 'public_key',
        parse:
            (v) => SuiMultisigMemberPublicKey.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      weight: json.valueAsInt<int?>(
        'weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMultisigMember.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMultisigMember(
      publicKey: decode.messageTo<SuiMultisigMemberPublicKey?>(
        1,
        (b) => SuiMultisigMemberPublicKey.deserialize(b),
      ),
      weight: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MultisigMember;
}

/// A multisig committee.
class SuiMultisigCommittee extends SuiProtoMessage {
  /// A list of committee members and their corresponding weight.
  final List<SuiMultisigMember> members;

  /// The threshold of signatures needed to validate a signature from
  /// this committee.
  final int? threshold;

  const SuiMultisigCommittee({this.members = const [], this.threshold});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [members, threshold];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'members': members.map((e) => config.encodeMessage(e)).toList(),
      'threshold': threshold,
    };
  }

  factory SuiMultisigCommittee.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMultisigCommittee(
      members:
          (json.valueEnsureAsList<dynamic>(
                'members',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiMultisigMember, Object>(
                  value: e,
                  parse:
                      (v) => SuiMultisigMember.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      threshold: json.valueAsInt<int?>(
        'threshold',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMultisigCommittee.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMultisigCommittee(
      members:
          decode
              .getListOfBytes(1)
              .map((b) => SuiMultisigMember.deserialize(b))
              .toList(),
      threshold: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MultisigCommittee;
}

/// Aggregated signature from members of a multisig committee.
class SuiMultisigAggregatedSignature extends SuiProtoMessage {
  /// The plain signatures encoded with signature scheme.
  ///
  /// The signatures must be in the same order as they are listed in the committee.
  final List<SuiMultisigMemberSignature> signatures;

  /// Bitmap indicating which committee members contributed to the
  /// signature.
  final int? bitmap;

  /// If present, means this signature's on-chain format uses the old
  /// legacy multisig format.
  final BuBytes? legacyBitmap;

  /// The committee to use to validate this signature.
  final SuiMultisigCommittee? committee;

  SuiMultisigAggregatedSignature({
    this.signatures = const [],
    this.bitmap,
    List<int>? legacyBitmap,
    this.committee,
  }) : legacyBitmap = legacyBitmap?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    signatures,
    bitmap,
    legacyBitmap,
    committee,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'signatures': signatures.map((e) => config.encodeMessage(e)).toList(),
      'bitmap': bitmap,
      'legacy_bitmap': config.encodeBinary(legacyBitmap),
      'committee': config.encodeMessage(committee),
    };
  }

  factory SuiMultisigAggregatedSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMultisigAggregatedSignature(
      signatures:
          (json.valueEnsureAsList<dynamic>(
                'signatures',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiMultisigMemberSignature, Object>(
                  value: e,
                  parse:
                      (v) => SuiMultisigMemberSignature.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      bitmap: json.valueAsInt<int?>(
        'bitmap',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      legacyBitmap: config.decodeBinary<List<int>?>(
        json.valueAs('legacy_bitmap', normalizeKeyLookup: config.normalizeKeys),
      ),
      committee: json.valueTo<SuiMultisigCommittee?, Object>(
        key: 'committee',
        parse:
            (v) => SuiMultisigCommittee.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMultisigAggregatedSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMultisigAggregatedSignature(
      signatures:
          decode
              .getListOfBytes(1)
              .map((b) => SuiMultisigMemberSignature.deserialize(b))
              .toList(),
      bitmap: decode.getInt<int?>(2),
      legacyBitmap: decode.getBytes<List<int>?>(3),
      committee: decode.messageTo<SuiMultisigCommittee?>(
        4,
        (b) => SuiMultisigCommittee.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MultisigAggregatedSignature;
}

/// A signature from a member of a multisig committee.
class SuiMultisigMemberSignature extends SuiProtoMessage {
  /// The signature scheme of this signature.
  final sui_rpc_v2_signature_scheme.SuiSignatureScheme? scheme;

  /// Signature bytes if scheme is ed25519 | secp256k1 | secp256r1.
  final BuBytes? signature;

  /// The zklogin authenticator if scheme is `ZKLOGIN`.
  final SuiZkLoginAuthenticator? zklogin;

  /// The passkey authenticator if scheme is `PASSKEY`.
  final SuiPasskeyAuthenticator? passkey;

  SuiMultisigMemberSignature({
    this.scheme,
    List<int>? signature,
    this.zklogin,
    this.passkey,
  }) : signature = signature?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.enumType(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [scheme, signature, zklogin, passkey];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'scheme': config.encodeEnum(scheme),
      'signature': config.encodeBinary(signature),
      'zklogin': config.encodeMessage(zklogin),
      'passkey': config.encodeMessage(passkey),
    };
  }

  factory SuiMultisigMemberSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiMultisigMemberSignature(
      scheme: json
          .valueTo<sui_rpc_v2_signature_scheme.SuiSignatureScheme?, Object?>(
            key: 'scheme',
            parse:
                (v) => sui_rpc_v2_signature_scheme.SuiSignatureScheme.from(v),
          ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      zklogin: json.valueTo<SuiZkLoginAuthenticator?, Object>(
        key: 'zklogin',
        parse:
            (v) => SuiZkLoginAuthenticator.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      passkey: json.valueTo<SuiPasskeyAuthenticator?, Object>(
        key: 'passkey',
        parse:
            (v) => SuiPasskeyAuthenticator.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiMultisigMemberSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMultisigMemberSignature(
      scheme: decode.getEnum<sui_rpc_v2_signature_scheme.SuiSignatureScheme?>(
        1,
        sui_rpc_v2_signature_scheme.SuiSignatureScheme.values,
      ),
      signature: decode.getBytes<List<int>?>(2),
      zklogin: decode.messageTo<SuiZkLoginAuthenticator?>(
        3,
        (b) => SuiZkLoginAuthenticator.deserialize(b),
      ),
      passkey: decode.messageTo<SuiPasskeyAuthenticator?>(
        4,
        (b) => SuiPasskeyAuthenticator.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2MultisigMemberSignature;
}

/// A zklogin authenticator.
class SuiZkLoginAuthenticator extends SuiProtoMessage {
  /// Zklogin proof and inputs required to perform proof verification.
  final SuiZkLoginInputs? inputs;

  /// Maximum epoch for which the proof is valid.
  final BigInt? maxEpoch;

  /// User signature with the public key attested to by the provided proof.
  final SuiSimpleSignature? signature;

  /// The public identifier (similar to a public key) for this zklogin authenticator
  final SuiZkLoginPublicIdentifier? publicIdentifier;

  /// The id of the JWK used to authorize this zklogin authenticator
  final sui_rpc_v2_jwk.SuiJwkId? jwkId;

  const SuiZkLoginAuthenticator({
    this.inputs,
    this.maxEpoch,
    this.signature,
    this.publicIdentifier,
    this.jwkId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
        ProtoFieldConfig.message(4, hasOptionalFlags: true),
        ProtoFieldConfig.message(5, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    inputs,
    maxEpoch,
    signature,
    publicIdentifier,
    jwkId,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'inputs': config.encodeMessage(inputs),
      'max_epoch': config.encodeBigint(maxEpoch),
      'signature': config.encodeMessage(signature),
      'public_identifier': config.encodeMessage(publicIdentifier),
      'jwk_id': config.encodeMessage(jwkId),
    };
  }

  factory SuiZkLoginAuthenticator.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiZkLoginAuthenticator(
      inputs: json.valueTo<SuiZkLoginInputs?, Object>(
        key: 'inputs',
        parse:
            (v) => SuiZkLoginInputs.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      maxEpoch: json.valueAsBigInt<BigInt?>(
        'max_epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: json.valueTo<SuiSimpleSignature?, Object>(
        key: 'signature',
        parse:
            (v) => SuiSimpleSignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      publicIdentifier: json.valueTo<SuiZkLoginPublicIdentifier?, Object>(
        key: 'public_identifier',
        parse:
            (v) => SuiZkLoginPublicIdentifier.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      jwkId: json.valueTo<sui_rpc_v2_jwk.SuiJwkId?, Object>(
        key: 'jwk_id',
        parse:
            (v) => sui_rpc_v2_jwk.SuiJwkId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiZkLoginAuthenticator.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiZkLoginAuthenticator(
      inputs: decode.messageTo<SuiZkLoginInputs?>(
        1,
        (b) => SuiZkLoginInputs.deserialize(b),
      ),
      maxEpoch: decode.getBigInt<BigInt?>(2),
      signature: decode.messageTo<SuiSimpleSignature?>(
        3,
        (b) => SuiSimpleSignature.deserialize(b),
      ),
      publicIdentifier: decode.messageTo<SuiZkLoginPublicIdentifier?>(
        4,
        (b) => SuiZkLoginPublicIdentifier.deserialize(b),
      ),
      jwkId: decode.messageTo<sui_rpc_v2_jwk.SuiJwkId?>(
        5,
        (b) => sui_rpc_v2_jwk.SuiJwkId.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ZkLoginAuthenticator;
}

/// A zklogin groth16 proof and the required inputs to perform proof verification.
class SuiZkLoginInputs extends SuiProtoMessage {
  final SuiZkLoginProof? proofPoints;

  final SuiZkLoginClaim? issBase64Details;

  final String? headerBase64;

  /// base10 encoded Bn254FieldElement
  final String? addressSeed;

  const SuiZkLoginInputs({
    this.proofPoints,
    this.issBase64Details,
    this.headerBase64,
    this.addressSeed,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    proofPoints,
    issBase64Details,
    headerBase64,
    addressSeed,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'proof_points': config.encodeMessage(proofPoints),
      'iss_base64_details': config.encodeMessage(issBase64Details),
      'header_base64': headerBase64,
      'address_seed': addressSeed,
    };
  }

  factory SuiZkLoginInputs.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiZkLoginInputs(
      proofPoints: json.valueTo<SuiZkLoginProof?, Object>(
        key: 'proof_points',
        parse:
            (v) =>
                SuiZkLoginProof.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      issBase64Details: json.valueTo<SuiZkLoginClaim?, Object>(
        key: 'iss_base64_details',
        parse:
            (v) =>
                SuiZkLoginClaim.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      headerBase64: json.valueAsString<String?>(
        'header_base64',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      addressSeed: json.valueAsString<String?>(
        'address_seed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiZkLoginInputs.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiZkLoginInputs(
      proofPoints: decode.messageTo<SuiZkLoginProof?>(
        1,
        (b) => SuiZkLoginProof.deserialize(b),
      ),
      issBase64Details: decode.messageTo<SuiZkLoginClaim?>(
        2,
        (b) => SuiZkLoginClaim.deserialize(b),
      ),
      headerBase64: decode.getString<String?>(3),
      addressSeed: decode.getString<String?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ZkLoginInputs;
}

/// A zklogin groth16 proof.
class SuiZkLoginProof extends SuiProtoMessage {
  final SuiCircomG1? a;

  final SuiCircomG2? b;

  final SuiCircomG1? c;

  const SuiZkLoginProof({this.a, this.b, this.c});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1, hasOptionalFlags: true),
        ProtoFieldConfig.message(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [a, b, c];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'a': config.encodeMessage(a),
      'b': config.encodeMessage(b),
      'c': config.encodeMessage(c),
    };
  }

  factory SuiZkLoginProof.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiZkLoginProof(
      a: json.valueTo<SuiCircomG1?, Object>(
        key: 'a',
        parse:
            (v) => SuiCircomG1.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      b: json.valueTo<SuiCircomG2?, Object>(
        key: 'b',
        parse:
            (v) => SuiCircomG2.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      c: json.valueTo<SuiCircomG1?, Object>(
        key: 'c',
        parse:
            (v) => SuiCircomG1.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiZkLoginProof.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiZkLoginProof(
      a: decode.messageTo<SuiCircomG1?>(1, (b) => SuiCircomG1.deserialize(b)),
      b: decode.messageTo<SuiCircomG2?>(2, (b) => SuiCircomG2.deserialize(b)),
      c: decode.messageTo<SuiCircomG1?>(3, (b) => SuiCircomG1.deserialize(b)),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ZkLoginProof;
}

/// A claim of the iss in a zklogin proof.
class SuiZkLoginClaim extends SuiProtoMessage {
  final String? value;

  final int? indexMod4;

  const SuiZkLoginClaim({this.value, this.indexMod4});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint32(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [value, indexMod4];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'value': value, 'index_mod_4': indexMod4};
  }

  factory SuiZkLoginClaim.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiZkLoginClaim(
      value: json.valueAsString<String?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      indexMod4: json.valueAsInt<int?>(
        'index_mod_4',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiZkLoginClaim.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiZkLoginClaim(
      value: decode.getString<String?>(1),
      indexMod4: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ZkLoginClaim;
}

/// A G1 point.
class SuiCircomG1 extends SuiProtoMessage {
  /// base10 encoded Bn254FieldElement
  final String? e0;

  /// base10 encoded Bn254FieldElement
  final String? e1;

  /// base10 encoded Bn254FieldElement
  final String? e2;

  const SuiCircomG1({this.e0, this.e1, this.e2});

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
  List<Object?> get protoValues => [e0, e1, e2];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'e0': e0, 'e1': e1, 'e2': e2};
  }

  factory SuiCircomG1.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCircomG1(
      e0: json.valueAsString<String?>(
        'e0',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e1: json.valueAsString<String?>(
        'e1',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e2: json.valueAsString<String?>(
        'e2',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiCircomG1.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCircomG1(
      e0: decode.getString<String?>(1),
      e1: decode.getString<String?>(2),
      e2: decode.getString<String?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CircomG1;
}

/// A G2 point.
class SuiCircomG2 extends SuiProtoMessage {
  /// base10 encoded Bn254FieldElement
  final String? e00;

  /// base10 encoded Bn254FieldElement
  final String? e01;

  /// base10 encoded Bn254FieldElement
  final String? e10;

  /// base10 encoded Bn254FieldElement
  final String? e11;

  /// base10 encoded Bn254FieldElement
  final String? e20;

  /// base10 encoded Bn254FieldElement
  final String? e21;

  const SuiCircomG2({
    this.e00,
    this.e01,
    this.e10,
    this.e11,
    this.e20,
    this.e21,
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
        ProtoFieldConfig.string(3, hasOptionalFlags: true),
        ProtoFieldConfig.string(4, hasOptionalFlags: true),
        ProtoFieldConfig.string(5, hasOptionalFlags: true),
        ProtoFieldConfig.string(6, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [e00, e01, e10, e11, e20, e21];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'e00': e00,
      'e01': e01,
      'e10': e10,
      'e11': e11,
      'e20': e20,
      'e21': e21,
    };
  }

  factory SuiCircomG2.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiCircomG2(
      e00: json.valueAsString<String?>(
        'e00',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e01: json.valueAsString<String?>(
        'e01',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e10: json.valueAsString<String?>(
        'e10',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e11: json.valueAsString<String?>(
        'e11',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e20: json.valueAsString<String?>(
        'e20',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e21: json.valueAsString<String?>(
        'e21',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiCircomG2.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiCircomG2(
      e00: decode.getString<String?>(1),
      e01: decode.getString<String?>(2),
      e10: decode.getString<String?>(3),
      e11: decode.getString<String?>(4),
      e20: decode.getString<String?>(5),
      e21: decode.getString<String?>(6),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2CircomG2;
}

/// A passkey authenticator.
///
/// See
/// [struct.PasskeyAuthenticator](https://mystenlabs.github.io/sui-rust-sdk/sui_sdk_types/struct.PasskeyAuthenticator.html#bcs)
/// for more information on the requirements on the shape of the
/// `client_data_json` field.
class SuiPasskeyAuthenticator extends SuiProtoMessage {
  /// Opaque authenticator data for this passkey signature.
  ///
  /// See [Authenticator Data](https://www.w3.org/TR/webauthn-2/#sctn-authenticator-data) for
  /// more information on this field.
  final BuBytes? authenticatorData;

  /// Structured, unparsed, JSON for this passkey signature.
  ///
  /// See [CollectedClientData](https://www.w3.org/TR/webauthn-2/#dictdef-collectedclientdata)
  /// for more information on this field.
  final String? clientDataJson;

  /// A secp256r1 signature.
  final SuiSimpleSignature? signature;

  SuiPasskeyAuthenticator({
    List<int>? authenticatorData,
    this.clientDataJson,
    this.signature,
  }) : authenticatorData = authenticatorData?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1, hasOptionalFlags: true),
        ProtoFieldConfig.string(2, hasOptionalFlags: true),
        ProtoFieldConfig.message(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    authenticatorData,
    clientDataJson,
    signature,
  ];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'authenticator_data': config.encodeBinary(authenticatorData),
      'client_data_json': clientDataJson,
      'signature': config.encodeMessage(signature),
    };
  }

  factory SuiPasskeyAuthenticator.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiPasskeyAuthenticator(
      authenticatorData: config.decodeBinary<List<int>?>(
        json.valueAs(
          'authenticator_data',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      clientDataJson: json.valueAsString<String?>(
        'client_data_json',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: json.valueTo<SuiSimpleSignature?, Object>(
        key: 'signature',
        parse:
            (v) => SuiSimpleSignature.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiPasskeyAuthenticator.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiPasskeyAuthenticator(
      authenticatorData: decode.getBytes<List<int>?>(1),
      clientDataJson: decode.getString<String?>(2),
      signature: decode.messageTo<SuiSimpleSignature?>(
        3,
        (b) => SuiSimpleSignature.deserialize(b),
      ),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2PasskeyAuthenticator;
}

/// The validator set for a particular epoch.
class SuiValidatorCommittee extends SuiProtoMessage {
  /// The epoch where this committee governs.
  final BigInt? epoch;

  /// The committee members.
  final List<SuiValidatorCommitteeMember> members;

  const SuiValidatorCommittee({this.epoch, this.members = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [epoch, members];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'members': members.map((e) => config.encodeMessage(e)).toList(),
    };
  }

  factory SuiValidatorCommittee.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorCommittee(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      members:
          (json.valueEnsureAsList<dynamic>(
                'members',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<SuiValidatorCommitteeMember, Object>(
                  value: e,
                  parse:
                      (v) => SuiValidatorCommitteeMember.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory SuiValidatorCommittee.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorCommittee(
      epoch: decode.getBigInt<BigInt?>(1),
      members:
          decode
              .getListOfBytes(2)
              .map((b) => SuiValidatorCommitteeMember.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorCommittee;
}

/// A member of a validator committee.
class SuiValidatorCommitteeMember extends SuiProtoMessage {
  /// The 96-byte Bls12381 public key for this validator.
  final BuBytes? publicKey;

  /// voting weight this validator possesses.
  final BigInt? weight;

  SuiValidatorCommitteeMember({List<int>? publicKey, this.weight})
    : publicKey = publicKey?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1, hasOptionalFlags: true),
        ProtoFieldConfig.uint64(2, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [publicKey, weight];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'public_key': config.encodeBinary(publicKey),
      'weight': config.encodeBigint(weight),
    };
  }

  factory SuiValidatorCommitteeMember.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorCommitteeMember(
      publicKey: config.decodeBinary<List<int>?>(
        json.valueAs('public_key', normalizeKeyLookup: config.normalizeKeys),
      ),
      weight: json.valueAsBigInt<BigInt?>(
        'weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiValidatorCommitteeMember.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorCommitteeMember(
      publicKey: decode.getBytes<List<int>?>(1),
      weight: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorCommitteeMember;
}

/// / An aggregated signature from multiple validators.
class SuiValidatorAggregatedSignature extends SuiProtoMessage {
  /// The epoch when this signature was produced.
  ///
  /// This can be used to lookup the `ValidatorCommittee` from this epoch
  /// to verify this signature.
  final BigInt? epoch;

  /// The 48-byte Bls12381 aggregated signature.
  final BuBytes? signature;

  /// Bitmap indicating which members of the committee contributed to
  /// this signature.
  final BuBytes? bitmap;

  SuiValidatorAggregatedSignature({
    this.epoch,
    List<int>? signature,
    List<int>? bitmap,
  }) : signature = signature?.asImmutableBytes,
       bitmap = bitmap?.asImmutableBytes;

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(2, hasOptionalFlags: true),
        ProtoFieldConfig.bytes(3, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [epoch, signature, bitmap];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'epoch': config.encodeBigint(epoch),
      'signature': config.encodeBinary(signature),
      'bitmap': config.encodeBinary(bitmap),
    };
  }

  factory SuiValidatorAggregatedSignature.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiValidatorAggregatedSignature(
      epoch: json.valueAsBigInt<BigInt?>(
        'epoch',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      signature: config.decodeBinary<List<int>?>(
        json.valueAs('signature', normalizeKeyLookup: config.normalizeKeys),
      ),
      bitmap: config.decodeBinary<List<int>?>(
        json.valueAs('bitmap', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory SuiValidatorAggregatedSignature.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiValidatorAggregatedSignature(
      epoch: decode.getBigInt<BigInt?>(1),
      signature: decode.getBytes<List<int>?>(2),
      bitmap: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2ValidatorAggregatedSignature;
}
