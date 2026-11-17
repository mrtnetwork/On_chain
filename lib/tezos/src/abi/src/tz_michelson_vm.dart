import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';

/// A minimal Michelson interpreter for the pure subset legal in TZIP-16
/// off-chain storage views. Operates directly on MichelineExpr values —
/// no separate typed representation needed since the code was already
/// type-checked at origination.
class TezosMichelsonVM {
  final List<MichelineExpr> _stack = [];

  List<MichelineExpr> run(
    List<MichelineExpr> code,
    List<MichelineExpr> initialStack,
  ) {
    _stack
      ..clear()
      ..addAll(initialStack);
    _exec(code);
    return List.unmodifiable(_stack);
  }

  void _exec(List<MichelineExpr> code) {
    for (final instr in code) {
      _step(_asPrim(instr));
    }
  }

  void _step(MichelinePrim i) {
    switch (i.prim) {
      // ---------------- stack shuffling ----------------
      case 'DUP':
        final n = i.args.isEmpty ? 1 : _intArg(i, 0);
        _push(_peek(n - 1));
        break;
      case 'DROP':
        final n = i.args.isEmpty ? 1 : _intArg(i, 0);
        for (var k = 0; k < n; k++) {
          _pop();
        }
        break;
      case 'SWAP':
        final a = _pop(), b = _pop();
        _push(a);
        _push(b);
        break;
      case 'DIG':
        final n = _intArg(i, 0);
        final v = _stack.removeAt(_stack.length - 1 - n);
        _push(v);
        break;
      case 'DUG':
        final n = _intArg(i, 0);
        final v = _pop();
        _stack.insert(_stack.length - n, v);
        break;
      case 'DIP':
        if (i.args.length == 2) {
          final n = _intArg(i, 0);
          final saved = [for (var k = 0; k < n; k++) _pop()];
          _exec((i.args[1] as MichelineSequence).items);
          for (final v in saved.reversed) {
            _push(v);
          }
        } else {
          final saved = _pop();
          _exec((i.args[0] as MichelineSequence).items);
          _push(saved);
        }
        break;
      case 'RENAME':
      case 'CAST':
        break; // type-level only; no runtime effect

      // ---------------- literals ----------------
      case 'PUSH':
        _push(i.args[1]);
        break;
      case 'UNIT':
        _push(const MichelinePrimNoArgsNoAnnots.unit());
        break;
      case 'NIL':
        _push(const MichelineSequence([]));
        break;
      case 'NONE':
        _push(MichelinePrimNoArgsNoAnnots('None'));
        break;
      case 'EMPTY_MAP':
      case 'EMPTY_SET':
        _push(const MichelineSequence([]));
        break;

      // ---------------- pairs / combs ----------------
      case 'PAIR':
        final n = i.args.isEmpty ? 2 : _intArg(i, 0);
        final items = [for (var k = 0; k < n; k++) _pop()].reversed.toList();
        _push(
          n == 2
              ? MichelinePrim2ArgsNoAnnots('Pair', items[0], items[1])
              : MichelinePrimGeneric('Pair', items, const []),
        );
        break;
      case 'UNPAIR':
        final n = i.args.isEmpty ? 2 : _intArg(i, 0);
        final parts = _pairParts(_pop(), n);
        for (final p in parts.reversed) {
          _push(p);
        }
        break;
      case 'CAR':
        _push(_pairParts(_pop(), 2)[0]);
        break;
      case 'CDR':
        _push(_pairTail(_pop()));
        break;
      case 'GET':
        if (i.args.isNotEmpty) {
          // GET n — comb field access by index
          final n = _intArg(i, 0);
          _push(_combGetIndex(_pop(), n));
        } else {
          // GET — map/set lookup: key : map -> option(value)
          final key = _pop();
          final map = _pop();
          _push(_mapGet(map, key));
        }
        break;

      // ---------------- options ----------------
      case 'SOME':
        _push(MichelinePrim1ArgNoAnnots('Some', _pop()));
        break;
      case 'IF_NONE':
        final v = _pop();
        if (v is MichelinePrim && v.prim == 'None') {
          _exec((i.args[0] as MichelineSequence).items);
        } else {
          _push((v as MichelinePrim1ArgNoAnnots).arg);
          _exec((i.args[1] as MichelineSequence).items);
        }
        break;

      // ---------------- or / unions ----------------
      case 'LEFT':
        _push(MichelinePrim1ArgNoAnnots('Left', _pop()));
        break;
      case 'RIGHT':
        _push(MichelinePrim1ArgNoAnnots('Right', _pop()));
        break;
      case 'IF_LEFT':
        final v = _pop() as MichelinePrim1ArgNoAnnots;
        _push(v.arg);
        _exec(
          ((v.prim == 'Left' ? i.args[0] : i.args[1]) as MichelineSequence)
              .items,
        );
        break;

      // ---------------- lists ----------------
      case 'CONS':
        final h = _pop(), t = _pop() as MichelineSequence;
        _push(MichelineSequence([h, ...t.items]));
        break;
      case 'IF_CONS':
        final v = _pop() as MichelineSequence;
        if (v.items.isEmpty) {
          _exec((i.args[1] as MichelineSequence).items);
        } else {
          _push(MichelineSequence(v.items.sublist(1)));
          _push(v.items.first);
          _exec((i.args[0] as MichelineSequence).items);
        }
        break;
      case 'SIZE':
        final v = _pop();
        final n =
            v is MichelineSequence
                ? v.items.length
                : v is MichelineString
                ? StringUtils.encode(v.value).length
                : v is MichelineBytes
                ? v.value.length
                : throw BuError(
                  DefaultErrorType.unsupported,
                  'SIZE: Unsupported operand $v',
                );

        _push(MichelineInt(BigInt.from(n)));
        break;
      case 'ITER':
        final seq = _pop();
        final items =
            seq is MichelineSequence
                ? seq.items
                : throw BuError(
                  DefaultErrorType.invalidArgument,
                  'ITER: Expected list/set/map, got $seq',
                );
        for (final item in items) {
          _push(item);
          _exec((i.args[0] as MichelineSequence).items);
        }
        break;
      case 'MAP':
        final seq = _pop() as MichelineSequence;
        final out = <MichelineExpr>[];
        for (final item in seq.items) {
          _push(item);
          _exec((i.args[0] as MichelineSequence).items);
          out.add(_pop());
        }
        _push(MichelineSequence(out));
        break;
      case 'LOOP':
        while (true) {
          final cond = _pop();
          if (!_isTrue(cond)) break;
          _exec((i.args[0] as MichelineSequence).items);
        }
        break;

      // ---------------- comparisons / bools ----------------
      case 'COMPARE':
        final b = _pop(), a = _pop();
        _push(MichelineInt(BigInt.from(_compare(a, b))));
        break;
      case 'EQ':
        _cmpToBool((c) => c == 0);
        break;
      case 'NEQ':
        _cmpToBool((c) => c != 0);
        break;
      case 'LT':
        _cmpToBool((c) => c < 0);
        break;
      case 'GT':
        _cmpToBool((c) => c > 0);
        break;
      case 'LE':
        _cmpToBool((c) => c <= 0);
        break;
      case 'GE':
        _cmpToBool((c) => c >= 0);
        break;
      case 'IF':
        final cond = _pop();
        _exec(
          ((_isTrue(cond) ? i.args[0] : i.args[1]) as MichelineSequence).items,
        );
        break;
      case 'NOT':
        final v = _pop();
        _push(
          v is MichelinePrim
              ? MichelinePrimNoArgsNoAnnots(_isTrue(v) ? 'False' : 'True')
              : MichelineInt(~(v as MichelineInt).value),
        );
        break;
      case 'AND':
        final b = _pop(), a = _pop();
        _push(
          a is MichelinePrim
              ? MichelinePrimNoArgsNoAnnots(
                _isTrue(a) && _isTrue(b) ? 'True' : 'False',
              )
              : MichelineInt(
                (a as MichelineInt).value & (b as MichelineInt).value,
              ),
        );
        break;
      case 'OR':
        final b = _pop(), a = _pop();
        _push(
          a is MichelinePrim
              ? MichelinePrimNoArgsNoAnnots(
                _isTrue(a) || _isTrue(b) ? 'True' : 'False',
              )
              : MichelineInt(
                (a as MichelineInt).value | (b as MichelineInt).value,
              ),
        );
        break;

      // ---------------- arithmetic ----------------
      case 'ADD':
        _binInt((a, b) => a + b);
        break;
      case 'SUB':
        _binInt((a, b) => a - b);
        break;
      case 'MUL':
        _binInt((a, b) => a * b);
        break;
      case 'ABS':
        _push(MichelineInt((_pop() as MichelineInt).value.abs()));
        break;
      case 'NEG':
        _push(MichelineInt(-(_pop() as MichelineInt).value));
        break;
      case 'INT':
        _push(MichelineInt((_pop() as MichelineInt).value));
        break;
      case 'ISNAT':
        final v = (_pop() as MichelineInt).value;
        _push(
          v.isNegative
              ? MichelinePrimNoArgsNoAnnots('None')
              : MichelinePrim1ArgNoAnnots('Some', MichelineInt(v)),
        );
        break;
      case 'CONCAT':
        final b = _pop();
        if (b is MichelineSequence) {
          _push(
            MichelineString(
              b.items.map((e) => (e as MichelineString).value).join(),
            ),
          );
        } else {
          final a = _pop() as MichelineString;
          _push(MichelineString(a.value + (b as MichelineString).value));
        }
        break;

      // ---------------- control ----------------
      case 'FAILWITH':
        throw BuError(
          OnChainErrorType.tezosView,
          'View FAILWITH: ${_pop().toJson()}',
        );
      case 'ASSERT':
        if (!_isTrue(_pop())) {
          throw BuError(OnChainErrorType.tezosView, 'View assertion failed.');
        }
        break;

      default:
        throw BuError(
          DefaultErrorType.unsupported,
          'Unsupported instruction `${i.prim}` — not legal in a pure TZIP-16 '
          'view (or not yet implemented in TezosMichelsonVM). If this is a '
          'legitimate pure instruction, it just needs a case added.',
        );
    }
  }

