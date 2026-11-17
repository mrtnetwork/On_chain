import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/operations.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';

import 'tz_michelson_vm.dart';

typedef _Templater = dynamic Function(MichelineExpr);

/// All ABI-layer errors flow through this. Never construct/throw a bare
/// Exception/FormatException from within TezosAbi/TezosContractAbi — always go
/// through [OnChainErrors.tezosAbi] so callers get a single,
/// consistent, introspectable error type with `where`/`reason`/`path`
/// context attached.
/// A reference to an existing on-chain big_map, or literal entries to
/// write when originating a contract with a fresh big_map.
class TezosBigMapValue {
  final BigInt? id;
  final Map<dynamic, dynamic>? entries;
  const TezosBigMapValue.id(this.id) : entries = null;
  const TezosBigMapValue.entries(this.entries) : id = null;
  bool get isId => id != null;
  @override
  String toString() =>
      isId ? 'BigMap#$id' : 'BigMap(${entries!.length} entries)';
}

/// Low-level ABI codec: Dart value <-> MichelineExpr, given a Michelson
/// type node (itself a MichelineExpr, e.g. the `storage`/`parameter` type
/// pulled out of contract code).
class TezosAbi {
  TezosAbi._();

  static String debugBigMaps(MichelineExpr storage, MichelineExpr storageType) {
    final all = _collectBigMapIds(storage, storageType, '');
    return all.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }

  // ============================================================ ENCODE ===
  static MichelineExpr encode(
    dynamic value,
    MichelineExpr type, {
    String path = '',
  }) {
    final t = _asPrim(type, path: path);
    switch (t.prim) {
      case 'unit':
        return const MichelinePrimNoArgsNoAnnots.unit();

      case 'bool':
        if (value is! bool) {
          throw OnChainErrors.tezosAbi(
            'encode `bool`',
            reason: 'Expected bool, got $value',
            details: {'path': path},
          );
        }
        return MichelinePrimNoArgsNoAnnots(value ? 'True' : 'False');

      case 'nat':
        {
          final v = _toBigInt(value, 'nat', path: path);
          if (v.isNegative) {
            throw OnChainErrors.tezosAbi(
              'encode `nat`',
              reason: '`nat` cannot be negative, got $v',
              details: {'path': path},
            );
          }
          return MichelineInt(v);
        }

      case 'int':
      case 'mutez':
      case 'timestamp':
        {
          final v = _toBigInt(value, t.prim, path: path);
          if (t.prim == 'mutez' && v.isNegative) {
            throw OnChainErrors.tezosAbi(
              'encode `mutez`',
              reason: '`mutez` cannot be negative, got $v',
              details: {'path': path},
            );
          }
          return MichelineInt(v);
        }

      case 'string':
        if (value is! String) {
          throw OnChainErrors.tezosAbi(
            'encode `string`',
            reason: 'Expected String, got $value',
            details: {'path': path},
          );
        }
        return MichelineString(value);

      case 'address':
        if (value is TezosAddress) {
          return MichelineString(value.address);
        }
        if (value is! String) {
          throw OnChainErrors.tezosAbi(
            'encode `${t.prim}`',
            reason: 'Expected String for `${t.prim}`, got $value',
            details: {'path': path},
          );
        }
        return MichelineString(value);
      case 'key_hash':
      case 'key':
      case 'signature':
      case 'chain_id':
      case 'contract':
        if (value is! String) {
          throw OnChainErrors.tezosAbi(
            'encode `${t.prim}`',
            reason: 'Expected String for `${t.prim}`, got $value',
            details: {'path': path},
          );
        }
        return MichelineString(value);

      case 'bytes':
      case 'bls12_381_g1':
      case 'bls12_381_g2':
      case 'bls12_381_fr':
      case 'chest':
      case 'chest_key':
      case 'sapling_state':
      case 'sapling_transaction':
        if (value is List<int>) return MichelineBytes(value);
        if (value is String) {
          return MichelineBytes(_hexToBytes(value, path: path));
        }
        throw OnChainErrors.tezosAbi(
          'encode `${t.prim}`',
          reason: 'Expected List<int> or hex String, got $value',
          details: {'path': path},
        );

      case 'option':
        if (value == null) return MichelinePrimNoArgsNoAnnots('None');
        return MichelinePrim1ArgNoAnnots(
          'Some',
          encode(value, t.args[0], path: '$path.Some'),
        );

      case 'pair':
        return _encodePair(value, t, path);

      case 'or':
        return _encodeOr(value, t, path);

      case 'list':
      case 'set':
        if (value is! Iterable) {
          throw OnChainErrors.tezosAbi(
            'encode `${t.prim}`',
            reason: 'Expected Iterable, got $value',
            details: {'path': path},
          );
        }
        return MichelineSequence([
          for (var i = 0; i < value.length; i++)
            encode(value.elementAt(i), t.args[0], path: '$path[$i]'),
        ]);

      case 'map':
        return _encodeMap(value, t, path);

      case 'big_map':
        return _encodeBigMap(value, t, path);

      case 'lambda':
        if (value is MichelineExpr) return value;
        throw OnChainErrors.tezosAbi(
          'encode `lambda`',
          reason: 'Lambda values must be a pre-built MichelineExpr.',
          details: {'path': path},
        );

      case 'ticket':
        throw OnChainErrors.tezosAbi(
          'encode `ticket`',
          reason:
              'Cannot construct a `ticket` literal — tickets are contract-native only',
          details: {'path': path},
        );

      case 'operation':
        throw OnChainErrors.tezosAbi(
          'encode `operation`',
          reason: 'Cannot construct an `operation` literal',
          details: {'path': path},
        );

      default:
        throw OnChainErrors.tezosAbi(
          'encode `${t.prim}`',
          reason: 'Unsupported Michelson type for encode',
          details: {'path': path},
        );
    }
  }

