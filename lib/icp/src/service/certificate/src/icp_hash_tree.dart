import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';

sealed class ICPHashTree {
  const ICPHashTree();

  /// Reconstruct the root hash of this (partial) tree.
  List<int> reconstruct();

  /// CBOR encode (no outer 55799 tag – tree is nested inside the certificate).
  CborObject toCbor();

  factory ICPHashTree.fromCbor(CborObject obj) {
    // Tree is always a CBOR array: [tag, ...]
    final list = (obj is CborListValue) ? obj.value : (obj.getValue() as List);
    final tag = (list[0] as CborNumeric).toInt();

    return switch (tag) {
      0 => const ICPHashTreeEmpty(),
      1 => ICPHashTreeFork(
        left: ICPHashTree.fromCbor(list[1] as CborObject),
        right: ICPHashTree.fromCbor(list[2] as CborObject),
      ),
      2 => ICPHashTreeLabeled(
        label: (list[1] as CborBytesValue).value,
        subtree: ICPHashTree.fromCbor(list[2] as CborObject),
      ),
      3 => ICPHashTreeLeaf(
        value:
            (list[1] as CborBytesValue).value, // some encoders put value at [1]
      ),
      4 => ICPHashTreePruned(hash: (list[1] as CborBytesValue).value),
      _ =>
        throw OnChainErrors.icpPlugin(
          "ICPHashTree.fromCbor",
          reason: 'Unknown HashTree tag.',
          details: {'tag': '$tag'},
        ),
    };
  }

  /// Safer parser that handles both [3, bytes] and occasional layout quirks.
  static ICPHashTree deserializeNode(dynamic raw) {
    final list =
        raw is CborListValue
            ? raw.value.map((e) => e.getValue()).toList()
            : (raw as List);

    final tag = list[0] as int;

    switch (tag) {
      case 0:
        return const ICPHashTreeEmpty();
      case 1:
        return ICPHashTreeFork(
          left: deserializeNode(list[1]),
          right: deserializeNode(list[2]),
        );
      case 2:
        final label = list[1] as List<int>;
        return ICPHashTreeLabeled(
          label: label,
          subtree: deserializeNode(list[2]),
        );
      case 3:
        final value = list[1] as List<int>;
        return ICPHashTreeLeaf(value: value);
      case 4:
        final hash = list[1] as List<int>;
        return ICPHashTreePruned(hash: hash);
      default:
        throw OnChainErrors.icpPlugin(
          "ICPHashTree.deserializeNode",
          reason: 'Unknown HashTree tag.',
          details: {'tag': '$tag'},
        );
    }
  }
}

final class ICPHashTreeEmpty extends ICPHashTree {
  const ICPHashTreeEmpty();

  @override
  List<int> reconstruct() =>
      ICPCryptoUtils.hashDomainSeparator("ic-hashtree-empty", []);

  @override
  CborObject toCbor() => CborListValue.definite([CborIntValue(0)]);
}

final class ICPHashTreeFork extends ICPHashTree {
  final ICPHashTree left;
  final ICPHashTree right;

  const ICPHashTreeFork({required this.left, required this.right});

  @override
  List<int> reconstruct() => ICPCryptoUtils.hashDomainSeparator(
    "ic-hashtree-fork",
    [...left.reconstruct(), ...right.reconstruct()],
  );

  @override
  CborObject toCbor() =>
      CborListValue.definite([CborIntValue(1), left.toCbor(), right.toCbor()]);
}

final class ICPHashTreeLabeled extends ICPHashTree {
  final List<int> label;
  final ICPHashTree subtree;

  const ICPHashTreeLabeled({required this.label, required this.subtree});

  @override
  List<int> reconstruct() => ICPCryptoUtils.hashDomainSeparator(
    "ic-hashtree-labeled",
    [...label, ...subtree.reconstruct()],
  );

  @override
  CborObject toCbor() => CborListValue.definite(<CborObject>[
    CborIntValue(2),
    CborBytesValue(label),
    subtree.toCbor(),
  ]);
}

final class ICPHashTreeLeaf extends ICPHashTree {
  final List<int> value;

  const ICPHashTreeLeaf({required this.value});

  @override
  List<int> reconstruct() =>
      ICPCryptoUtils.hashDomainSeparator("ic-hashtree-leaf", value);

  @override
  CborObject toCbor() => CborListValue.definite(<CborObject>[
    CborIntValue(3),
    CborBytesValue(value),
  ]);
}

final class ICPHashTreePruned extends ICPHashTree {
  final List<int> hash; // 32 bytes

  const ICPHashTreePruned({required this.hash});

  @override
  List<int> reconstruct() => hash;

