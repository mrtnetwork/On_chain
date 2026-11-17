/// VM-only backend builders: resolve + cargo-build the FFI library and the
/// WASM assets. Imported through a conditional import; the stub twin throws
/// [UnsupportedError] so browser suites fail loudly instead of silently.
///
/// Never imported directly by browser-compiled files.
///
/// Mirrors `blockchain_utils/test/test_backend_io.dart`. The FFI library is
/// the same `libblockchain_utils` cdylib (shared `BU_*` env); only the
/// default WASM output dir points at this package (`on_chain/test/wasm_assets`).
library;

import 'dart:convert' show utf8;
import 'dart:io'
    show
        Directory,
        File,
        HttpClient,
        HttpStatus,
        Platform,
        Process,
        ProcessException;

/// Absolute path of this package root (cwd when running `dart test`).
String _packageRoot() {
  final cwd = Directory.current;
  if (File('${cwd.path}/pubspec.yaml').existsSync()) return cwd.path;
  var d = File(Platform.script.toFilePath()).parent;
  while (d.parent.path != d.path) {
    if (File('${d.path}/pubspec.yaml').existsSync()) return d.path;
    d = d.parent;
  }
  return cwd.path;
}

/// Rust crate directory: `BU_RUST_CRATE` when set, else a managed checkout
/// under `<package>/build/rust-crate` (see [ensureRustCrate]).
String rustCrateDir() {
  return Platform.environment['BU_RUST_CRATE'] ??
      '${_packageRoot()}/build/rust-crate';
}

/// Official upstream repository of the Rust crate. Last-resort source: when
/// the crate directory is missing and a build was requested, it is
/// downloaded from here (no `git` required) instead of failing.
const kOfficialRustRepo = 'https://github.com/mrtnetwork/blockchain-utils';

/// Tarball of the official repository's default branch, fetched with
/// `dart:io`'s [HttpClient] by [ensureRustCrate].
const kOfficialRustTarball =
    'https://github.com/mrtnetwork/blockchain-utils/archive/refs/heads/main.tar.gz';

/// True when [dir] (default [rustCrateDir]) looks like the Rust checkout
/// (contains `Cargo.toml`).
bool rustCrateExists([String? dir]) {
  final d = dir ?? rustCrateDir();
  return File('$d/Cargo.toml').existsSync();
}

/// Downloads [url] to [outPath] with `dart:io`'s [HttpClient], following
/// redirects. Throws [StateError] on non-200 responses.
Future<void> _downloadFile(String url, String outPath) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    request.followRedirects = true;
    request.maxRedirects = 5;
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw StateError('Download failed: $url (HTTP ${response.statusCode}).');
    }
    final out = File(outPath);
    await out.parent.create(recursive: true);
    final sink = out.openWrite();
    try {
      await response.pipe(sink);
    } finally {
      await sink.close();
    }
  } finally {
    client.close();
  }
}

/// Resolves the Rust crate directory, downloading the official repository
/// tarball into it when the checkout is missing and [cloneIfMissing] is
/// true.
///
/// The download target is the resolved dir (the explicit `BU_RUST_CRATE`
/// path when set, else the `<package>/build/rust-crate` default). Throws
/// [StateError] when the checkout is missing and downloading is disabled,
/// when the target directory exists but is not a crate, or when the
/// download/extraction fails.
Future<String> ensureRustCrate({
  String? dir,
  bool cloneIfMissing = false,
}) async {
  final target = dir ?? rustCrateDir();
  if (!rustCrateExists(target)) {
    if (!cloneIfMissing) {
      final env = Platform.environment['BU_RUST_CRATE'];
      throw StateError(
        'Rust crate not found at $target. '
        '${env == null ? 'Set BU_RUST_CRATE to a blockchain-utils checkout, or ' : ''}'
        're-run with BU_BUILD=ffi to download $kOfficialRustRepo automatically.',
      );
    }
    final d = Directory(target);
    if (d.existsSync() && d.listSync().isNotEmpty) {
      throw StateError(
        'Rust crate directory $target exists but has no Cargo.toml. Remove '
        'it, or set BU_RUST_CRATE to a blockchain-utils checkout, to allow '
        'downloading $kOfficialRustRepo.',
      );
    }
    await d.parent.create(recursive: true);
    if (d.existsSync()) d.deleteSync(recursive: true);
    final archive = File('${d.parent.path}/.blockchain-utils.tar.gz');
    final stage = Directory('${d.parent.path}/.blockchain-utils-extract');
    try {
      await _downloadFile(kOfficialRustTarball, archive.path).timeout(
        const Duration(minutes: 10),
        onTimeout: () {
          throw StateError('Download timed out: $kOfficialRustTarball.');
        },
      );
      if (stage.existsSync()) stage.deleteSync(recursive: true);
      await stage.create(recursive: true);
      await _run('tar', ['-xzf', archive.path, '-C', stage.path]);
      final entries = stage.listSync();
      if (entries.length != 1 || entries.single is! Directory) {
        throw StateError('Unexpected tarball layout in $kOfficialRustTarball.');
      }
      await (entries.single as Directory).rename(target);
    } finally {
      if (archive.existsSync()) archive.deleteSync();
      if (stage.existsSync()) stage.deleteSync(recursive: true);
    }
    if (!rustCrateExists(target)) {
      throw StateError(
        'Download succeeded but $target/Cargo.toml is still missing.',
      );
    }
  }
  _detachWorkspace(target);
  return target;
}