  // ============================================================ DECODE ===
  /// Handles `pair` values in *any* comb shape (flat, strict nested, or
  /// mixed) transparently — you never need to know or check which shape
  /// the RPC returned.
  static dynamic decode(
    MichelineExpr expr,
    MichelineExpr type, {
    String path = '',
  }) {
    final t = _asPrim(type, path: path);
    switch (t.prim) {
      case 'unit':
        if (expr is MichelinePrim && expr.prim == 'Unit') return null;
        throw OnChainErrors.tezosAbi(
          'decode `unit`',
          reason: 'Expected `Unit`, got $expr',
          details: {'path': path},
        );

      case 'bool':
        if (expr is MichelinePrim && expr.prim == 'True') return true;
        if (expr is MichelinePrim && expr.prim == 'False') return false;
        throw OnChainErrors.tezosAbi(
          'decode `bool`',
          reason: 'Expected True/False, got $expr',
          details: {'path': path},
        );

      case 'nat':
      case 'int':
      case 'mutez':
      case 'timestamp':
        if (expr is MichelineInt) return expr.value;
        throw OnChainErrors.tezosAbi(
          'decode `${t.prim}`',
          reason: 'Expected int expr, got $expr',
          details: {'path': path},
        );

      case 'string':
      case 'address':
      case 'key_hash':
      case 'key':
      case 'signature':
      case 'chain_id':
      case 'contract':
        if (expr is MichelineString) return expr.value;
        throw OnChainErrors.tezosAbi(
          'decode `${t.prim}`',
          reason: 'Expected string expr, got $expr',
          details: {'path': path},
        );

      case 'bytes':
      case 'bls12_381_g1':
      case 'bls12_381_g2':
      case 'bls12_381_fr':
      case 'chest':
      case 'chest_key':
      case 'sapling_state':
      case 'sapling_transaction':
        if (expr is MichelineBytes) return expr.value;
        throw OnChainErrors.tezosAbi(
          'decode `${t.prim}`',
          reason: 'Expected bytes expr, got $expr',
          details: {'path': path},
        );

      case 'option':
        if (expr is MichelinePrim && expr.prim == 'None') return null;
        if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Some') {
          return decode(expr.arg, t.args[0], path: '$path.Some');
        }
        throw OnChainErrors.tezosAbi(
          'decode `option`',
          reason: 'Expected None/Some, got $expr',
          details: {'path': path},
        );

      case 'pair':
        return _decodePair(expr, t, path);

      case 'or':
        return _decodeOr(expr, t, path);

      case 'list':
      case 'set':
        if (expr is MichelineSequence) {
          return [
            for (var i = 0; i < expr.items.length; i++)
              decode(expr.items[i], t.args[0], path: '$path[$i]'),
          ];
        }
        throw OnChainErrors.tezosAbi(
          'decode `${t.prim}`',
          reason: 'Expected sequence, got $expr',
          details: {'path': path},
        );

      case 'map':
        return _decodeMap(expr, t, path);

      case 'big_map':
        return _decodeBigMap(expr, t, path);

      case 'lambda':
        return expr;

      case 'operation':
        // Not constructible as input, but legitimate to inspect when
        // decoded out of a lambda/view result — hand back the raw node.
        return expr;

      case 'ticket':
        throw OnChainErrors.tezosAbi(
          'decode `ticket`',
          reason:
              'Cannot decode a `ticket` value outside contract execution context',
          details: {'path': path},
        );

      default:
        throw OnChainErrors.tezosAbi(
          'decode `${t.prim}`',
          reason: 'Unsupported Michelson type for decode',
          details: {'path': path},
        );
    }
  }

  // =============================================== pack-mode encoding ===
  /// Converts a value already produced by [encode] into the form
  /// Michelson `PACK` actually serializes. Only matters for types whose
  /// display form (used for RPC calls, which the node canonicalizes for
  /// you) differs from their raw packed form: `address`, `contract`,
  /// `key_hash`, `key`, `signature`, `chain_id`. Everything else already
  /// serializes identically either way.
  ///
  /// Call this on the result of [encode] before `.serializeBytes()`
  /// whenever you need PACK-compatible bytes (e.g. a big_map key hash) —
  /// never for values only being sent to the RPC as-is.
  static MichelineExpr toPackable(
    MichelineExpr expr,
    MichelineExpr type, {
    String path = '',
  }) {
    final t = _asPrim(type, path: path);
    switch (t.prim) {
      case 'address':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            final addr = TezosAddress(expr.value);
            return MichelineBytes(TezosUtils.encodeDestinationAddr(addr));
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `address`',
              reason: 'Failed to parse address "${expr.value}"',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `address`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'contract':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            final parts = expr.value.split('%');
            final addr = TezosAddress(parts[0]);
            final addrBytes = TezosUtils.encodeDestinationAddr(addr);
            if (parts.length > 1 && parts[1] != 'default') {
              return MichelineBytes([...addrBytes, ...parts[1].codeUnits]);
            }
            return MichelineBytes(addrBytes);
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `contract`',
              reason: 'Failed to parse contract "${expr.value}"',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `contract`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'key_hash':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            final addr = TezosAddress(expr.value);
            final full = TezosUtils.encodeDestinationAddr(addr);
            // Packed key_hash = 1-byte curve tag + 20-byte hash — same
            // bytes an implicit address carries after its 0x00 addr tag.
            return MichelineBytes(full.sublist(1));
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `key_hash`',
              reason: 'Failed to parse key_hash "${expr.value}"',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `key_hash`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'key':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            // NOTE: verify against your TezosKeyType's actual public-key
            // decode API — this assumes a helper that returns
            // (curveTag, rawBytes) for a base58 public key string.
            final decoded = TezosPublicKey.decode(expr.value);
            return MichelineBytes([decoded.type.tag, ...decoded.toBytes()]);
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `key`',
              reason: 'Failed to parse key "${expr.value}"',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `key`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'signature':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            return MichelineBytes(TezosUtils.decodeSignature(expr.value));
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `signature`',
              reason: 'Failed to parse signature.',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `signature`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'chain_id':
        if (expr is MichelineBytes) return expr;
        if (expr is MichelineString) {
          try {
            return MichelineBytes(
              TezosUtils.decode(expr.value, TezosBase58Kind.chainId),
            );
          } catch (e) {
            throw OnChainErrors.tezosAbi(
              'pack `chain_id`',
              reason: 'Failed to parse chain_id "${expr.value}"',
              internalError: e,
              details: {'path': path},
            );
          }
        }
        throw OnChainErrors.tezosAbi(
          'pack `chain_id`',
          reason: 'Cannot pack value $expr',
          details: {'path': path},
        );

      case 'operation':
        throw OnChainErrors.tezosAbi(
          'pack `operation`',
          reason:
              'Cannot PACK a value containing `operation` — forbidden by Michelson',
          details: {'path': path},
        );

      case 'big_map':
        throw OnChainErrors.tezosAbi(
          'pack `big_map`',
          reason: 'Cannot PACK a value containing `big_map`',
          details: {'path': path},
        );

      case 'sapling_state':
        throw OnChainErrors.tezosAbi(
          'pack `sapling_state`',
          reason: 'Cannot PACK a value containing `sapling_state`',
          details: {'path': path},
        );

      case 'option':
        if (expr is MichelinePrimNoArgsNoAnnots && expr.prim == 'None') {
          return expr;
        }
        if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Some') {
          return MichelinePrim1ArgNoAnnots(
            'Some',
            toPackable(expr.arg, t.args[0], path: '$path.Some'),
          );
        }
        throw OnChainErrors.tezosAbi(
          'pack `option`',
          reason: 'Expected None/Some, got $expr',
          details: {'path': path},
        );

      case 'pair':
        {
          final subs = _pairSubExprs(expr, t.args.length, path);
          final packed = [
            for (var i = 0; i < t.args.length; i++)
              toPackable(subs[i], t.args[i], path: '$path.$i'),
          ];
          if (packed.length == 2) {
            return MichelinePrim2ArgsNoAnnots('Pair', packed[0], packed[1]);
          }
          return MichelinePrimGeneric('Pair', packed, const []);
        }

      case 'or':
        if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Left') {
          return MichelinePrim1ArgNoAnnots(
            'Left',
            toPackable(expr.arg, t.args[0], path: '$path.Left'),
          );
        }
        if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Right') {
          return MichelinePrim1ArgNoAnnots(
            'Right',
            toPackable(expr.arg, t.args[1], path: '$path.Right'),
          );
        }
        throw OnChainErrors.tezosAbi(
          'pack `or`',
          reason: 'Expected Left/Right, got $expr',
          details: {'path': path},
        );

      case 'list':
      case 'set':
        if (expr is MichelineSequence) {
          return MichelineSequence([
            for (var i = 0; i < expr.items.length; i++)
              toPackable(expr.items[i], t.args[0], path: '$path[$i]'),
          ]);
        }
        throw OnChainErrors.tezosAbi(
          'pack `${t.prim}`',
          reason: 'Expected sequence, got $expr',
          details: {'path': path},
        );

      case 'map':
        if (expr is MichelineSequence) {
          final keyType = t.args[0];
          final valType = t.args[1];
          return MichelineSequence([
            for (var i = 0; i < expr.items.length; i++)
              if (expr.items[i] is MichelinePrim2ArgsNoAnnots &&
                  (expr.items[i] as MichelinePrim2ArgsNoAnnots).prim == 'Elt')
                MichelinePrim2ArgsNoAnnots(
                  'Elt',
                  toPackable(
                    (expr.items[i] as MichelinePrim2ArgsNoAnnots).arg1,
                    keyType,
                    path: '$path[$i].key',
                  ),
                  toPackable(
                    (expr.items[i] as MichelinePrim2ArgsNoAnnots).arg2,
                    valType,
                    path: '$path[$i].value',
                  ),
                )
              else
                throw OnChainErrors.tezosAbi(
                  'pack `map`',
                  reason: 'Expected `Elt` pair, got ${expr.items[i]}',
                  details: {'path': '$path[$i]'},
                ),
          ]);
        }
        throw OnChainErrors.tezosAbi(
          'pack `map`',
          reason: 'Expected sequence, got $expr',
          details: {'path': path},
        );

      case 'lambda':
        return expr;

      default:
        // unit, bool, nat, int, mutez, timestamp, string, bytes,
        // bls12_381_*, chest*, ticket rejection already handled at encode
        // time — display form already matches PACK's binary form.
        return expr;
    }
  }

  // ================================================= big_map key hash ===
  /// Encodes [value] against Michelson [keyType], converts it to
  /// PACK-compatible form, packs it (Micheline binary + PACK's `0x05`
  /// tag), hashes with blake2b-256, and returns the `expr...` Base58Check
  /// script-expression hash the RPC's `.../big_maps/{id}/{script_expr}`
  /// endpoint expects.
  static String bigMapKeyHash(dynamic value, MichelineExpr keyType) {
    try {
      final keyExpr = encode(value, keyType, path: 'key');
      final packable = toPackable(keyExpr, keyType, path: 'key');
      return TezosUtils.encodeScriptExprFromMicheline(
        packable.serializeBytes(),
      );
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.tezosAbi) rethrow;
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosAbi(
        'bigMapKeyHash',
        reason: 'Failed to compute big_map key hash.',
        internalError: e,
      );
    }
  }

  static BigInt getBigMapId(
    MichelineExpr storage,
    MichelineExpr storageType, {
    String? path,
  }) {
    final all = _collectBigMapIds(storage, storageType, '');
    if (path != null) {
      final id = all[path];
      if (id == null) {
        throw OnChainErrors.tezosAbi(
          'getBigMapId',
          reason:
              'No big_map at path "$path". Available: ${all.keys.join(", ")}',
        );
      }
      return id;
    }
    if (all.isEmpty) {
      throw OnChainErrors.tezosAbi(
        'getBigMapId',
        reason: 'No big_map found in storage.',
      );
    }
    if (all.length > 1) {
      throw OnChainErrors.tezosAbi(
        'getBigMapId',
        reason:
            'Multiple big_maps found (${all.keys.join(", ")}); pass `path` to disambiguate.',
      );
    }
    return all.values.first;
  }

  static Map<String, BigInt> _collectBigMapIds(
    MichelineExpr expr,
    MichelineExpr ty,
    String path,
  ) {
    final result = <String, BigInt>{};
    void walk(MichelineExpr e, MichelineExpr ty, String p) {
      final t = _asPrim(ty, path: p);
      switch (t.prim) {
        case 'big_map':
          final own = _fieldAnnot(t);
          final key = own ?? (p.isEmpty ? 'big_map' : p);
          if (e is! MichelineInt) {
            throw OnChainErrors.tezosAbi(
              'collectBigMapIds',
              reason: 'Expected int id for big_map storage form, got $e',
              details: {'path': p},
            );
          }
          result[key] = e.value;
          if (own != null && p.isNotEmpty) {
            result[p] = result[key]!;
          }
          return;
        case 'pair':
          {
            final types = t.args;
            final subs = _pairSubExprs(e, types.length, p);
            for (var i = 0; i < types.length; i++) {
              final ft = _asPrim(types[i], path: p);
              final name = _fieldAnnot(ft) ?? '$i';
              walk(subs[i], types[i], p.isEmpty ? name : '$p.$name');
            }
            return;
          }
        case 'option':
          if (e is MichelinePrim1ArgNoAnnots && e.prim == 'Some') {
            walk(e.arg, t.args[0], '$p.Some');
          }
          return;
        case 'or':
          if (e is MichelinePrim1ArgNoAnnots && e.prim == 'Left') {
            walk(e.arg, t.args[0], '$p.Left');
          } else if (e is MichelinePrim1ArgNoAnnots && e.prim == 'Right') {
            walk(e.arg, t.args[1], '$p.Right');
          }
          return;
        case 'list':
        case 'set':
          if (e is MichelineSequence) {
            for (var i = 0; i < e.items.length; i++) {
              walk(e.items[i], t.args[0], '$p[$i]');
            }
          }
          return;
        case 'map':
          if (e is MichelineSequence) {
            for (var i = 0; i < e.items.length; i++) {
              final item = e.items[i];
              if (item is MichelinePrim2ArgsNoAnnots && item.prim == 'Elt') {
                walk(item.arg2, t.args[1], '$p[$i].value');
              }
            }
          }
          return;
        default:
          return; // leaf types can't contain a nested big_map
      }
    }

    walk(expr, ty, path);
    return result;
  }

  static MichelineExpr _encodePair(
    dynamic value,
    MichelinePrim type,
    String path,
  ) {
    final fieldTypes = type.args;
    late List<dynamic> values;
    if (value is Map) {
      values = [
        for (final ft in fieldTypes) value[_fieldAnnotOrThrow(ft, path)],
      ];
    } else if (value is List) {
      if (value.length != fieldTypes.length) {
        throw OnChainErrors.tezosAbi(
          'encode `pair`',
          reason:
              '`pair` expects ${fieldTypes.length} values, got ${value.length}',
          details: {'path': path},
        );
      }
      values = value;
    } else {
      throw OnChainErrors.tezosAbi(
        'encode `pair`',
        reason: 'Expected List or Map, got $value',
        details: {'path': path},
      );
    }
    final exprs = [
      for (var i = 0; i < fieldTypes.length; i++)
        encode(values[i], fieldTypes[i], path: '$path.$i'),
    ];
    if (exprs.length == 2) {
      return MichelinePrim2ArgsNoAnnots('Pair', exprs[0], exprs[1]);
    }
    return MichelinePrimGeneric('Pair', exprs, const []);
  }

  static dynamic _decodePair(
    MichelineExpr expr,
    MichelinePrim type,
    String path,
  ) {
    final fieldTypes = type.args;
    final subExprs = _pairSubExprs(expr, fieldTypes.length, path);
    final allAnnotated = fieldTypes.every(
      (ft) => _fieldAnnot(_asPrim(ft, path: path)) != null,
    );
    if (allAnnotated) {
      final map = <String, dynamic>{};
      for (var i = 0; i < fieldTypes.length; i++) {
        map[_fieldAnnotOrThrow(fieldTypes[i], path)] = decode(
          subExprs[i],
          fieldTypes[i],
          path: '$path.$i',
        );
      }
      return map;
    }
    return [
      for (var i = 0; i < fieldTypes.length; i++)
        decode(subExprs[i], fieldTypes[i], path: '$path.$i'),
    ];
  }

  static String? _fieldAnnot(MichelinePrim p) {
    for (final a in p.annots) {
      if (a.startsWith('%')) return a.substring(1);
    }
    return null;
  }

  static String _fieldAnnotOrThrow(MichelineExpr fieldType, String path) {
    final a = _fieldAnnot(_asPrim(fieldType, path: path));
    if (a == null) {
      throw OnChainErrors.tezosAbi(
        'pair field lookup',
        reason:
            'Pair field has no `%annot`; use a positional List instead of a Map here',
        details: {'path': path},
      );
    }
    return a;
  }

  /// Unfolds a `Pair` node of any comb shape — flat (`Pair a b c d`),
  /// strict nested (`Pair a (Pair b (Pair c d))`), or any partial mix
  /// (`Pair a (Pair b c d)`), and any *over*-flattened mix relative to
  /// this type node's own arity — into exactly [arity] sub-expressions.
  static List<MichelineExpr> _pairSubExprs(
    MichelineExpr expr,
    int arity,
    String path,
  ) {
    if (arity < 2) {
      throw OnChainErrors.tezosAbi(
        'pairSubExprs',
        reason: 'Pair arity must be >= 2, got $arity.',
        details: {'path': path},
      );
    }
    List<MichelineExpr> args;
    if (expr is MichelinePrim && expr.prim == 'Pair') {
      args = expr.args;
    } else if (expr is MichelineSequence) {
      // Octez normalizes right-combs to a bare JSON array instead of
      // nested {"prim":"Pair", ...} nodes. Treat it identically.
      args = expr.items;
    } else {
      throw OnChainErrors.tezosAbi(
        'pairSubExprs',
        reason: 'Expected `Pair` node or array for pair data, got $expr',
        details: {'path': path},
      );
    }
    if (args.length < 2) {
      throw OnChainErrors.tezosAbi(
        'pairSubExprs',
        reason: '`Pair` data must have >= 2 elements, got ${args.length}',
        details: {'path': path},
      );
    }
    if (args.length == arity) return args;

    if (args.length > arity) {
      // Data flattened past this type node's own arity — Octez merged
      // this comb with its (pair-typed) tail field. Keep the first
      // arity-1 elements as-is; bundle the rest back up as a synthetic
      // sequence for the last slot, so the *next* recursive call (into
      // that slot's own pair type) unpacks it against its real arity.
      final head = args.sublist(0, arity - 1);
      final tail = args.sublist(arity - 1);
      return [...head, MichelineSequence(tail)];
    }

    // args.length < arity: data under-flattened relative to type —
    // expand the last element further.
    final head = args.sublist(0, args.length - 1);
    return [...head, ..._pairSubExprs(args.last, arity - head.length, path)];
  }

  static MichelineExpr _encodeOr(
    dynamic value,
    MichelinePrim type,
    String path,
  ) {
    if (value is! Map || !value.containsKey('kind')) {
      throw OnChainErrors.tezosAbi(
        'encode `or`',
        reason: 'Expected {"kind": "Left"|"Right"|<annot>, "value": ...}',
        details: {'path': path},
      );
    }
    final leftType = _asPrim(type.args[0], path: '$path.Left');
    final rightType = _asPrim(type.args[1], path: '$path.Right');
    final leftName = _fieldAnnot(leftType) ?? 'Left';
    final rightName = _fieldAnnot(rightType) ?? 'Right';
    final kind = value['kind'] as String;
    if (kind == 'Left' || kind == leftName) {
      return MichelinePrim1ArgNoAnnots(
        'Left',
        encode(value['value'], leftType, path: '$path.Left'),
      );
    }
    if (kind == 'Right' || kind == rightName) {
      return MichelinePrim1ArgNoAnnots(
        'Right',
        encode(value['value'], rightType, path: '$path.Right'),
      );
    }
    throw OnChainErrors.tezosAbi(
      'encode `or`',
      reason:
          'Unknown `or` kind "$kind" (expected Left/$leftName or Right/$rightName)',
      details: {'path': path},
    );
  }

  static dynamic _decodeOr(
    MichelineExpr expr,
    MichelinePrim type,
    String path,
  ) {
    if (expr is! MichelinePrim1ArgNoAnnots) {
      throw OnChainErrors.tezosAbi(
        'decode `or`',
        reason: 'Expected Left/Right, got $expr',
        details: {'path': path},
      );
    }
    final leftType = _asPrim(type.args[0], path: '$path.Left');
    final rightType = _asPrim(type.args[1], path: '$path.Right');
    if (expr.prim == 'Left') {
      return {
        'kind': _fieldAnnot(leftType) ?? 'Left',
        'value': decode(expr.arg, leftType, path: '$path.Left'),
      };
    }
    if (expr.prim == 'Right') {
      return {
        'kind': _fieldAnnot(rightType) ?? 'Right',
        'value': decode(expr.arg, rightType, path: '$path.Right'),
      };
    }
    throw OnChainErrors.tezosAbi(
      'decode `or`',
      reason: 'Expected Left/Right prim, got ${expr.prim}',
      details: {'path': path},
    );
  }

  static MichelineExpr _encodeMap(
    dynamic value,
    MichelinePrim type,
    String path,
  ) {
    if (value is! Map) {
      throw OnChainErrors.tezosAbi(
        'encode `map`',
        reason: 'Expected Map, got $value',
        details: {'path': path},
      );
    }
    final keyType = type.args[0];
    final valType = type.args[1];
    final entries =
        value.entries
            .map(
              (e) => MapEntry(
                encode(e.key, keyType, path: '$path.key'),
                encode(e.value, valType, path: '$path.value'),
              ),
            )
            .toList()
          ..sort(
            (a, b) => BytesUtils.compareBytes(
              a.key.serializeBytes(),
              b.key.serializeBytes(),
            ),
          );
    return MichelineSequence([
      for (final e in entries)
        MichelinePrim2ArgsNoAnnots('Elt', e.key, e.value),
    ]);
  }

  static dynamic _decodeMap(
    MichelineExpr expr,
    MichelinePrim type,
    String path,
  ) {
    if (expr is! MichelineSequence) {
      throw OnChainErrors.tezosAbi(
        'decode `map`',
        reason: 'Expected sequence, got $expr',
        details: {'path': path},
      );
    }
    final keyType = type.args[0];
    final valType = type.args[1];
    final map = <dynamic, dynamic>{};
    for (var i = 0; i < expr.items.length; i++) {
      final item = expr.items[i];
      if (item is! MichelinePrim2ArgsNoAnnots || item.prim != 'Elt') {
        throw OnChainErrors.tezosAbi(
          'decode `map`',
          reason: 'Expected `Elt` pair, got $item',
          details: {'path': '$path[$i]'},
        );
      }
      map[decode(item.arg1, keyType, path: '$path[$i].key')] = decode(
        item.arg2,
        valType,
        path: '$path[$i].value',
      );
    }
    return map;
  }

  static MichelineExpr _encodeBigMap(
    dynamic value,
    MichelinePrim type,
    String path,
  ) {
    if (value is TezosBigMapValue) {
      if (value.entries == null) {
        throw OnChainErrors.tezosAbi(
          'encode `big_map`',
          reason:
              'Cannot encode a big_map by id — only fresh entries can be encoded',
          details: {'path': path},
        );
      }
      return _encodeMap(value.entries, type, path);
    }
    if (value is Map) return _encodeMap(value, type, path);
    throw OnChainErrors.tezosAbi(
      'encode `big_map`',
      reason: 'Expected Map or TezosBigMapValue.entries(...), got $value',
      details: {'path': path},
    );
  }

  static dynamic _decodeBigMap(
    MichelineExpr expr,
    MichelinePrim type,
    String path,
  ) {
    if (expr is MichelineInt) return TezosBigMapValue.id(expr.value);
    if (expr is MichelineSequence) {
      return TezosBigMapValue.entries(_decodeMap(expr, type, path) as Map);
    }
    throw OnChainErrors.tezosAbi(
      'decode `big_map`',
      reason: 'Expected int id or sequence, got $expr',
      details: {'path': path},
    );
  }

  static MichelinePrim _asPrim(MichelineExpr type, {String path = ''}) {
    if (type is MichelinePrim) return type;
    throw OnChainErrors.tezosAbi(
      'type resolution',
      reason: 'Type node must be a Michelson prim, got $type',
      details: {'path': path},
    );
  }

  static BigInt _toBigInt(dynamic value, String primName, {String path = ''}) {
    final v = BigintUtils.tryParse(value);
    if (v != null) return v;
    if (primName == 'timestamp' && value is DateTime) {
      return BigInt.from(value.millisecondsSinceEpoch ~/ 1000);
    }
    throw OnChainErrors.tezosAbi(
      'convert to `$primName`',
      reason: 'Cannot convert $value to a Michelson `$primName`',
      details: {'path': path},
    );
  }

  static List<int> _hexToBytes(String hex, {String path = ''}) {
    final out = BytesUtils.tryFromHexString(hex);
    if (out == null) {
      throw OnChainErrors.tezosAbi(
        'parse hex bytes',
        reason: 'Invalid hex bytes.',
        details: {'path': path},
      );
    }
    return out;
  }
  // ===================================================
  // Type templates
  // ===================================================

  /// Short human descriptions for each `#placeholder` used by [typeTemplate].
  ///
  /// Copy-paste the template, replace every `"#foo"` with a real value, and
  /// consult this map when unsure what a placeholder accepts.
  static const Map<String, String> typeTemplateHelp = {
    '#unit': 'null (no value)',
    '#bool': 'true or false',
    '#nat': 'non-negative integer (int / BigInt / String)',
    '#int': 'integer (int / BigInt / String)',
    '#mutez': 'non-negative mutez amount (int / BigInt / String)',
    '#timestamp': 'unix seconds (int / BigInt / String) or a DateTime',
    '#string': 'any String',
    '#address': 'Tezos address String: "tz1…", "tz2…", "tz3…", or "KT1…"',

    '#key_hash': 'base58 key_hash String (tz1/tz2/tz3…)',
    '#key': 'base58 public-key String (edpk… / sppk… / p2pk…)',
    '#signature': 'base58 signature String (edsig… / spsig… / p2sig…)',
    '#chain_id': 'base58 chain_id String (Net…)',
    '#contract': 'contract String: "KT1…" or "KT1…%entrypoint"',

    '#bytes': 'List<int> raw bytes, or hex String ("0x…" or bare hex)',
    '#bls12_381_g1': 'List<int> or hex String (BLS12-381 G1 point)',
    '#bls12_381_g2': 'List<int> or hex String (BLS12-381 G2 point)',
    '#bls12_381_fr': 'List<int> or hex String (BLS12-381 Fr scalar)',
    '#chest': 'List<int> or hex String (Timelock chest)',
    '#chest_key': 'List<int> or hex String (Timelock chest key)',
    '#sapling_state': 'List<int> or hex String (Sapling state)',
    '#sapling_transaction': 'List<int> or hex String (Sapling transaction)',

    '#lambda': 'pre-built MichelineExpr (not a plain Dart value)',
    '#operation': 'decode-only — cannot be constructed as input',
    '#ticket': 'contract-native only — cannot be constructed as input',
  };
  // ===========================================================================
  // DROP-IN REPLACEMENT for the `typeTemplate` region in TezosAbi.
  // Delete both the current active `typeTemplate` method AND the big
  // commented-out duplicate below it — replace with everything in this file
  // (paste inside the TezosAbi class body, `typeTemplateHelp` can stay as-is).
  // ===========================================================================

  /// Signature of the recursion callback shared by [typeTemplate] and
  /// [typeSchema]'s builders — lets one leaf/shape function ([_buildTemplate])
  /// serve both "always inline" and "ref repeats" modes.

  // =============================================================== plain ===
  /// Returns a **directly copy-pasteable** JSON value for [type] — exactly
  /// what you'd hand to [encode]. No explanatory keys, no "repeat me" strings
  /// mixed into the data:
  ///
  /// - scalar leaf            -> `"#placeholder"` (see [typeTemplateHelp])
  /// - `option`                -> the Some-value template directly
  ///                              (None just means passing `null` instead —
  ///                              not shown separately, since both are valid
  ///                              `encode()` input)
  /// - `or` (all-unit variants) -> `{"kind": "#A|B|C", "value": null}`
  /// - `or` (carries a value)   -> `{"kind": "#Left|Right", "value": <example
  ///                              for the first branch>}`
  /// - annotated `pair`         -> `{"field": ..., ...}`
  /// - bare `pair`              -> `[..., ...]`
  /// - `list` / `set`           -> `[itemTemplate]` — a single example
  ///                              element; repeat the pattern as needed
  /// - `map` / `big_map`        -> `{"<keyTemplate>": valueTemplate}` — a
  ///                              single example entry; add more
  ///                              `"#key": value` pairs as needed
  ///
  /// Example — `map(address, bytes)`:
  /// ```json
  /// {"#address": "#bytes"}
  /// ```
  /// Example — `list(pair(%to address, %amount nat))`:
  /// ```json
  /// [{"to": "#address", "amount": "#nat"}]
  /// ```
  static Map<String, dynamic> typeTemplate(MichelineExpr type) {
    late _Templater self;
    self = (ty) => _buildTemplate(ty, self);
    return {"template": self(type), "schame": typeSchema(type)};
  }

  // `typeSchema` implementation (counts repeated shapes for component names).

  static Map<String, dynamic> typeSchema(MichelineExpr type) {
    // ---- pass 1: count occurrences of each annotated shape -----------------
    // (still used for plain repeated substructures, e.g. the same record
    // pair reused across several entrypoints)
    final counts = <String, int>{};
    final compNames = <String, String>{};
    void count(MichelineExpr ty) {
      final t = _asPrim(ty);
      final annot = _fieldAnnot(t);
      if (annot != null) {
        final sig = _typeSignature(t);
        counts[sig] = (counts[sig] ?? 0) + 1;
        compNames.putIfAbsent(sig, () => annot);
      }
      for (final a in t.args) {
        count(a);
      }
    }

    count(type);
    final reused = <String>{
      for (final e in counts.entries)
        if (e.value > 1) e.key,
    };

    // ---- pass 2: build -------------------------------------------------------
    final components = <String, dynamic>{};
    final inProgress = <String>{};
    late _Templater self;
    self = (ty) {
      final t = _asPrim(ty);

      // `or` with BOTH branches named (e.g. %existing / %new): always hoist
      // both into components, regardless of reuse count. Without this, the
      // right-hand branch's shape (e.g. `map(string,bytes)` under %new)
      // never appears anywhere in the output at all — only the left branch
      // got inlined into "value" and the other was silently dropped.
      if (t.prim == 'or' && !_isAllUnitOr(t)) {
        final leftType = _asPrim(t.args[0]);
        final rightType = _asPrim(t.args[1]);
        final leftName = _fieldAnnot(leftType);
        final rightName = _fieldAnnot(rightType);
        if (leftName != null && rightName != null) {
          for (final branch in [
            MapEntry(leftName, leftType),
            MapEntry(rightName, rightType),
          ]) {
            final key = '${branch.key}::${_typeSignature(branch.value)}';
            if (!components.containsKey(branch.key) &&
                !inProgress.contains(key)) {
              inProgress.add(key);
              components[branch.key] = _buildTemplate(branch.value, self);
              inProgress.remove(key);
            }
          }
          return {
            'kind': '#$leftName|$rightName',
            'value': '#components/$leftName|#components/$rightName',
          };
        }
        // one or both branches unnamed -> nothing to key a component by;
        // falls through to the generic (single-branch-inline) handling below.
      }

      // generic repeated-substructure hoisting (pairs, records, etc.)
      final annot = _fieldAnnot(t);
      if (annot != null) {
        final sig = _typeSignature(t);
        if (reused.contains(sig)) {
          if (!components.containsKey(annot) && !inProgress.contains(sig)) {
            inProgress.add(sig);
            components[annot] = _buildTemplate(t, self);
            inProgress.remove(sig);
          }
          return '#components/$annot';
        }
      }

      return _buildTemplate(t, self);
    };

    return {'schema': self(type), 'components': components};
  }

  // ============================================================== shared ===
  /// One leaf/shape function used by both modes above. [next] is how it
  /// recurses into child type nodes — plain identity recursion for
  /// [typeTemplate], reuse-checking recursion for [typeSchema].
  static dynamic _buildTemplate(MichelineExpr type, _Templater next) {
    final t = _asPrim(type);
    switch (t.prim) {
      case 'unit':
        return '#unit';
      case 'bool':
        return '#bool';
      case 'nat':
        return '#nat';
      case 'int':
        return '#int';
      case 'mutez':
        return '#mutez';
      case 'timestamp':
        return '#timestamp';
      case 'string':
        return '#string';
      case 'address':
        return '#address';
      case 'key_hash':
        return '#key_hash';
      case 'key':
        return '#key';
      case 'signature':
        return '#signature';
      case 'chain_id':
        return '#chain_id';
      case 'contract':
        return '#contract';
      case 'bytes':
      case 'bls12_381_g1':
      case 'bls12_381_g2':
      case 'bls12_381_fr':
      case 'chest':
      case 'chest_key':
      case 'sapling_state':
      case 'sapling_transaction':
        return '#${t.prim}';
      case 'lambda':
        return '#lambda';
      case 'operation':
        return '#operation';
      case 'ticket':
        return '#ticket';

      case 'option':
        // encode() accepts null for None, or the Some-value directly — so
        // the value template IS the Some-value template.
        return next(t.args[0]);

      case 'or':
        if (_isAllUnitOr(t)) {
          return {
            'kind': '#${_collectUnitOrNames(t).join("|")}',
            'value': null,
          };
        }
        final leftType = _asPrim(t.args[0]);
        final rightType = _asPrim(t.args[1]);
        final leftName = _fieldAnnot(leftType) ?? 'Left';
        final rightName = _fieldAnnot(rightType) ?? 'Right';
        return {'kind': '#$leftName|$rightName', 'value': next(t.args[0])};

      case 'pair':
        {
          final allAnnotated = t.args.every(
            (ft) => _fieldAnnot(_asPrim(ft)) != null,
          );
          if (allAnnotated) {
            return {
              for (final ft in t.args) _fieldAnnot(_asPrim(ft))!: next(ft),
            };
          }
          return [for (final ft in t.args) next(ft)];
        }

      case 'list':
      case 'set':
        return [next(t.args[0])];

      case 'map':
      case 'big_map':
        return {'${next(t.args[0])}': next(t.args[1])};

      default:
        return '<${t.prim}: unsupported>';
    }
  }

  /// Canonical structural signature of a type node — used only to detect
  /// "this annotated substructure has the exact same shape elsewhere",
  /// so [typeSchema] knows when it's safe to hoist into `components`.
  static String _typeSignature(MichelinePrim t) {
    final annots = t.annots.join(',');
    if (t.args.isEmpty) return '${t.prim}{$annots}';
    final argsSig = t.args.map((a) => _typeSignature(_asPrim(a))).join('|');
    return '${t.prim}{$annots}($argsSig)';
  }

  static bool _isAllUnitOr(MichelinePrim t) {
    if (t.prim == 'unit') return true;
    if (t.prim != 'or') return false;
    return t.args.every((a) => _isAllUnitOr(_asPrim(a)));
  }

  static List<String> _collectUnitOrNames(MichelinePrim t) {
    if (t.prim == 'unit') return [_fieldAnnot(t) ?? '?'];
    return [for (final a in t.args) ..._collectUnitOrNames(_asPrim(a))];
  }

  // =============================================== entrypoint helpers ===
  // (used by TezosContractAbi below)
  static Map<String, MichelineExpr> collectEntrypoints(MichelineExpr type) {
    final result = <String, MichelineExpr>{};
    void walk(MichelineExpr t, bool isRoot) {
      final p = _asPrim(t);
      final annot = _fieldAnnot(p);
      if (p.prim == 'or' && annot == null) {
        walk(p.args[0], false);
        walk(p.args[1], false);
        return;
      }
      final name = annot ?? (isRoot ? 'default' : null);
      if (name != null) {
        if (result.containsKey(name)) {
          throw OnChainErrors.tezosAbi(
            'collectEntrypoints',
            reason:
                'Duplicate entrypoint annotation "%$name" in parameter type',
          );
        }
        result[name] = t;
      }
    }

    walk(type, true);
    if (result.isEmpty) result['default'] = type;
    return result;
  }

  static ({MichelineExpr type, List<bool> path})? findEntrypoint(
    MichelineExpr type,
    String name,
    List<bool> path,
    bool isRoot,
  ) {
    final p = _asPrim(type);
    final annot = _fieldAnnot(p);
    final myName = annot ?? (isRoot ? 'default' : null);
    if (myName == name) return (type: type, path: path);
    if (p.prim == 'or' && annot == null) {
      final l = findEntrypoint(p.args[0], name, [...path, true], false);
      if (l != null) return l;
      final r = findEntrypoint(p.args[1], name, [...path, false], false);
      if (r != null) return r;
    }
    return null;
  }

  static ({String name, MichelineExpr type, MichelineExpr value})
  decodeEntrypointNode(
    MichelineExpr expr,
    MichelineExpr type, {
    required bool isRoot,
  }) {
    final p = _asPrim(type);
    final annot = _fieldAnnot(p);
    final myName = annot ?? (isRoot ? 'default' : null);
    if (p.prim == 'or' && annot == null) {
      if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Left') {
        return decodeEntrypointNode(expr.arg, p.args[0], isRoot: false);
      }
      if (expr is MichelinePrim1ArgNoAnnots && expr.prim == 'Right') {
        return decodeEntrypointNode(expr.arg, p.args[1], isRoot: false);
      }
      throw OnChainErrors.tezosAbi(
        'decodeEntrypointNode',
        reason:
            'Expected Left/Right while walking parameter `or` tree, got $expr',
      );
    }
    return (name: myName ?? 'default', type: type, value: expr);
  }
}

