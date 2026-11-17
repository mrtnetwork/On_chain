/// Shared test harness for `on_chain` suites.
///
/// Mirrors `blockchain_utils/test/utils.dart` (same structs): every
/// `*_test.dart` under `test/` is rewritten by `transform_tests.py` so its
/// `main()` body runs through [OnChainUtilsTestApi.runTest], which selects
/// the crypto backend first. The generated `test/one_shot_suite.dart`
/// aggregates all of them into one VM/browser run.
///
/// Backend selection is shared with `blockchain_utils` (`BU_BACKEND`,
/// `BU_LIB_PATH`, `BU_BUILD`, ... — see `test_backend.dart`):
/// ```sh
/// BU_BACKEND=dart dart test test/sui/system_kinds_test.dart
/// BU_BACKEND=ffi BU_LIB_PATH=/path/to/libblockchain_utils.so dart test test/
/// BU_BACKEND=ffi BU_BUILD=ffi dart test test/   # cargo-build .so if missing
/// ```
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils_connector/blockchain_utils_connector.dart';
import 'package:test/test.dart';

import 'test_backend.dart';
export 'test_backend.dart';
import 'test_backend_stub.dart'
    if (dart.library.io) 'test_backend_io.dart'
    as backend_io;

/// Central workload knobs for all suites (vector counts, fuzz iterations).
///
/// Resolution per knob: explicit [TestThrottle.configure] (browser entries) →
/// `BU_TAKE` / `BU_FUZZ_ITERS` env (VM) → file default (`null` = full).
/// Browser-safe (no `dart:io`).
class TestThrottle {
  static int? _explicitTake;
  static int? _explicitFuzz;
  static int? _explicitGen;
  static int? _envTake;
  static int? _envFuzz;
  static int? _envGen;
  static bool _resolved = false;

  /// Pins explicit values (browser entries; overrides env).
  static void configure({
    int? vectorTake,
    int? fuzzIterations,
    int? generatorTotal,
  }) {
    _explicitTake = vectorTake;
    _explicitFuzz = fuzzIterations;
    _explicitGen = generatorTotal;
  }

  static void _ensureResolved() {
    if (_resolved) return;
    _resolved = true;
    _envTake ??= testEnvInt('BU_TAKE');
    _envFuzz ??= testEnvInt('BU_FUZZ_ITERS');
    _envGen ??= testEnvInt('BU_GEN_TOTAL');
  }

  /// Max vectors per `shuffleTake()` site. `null` = all vectors.
  static int? get vectorTake {
    _ensureResolved();
    return _explicitTake ?? _envTake;
  }

  /// Fuzz-loop iterations. `null` = file default.
  static int? get fuzzIterations {
    _ensureResolved();
    return _explicitFuzz ?? _envFuzz;
  }

  /// Random scalar/point count for generator harnesses.
  /// [fallback] is the file default (4); explicit/env override wins.
  static int generatorTotal([int fallback = 4]) {
    _ensureResolved();
    return _explicitGen ?? _envGen ?? fallback;
  }
}

const int iteration = int.fromEnvironment("ITER", defaultValue: 0);
const bool native = bool.fromEnvironment('dart.library.io');

extension ExtHEX on List<int> {
  String toHex() => BytesUtils.toHexString(this);
}

extension TAKE on List<Map<String, dynamic>> {
  /// Takes up to [total] vectors (explicit arg wins; otherwise the
  /// [TestThrottle.vectorTake] knob; `null` = all, preserving old behavior).
  List<Map<String, dynamic>> shuffleTake([int? total]) {
    final t = total ?? TestThrottle.vectorTake;
    if (t == null) return this;
    return take(t).toList();
  }
}

final Matcher buErrorOrCryptoException = throwsA(isA<BuError>());
final Matcher throwsArgumentException = throwsA(isA<BuError>());

enum TestApi {
  native,
  dart;

  bool get isNative => false;
}

typedef CbRunTest = void Function();
typedef CbRunTestApi = void Function(BlockchainUtilsApi api);

/// Shared backend bootstrap for `on_chain` tests.
///
/// Browser-safe: this file imports neither `dart:io` nor `dart:html`.
/// Selection order: explicit [configure] → environment (VM only) → default.
///
/// Every rewritten `*_test.dart` calls [runTest] from its `main()`, so the
/// backend is selected before any test body runs. `on_chain` has no backend
/// of its own — init goes through the shared [blockchainUtils] singleton.
///
/// VM examples:
/// ```sh
/// BU_BACKEND=dart dart test test/one_shot_test.dart
/// BU_BACKEND=ffi BU_LIB_PATH=/path/to/libblockchain_utils.so dart test test/
/// BU_BACKEND=ffi BU_BUILD=ffi dart test test/   # cargo-build .so if missing
/// ```
/// Browser (see `test/browser_wasm_test.dart`):
/// ```sh
/// CHROME_EXECUTABLE=/tmp/chrome-nosandbox.sh dart test -p chrome test/browser_wasm_test.dart
/// ```
/// with WASM assets in `test/wasm_assets/` (copied from
/// `blockchain_utils/test/wasm_assets/` after building them there).
class OnChainUtilsTestApi {
  static bool _inited = false;
  static BuTestConfig? _explicit;