/// Cargo target dir honoring `CARGO_TARGET_DIR`, else `<crate>/target`.
String _cargoTargetDir(String crateDir) {
  return Platform.environment['CARGO_TARGET_DIR'] ?? '$crateDir/target';
}

String _libFileName() {
  if (Platform.isMacOS) return 'libblockchain_utils.dylib';
  if (Platform.isWindows) return 'blockchain_utils.dll';
  return 'libblockchain_utils.so';
}

/// Expected FFI library path for [profile] (`debug` default).
String defaultFfiLibraryPath({String profile = 'debug'}) {
  final crate = rustCrateDir();
  return '${_cargoTargetDir(crate)}/$profile/${_libFileName()}';
}

/// True when [path] points at an existing file (VM only).
bool ffiLibraryExists(String path) => File(path).existsSync();

Future<void> _run(
  String exe,
  List<String> args, {
  String? cwd,
  Map<String, String>? env,
  Duration timeout = const Duration(minutes: 45),
}) async {
  late final Process process;
  try {
    process = await Process.start(
      exe,
      args,
      workingDirectory: cwd,
      environment: env,
    );
  } on ProcessException catch (e) {
    throw StateError('Cannot start `$exe`: $e');
  }
  final out = StringBuffer();
  process.stdout.transform(utf8.decoder).listen(out.write);
  process.stderr.transform(utf8.decoder).listen(out.write);
  final code = await process.exitCode.timeout(
    timeout,
    onTimeout: () {
      process.kill();
      throw StateError('`$exe ${args.join(' ')}` timed out after $timeout.');
    },
  );
  if (code != 0) {
    final tail = out.toString().split('\n').reversed.take(25).toList().reversed;
    throw StateError(
      '`$exe ${args.join(' ')}` failed (exit $code):\n${tail.join('\n')}',
    );
  }
}

/// Feature set for FFI builds: default features plus the opt-in `hw`
/// codecs and circomlib Poseidon over BN254 (`poseidon-bn254`, ~404 KB of
/// tables). Aptos keyless + Sui zkLogin hash through it, so a default-features
/// `.so` fails those tests with `BuError(unsupported ... poseidonBn254Hash)`.
const ffiBuildFeatures = 'hw,poseidon-bn254';

/// Returns the FFI library path, building it with cargo when missing and
/// [buildMissing] is true (downloading the Rust crate from
/// [kOfficialRustRepo] first when the checkout is missing and
/// [cloneIfMissing] is true). [features] overrides [ffiBuildFeatures];
/// [noDefaultFeatures] passes `--no-default-features` (reduced builds still
/// load: optional domains report `unsupported`, core stays mandatory).
/// [force] rebuilds even when the library already exists.
/// Throws [StateError] when missing and no build.
Future<String> ensureFfiLibrary({
  String? explicitPath,
  String profile = 'debug',
  bool buildMissing = false,
  bool cloneIfMissing = true,
  String? features,
  bool noDefaultFeatures = false,
  bool force = false,
}) async {
  final path = explicitPath ?? defaultFfiLibraryPath(profile: profile);
  if (File(path).existsSync() && !force) return path;
  if (!buildMissing) {
    throw StateError(
      'FFI library missing: $path. Re-run with BU_BUILD=ffi (or '
      '`dart tool/build_backends.dart --ffi --profile $profile`). Set '
      'BU_RUST_CRATE to point at a blockchain-utils checkout to build '
      'from elsewhere; with BU_BUILD=ffi the checkout is downloaded from '
      '$kOfficialRustRepo when missing.',
    );
  }
  final crate = await ensureRustCrate(cloneIfMissing: cloneIfMissing);
  await _run('cargo', [
    'build',
    if (profile == 'release') '--release',
    if (noDefaultFeatures) '--no-default-features',
    '--features',
    features ?? ffiBuildFeatures,
    '--manifest-path',
    '$crate/Cargo.toml',
  ], cwd: crate);
  if (!File(path).existsSync()) {
    throw StateError('cargo build succeeded but $path is still missing.');
  }
  return path;
}