/// The ethers-`Contract`-style entry point: build once from a contract's
/// `code`, then use plain Dart values for everything.
class TezosContractAbi {
  final MichelineExpr code;
  final MichelineExpr parameterType;
  final MichelineExpr storageType;
  final Map<String, MichelineExpr> _entrypoints;
  final Map<String, ({MichelineExpr input, MichelineExpr output})> _views;

  TezosContractAbi._(
    this.code,
    this.parameterType,
    this.storageType,
    this._entrypoints,
    this._views,
  );

  factory TezosContractAbi.fromCode(MichelineExpr code) {
    if (code is! MichelineSequence) {
      throw OnChainErrors.tezosAbi(
        'TezosContractAbi.fromCode',
        reason:
            'code must be a Micheline sequence [parameter; storage; code; view*]',
      );
    }
    MichelineExpr? paramT, storageT;
    final views = <String, ({MichelineExpr input, MichelineExpr output})>{};

    for (final section in code.items) {
      if (section is! MichelinePrim) continue;
      switch (section.prim) {
        case 'parameter':
          if (section.args.isNotEmpty) paramT = section.args[0];
          break;
        case 'storage':
          if (section.args.isNotEmpty) storageT = section.args[0];
          break;
        case 'view':
          final args = section.args;
          if (args.length >= 3 && args[0] is MichelineString) {
            final name = (args[0] as MichelineString).value;
            views[name] = (input: args[1], output: args[2]);
          }
          break;
      }
    }

    if (paramT == null) {
      throw OnChainErrors.tezosAbi(
        'TezosContractAbi.fromCode',
        reason: 'Code is missing a `parameter` section.',
      );
    }
    if (storageT == null) {
      throw OnChainErrors.tezosAbi(
        'TezosContractAbi.fromCode',
        reason: 'Code is missing a `storage` section.',
      );
    }
    return TezosContractAbi._(
      code,
      paramT,
      storageT,
      TezosAbi.collectEntrypoints(paramT),
      views,
    );
  }

