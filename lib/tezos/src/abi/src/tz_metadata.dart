import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Resolves a TZIP-16 metadata URI to raw bytes. You supply the fetchers —
/// this stays a pure library with no hard network/RPC dependency.
class TezosMetadataResolver {
  /// Fetches `bytes` value for [key] out of the given big_map id, as the
  /// RPC does: GET .../big_maps/{id}/{script_expr(key)} -> {"bytes": "..."}.
  /// Needed for `tezos-storage:key` (self) and `tezos-storage:key?contract=KT1...`.
  final Future<List<int>?> Function(BigInt bigMapId, String key)
  fetchStorageBytes;

  /// Fetches raw bytes from an http(s):// or ipfs:// (already-gatewayed) URL.
  final Future<List<int>> Function(String url) fetchUrl;

  /// Optional: resolves `KT1...` -> its metadata big_map id, for the
  /// `tezos-storage:key?contract=KT1...` cross-contract form. Only needed
  /// if you expect to hit that form.
  final Future<BigInt> Function(String contractAddress)?
  resolveMetadataBigMapId;

  TezosMetadataResolver({
    required this.fetchStorageBytes,
    required this.fetchUrl,
    this.resolveMetadataBigMapId,
  });

  /// [ownMetadataBigMapId] is this contract's own `%metadata` big_map id
  /// (get it via `abi.getBigMapId(storage, path: 'metadata')`).
  Future<Map<String, dynamic>> resolve(
    String uri, {
    required BigInt ownMetadataBigMapId,
  }) async {
    final bytes = await _resolveToBytes(uri, ownMetadataBigMapId);
    return StringUtils.decodeJson(bytes);
  }

  Future<List<int>> _resolveToBytes(String uri, BigInt ownBigMapId) async {
    if (uri.startsWith('tezos-storage:')) {
      final rest = uri.substring('tezos-storage:'.length);
      final qIdx = rest.indexOf('?');
      final key = qIdx < 0 ? rest : rest.substring(0, qIdx);
      var bigMapId = ownBigMapId;
      if (qIdx >= 0) {
        final query = Uri.splitQueryString(rest.substring(qIdx + 1));
        final contract = query['contract'];
        if (contract != null) {
          if (resolveMetadataBigMapId == null) {
            throw OnChainErrors.tezosMetadata(
              "resolve",
              reason:
                  'URI references another contract ($contract) but no resolveMetadataBigMapId was supplied',
            );
          }
          bigMapId = await resolveMetadataBigMapId!(contract);
        }
      }
      final decodedKey = key.isEmpty ? '' : key; // "" is the common root key
      final data = await fetchStorageBytes(bigMapId, decodedKey);
      if (data == null) {
        throw OnChainErrors.tezosMetadata(
          "resolve",
          reason: 'No metadata found at tezos-storage key "$decodedKey"',
        );
      }
      // Root pointer may itself be another URI (chained), or the JSON directly.
      final asString = StringUtils.decode(data);
      if (asString.startsWith('tezos-storage:') ||
          asString.startsWith('ipfs://') ||
          asString.startsWith('http://') ||
          asString.startsWith('https://') ||
          asString.startsWith('sha256://')) {
        return _resolveToBytes(asString, ownBigMapId);
      }
      return data;
    }
    if (uri.startsWith('ipfs://')) {
      final cidPath = uri.substring('ipfs://'.length);
      return fetchUrl(
        'https://ipfs.io/ipfs/$cidPath',
      ); // swap gateway as you prefer
    }
    if (uri.startsWith('http://') || uri.startsWith('https://')) {
      return fetchUrl(uri);
    }
    if (uri.startsWith('sha256://')) {
      // sha256://<hex-hash>/<url> — integrity-checked fetch of the trailing URL.
      final rest = uri.substring('sha256://'.length);
      final slash = rest.indexOf('/');
      if (slash < 0) {
        throw OnChainErrors.tezosMetadata(
          "resolve",
          reason: 'Malformed sha256:// URI: $uri',
        );
      }
      final url = rest.substring(slash + 1);
      return fetchUrl(url.startsWith('http') ? url : 'https://$url');
      // NOTE: hash verification against rest.substring(0, slash) is on you —
      // wire your sha256 impl of choice if you need integrity checking.
    }
    throw OnChainErrors.tezosMetadata(
      "resolve",
      reason:
          'Unsupported metadata URI scheme: $uri (expected ipfs, http, https, sha256, or tezos-storage).',
    );
  }
}