  // ------------------------------------------------------------ helpers --
  void _push(MichelineExpr v) => _stack.add(v);
  MichelineExpr _pop() {
    if (_stack.isEmpty) {
      throw BuError(OnChainErrorType.tezosView, 'Stack underflow.');
    }

    return _stack.removeLast();
  }

  MichelineExpr _peek(int depth) => _stack[_stack.length - 1 - depth];

  void _binInt(BigInt Function(BigInt, BigInt) op) {
    final b = (_pop() as MichelineInt).value;
    final a = (_pop() as MichelineInt).value;
    _push(MichelineInt(op(a, b)));
  }

  void _cmpToBool(bool Function(int) test) {
    final c = (_pop() as MichelineInt).value;
    _push(MichelinePrimNoArgsNoAnnots(test(c.toInt()) ? 'True' : 'False'));
  }

  bool _isTrue(MichelineExpr v) => v is MichelinePrim && v.prim == 'True';

  int _intArg(MichelinePrim i, int idx) =>
      (i.args[idx] as MichelineInt).value.asSafeInt;

  MichelinePrim _asPrim(MichelineExpr e) {
    if (e is MichelinePrim) return e;
    throw BuError(
      DefaultErrorType.invalidArgument,
      'Expected instruction node, got $e.',
    );
  }