  factory TezosContractAbi.fromCodeJson(dynamic codeJson) =>
      TezosContractAbi.fromCode(MichelineExpr.deserializeJson(codeJson));

  /// Entrypoint names, e.g. `['increment', 'decrement', 'reset']`.
  /// Includes `'default'` for contracts with a single, unnamed entrypoint.
  List<String> get entrypoints => _entrypoints.keys.toList();

  // ------------------------------------------------------------ storage --
  MichelineExpr encodeStorage(dynamic value) =>
      TezosAbi.encode(value, storageType, path: 'storage');
  dynamic decodeStorage(MichelineExpr expr) =>
      TezosAbi.decode(expr, storageType, path: 'storage');

  TezosScript originationScript(dynamic storageValue) =>
      TezosScript(code: code, storage: encodeStorage(storageValue));

  // --------------------------------------------------------- parameter --
  MichelineExpr encodeParameter(String entrypoint, dynamic value) {
    final found = TezosAbi.findEntrypoint(parameterType, entrypoint, [], true);
    if (found == null) {
      throw OnChainErrors.tezosAbi(
        'encodeParameter',
        reason: 'Unknown entrypoint "$entrypoint". Available: $entrypoints',
      );
    }
    var expr = TezosAbi.encode(value, found.type, path: entrypoint);
    for (final isLeft in found.path.reversed) {
      expr = MichelinePrim1ArgNoAnnots(isLeft ? 'Left' : 'Right', expr);
    }
    return expr;
  }

