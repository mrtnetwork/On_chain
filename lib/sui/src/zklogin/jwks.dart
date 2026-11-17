import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/zklogin/jwt.dart';

/// Transport for JWKS documents. Implement with any HTTP client
/// (e.g. `package:http` in apps/tests).
mixin SuiJwksService {
  /// GETs the JWKS document text at [url].
  Future<String> fetchJwksDocument(Uri url);
}

/// JWKS provider: binds a transport to key fetches.
class SuiJwksProvider {
  final SuiJwksService service;
  const SuiJwksProvider(this.service);
}

/// An OIDC provider: JWT `iss` value + its JWKS document URL.
class SuiOidcProvider {
  final String iss;
  final String jwksUrl;
  const SuiOidcProvider({required this.iss, required this.jwksUrl});

  static const google = SuiOidcProvider(
    iss: 'https://accounts.google.com',
    jwksUrl: 'https://www.googleapis.com/oauth2/v2/certs',
  );
  static const twitch = SuiOidcProvider(
    iss: 'https://id.twitch.tv/oauth2',
    jwksUrl: 'https://id.twitch.tv/oauth2/keys',
  );
  static const facebook = SuiOidcProvider(
    iss: 'https://www.facebook.com',
    jwksUrl: 'https://www.facebook.com/.well-known/oauth/openid/jwks/',
  );
  static const kakao = SuiOidcProvider(
    iss: 'https://kauth.kakao.com',
    jwksUrl: 'https://kauth.kakao.com/.well-known/jwks.json',
  );
  static const apple = SuiOidcProvider(
    iss: 'https://appleid.apple.com',
    jwksUrl: 'https://appleid.apple.com/auth/keys',
  );
  static const slack = SuiOidcProvider(
    iss: 'https://slack.com',
    jwksUrl: 'https://slack.com/openid/connect/keys',
  );

  /// Mysten's non-interactive test issuer (devnet/tests only).
  static const testIssuer = SuiOidcProvider(
    iss: 'https://oauth.sui.io',
    jwksUrl: 'https://jwt-tester.mystenlabs.com/.well-known/jwks.json',
  );

  static const List<SuiOidcProvider> defaults = [
    google,
    twitch,
    facebook,
    kakao,
    apple,
    slack,
    testIssuer,
  ];
}

/// RSA public key (only what zkLogin needs: `kty`/`e`/`n`/`kid`/`alg`).
class SuiJwkKey {
  final String kid;
  final String kty;
  final String e;
  final String n;
  final String alg;
  const SuiJwkKey({
    required this.kid,
    required this.kty,
    required this.e,
    required this.n,
    required this.alg,
  });
  factory SuiJwkKey.fromJson(Map<String, dynamic> json) {
    return SuiJwkKey(
      kid: json['kid']?.toString() ?? '',
      kty: json['kty']?.toString() ?? '',
      e: json['e']?.toString() ?? '',
      n: json['n']?.toString() ?? '',
      alg: json['alg']?.toString() ?? '',
    );
  }
}

/// JWKS fetcher with in-memory `(iss, kid)` cache.
///
/// Register extra issuers with [register]; unknown issuers throw instead of
/// guessing a URL. Pass a [provider] to fetch; without one only the
/// registry (no network) is available.
class SuiJwksCache {
  SuiJwksCache({List<SuiOidcProvider>? providers, this.provider})
    : _providers = {
        for (final p in providers ?? SuiOidcProvider.defaults) p.iss: p,
      };
  final Map<String, SuiOidcProvider> _providers;
  final SuiJwksProvider? provider;
  final Map<String, SuiJwkKey> _keys = {};

  void register(SuiOidcProvider provider) {
    _providers[provider.iss] = provider;
  }

  /// Returns the JWK for (`parts.iss`, `parts.kid`), fetching once per key.
  /// Only RSA (`kty == 'RSA'`) keys are kept.
  Future<SuiJwkKey> getKey(SuiJwtParts parts) async {
    final fetcher = provider;
    if (fetcher == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'JWKS fetch needs a provider.',
        details: {'iss': parts.iss},
      );
    }
    final cacheKey = '${parts.iss}\n${parts.kid}';
    final cached = _keys[cacheKey];
    if (cached != null) return cached;
    final repo = _providers[parts.iss];
    if (repo == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Unknown OIDC issuer; register its JWKS URL first.',
        details: {'iss': parts.iss},
      );
    }
    late final String body;
    try {
      body = await fetcher.service.fetchJwksDocument(Uri.parse(repo.jwksUrl));
    } catch (e) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'JWKS fetch failed.',
        details: {'url': repo.jwksUrl, 'error': '$e'},
      );
    }
    return _store(cacheKey, parts, body);
  }

  SuiJwkKey _store(String cacheKey, SuiJwtParts parts, String body) {
    late final Map<String, dynamic> parsed;
    try {
      parsed = StringUtils.toJson<Map<String, dynamic>>(body);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid JWKS document.',
        details: {'error': '$e'},
      );
    }
    final keys = parsed['keys'];
    if (keys is! List) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid JWKS document: missing "keys" list.',
      );
    }
    for (final entry in keys) {
      if (entry is! Map) continue;
      final key = SuiJwkKey.fromJson(entry.cast<String, dynamic>());
      if (key.kty != 'RSA' || key.kid.isEmpty) continue;
      _keys['${parts.iss}\n${key.kid}'] = key;
    }
    final found = _keys[cacheKey];
    if (found == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'No matching JWK for JWT kid.',
        details: {'kid': parts.kid, 'iss': parts.iss},
      );
    }
    return found;
  }
}
