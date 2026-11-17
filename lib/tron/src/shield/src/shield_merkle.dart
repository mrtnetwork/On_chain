import 'package:blockchain_utils/blockchain_utils.dart';

/// TRON shielded merkle helpers.
/// TRON fullnode returns `VoucherInfo` (fillers/cursors + auth paths) via
/// `GetMerkleTreeVoucherInfo`. This file converts that into anchor + path
/// buffers consumable by the Sapling prover witness layout.
class TronShieldMerklePath {
  /// 32 siblings, each 32-byte Fq LE.
  final List<List<int>> siblings;

  /// Position bits (false = left, true = right), depth 32.
  final List<bool> position;
  final List<int> anchor;
  const TronShieldMerklePath({
    required this.siblings,
    required this.position,
    required this.anchor,
  });

  /// Parse from TRON `GetMerkleTreeVoucherInfo` JSON voucher entry.
  /// Expects `auth_path` (list of 32 hex/bytes), `index` (bool list),
  /// `rt` (root bytes). Accepts both hex strings and int lists.
  factory TronShieldMerklePath.fromVoucherJson(Map<String, dynamic> json) {
    List<List<int>> sibs = [];
    final rawPaths = json['auth_path'] ?? json['authentication_paths'] ?? [];
    for (final e in (rawPaths as List)) {
      if (e is String) {
        sibs.add(BytesUtils.fromHexString(e));
      } else if (e is List) {
        sibs.add(List<int>.from(e));
      } else if (e is Map && e['value'] is List) {
        // TronAuthenticationPath JSON: {value: [bool...]} is path flags,
        // not sibling; handled below if siblings missing.
        continue;
      }
    }
    // Fallback: TronMerklePath.authenticationPaths is list of
    // TronAuthenticationPath (bool lists) — not siblings; in that case
    // caller must supply siblings via `fillers` resolution (Phase 2).
    final idxRaw = (json['index'] as List?) ?? [];
    final pos = idxRaw.map((e) => e == true || e == 1).toList();
    final rt = json['rt'];
    List<int> anchor;
    if (rt is String) {
      anchor = BytesUtils.fromHexString(rt);
    } else if (rt is List) {
      anchor = List<int>.from(rt);
    } else {
      anchor = List<int>.filled(32, 0);
    }
    while (sibs.length < 32) {
      sibs.add(List<int>.filled(32, 0));
    }
    while (pos.length < 32) {
      pos.add(false);
    }
    return TronShieldMerklePath(
      siblings: sibs.sublist(0, 32),
      position: pos.sublist(0, 32),
      anchor: anchor,
    );
  }

  /// Position integer from path bits (LSB first).
  int get positionInt {
    int v = 0;
    for (int i = 0; i < position.length; i++) {
      if (position[i]) v |= (1 << i);
    }
    return v;
  }
}

/// Anchor tracker across scanned notes (frontier size per block).
class TronShieldAnchorTracker {
  List<int> currentAnchor = List<int>.filled(32, 0);
  int treeSize = 0;
  void update(List<int> anchor, int size) {
    currentAnchor = anchor;
    treeSize = size;
  }
}