  TezosContractParameters encodeTxParameter(String entrypoint, dynamic value) {
    final found = TezosAbi.findEntrypoint(parameterType, entrypoint, [], true);
    if (found == null) {
      throw OnChainErrors.tezosAbi(
        'encodeParameter',
        reason: 'Unknown entrypoint "$entrypoint". Available: $entrypoints',
      );
    }
    var expr = TezosAbi.encode(value, found.type, path: entrypoint);
    return TezosContractParameters(
      entrypoint: TezosEntrypoint.deserializeJson(entrypoint),
      value: expr,
    );
  }

  ({String entrypoint, T value}) decodeParameter<T>(MichelineExpr expr) {
    final node = TezosAbi.decodeEntrypointNode(
      expr,
      parameterType,
      isRoot: true,
    );
    return (
      entrypoint: node.name,
      value: JsonParser.valueAs<T>(
        TezosAbi.decode(node.value, node.type, path: node.name),
      ),
    );
  }

  // --------------------------------------------------------- big_map -----
  BigInt getBigMapId(MichelineExpr storageExpr, {String? path}) =>
      TezosAbi.getBigMapId(storageExpr, storageType, path: path);

  /// Looks up the big_map at [path] and returns everything needed to
  /// both fetch and decode a key's value: the big_map id, the RPC-ready
  /// `expr...` script-expr hash for [keyValue], and the value type (for
  /// [decodeBigMapResult]).
  ({BigInt bigMapId, String scriptExpr, MichelineExpr valueType})
  bigMapKeyLookup(MichelineExpr storageExpr, String path, dynamic keyValue) {
    final types = _findBigMapTypes(storageType, path, '');
    if (types == null) {
      throw OnChainErrors.tezosAbi(
        'bigMapKeyLookup',
        reason: 'No big_map at path "$path"',
      );
    }
    final id = getBigMapId(storageExpr, path: path);
    final scriptExpr = TezosAbi.bigMapKeyHash(keyValue, types.keyType);
    return (bigMapId: id, scriptExpr: scriptExpr, valueType: types.valueType);
  }

