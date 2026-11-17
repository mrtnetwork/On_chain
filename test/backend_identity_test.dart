import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';

import 'utils.dart';

/// Backend-identity pin: the suite must execute against the backend it
/// claims. A run labeled `BU_BACKEND=ffi|wasm` silently falling back to
/// pure Dart (or vice versa) fails here by name instead of producing
/// backend-mislabeled green results.
void backendIdentityTest() {
  group('Core/Backend Identity', () {
    test('backend identity matches BU_BACKEND', () {
      // Same resolution as the harness: explicit entry config first,
      // then BU_BACKEND, then default (unset/empty/unknown → ffi).
      final requested = OnChainUtilsTestApi.resolvedBackend;
      final native = blockchainUtils.hasNativeBackend;
      expect(
        native,
        requested != BuTestBackend.dart,
        reason:
            requested == BuTestBackend.dart
                ? 'BU_BACKEND resolves to pure Dart, but a native backend is active.'
                : 'BU_BACKEND resolves to $requested, but no native backend is '
                    'active. The suite would silently run on pure Dart.',
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(backendIdentityTest, 'BackendIdentity');
}
