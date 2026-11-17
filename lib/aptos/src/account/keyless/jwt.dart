import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Decoded OIDC JWT claims needed for Aptos keyless (AIP-61).
///
/// Decode-only over [Jwt]: the JWT signature is verified on chain by the
/// keyless verifier, never here. Source the token from a trusted IdP
/// redirect flow.
class AptosJwtClaims {
  final Jwt jwt;

  /// Raw segments as they appear in the token (base64url, unpadded).
  final String headerBase64;
  final String payloadBase64;

  const AptosJwtClaims._({
    required this.jwt,
    required this.headerBase64,
    required this.payloadBase64,
  });

  /// Parses a signed compact serialization (header.payload.signature).
  factory AptosJwtClaims.parse(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid JWT compact serialization.',
        details: {'segments': parts.length.toString()},
      );
    }
    try {
      return AptosJwtClaims._(
        jwt: Jwt.deserializeOidc(token),
        headerBase64: parts[0],
        payloadBase64: parts[1],
      );
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid JWT claims.',
        details: {'error': '$e'},
      );
    }
  }

  Map<String, dynamic> get header => jwt.header.toJson();
  Map<String, dynamic> get payload => jwt.payload.toJson();

  String _claim(String name) {
    final v = payload[name];
    if (v is! String || v.isEmpty) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'JWT is missing required string claim.',
        details: {'claim': name},
      );
    }
    return v;
  }

  /// Issuer claim (`iss`).
  String get iss => _claim('iss');

  /// Audience claim (`aud`); must be a plain string (not a list).
  String get aud {
    final v = payload['aud'];
    if (v is! String || v.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'JWT aud must be a plain string.',
        details: {'aud': '$v'},
      );
    }
    return v;
  }

  /// User id from [uidKey] (defaults to `sub`).
  String uidVal([String uidKey = 'sub']) => _claim(uidKey);

  /// Expiry (`exp`, seconds since epoch) when present.
  int? get exp {
    final v = payload['exp'];
    if (v is int) return v;
    if (v is String) return IntUtils.tryParse(v);
    return null;
  }

  /// Key id from the JWT header (selects the verifying JWK).
  String? get kid {
    final v = header['kid'];
    return v is String ? v : null;
  }

  /// Raw JWT header JSON (carried verbatim in the keyless authenticator).
  String get headerJson {
    final bytes = StringUtils.encode(
      headerBase64,
      encoding: StringEncoding.base64UrlSafe,
      validateB64Padding: false,
    );
    return StringUtils.decode(bytes);
  }
}