  @override
  CborObject toCbor() => CborListValue.definite(<CborObject>[
    CborIntValue(4),
    CborBytesValue(hash),
  ]);
}

sealed class ICPLookupResult {
  const ICPLookupResult();
}

final class ICPLookupFound extends ICPLookupResult {
  final List<int> value;
  const ICPLookupFound(this.value);
}

final class ICPLookupAbsent extends ICPLookupResult {
  const ICPLookupAbsent();
}

final class ICPLookupUnknown extends ICPLookupResult {
  const ICPLookupUnknown();
}

final class ICPLookupError extends ICPLookupResult {
  const ICPLookupError();
}

abstract final class ICPHashTreeUtils {
  static ICPLookupResult lookupPath(List<List<int>> path, ICPHashTree tree) {
    if (path.isEmpty) {
      return switch (tree) {
        ICPHashTreeEmpty() => const ICPLookupAbsent(),
        ICPHashTreeLeaf(:final value) => ICPLookupFound(value),
        ICPHashTreePruned() => const ICPLookupUnknown(),
        ICPHashTreeLabeled() || ICPHashTreeFork() => const ICPLookupError(),
      };
    }

    final label = path.first;
    final rest = path.sublist(1);
    final flat = _flattenForks(tree);

    final found = _findLabel(label, flat);
    return switch (found) {
      _FindAbsent() => const ICPLookupAbsent(),
      _FindUnknown() => const ICPLookupUnknown(),
      _FindError() => const ICPLookupError(),
      _FindSubtree(:final subtree) => lookupPath(rest, subtree),
    };
  }

  static List<ICPHashTree> _flattenForks(ICPHashTree tree) {
    return switch (tree) {
      ICPHashTreeEmpty() => [],
      ICPHashTreeFork(:final left, :final right) => [
        ..._flattenForks(left),
        ..._flattenForks(right),
      ],
      _ => [tree],
    };
  }

  static _FindResult _findLabel(List<int> label, List<ICPHashTree> nodes) {
    final hasPruned = nodes.any((n) => n is ICPHashTreePruned);
    final labeled = <({List<int> l, ICPHashTree t})>[];

    for (final n in nodes) {
      if (n is ICPHashTreeLabeled) {
        labeled.add((l: n.label, t: n.subtree));
      } else if (n is ICPHashTreeLeaf) {
        // Looking for a label but hit a leaf at this level → absent
        return _FindAbsent();
      }
      // Empty / Pruned: ignore for matching; pruned is tracked via hasPruned
    }

    // Critical: flatten order is NOT sorted — sort by label bytes
    labeled.sort((a, b) => BytesUtils.compareBytes(a.l, b.l));

    for (final e in labeled) {
      final cmp = BytesUtils.compareBytes(label, e.l);
      if (cmp == 0) return _FindSubtree(e.t);
    }

    // Missing label: pruned sibling → Unknown, else Absent
    return hasPruned ? _FindUnknown() : _FindAbsent();
  }
}

sealed class _FindResult {}

class _FindAbsent extends _FindResult {}

class _FindUnknown extends _FindResult {}

class _FindError extends _FindResult {}

class _FindSubtree extends _FindResult {
  final ICPHashTree subtree;
  _FindSubtree(this.subtree);
}

// _FindResult _findLabel(List<int> label, List<ICPHashTree> nodes) {
//   // Collect labeled nodes
//   final labeled = <({List<int> l, ICPHashTree t})>[];
//   for (final n in nodes) {
//     if (n is ICPHashTreeLabeled) {
//       labeled.add((l: n.label, t: n.subtree));
//     } else if (n is ICPHashTreeLeaf) {
//       return _FindAbsent(); // leaf at this level → absent
//     } else if (n is ICPHashTreePruned) {
//       // may hide the label
//     }
//   }

//   if (labeled.isEmpty) {
//     // only pruned / empty → unknown if any pruned, else absent
//     final hasPruned = nodes.any((n) => n is ICPHashTreePruned);
//     return hasPruned ? _FindUnknown() : _FindAbsent();
//   }

//   // binary-search style (labels are sorted)
//   for (var i = 0; i < labeled.length; i++) {
//     final cmp = BytesUtils.compareBytes(label, labeled[i].l);
//     if (cmp == 0) return _FindSubtree(labeled[i].t);
//     if (cmp < 0) {
//       // label < this one
//       if (i == 0) return _FindAbsent();
//       // between previous and this → absent
//       return _FindAbsent();
//     }
//   }
//   // label > all labeled → check if pruned could hide it
//   final hasPruned = nodes.any((n) => n is ICPHashTreePruned);
//   return hasPruned ? _FindUnknown() : _FindAbsent();
// }
