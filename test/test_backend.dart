/// Backend selection + configuration for `on_chain` tests.
///
/// Mirrors `blockchain_utils/test/test_backend.dart` (same structs, same
/// `BU_*` environment variables so one env controls both suites).
///
/// Browser-safe: this file imports neither `dart:io` nor `dart:html`
/// (environment access goes through the conditional `test_backend_env_*`
/// pair; WASM loading through `Bu.ensureWasmLoaded`, which is a no-op import
/// on the VM). VM-only helpers (cargo builds) live in `test_backend_io.dart`.
///
/// Resolution order for every field: explicit [BuTestConfig] value →
/// environment variable (VM only) → built-in default.
///
/// Environment (VM):
/// - `BU_BACKEND=dart|ffi|wasm` (`rust`/`native` are aliases of `ffi`;
///   `web`/`browser`/`chrome` are aliases of `wasm`). Default `ffi`.
/// - `BU_LIB_PATH` — FFI `.so`/`.dylib`/`.dll` path. Default: auto-resolved
///   to `<rust-crate>/target/<profile>/libblockchain_utils.so` relative to
///   this package (`..` + `blockchain-utils`), honoring `BU_FFI_PROFILE`
///   (`debug`, default) and `CARGO_TARGET_DIR`. Override the crate dir with
///   `BU_RUST_CRATE`.
/// - `BU_BUILD=1|ffi|wasm|all` — build the backend with cargo when the
///   artifact is missing (VM only; same as calling `tool/build_backends.dart`).
/// - `BU_FFI_FEATURES` — cargo features for FFI builds (default `hw` +
///   `poseidon-bn254` for Aptos keyless / Sui zkLogin, combined with the
///   crate defaults).
/// - `BU_FFI_NO_DEFAULT_FEATURES=1` — pass `--no-default-features` to the
///   FFI cargo build.
/// - `BU_WASM_GLUE_URL` — glue script URL (default `wasm_assets/bu.js`,
///   served from `on_chain/test/wasm_assets/`, built via
///   `dart tool/build_backends.dart --wasm`).
/// - `BU_WASM_MODULE_URL` — `.wasm` module URL (default: auto-located next
///   to the glue script).
library;

import 'package:blockchain_utils/api/api/api.dart';

import 'test_backend_env_stub.dart'
    if (dart.library.io) 'test_backend_env_vm.dart'
    as test_env;

/// Reads a raw env var (VM `Platform.environment`) / define default.
/// Browser-safe: stub returns the define default (`null` unless passed).
String? testEnvVar(String name, {String? defineDefault}) {
  return test_env.testEnvVar(name, defineDefault: defineDefault);
}

/// Reads an int-valued env var (VM) / define default. `null` when unset.
int? testEnvInt(String name, {String? defineDefault}) {
  final raw = test_env.testEnvVar(name, defineDefault: defineDefault);
  return raw == null ? null : int.tryParse(raw.trim());
}

/// Selectable test backend.
enum BuTestBackend {
  /// Pure-Dart backend (`setDartApi`). No native library, no WASM.
  dart,

  /// Rust backend over FFI (`setRustApi(libraryPath:)`). VM only.
  ffi,

  /// Rust backend over WASM (`setRustApi` + glue/module URLs). Browser only.
  wasm;

  /// Parses `BU_BACKEND` values; unknown/empty → [ffi].
  static BuTestBackend parse(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'dart':
        return BuTestBackend.dart;
      case 'wasm':
      case 'web':
      case 'browser':
      case 'chrome':
        return BuTestBackend.wasm;
      case 'ffi':
      case 'rust':
      case 'native':
      case null:
      case '':
        return BuTestBackend.ffi;
      default:
        return BuTestBackend.ffi;
    }
  }
}

/// Backend configuration. Construct explicitly or via [BuTestConfig.fromEnv].
class BuTestConfig {
  const BuTestConfig({
    this.backend = BuTestBackend.ffi,
    this.ffiLibraryPath,
    this.ffiProfile = 'debug',
    this.buildMissing = false,
    this.ffiFeatures = 'hw,poseidon-bn254',
    this.ffiNoDefaultFeatures = false,
    this.wasmGlueUrl = 'wasm_assets/bu.js',
    this.wasmModuleUrl,
    this.vectorTake,
    this.fuzzIterations,
    this.generatorTotal,
  });

