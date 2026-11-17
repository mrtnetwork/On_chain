// /// Builds the Rust backends used by `On_chain` tests (VM only).
// ///
// /// ```sh
// /// dart tool/build_backends.dart --ffi [--profile debug|release]
// /// dart tool/build_backends.dart --wasm [--profile release] [--force]
// /// dart tool/build_backends.dart --all
// /// ```
// /// FFI output: `<crate>/target/<profile>/libblockchain_utils.so` (used via
// /// `BU_LIB_PATH` or auto-resolved). WASM output: `test/wasm_assets/`
// /// (`bu.js` + `bu_bg.wasm`, served to Chrome by `dart test -p chrome`).
// library;

// import 'dart:io' show exit, stdout;

// void _usage() {
//   stdout.writeln('usage: dart tool/build_backends.dart [--ffi] [--wasm] '
//       '[--all] [--profile <debug|release>] [--force]');
// }

// Future<void> main(List<String> args) async {
//   var ffi = false;
//   var wasm = false;
//   var profile = 'debug';
//   var force = false;
//   for (var i = 0; i < args.length; i++) {
//     switch (args[i]) {
//       case '--ffi':
//         ffi = true;
//       case '--wasm':
//         wasm = true;
//       case '--all':
//         ffi = true;
//         wasm = true;
//       case '--force':
//         force = true;
//       case '--profile':
//         if (++i >= args.length) {
//           _usage();
//           exit(2);
//         }
//         profile = args[i];
//         if (profile != 'debug' && profile != 'release') {
//           _usage();
//           exit(2);
//         }
//       default:
//         _usage();
//         exit(2);
//     }
//   }
//   if (!ffi && !wasm) {
//     _usage();
//     exit(2);
//   }
//   if (ffi) {
//     final path = await backend_io.ensureFfiLibrary(
//       profile: profile,
//       buildMissing: true,
//     );
//     stdout.writeln('ffi: $path');
//   }
//   if (wasm) {
//     await backend_io.ensureWasmAssets(
//       profile: profile == 'debug' ? 'debug' : 'release',
//       force: force,
//     );
//     stdout.writeln('wasm: ${backend_io.defaultWasmOutDir()}/bu.js');
//   }
// }
