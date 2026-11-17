import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Key to uniquely identify a JWK.
class SuiJwkId extends SuiProtoMessage {
  /// The issuer or identity of the OIDC provider.
  final String? iss;

  /// A key ID used to uniquely identify a key from an OIDC provider.
  final String? kid;

  const SuiJwkId({this.iss, this.kid});

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
  List<Object?> get protoValues => [iss, kid];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'iss': iss, 'kid': kid};
  }

  factory SuiJwkId.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiJwkId(
      iss: json.valueAsString<String?>(
        'iss',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      kid: json.valueAsString<String?>(
        'kid',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiJwkId.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiJwkId(
      iss: decode.getString<String?>(1),
      kid: decode.getString<String?>(2),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2JwkId;
}

/// A JSON web key.
///
/// Struct that contains info for a JWK. A list of them for different kinds can
/// be retrieved from the JWK endpoint (for example, &lt;https://www.googleapis.com/oauth2/v3/certs&gt;).
/// The JWK is used to verify the JWT token.
class SuiJwk extends SuiProtoMessage {
  /// Key type parameter, https://datatracker.ietf.org/doc/html/rfc7517#section-4.1.
  final String? kty;

  /// RSA public exponent, https://datatracker.ietf.org/doc/html/rfc7517#section-9.3.
  final String? e;

  /// RSA modulus, https://datatracker.ietf.org/doc/html/rfc7517#section-9.3.
  final String? n;

  /// Algorithm parameter, https://datatracker.ietf.org/doc/html/rfc7517#section-4.4.
  final String? alg;

  const SuiJwk({this.kty, this.e, this.n, this.alg});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [kty, e, n, alg];

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'kty': kty, 'e': e, 'n': n, 'alg': alg};
  }

  factory SuiJwk.fromJson(
    Map<String, dynamic> json, {
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return SuiJwk(
      kty: json.valueAsString<String?>(
        'kty',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      e: json.valueAsString<String?>(
        'e',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      n: json.valueAsString<String?>(
        'n',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      alg: json.valueAsString<String?>(
        'alg',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory SuiJwk.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiJwk(
      kty: decode.getString<String?>(1),
      e: decode.getString<String?>(2),
      n: decode.getString<String?>(3),
      alg: decode.getString<String?>(4),
    );
  }

  @override
  DefaultSuiProtoTypeUrl get declarationId =>
      DefaultSuiProtoTypeUrl.suiRpcV2Jwk;
}