  /// Pins an explicit backend config (overrides environment). A test `main()`
  /// may `await ensureBackend()` after this for cargo builds.
  static void configure(BuTestConfig config) {
    _explicit = config;
    TestThrottle.configure(
      vectorTake: config.vectorTake,
      fuzzIterations: config.fuzzIterations,
      generatorTotal: config.generatorTotal,
    );
    _inited = false;
  }

  static BuTestConfig _resolve([BuTestConfig? override]) {
    return override ?? _explicit ?? BuTestConfig.fromEnv();
  }

  /// Backend the harness resolved for this run (explicit entry config →
  /// `BU_BACKEND` → default). The backend-identity test reads this instead
  /// of the raw env var, because suite entries pin the backend explicitly
  /// (e.g. the browser-dart entry forces pure Dart while `BU_BACKEND`
  /// is unset, which parses as `ffi`).
  static BuTestBackend get resolvedBackend => _resolve().backend;

  /// Resolves + applies the backend, building the FFI library with cargo
  /// first when missing and `BU_BUILD=ffi|all|1` (VM only). Call once from an
  /// async `main()` before registering tests to allow builds:
  /// ```dart
  /// void main() async {
  ///   await OnChainUtilsTestApi.ensureBackend();
  ///   ...register tests...
  /// }
  /// ```
  /// Throws [StateError] when the resolved backend did not actually
  /// activate (e.g. an `ffi` run silently falling back to pure Dart).
  /// Every entry point funnels through here so a misconfigured backend
  /// fails loudly instead of producing backend-mislabeled results.
  static void _assertBackendActive(BuTestBackend backend) {
    final native = blockchainUtils.hasNativeBackend;
    if (backend == BuTestBackend.dart && native) {
      throw StateError(
        'BU_BACKEND=dart selected but a native backend is active. '
        'Refusing to run Dart-backend tests against Rust.',
      );
    }
    if (backend != BuTestBackend.dart && !native) {
      throw StateError(
        'BU_BACKEND=$backend selected but no native backend is active '
        '(hasNativeBackend == false). Refusing to run Rust-backend tests '
        'on the pure-Dart backend.',
      );
    }
  }

  static Future<void> ensureBackend([BuTestConfig? config]) async {
    if (_inited) return;
    final c = _resolve(config);
    if (c.backend == BuTestBackend.wasm) {
      throw UnsupportedError(
        'wasm backend needs a browser: run '
        '`dart test -p chrome test/browser_wasm_test.dart` '
        '(or call OnChainUtilsTestApi.initWasmBrowser on web).',
      );
    }
    if (c.backend == BuTestBackend.ffi) {
      final path = await backend_io.ensureFfiLibrary(
        explicitPath: c.ffiLibraryPath,
        profile: c.ffiProfile,
        buildMissing: c.buildMissing,
        features: c.ffiFeatures,
        noDefaultFeatures: c.ffiNoDefaultFeatures,
      );
      c.applyTo(blockchainUtils, resolvedFfiPath: path);
    } else {
      c.applyTo(blockchainUtils);
    }
    _assertBackendActive(c.backend);
    _inited = true;
  }

  /// Browser entry point: loads the WASM glue/module from [config] (defaults
  /// `wasm_assets/bu.js` + auto-located `bu_bg.wasm`, served by `dart test`
  /// from `test/wasm_assets/`) and selects the Rust backend. Web only.
  static Future<void> initWasmBrowser([BuTestConfig? config]) async {
    final c = _resolve(config);
    final buConfig = BuConfig(
      wasmGlueUrl: c.wasmGlueUrl,
      wasmModuleUrl: c.wasmModuleUrl,
    );
    await Bu.ensureWasmLoaded(buConfig);
    blockchainUtils.setRustApi(
      wasmGlueUrl: c.wasmGlueUrl,
      wasmModuleUrl: c.wasmModuleUrl,
    );
    _assertBackendActive(BuTestBackend.wasm);
    _inited = true;
  }

  static void _init() {
    if (_inited) return;
    final c = _resolve();
    if (c.backend == BuTestBackend.ffi) {
      // Fast sync path: no cargo involved (use ensureBackend()/BU_BUILD=ffi
      // to build when missing).
      String? path = c.ffiLibraryPath;
      try {
        path ??= backend_io.defaultFfiLibraryPath(profile: c.ffiProfile);
        if (!backend_io.ffiLibraryExists(path)) {
          if (c.buildMissing) {
            throw StateError(
              'FFI library missing: $path. Call '
              '`await OnChainUtilsTestApi.ensureBackend()` from an async '
              'main() (or set BU_LIB_PATH to an existing library) to '
              'build it with cargo first.',
            );
          }
          path = null; // fall back to platform default lookup
        }
      } on UnsupportedError {
        path = c.ffiLibraryPath;
      }
      c.applyTo(blockchainUtils, resolvedFfiPath: path);
    } else {
      c.applyTo(blockchainUtils);
    }
    _assertBackendActive(c.backend);
    _inited = true;
  }

  static void runTest(CbRunTest fn, String name, {CbRunTestApi? onNative}) {
    _init();
    fn();
    if (onNative != null) onNative(blockchainUtils.api);
  }
}