/// Appends an empty `[workspace]` table to the crate manifest when it has
/// none, so cargo never treats an ancestor `Cargo.toml` as this build's
/// workspace root. This is exactly what cargo itself suggests
/// (`add [workspace] to the package manifest`) and is a no-op for
/// standalone builds; a manifest that already declares `[workspace...]` is
/// left untouched.
void _detachWorkspace(String crateDir) {
  final manifest = File('$crateDir/Cargo.toml');
  final text = manifest.readAsStringSync();
  if (RegExp(r'^\s*\[workspace(\s|\])', multiLine: true).hasMatch(text)) {
    return;
  }
  manifest.writeAsStringSync(
    '${text.endsWith('\n') ? text : '$text\n'}\n[workspace]\n',
  );
}

/// Directory holding the served WASM assets (`test/wasm_assets` default).
String defaultWasmOutDir() => '${_packageRoot()}/test/wasm_assets';

/// Feature set for a full WASM build: everything the browser suites touch
/// (hash/curve/signing + Groth16 + BN254 Poseidon + Sapling/Orchard/Merkle +
/// Monero + HW codecs + Solana ZK + PQ verifiers). Same set as
/// blockchain_utils_connector. `ffi` is excluded: its native deps don't
/// compile for wasm32.
const wasmBuildFeatures =
    'wasm,std,groth16,poseidon-bn254,zcash-full,monero,hw,solana-zk';

/// Builds the WASM module + wasm-bindgen `--target web` glue into
/// [outDir] (`bu.js`, `bu_bg.wasm`, `.d.ts`). The glue is a real ES module
/// loaded with dynamic `import()` by the connector — no companion files.
/// The Rust crate is downloaded from [kOfficialRustRepo] first when the
/// checkout is missing and [cloneIfMissing] is true.
Future<void> ensureWasmAssets({
  String? outDir,
  String profile = 'release',
  bool force = false,
  bool cloneIfMissing = true,
}) async {
  final out = Directory(outDir ?? defaultWasmOutDir());
  final js = File('${out.path}/bu.js');
  final wasm = File('${out.path}/bu_bg.wasm');
  if (!force && js.existsSync() && wasm.existsSync()) return;
  final crate = await ensureRustCrate(cloneIfMissing: cloneIfMissing);
  await _run(
    'cargo',
    [
      'build',
      '--target',
      'wasm32-unknown-unknown',
      if (profile == 'release') '--release',
      '--no-default-features',
      '--features',
      wasmBuildFeatures,
      '--manifest-path',
      '$crate/Cargo.toml',
    ],
    cwd: crate,
    timeout: const Duration(minutes: 60),
  );
  final artifact =
      '${_cargoTargetDir(crate)}/wasm32-unknown-unknown/$profile/${_wasmArtifactName(crate)}';
  if (!File(artifact).existsSync()) {
    throw StateError('WASM artifact missing after build: $artifact');
  }
  await out.create(recursive: true);
  await _run('wasm-bindgen', [
    '--target',
    'web',
    '--out-dir',
    out.path,
    '--out-name',
    'bu',
    artifact,
  ]);
  if (!js.existsSync() || !wasm.existsSync()) {
    throw StateError('wasm-bindgen did not emit bu.js + bu_bg.wasm.');
  }
}

/// Resolves the cdylib artifact name from the crate manifest: `[lib] name`
/// when set, else the package name with `-` → `_` (cargo convention).
String _wasmArtifactName(String crateDir) {
  try {
    final manifest = File('$crateDir/Cargo.toml').readAsStringSync();
    final libSection = manifest
        .split(RegExp(r'^\[', multiLine: true))
        .firstWhere((s) => s.startsWith('lib]'), orElse: () => '');
    final libName = RegExp(
      r'^\s*name\s*=\s*"([^"]+)"',
      multiLine: true,
    ).firstMatch(libSection);
    if (libName != null) return '${libName.group(1)}.wasm';
    final pkgName = RegExp(
      r'^\s*name\s*=\s*"([^"]+)"',
      multiLine: true,
    ).firstMatch(manifest);
    if (pkgName != null) {
      return '${pkgName.group(1)!.replaceAll('-', '_')}.wasm';
    }
  } catch (_) {}
  return 'blockchain_utils.wasm';
}