  /// Decodes a raw big_map value response (already-parsed JSON, e.g. from
  /// `client.getBigMapValue(...)`) against the value type of the big_map
  /// at [path]. Use with the same [path] passed to [bigMapKeyLookup].
  T decodeBigMapResult<T>(String path, MichelineExpr expr) {
    final types = _findBigMapTypes(storageType, path, '');
    if (types == null) {
      throw OnChainErrors.tezosAbi(
        'decodeBigMapResult',
        reason: 'No big_map at path "$path"',
      );
    }
    return JsonParser.valueAs<T>(
      TezosAbi.decode(expr, types.valueType, path: path),
    );
  }

  static ({MichelineExpr keyType, MichelineExpr valueType})? _findBigMapTypes(
    MichelineExpr ty,
    String targetPath,
    String path,
  ) {
    final t = ty as MichelinePrim;
    switch (t.prim) {
      case 'big_map':
        final own = TezosAbi._fieldAnnot(t);
        final key = own ?? (path.isEmpty ? 'big_map' : path);
        if (key == targetPath || path == targetPath) {
          return (keyType: t.args[0], valueType: t.args[1]);
        }
        return null;
      case 'pair':
        for (var i = 0; i < t.args.length; i++) {
          final ft = t.args[i] as MichelinePrim;
          final name = TezosAbi._fieldAnnot(ft) ?? '$i';
          final found = _findBigMapTypes(
            t.args[i],
            targetPath,
            path.isEmpty ? name : '$path.$name',
          );
          if (found != null) return found;
        }
        return null;
      default:
        return null;
    }
  }

