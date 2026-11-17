import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/account/get_account_resource.dart';
import 'package:on_chain/aptos/src/provider/provider/provider.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// RSA JWK from the on-chain `0x1::jwks` set (AIP-61).
///
/// Wire form inside `PatchedJWKs`: five BCS strings
/// `[kid, kty, alg, e, n]`.
class AptosJwkKey {
  final String kid;
  final String kty;
  final String alg;
  final String e;
  final String n;

  const AptosJwkKey({
    required this.kid,
    required this.kty,
    required this.alg,
    required this.e,
    required this.n,
  });

  factory AptosJwkKey.fromBcs(List<int> bytes) {
    final parts = _readStrings(bytes, 5);
    return AptosJwkKey(
      kid: parts[0],
      kty: parts[1],
      alg: parts[2],
      e: parts[3],
      n: parts[4],
    );
  }

  /// Reads exactly [count] BCS strings (`uleb128(len) ++ utf8`).
  static List<String> _readStrings(List<int> bytes, int count) {
    final out = <String>[];
    int offset = 0;
    for (int i = 0; i < count; i++) {
      int len = 0;
      int shift = 0;
      while (true) {
        if (offset >= bytes.length) {
          throw BuError(
            DefaultErrorType.invalidLength,
            'Truncated on-chain JWK bytes.',
            details: {'field': '$i'},
          );
        }
        final b = bytes[offset++];
        len |= (b & 0x7f) << shift;
        if ((b & 0x80) == 0) break;
        shift += 7;
      }
      if (offset + len > bytes.length) {
        throw BuError(
          DefaultErrorType.invalidLength,
          'Truncated on-chain JWK bytes.',
          details: {'field': '$i'},
        );
      }
      out.add(StringUtils.decode(bytes.sublist(offset, offset + len)));
      offset += len;
    }
    if (offset != bytes.length) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Trailing bytes in on-chain JWK.',
        details: {'consumed': '$offset', 'total': '${bytes.length}'},
      );
    }
    return out;
  }
}

/// One issuer entry of `0x1::jwks::PatchedJWKs`.
class AptosPatchedJwkEntry {
  /// Issuer URL (`iss`).
  final String issuer;
  final List<AptosJwkKey> keys;

  const AptosPatchedJwkEntry({required this.issuer, required this.keys});

  factory AptosPatchedJwkEntry.fromJson(Map<String, dynamic> json) {
    final issuerHex = (json['issuer'] as String?) ?? '';
    final issuer = StringUtils.decode(BytesUtils.fromHexString(issuerHex));
    final rawKeys = (json['jwks'] as List?) ?? const [];
    return AptosPatchedJwkEntry(
      issuer: issuer,
      keys:
          rawKeys.map((e) {
            final data = ((e as Map)['variant'] as Map)['data'] as String;
            return AptosJwkKey.fromBcs(BytesUtils.fromHexString(data));
          }).toList(),
    );
  }
}

/// Parsed `0x1::jwks::PatchedJWKs` resource.
class AptosPatchedJwks {
  final List<AptosPatchedJwkEntry> entries;

  const AptosPatchedJwks(this.entries);

  factory AptosPatchedJwks.fromResource(Map<String, dynamic> data) {
    final raw = (data['jwks'] as Map?)?['entries'] as List? ?? const [];
    return AptosPatchedJwks(
      raw
          .map(
            (e) => AptosPatchedJwkEntry.fromJson(
              (e as Map).cast<String, dynamic>(),
            ),
          )
          .toList(),
    );
  }

  /// Finds the JWK for ([iss], [kid]), or throws.
  AptosJwkKey findJwk({required String iss, required String kid}) {
    final entry = entries.firstWhere(
      (e) => e.issuer == iss,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.aptosPlugin,
                'No on-chain JWKs for issuer.',
                details: {'iss': iss},
              ),
    );
    return entry.keys.firstWhere(
      (k) => k.kid == kid,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.aptosPlugin,
                'No on-chain JWK for kid.',
                details: {'iss': iss, 'kid': kid},
              ),
    );
  }
}

/// Chain-backed JWK resolution over the fullnode REST API.
///
/// Reads `0x1::jwks::PatchedJWKs` through any [provider] (HTTP transport
/// stays with the caller, like every other live helper in this package).
class AptosChainJwks {
  static const String patchedJwksType = '0x1::jwks::PatchedJWKs';
  static const String frameworkAddress = '0x1';

  /// Fetches and parses the whole patched set (callers should cache it;
  /// the set rotates rarely).
  static Future<AptosPatchedJwks> fetchPatchedJwks({
    required AptosProvider provider,
  }) async {
    final resource = await provider.request(
      AptosRequestGetAccountResource(
        address: AptosAddress(frameworkAddress),
        resourceType: patchedJwksType,
      ),
    );
    return AptosPatchedJwks.fromResource(resource.data.cast<String, dynamic>());
  }

  /// Resolves a single verifying JWK for ([iss], [kid]).
  static Future<AptosJwkKey> fetchJwk({
    required AptosProvider provider,
    required String iss,
    required String kid,
  }) async {
    final set = await fetchPatchedJwks(provider: provider);
    return set.findJwk(iss: iss, kid: kid);
  }
}
