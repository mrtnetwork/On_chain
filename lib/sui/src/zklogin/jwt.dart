import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Parsed OIDC JWT (decode-only; signature checked separately on chain).
///
/// Thin strict layer over [Jwt]: keeps the raw segments plus validated
/// claim accessors (`iss`/`sub` present, string `aud`, like TS `decodeJwt`).
class SuiJwtParts {
  final Jwt jwt;

  /// Raw segments as they appear in the token (base64url, unpadded).
  final String headerBase64;
  final String payloadBase64;
  final String signatureBase64;

  const SuiJwtParts._({
    required this.jwt,
    required this.headerBase64,
    required this.payloadBase64,
    required this.signatureBase64,
  });

  /// Parses and validates structure (`iss`/`sub` present, string `aud`).
  factory SuiJwtParts.parse(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid JWT compact serialization.',
        details: {'segments': parts.length.toString()},
      );
    }
    late final Jwt jwt;
    try {
      jwt = Jwt.deserializeOidc(token);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid JWT segment.',
        details: {'error': '$e'},
      );
    }
    final self = SuiJwtParts._(
      jwt: jwt,
      headerBase64: parts[0],
      payloadBase64: parts[1],
      signatureBase64: parts[2],
    );
    // Same requirements as TS `decodeJwt`.
    if (self.sub.isEmpty || self.iss.isEmpty) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'JWT is missing sub/iss.',
        details: {'jwt': '${token.substring(0, 24)}...'},
      );
    }
    return self;
  }

  Map<String, dynamic> get header => jwt.header.toJson();
  Map<String, dynamic> get payload => jwt.payload.toJson();

  String get kid => header['kid']?.toString() ?? '';
  String get alg => jwt.header.algName ?? '';
  String get iss => payload['iss']?.toString() ?? '';
  String get sub => payload['sub']?.toString() ?? '';

  /// Audience; must be a plain string (arrays unsupported, like TS SDK).
  String get aud {
    final aud = payload['aud'];
    if (aud is! String || aud.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'JWT aud must be a non-empty string.',
        details: {'aud': '$aud'},
      );
    }
    return aud;
  }

  /// The `nonce` claim (empty when the provider omitted it).
  String get nonce => payload['nonce']?.toString() ?? '';

  /// Claim value for [name] as a string (numbers are stringified).
  String claimAsString(String name) => payload[name]?.toString() ?? '';
}