  // ---------------------------------------------------------- templates --
  ({dynamic keyTemplate, dynamic valueTemplate}) getBigMapTemplate(
    String path,
  ) {
    final types = _findBigMapTypes(storageType, path, '');
    if (types == null) {
      throw OnChainErrors.tezosAbi(
        'getBigMapTemplate',
        reason: 'No big_map at path "$path"',
      );
    }
    return (
      keyTemplate: TezosAbi.typeTemplate(types.keyType),
      valueTemplate: TezosAbi.typeTemplate(types.valueType),
    );
  }

  dynamic getEntrypointTemplate(String entrypoint) {
    final found = TezosAbi.findEntrypoint(parameterType, entrypoint, [], true);
    if (found == null) {
      throw OnChainErrors.tezosAbi(
        'getEntrypointTemplate',
        reason: 'Unknown entrypoint "$entrypoint". Available: $entrypoints',
      );
    }
    return TezosAbi.typeTemplate(found.type);
  }

  dynamic getStorageTemplate() {
    return TezosAbi.typeTemplate(storageType);
  }

  ({dynamic inputTemplate, dynamic outputTemplate}) getViewTemplate(
    String name,
  ) {
    return (
      inputTemplate: TezosAbi.typeTemplate(viewInputType(name)),
      outputTemplate: TezosAbi.typeTemplate(viewOutputType(name)),
    );
  }

