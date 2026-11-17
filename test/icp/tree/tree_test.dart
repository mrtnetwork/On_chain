import 'package:on_chain/icp/src/icp.dart';
import 'package:test/test.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import '../../utils.dart';

// Adjust this import path to match your project structure:
// import 'package:your_package/icp_hash_tree.dart';

/// Build a leaf node with a UTF-8 string value
ICPHashTree leaf(String value) => ICPHashTreeLeaf(value: value.codeUnits);

/// Build a labeled node with a UTF-8 string label
ICPHashTree labeled(String label, ICPHashTree subtree) =>
    ICPHashTreeLabeled(label: label.codeUnits, subtree: subtree);

/// Build a fork from two subtrees
ICPHashTree fork(ICPHashTree left, ICPHashTree right) =>
    ICPHashTreeFork(left: left, right: right);

/// Build a pruned node from raw 32-byte hash
ICPHashTree pruned(List<int> hash) => ICPHashTreePruned(hash: hash);

/// Encode a string path segment to bytes
List<int> lb(String s) => s.codeUnits;

/// Convenience: look up a path of string labels
ICPLookupResult lookup(List<String> path, ICPHashTree tree) =>
    ICPHashTreeUtils.lookupPath(path.map(lb).toList(), tree);

void treeTest() {
  group('ICP/Domain separator', () {
    test('Domain separator leaf good', () {
      final h = ICPCryptoUtils.hashDomainSeparator(
        'ic-hashtree-leaf',
        'good'.codeUnits,
      );
      expect(
        BytesUtils.toHexString(h),
        '7b32ac0c6ba8ce35ac82c255fc7906f7fc130dab2a090f80fe12f9c2cae83ba6',
      );
    });
  });

  group('ICP/HashTree CBOR serialization', () {
    test('Empty node serializes to [0]', () {
      final tree = const ICPHashTreeEmpty();
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor);

      expect(decoded, isA<ICPHashTreeEmpty>());
      expect(decoded.reconstruct(), equals(tree.reconstruct()));
    });
    test('Official IC example tree root hash', () {
      final tree = fork(
        fork(
          labeled(
            'a',
            fork(
              fork(labeled('x', leaf('hello')), const ICPHashTreeEmpty()),
              labeled('y', leaf('world')),
            ),
          ),
          labeled('b', leaf('good')),
        ),
        fork(
          labeled('c', const ICPHashTreeEmpty()),
          labeled('d', leaf('morning')),
        ),
      );

      expect(
        BytesUtils.toHexString(tree.reconstruct()),
        'eb5c5b2195e62d996b84c9bcc8259d19a83786a2f59e0878cec84c811f669aa0',
      );

      expect(
        BytesUtils.toHexString(leaf('good').reconstruct()),
        '7b32ac0c6ba8ce35ac82c255fc7906f7fc130dab2a090f80fe12f9c2cae83ba6',
      );
    });
    test('Leaf node round-trips correctly', () {
      final tree = leaf('hello world');
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor) as ICPHashTreeLeaf;

      expect(decoded.value, equals('hello world'.codeUnits));
      expect(decoded.reconstruct(), equals(tree.reconstruct()));
    });

    test('Labeled node round-trips correctly', () {
      final tree = labeled('time', leaf('2024-01-01'));
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor) as ICPHashTreeLabeled;

      expect(decoded.label, equals('time'.codeUnits));
      expect(decoded.subtree, isA<ICPHashTreeLeaf>());
    });

    test('Fork node round-trips correctly', () {
      final tree = fork(labeled('a', leaf('1')), labeled('b', leaf('2')));
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor) as ICPHashTreeFork;

      expect(decoded.left, isA<ICPHashTreeLabeled>());
      expect(decoded.right, isA<ICPHashTreeLabeled>());
    });

    test('Pruned node round-trips correctly', () {
      final hash = List<int>.generate(32, (i) => i);
      final tree = pruned(hash);
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor) as ICPHashTreePruned;

      expect(decoded.hash, equals(hash));
      expect(decoded.reconstruct(), equals(hash));
    });

    test('Nested tree round-trips correctly', () {
      final tree = labeled(
        'root',
        fork(
          labeled(
            'left',
            fork(labeled('deep', leaf('value')), const ICPHashTreeEmpty()),
          ),
          labeled('right', leaf('other')),
        ),
      );

      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor);

      // Verify structure by lookup
      final result = lookup(['root', 'left', 'deep'], decoded);
      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('value'.codeUnits));
    });

    test('deserializeNode handles raw list format', () {
      final tree = fork(labeled('x', leaf('y')), const ICPHashTreeEmpty());
      final cbor = tree.toCbor();
      // Extract raw list and feed to deserializeNode
      final rawList =
          (cbor as CborListValue).value.map((e) => e.getValue()).toList();
      final decoded = ICPHashTree.deserializeNode(rawList);

      expect(decoded, isA<ICPHashTreeFork>());
    });
  });

  // ---------------------------------------------------------------------------
  // Group 2: Hash reconstruction determinism
  // ---------------------------------------------------------------------------

  group('ICP/HashTree hash reconstruction', () {
    test('Empty hash is deterministic', () {
      final h1 = const ICPHashTreeEmpty().reconstruct();
      final h2 = const ICPHashTreeEmpty().reconstruct();
      expect(h1, equals(h2));
      expect(h1.length, equals(32)); // SHA-256 output size
    });

    test('Leaf hash depends on value', () {
      final h1 = leaf('a').reconstruct();
      final h2 = leaf('b').reconstruct();
      final h3 = leaf('a').reconstruct();

      expect(h1, equals(h3));
      expect(h1, isNot(equals(h2)));
    });

    test('Labeled hash depends on label and subtree', () {
      final h1 = labeled('label', leaf('val')).reconstruct();
      final h2 = labeled('label', leaf('val')).reconstruct();
      final h3 = labeled('other', leaf('val')).reconstruct();
      final h4 = labeled('label', leaf('other')).reconstruct();

      expect(h1, equals(h2));
      expect(h1, isNot(equals(h3)));
      expect(h1, isNot(equals(h4)));
    });

    test('Fork hash combines left and right', () {
      final left = leaf('L');
      final right = leaf('R');

      final fork1 = fork(left, right).reconstruct();
      final fork2 = fork(right, left).reconstruct(); // swapped
      final fork3 = fork(left, right).reconstruct();

      expect(fork1, equals(fork3));
      expect(fork1, isNot(equals(fork2))); // order matters
    });

    test('Pruned node returns its hash directly', () {
      final hash = List<int>.generate(32, (i) => i * 2);
      final tree = pruned(hash);
      expect(tree.reconstruct(), equals(hash));
    });

    test('Complex tree hash is deterministic', () {
      final tree = labeled(
        'cert',
        fork(labeled('tree', leaf('data')), labeled('sig', leaf('signature'))),
      );

      final h1 = tree.reconstruct();
      final h2 = tree.reconstruct();
      expect(h1, equals(h2));
      expect(h1.length, equals(32));
    });
  });

  // ---------------------------------------------------------------------------
  // Group 3: Path lookup – found cases
  // ---------------------------------------------------------------------------

  group('ICP/LookupPath – found', () {
    test('finds value at root leaf when path is empty', () {
      final tree = leaf('root-value');
      final result = lookup([], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('root-value'.codeUnits));
    });

    test('finds value at single label', () {
      final tree = labeled('time', leaf('noon'));
      final result = lookup(['time'], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('noon'.codeUnits));
    });

    test('finds value at nested path', () {
      final tree = labeled('a', labeled('b', labeled('c', leaf('deep'))));
      final result = lookup(['a', 'b', 'c'], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('deep'.codeUnits));
    });

    test('finds value in forked tree (left side)', () {
      final tree = fork(
        labeled('left', leaf('L')),
        labeled('right', leaf('R')),
      );
      final result = lookup(['left'], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('L'.codeUnits));
    });

    test('finds value in forked tree (right side)', () {
      final tree = fork(
        labeled('left', leaf('L')),
        labeled('right', leaf('R')),
      );
      final result = lookup(['right'], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('R'.codeUnits));
    });

    test('finds value in deeply forked tree', () {
      final tree = labeled(
        'root',
        fork(
          fork(labeled('x', leaf('1')), labeled('y', leaf('2'))),
          fork(labeled('z', leaf('3')), const ICPHashTreeEmpty()),
        ),
      );

      expect(lookup(['root', 'y'], tree), isA<ICPLookupFound>());
      expect(lookup(['root', 'z'], tree), isA<ICPLookupFound>());
    });
  });

  // ---------------------------------------------------------------------------
  // Group 4: Path lookup – absent cases
  // ---------------------------------------------------------------------------

  group('ICP/LookupPath – absent', () {
    test('empty path on empty tree returns absent', () {
      final result = lookup([], const ICPHashTreeEmpty());
      expect(result, isA<ICPLookupAbsent>());
    });

    test('missing label returns absent', () {
      final tree = labeled('exists', leaf('yes'));
      final result = lookup(['missing'], tree);
      expect(result, isA<ICPLookupAbsent>());
    });

    test('leaf at intermediate level returns absent', () {
      // If we encounter a leaf while still having path segments left
      final tree = labeled('a', leaf('early-leaf'));
      final result = lookup(['a', 'b'], tree);
      expect(result, isA<ICPLookupAbsent>());
    });

    test('unknown label in fork returns absent (no pruned)', () {
      final tree = fork(labeled('a', leaf('1')), labeled('b', leaf('2')));
      final result = lookup(['c'], tree);
      expect(result, isA<ICPLookupAbsent>());
    });

    test('path past leaf returns absent', () {
      final tree = labeled('x', leaf('val'));
      final result = lookup(['x', 'too', 'far'], tree);
      expect(result, isA<ICPLookupAbsent>());
    });
  });

  // ---------------------------------------------------------------------------
  // Group 5: Path lookup – unknown cases (pruned nodes)
  // ---------------------------------------------------------------------------

  group('ICP/LookupPath – unknown', () {
    test('pruned root with empty path returns unknown', () {
      final tree = pruned(List<int>.generate(32, (i) => 0));
      final result = lookup([], tree);
      expect(result, isA<ICPLookupUnknown>());
    });

    test('pruned node hiding label returns unknown', () {
      final tree = fork(
        labeled('visible', leaf('yes')),
        pruned(List<int>.generate(32, (i) => 1)),
      );
      final result = lookup(['hidden'], tree);
      expect(result, isA<ICPLookupUnknown>());
    });

    test('all-pruned tree returns unknown for any path', () {
      final tree = pruned(List<int>.generate(32, (i) => 0));
      final result = lookup(['anything'], tree);
      expect(result, isA<ICPLookupUnknown>());
    });

    test('pruned at intermediate level returns unknown', () {
      final tree = labeled('a', pruned(List<int>.generate(32, (i) => 0)));
      final result = lookup(['a', 'b'], tree);
      expect(result, isA<ICPLookupUnknown>());
    });
  });

  // ---------------------------------------------------------------------------
  // Group 6: Path lookup – error cases
  // ---------------------------------------------------------------------------

  group('ICP/LookupPath – error', () {
    test('empty path on labeled node returns error', () {
      final tree = labeled('label', leaf('val'));
      final result = lookup([], tree);
      expect(result, isA<ICPLookupError>());
    });

    test('empty path on fork returns error', () {
      final tree = fork(leaf('a'), leaf('b'));
      final result = lookup([], tree);
      expect(result, isA<ICPLookupError>());
    });
  });

  // ---------------------------------------------------------------------------
  // Group 7: Edge cases & binary search behavior
  // ---------------------------------------------------------------------------

  group('ICP/LookupPath – edge cases', () {
    test('handles empty label bytes', () {
      final tree = ICPHashTreeLabeled(label: [], subtree: leaf('empty-label'));
      final result = ICPHashTreeUtils.lookupPath([[]], tree);

      expect(result, isA<ICPLookupFound>());
      expect((result as ICPLookupFound).value, equals('empty-label'.codeUnits));
    });

    test('handles binary label sorting correctly', () {
      // Labels sorted lexicographically: "a" < "b" < "c"
      final tree = fork(
        labeled('b', leaf('B')),
        fork(labeled('a', leaf('A')), labeled('c', leaf('C'))),
      );

      // Flattening should still find all three regardless of tree shape
      expect(
        (lookup(['a'], tree) as ICPLookupFound).value,
        equals('A'.codeUnits),
      );
      expect(
        (lookup(['b'], tree) as ICPLookupFound).value,
        equals('B'.codeUnits),
      );
      expect(
        (lookup(['c'], tree) as ICPLookupFound).value,
        equals('C'.codeUnits),
      );
    });

    test('handles binary comparison with common prefix', () {
      final tree = fork(labeled('abc', leaf('1')), labeled('abd', leaf('2')));

      expect(
        (lookup(['abc'], tree) as ICPLookupFound).value,
        equals('1'.codeUnits),
      );
      expect(
        (lookup(['abd'], tree) as ICPLookupFound).value,
        equals('2'.codeUnits),
      );
      expect(lookup(['abx'], tree), isA<ICPLookupAbsent>());
    });

    test('large tree lookup performance (100 labels)', () {
      // Build a balanced-ish tree with 100 labeled leaves
      ICPHashTree buildTree(int start, int end) {
        if (start == end) {
          return labeled('key$start', leaf('val$start')); // interpolation
        }
        final mid = (start + end) ~/ 2;
        return fork(buildTree(start, mid), buildTree(mid + 1, end));
      }

      final tree = buildTree(0, 99);

      // Look up first, middle, last
      expect(lookup(['key0'], tree), isA<ICPLookupFound>());
      expect(lookup(['key50'], tree), isA<ICPLookupFound>());
      expect(lookup(['key99'], tree), isA<ICPLookupFound>());
      expect(lookup(['key100'], tree), isA<ICPLookupAbsent>());
    });

    test('lookup with non-UTF8 binary labels', () {
      final label = [0x00, 0x01, 0xFF, 0xFE];
      final tree = ICPHashTreeLabeled(label: label, subtree: leaf('binary'));
      final result = ICPHashTreeUtils.lookupPath([label], tree);

      expect(result, isA<ICPLookupFound>());
    });

    test('reconstruct after round-trip yields same hash', () {
      final tree = labeled(
        'cert',
        fork(
          labeled('time', leaf('1234567890')),
          labeled('data', leaf('payload')),
        ),
      );

      final originalHash = tree.reconstruct();
      final cbor = tree.toCbor();
      final decoded = ICPHashTree.fromCbor(cbor);
      final decodedHash = decoded.reconstruct();

      expect(decodedHash, equals(originalHash));
    });
  });

  // ---------------------------------------------------------------------------
  // Group 8: Real-world certificate-like structure
  // ---------------------------------------------------------------------------

  group('ICP/Real-world-like certificate tree', () {
    test('mimics ICP certificate hash tree structure', () {
      // Typical ICP certificate contains:
      // tree := labeled("tree",  fork(...canister state...))
      // sig  := labeled("sig",   leaf(signature))
      // cert := labeled("ic-cert", fork(tree, sig))

      final canisterState = fork(
        labeled('time', leaf('1700000000000000000')),
        fork(
          labeled(
            'canister',
            labeled(
              'aaaaa-aa',
              fork(
                labeled('certified_data', leaf('deadbeef')),
                labeled('module_hash', leaf('cafebabe')),
              ),
            ),
          ),
          labeled('subnet', labeled('subnet-id', leaf('subnet-data'))),
        ),
      );

      final certTree = labeled(
        'ic-cert',
        fork(
          labeled('tree', canisterState),
          labeled('sig', leaf('signature-bytes-here')),
        ),
      );

      // Verify all paths
      expect(
        lookup(['ic-cert', 'tree', 'time'], certTree),
        isA<ICPLookupFound>(),
      );
      expect(
        lookup([
          'ic-cert',
          'tree',
          'canister',
          'aaaaa-aa',
          'certified_data',
        ], certTree),
        isA<ICPLookupFound>(),
      );
      expect(lookup(['ic-cert', 'sig'], certTree), isA<ICPLookupFound>());
      expect(
        lookup(['ic-cert', 'tree', 'nonexistent'], certTree),
        isA<ICPLookupAbsent>(),
      );

      // Hash should be deterministic
      final h1 = certTree.reconstruct();
      final cbor = certTree.toCbor();
      final h2 = ICPHashTree.fromCbor(cbor).reconstruct();
      expect(h1, equals(h2));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(treeTest, "Tree");
}