  /// Splits a runtime Pair/array value into exactly [n] parts (comb-aware,
  /// same flat/nested/array-shorthand tolerance as TezosAbi's decoder).
  List<MichelineExpr> _pairParts(MichelineExpr expr, int n) {
    List<MichelineExpr> args;
    if (expr is MichelinePrim && expr.prim == 'Pair') {
      args = expr.args;
    } else if (expr is MichelineSequence) {
      args = expr.items;
    } else {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Expected Pair/array, got $expr',
      );
    }
    if (args.length == n) return args;
    if (args.length > n) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Pair has ${args.length} elements, expected $n',
      );
    }
    final head = args.sublist(0, args.length - 1);
    return [...head, ..._pairParts(args.last, n - head.length)];
  }

  MichelineExpr _pairTail(MichelineExpr expr) {
    final args =
        expr is MichelinePrim && expr.prim == 'Pair'
            ? expr.args
            : expr is MichelineSequence
            ? expr.items
            : throw BuError(
              DefaultErrorType.invalidArgument,
              'CDR: Expected Pair/array, got $expr',
            );
    if (args.length < 2) {
      throw BuError(
        OnChainErrorType.tezosView,
        'CDR: Not enough elements in $expr.',
      );
    }
    if (args.length == 2) return args[1];
    return MichelinePrimGeneric('Pair', args.sublist(1), const []);
  }

  MichelineExpr _combGetIndex(MichelineExpr expr, int n) {
    if (n < 0) {
      throw BuError(OnChainErrorType.tezosView, 'GET: negative index $n.');
    }
    var cur = expr;
    for (var i = 0; i < n; i++) {
      cur = _pairTail(cur);
    }
    final isPair =
        (cur is MichelinePrim && cur.prim == 'Pair') ||
        cur is MichelineSequence;
    if (n == 0 || isPair) {
      return _pairParts(cur, 2)[0];
    }
    return cur;
  }

  MichelineExpr _mapGet(MichelineExpr map, MichelineExpr key) {
    if (map is! MichelineSequence) {
      throw BuError(
        OnChainErrorType.tezosView,
        'GET: expected map/set, got $map',
      );
    }
    for (final item in map.items) {
      if (item is MichelinePrim2ArgsNoAnnots && item.prim == 'Elt') {
        if (_compare(item.arg1, key) == 0) {
          return MichelinePrim1ArgNoAnnots('Some', item.arg2);
        }
      }
    }
    return MichelinePrimNoArgsNoAnnots('None');
  }

  int _compare(MichelineExpr a, MichelineExpr b) {
    if (a is MichelineInt && b is MichelineInt) {
      return a.value.compareTo(b.value);
    }
    if (a is MichelineString && b is MichelineString) {
      return a.value.compareTo(b.value);
    }
    if (a is MichelineBytes && b is MichelineBytes) {
      return BytesUtils.compareBytes(a.value, b.value);
    }
    if (a is MichelinePrim &&
        b is MichelinePrim &&
        a.args.isEmpty &&
        b.args.isEmpty) {
      // e.g. True/False, or enum-like unit prims
      return a.prim.compareTo(b.prim);
    }
    throw BuError(
      DefaultErrorType.unsupported,
      'COMPARE: Unsupported operand pair ($a, $b).',
    );
  }
}