  // ---------------------------------------------------------- views ------
  static Map<String, dynamic> _viewImpl(
    Map<String, dynamic> metadata,
    String name,
  ) {
    final views = (metadata['views'] as List?) ?? const [];
    final view = views.cast<Map<String, dynamic>>().firstWhere(
      (v) => v['name'] == name,
      orElse:
          () =>
              throw OnChainErrors.tezosMetadata(
                "evaluateOffchainView",
                reason: 'No view named "$name" in metadata',
              ),
    );
    final impls = (view['implementations'] as List?) ?? const [];
    final msv = impls.cast<Map<String, dynamic>>().firstWhere(
      (i) => i.containsKey('michelsonStorageView'),
      orElse:
          () =>
              throw OnChainErrors.tezosMetadata(
                "evaluateOffchainView",
                reason:
                    'View "$name" has no michelsonStorageView implementation',
              ),
    );
    return msv['michelsonStorageView'] as Map<String, dynamic>;
  }

  dynamic evaluateOffchainView(
    Map<String, dynamic> metadata,
    String name,
    dynamic parameterValue,
    MichelineExpr storageExpr,
  ) {
    final impl = _viewImpl(metadata, name);
    final parameterTypeJson = impl['parameter'];
    final returnTypeJson = impl['returnType'];
    final codeJson = impl['code'];
    if (returnTypeJson == null || codeJson == null) {
      throw OnChainErrors.tezosAbi(
        'evaluateOffchainView',
        reason: 'View "$name" implementation is missing returnType/code',
      );
    }
    final returnType = MichelineExpr.deserializeJson(returnTypeJson);
    final code = MichelineExpr.deserializeJson(codeJson) as MichelineSequence;

    final MichelineExpr input;
    if (parameterTypeJson != null) {
      final paramType = MichelineExpr.deserializeJson(parameterTypeJson);
      final encodedParam = TezosAbi.encode(
        parameterValue,
        paramType,
        path: name,
      );
      input = MichelinePrim2ArgsNoAnnots('Pair', encodedParam, storageExpr);
    } else {
      input = storageExpr;
    }

    final vm = TezosMichelsonVM();
    final resultStack = vm.run(code.items, [input]);
    if (resultStack.length != 1) {
      throw OnChainErrors.tezosAbi(
        'evaluateOffchainView',
        reason:
            'View "$name" left ${resultStack.length} values on the stack, expected 1',
      );
    }
    return TezosAbi.decode(resultStack.single, returnType, path: name);
  }

  List<String> get views => _views.keys.toList();

  MichelineExpr viewInputType(String name) =>
      _views[name]?.input ??
      (throw OnChainErrors.tezosAbi(
        'viewInputType',
        reason: 'Unknown view "$name". Available: $views',
      ));
  MichelineExpr viewOutputType(String name) =>
      _views[name]?.output ??
      (throw OnChainErrors.tezosAbi(
        'viewOutputType',
        reason: 'Unknown view "$name". Available: $views',
      ));

  MichelineExpr encodeViewInput(String name, dynamic value) =>
      TezosAbi.encode(value, viewInputType(name), path: name);

  T decodeViewOutput<T>(String name, MichelineExpr expr) =>
      JsonParser.valueAs<T>(
        TezosAbi.decode(expr, viewOutputType(name), path: name),
      );
}
