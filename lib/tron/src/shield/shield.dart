/// TRON shielded support (Sapling) without zcash_dart.
/// Note crypto lives in `src/` (moved here from `package:blockchain_utils`
/// `protocol/shield` — TRON is its only consumer); proving still uses
/// `SaplingApi` (Groth16 in Rust).
library;

export 'src/consts.dart';
export 'src/types.dart';
export 'src/note_encryption.dart';
export 'src/sapling_note.dart';
export 'src/tron_config.dart';
export 'src/shield_keys.dart';
export 'src/shield_note.dart';
export 'src/shield_merkle.dart';
export 'src/shield_builder.dart';
export 'src/shield_scanner.dart';
export 'src/shield_provider.dart';
export 'src/shield_trc20.dart';