  /// Explicit config; resolution order per field: argument → env → default.
  factory BuTestConfig.fromEnv({
    BuTestBackend? backend,
    String? ffiLibraryPath,
    String? ffiProfile,
    bool? buildMissing,
    String? ffiFeatures,
    bool? ffiNoDefaultFeatures,
    String? wasmGlueUrl,
    String? wasmModuleUrl,
    int? vectorTake,
    int? fuzzIterations,
    int? generatorTotal,
  }) {
    final build = test_env.testEnvVar('BU_BUILD');
    return BuTestConfig(
      backend:
          backend ?? BuTestBackend.parse(test_env.testEnvVar('BU_BACKEND')),
      ffiLibraryPath: ffiLibraryPath ?? test_env.testEnvVar('BU_LIB_PATH'),
      ffiProfile:
          ffiProfile ?? test_env.testEnvVar('BU_FFI_PROFILE') ?? 'debug',
      buildMissing:
          buildMissing ??
          (build == '1' ||
              (build ?? '')
                  .split(',')
                  .any((p) => p.trim() == 'ffi' || p.trim() == 'all')),
      ffiFeatures:
          ffiFeatures ??
          test_env.testEnvVar('BU_FFI_FEATURES') ??
          'hw,poseidon-bn254',
      ffiNoDefaultFeatures:
          ffiNoDefaultFeatures ??
          (test_env.testEnvVar('BU_FFI_NO_DEFAULT_FEATURES') == '1'),
      wasmGlueUrl:
          wasmGlueUrl ??
          test_env.testEnvVar('BU_WASM_GLUE_URL') ??
          'wasm_assets/bu.js',
      wasmModuleUrl: wasmModuleUrl ?? test_env.testEnvVar('BU_WASM_MODULE_URL'),
      vectorTake: vectorTake ?? testEnvInt('BU_TAKE'),
      fuzzIterations: fuzzIterations ?? testEnvInt('BU_FUZZ_ITERS'),
      generatorTotal: generatorTotal ?? testEnvInt('BU_GEN_TOTAL'),
    );
  }

  /// Active backend.
  final BuTestBackend backend;

  /// FFI library path (`null` = auto-resolve, VM only).
  ///
  /// Optional workload knobs (all `null` = file defaults = full vectors).
  /// Browser entries pass small values explicitly; VM entries read
  /// `BU_TAKE` / `BU_FUZZ_ITERS`:
  final String? ffiLibraryPath;

  /// Max vectors per `shuffleTake()` site. `null` = all vectors.
  final int? vectorTake;

  /// Fuzz-loop iterations. `null` = file default.
  final int? fuzzIterations;

  /// Random scalar/point count for generator harnesses.
  /// `null` = file default (4).
  final int? generatorTotal;

  /// Cargo profile used to resolve/build the FFI library (`debug` default).
  final String ffiProfile;

  /// Build the backend with cargo when the artifact is missing (VM only).
  final bool buildMissing;

  /// Cargo features for FFI builds (`hw` + `poseidon-bn254` default; combined
  /// with the crate defaults unless [ffiNoDefaultFeatures]).
  final String ffiFeatures;

  /// Pass `--no-default-features` to the FFI cargo build (VM only).
  final bool ffiNoDefaultFeatures;

  /// wasm-bindgen glue script URL (browser only).
  final String wasmGlueUrl;

  /// `.wasm` module URL; `null` auto-locates next to the glue (browser only).
  final String? wasmModuleUrl;

  /// Whether `BU_BUILD` also requests a WASM rebuild (VM only).
  bool get buildWasm {
    final build = test_env.testEnvVar('BU_BUILD');
    if (build == null) return buildMissing;
    final parts = build.split(',').map((p) => p.trim()).toSet();
    return parts.contains('1') ||
        parts.contains('all') ||
        parts.contains('wasm');
  }

  /// Applies the non-WASM part of this config: `dart` → [BlockchainUtils.setDartApi],
  /// `ffi` → [BlockchainUtils.setRustApi] with [ffiLibraryPath].
  /// `wasm` on the VM throws [UnsupportedError] (run the browser suite).
  void applyTo(BlockchainUtils apiOwner, {String? resolvedFfiPath}) {
    switch (backend) {
      case BuTestBackend.dart:
        apiOwner.setDartApi();
      case BuTestBackend.ffi:
        apiOwner.setRustApi(libraryPath: resolvedFfiPath ?? ffiLibraryPath);
      case BuTestBackend.wasm:
        throw UnsupportedError(
          'wasm backend needs a browser: run '
          '`dart test -p chrome test/browser_wasm_test.dart` '
          '(or call OnChainUtilsTestApi.initWasmBrowser on web).',
        );
    }
  }
}
