// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `canister_id`.
typedef ICCanisterId = IcpPrincipalAddress;

/// Candid type alias `wasm_module`.
typedef ICWasmModule = List<int>;

/// Candid type alias `snapshot_id`.
typedef ICSnapshotId = List<int>;

/// Candid type alias `satoshi`.
typedef ICSatoshi = BigInt;

/// Candid type alias `bitcoin_address`.
typedef ICBitcoinAddress = String;

/// Candid type alias `bitcoin_block_hash`.
typedef ICBitcoinBlockHash = List<int>;

/// Candid type alias `bitcoin_block_header`.
typedef ICBitcoinBlockHeader = List<int>;

/// Candid type alias `millisatoshi_per_byte`.
typedef ICMillisatoshiPerByte = BigInt;

/// Candid type alias `bitcoin_block_height`.
typedef ICBitcoinBlockHeight = int;

/// Candid type alias `bitcoin_get_balance_result`.
typedef ICBitcoinGetBalanceResult = ICSatoshi;

/// Candid type alias `bitcoin_get_current_fee_percentiles_result`.
typedef ICBitcoinGetCurrentFeePercentilesResult = List<ICMillisatoshiPerByte>;

/// CType for alias `bitcoin_get_current_fee_percentiles_result`.
abstract final class ICBitcoinGetCurrentFeePercentilesResultCandid {
  static CType get ctype => CType.vec(CType.nat64);
}

/// Candid type alias `node_metrics_history_result`.
typedef ICNodeMetricsHistoryResult = List<ICNodeMetricsHistoryResultItem>;

/// CType for alias `node_metrics_history_result`.
abstract final class ICNodeMetricsHistoryResultCandid {
  static CType get ctype => CType.vec(ICNodeMetricsHistoryResultItem.ctype);
}

/// Candid type alias `raw_rand_result`.
typedef ICRawRandResult = List<int>;

/// Candid type alias `stored_chunks_result`.
typedef ICStoredChunksResult = List<ICChunkHash>;

/// CType for alias `stored_chunks_result`.
abstract final class ICStoredChunksResultCandid {
  static CType get ctype => CType.vec(ICChunkHash.ctype);
}

/// Candid type alias `upload_chunk_result`.
typedef ICUploadChunkResult = ICChunkHash;

/// CType for alias `upload_chunk_result`.
abstract final class ICUploadChunkResultCandid {
  static CType get ctype => ICChunkHash.ctype;
}

/// Candid type alias `take_canister_snapshot_result`.
typedef ICTakeCanisterSnapshotResult = ICSnapshot;

/// CType for alias `take_canister_snapshot_result`.
abstract final class ICTakeCanisterSnapshotResultCandid {
  static CType get ctype => ICSnapshot.ctype;
}

/// Candid type alias `list_canister_snapshots_result`.
typedef ICListCanisterSnapshotsResult = List<ICSnapshot>;

/// CType for alias `list_canister_snapshots_result`.
abstract final class ICListCanisterSnapshotsResultCandid {
  static CType get ctype => CType.vec(ICSnapshot.ctype);
}

/// Candid variant `ICChangeDetailsCodeDeployment.mode`.
sealed class ICChangeDetailsCodeDeploymentMode with CandidSerializable {
  const ICChangeDetailsCodeDeploymentMode();

  static CType get ctype => CType.variant([
    Field(Label.named('install'), CType.null_),
    Field(Label.named('reinstall'), CType.null_),
    Field(Label.named('upgrade'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICChangeDetailsCodeDeploymentMode.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('install')) {
      return const ICChangeDetailsCodeDeploymentModeInstall();
    }
    if (json.containsKey('reinstall')) {
      return const ICChangeDetailsCodeDeploymentModeReinstall();
    }
    if (json.containsKey('upgrade')) {
      return const ICChangeDetailsCodeDeploymentModeUpgrade();
    }
    throw OnChainErrors.icpCandid(
      'ICChangeDetailsCodeDeploymentMode.fromCandid',
      reason: 'Unknown ICChangeDetailsCodeDeploymentMode arm',
    );
  }

  factory ICChangeDetailsCodeDeploymentMode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChangeDetailsCodeDeploymentMode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICChangeDetailsCodeDeployment.mode.install` (nullary).
final class ICChangeDetailsCodeDeploymentModeInstall
    extends ICChangeDetailsCodeDeploymentMode {
  const ICChangeDetailsCodeDeploymentModeInstall();

  @override
  CType get candidType => ICChangeDetailsCodeDeploymentMode.ctype;

  @override
  dynamic get candidValue => const Variant('install', null);

  @override
  Map<String, dynamic> toJson() => {'install': null};
}

/// Variant arm `ICChangeDetailsCodeDeployment.mode.reinstall` (nullary).
final class ICChangeDetailsCodeDeploymentModeReinstall
    extends ICChangeDetailsCodeDeploymentMode {
  const ICChangeDetailsCodeDeploymentModeReinstall();

  @override
  CType get candidType => ICChangeDetailsCodeDeploymentMode.ctype;

  @override
  dynamic get candidValue => const Variant('reinstall', null);

  @override
  Map<String, dynamic> toJson() => {'reinstall': null};
}

/// Variant arm `ICChangeDetailsCodeDeployment.mode.upgrade` (nullary).
final class ICChangeDetailsCodeDeploymentModeUpgrade
    extends ICChangeDetailsCodeDeploymentMode {
  const ICChangeDetailsCodeDeploymentModeUpgrade();

  @override
  CType get candidType => ICChangeDetailsCodeDeploymentMode.ctype;

  @override
  dynamic get candidValue => const Variant('upgrade', null);

  @override
  Map<String, dynamic> toJson() => {'upgrade': null};
}

/// Candid variant `ICChangeDetailsLoadSnapshot.source`.
sealed class ICChangeDetailsLoadSnapshotSource with CandidSerializable {
  const ICChangeDetailsLoadSnapshotSource();

  static CType get ctype => CType.variant([
    Field(Label.named('taken_from_canister'), CType.reserved),
    Field(Label.named('metadata_upload'), CType.reserved),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICChangeDetailsLoadSnapshotSource.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('taken_from_canister')) {
      return const ICChangeDetailsLoadSnapshotSourceTakenFromCanister();
    }
    if (json.containsKey('metadata_upload')) {
      return const ICChangeDetailsLoadSnapshotSourceMetadataUpload();
    }
    throw OnChainErrors.icpCandid(
      'ICChangeDetailsLoadSnapshotSource.fromCandid',
      reason: 'Unknown ICChangeDetailsLoadSnapshotSource arm',
    );
  }

  factory ICChangeDetailsLoadSnapshotSource.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChangeDetailsLoadSnapshotSource.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICChangeDetailsLoadSnapshot.source.taken_from_canister` (nullary).
final class ICChangeDetailsLoadSnapshotSourceTakenFromCanister
    extends ICChangeDetailsLoadSnapshotSource {
  const ICChangeDetailsLoadSnapshotSourceTakenFromCanister();

  @override
  CType get candidType => ICChangeDetailsLoadSnapshotSource.ctype;

  @override
  dynamic get candidValue => const Variant('taken_from_canister', null);

  @override
  Map<String, dynamic> toJson() => {'taken_from_canister': null};
}

/// Variant arm `ICChangeDetailsLoadSnapshot.source.metadata_upload` (nullary).
final class ICChangeDetailsLoadSnapshotSourceMetadataUpload
    extends ICChangeDetailsLoadSnapshotSource {
  const ICChangeDetailsLoadSnapshotSourceMetadataUpload();

  @override
  CType get candidType => ICChangeDetailsLoadSnapshotSource.ctype;

  @override
  dynamic get candidValue => const Variant('metadata_upload', null);

  @override
  Map<String, dynamic> toJson() => {'metadata_upload': null};
}

/// Candid record `ICChangeDetailsRenameCanister.rename_to`.
final class ICChangeDetailsRenameCanisterRenameTo with CandidSerializable {
  final IcpPrincipalAddress canisterId;
  final BigInt version;
  final BigInt totalNumChanges;

  const ICChangeDetailsRenameCanisterRenameTo({
    required this.canisterId,
    required this.version,
    required this.totalNumChanges,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('version'), CType.nat64),
    Field(Label.named('total_num_changes'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'version': version,
    'total_num_changes': totalNumChanges,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'version': version,
    'total_num_changes': totalNumChanges,
  };

  factory ICChangeDetailsRenameCanisterRenameTo.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICChangeDetailsRenameCanisterRenameTo(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      version: json.valueAsBigInt<BigInt>('version'),
      totalNumChanges: json.valueAsBigInt<BigInt>('total_num_changes'),
    );
  }

  factory ICChangeDetailsRenameCanisterRenameTo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChangeDetailsRenameCanisterRenameTo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICBitcoinGetUtxosArgs.filter`.
sealed class ICBitcoinGetUtxosArgsFilter with CandidSerializable {
  const ICBitcoinGetUtxosArgsFilter();

  static CType get ctype => CType.variant([
    Field(Label.named('min_confirmations'), CType.nat32),
    Field(Label.named('page'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICBitcoinGetUtxosArgsFilter.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('min_confirmations')) {
      return ICBitcoinGetUtxosArgsFilterMinConfirmations(
        json.valueAsInt<int>('min_confirmations'),
      );
    }
    if (json.containsKey('page')) {
      return ICBitcoinGetUtxosArgsFilterPage(
        json.valueAsBytes<List<int>>('page', encoding: StringEncoding.base64),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICBitcoinGetUtxosArgsFilter.fromCandid',
      reason: 'Unknown ICBitcoinGetUtxosArgsFilter arm',
    );
  }

  factory ICBitcoinGetUtxosArgsFilter.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetUtxosArgsFilter.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICBitcoinGetUtxosArgs.filter.min_confirmations`.
final class ICBitcoinGetUtxosArgsFilterMinConfirmations
    extends ICBitcoinGetUtxosArgsFilter {
  final int value;
  const ICBitcoinGetUtxosArgsFilterMinConfirmations(this.value);

  @override
  CType get candidType => ICBitcoinGetUtxosArgsFilter.ctype;

  @override
  dynamic get candidValue => Variant('min_confirmations', value);

  @override
  Map<String, dynamic> toJson() => {'min_confirmations': value};
}

/// Variant arm `ICBitcoinGetUtxosArgs.filter.page`.
final class ICBitcoinGetUtxosArgsFilterPage
    extends ICBitcoinGetUtxosArgsFilter {
  final List<int> value;
  const ICBitcoinGetUtxosArgsFilterPage(this.value);

  @override
  CType get candidType => ICBitcoinGetUtxosArgsFilter.ctype;

  @override
  dynamic get candidValue => Variant('page', value);

  @override
  Map<String, dynamic> toJson() => {'page': value};
}

/// Candid record `ICCanisterInstallMode.upgrade`.
final class ICCanisterInstallModeUpgradePayload with CandidSerializable {
  final bool? skipPreUpgrade;
  final ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence?
  wasmMemoryPersistence;

  const ICCanisterInstallModeUpgradePayload({
    this.skipPreUpgrade,
    this.wasmMemoryPersistence,
  });

  static CType get ctype => CType.record([
    Field(Label.named('skip_pre_upgrade'), CType.opt(CType.bool_)),
    LazyField(
      Label.named('wasm_memory_persistence'),
      () => CType.opt(
        ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'skip_pre_upgrade': skipPreUpgrade,
    'wasm_memory_persistence': wasmMemoryPersistence?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'skip_pre_upgrade': skipPreUpgrade,
    'wasm_memory_persistence': wasmMemoryPersistence?.toJson(),
  };

  factory ICCanisterInstallModeUpgradePayload.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICCanisterInstallModeUpgradePayload(
      skipPreUpgrade: json.valueAsBool<bool?>('skip_pre_upgrade'),
      wasmMemoryPersistence: json.valueTo<
        ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence?,
        Map
      >(
        key: 'wasm_memory_persistence',
        parse:
            (e) =>
                ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
    );
  }

  factory ICCanisterInstallModeUpgradePayload.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterInstallModeUpgradePayload.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICCanisterInstallModeUpgradePayload.wasm_memory_persistence`.
sealed class ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence
    with CandidSerializable {
  const ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence();

  static CType get ctype => CType.variant([
    Field(Label.named('keep'), CType.null_),
    Field(Label.named('replace'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('keep')) {
      return const ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceKeep();
    }
    if (json.containsKey('replace')) {
      return const ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceReplace();
    }
    throw OnChainErrors.icpCandid(
      'ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.fromCandid',
      reason:
          'Unknown ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence arm',
    );
  }

  factory ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICCanisterInstallModeUpgradePayload.wasm_memory_persistence.keep` (nullary).
final class ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceKeep
    extends ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence {
  const ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceKeep();

  @override
  CType get candidType =>
      ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.ctype;

  @override
  dynamic get candidValue => const Variant('keep', null);

  @override
  Map<String, dynamic> toJson() => {'keep': null};
}

/// Variant arm `ICCanisterInstallModeUpgradePayload.wasm_memory_persistence.replace` (nullary).
final class ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceReplace
    extends ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence {
  const ICCanisterInstallModeUpgradePayloadWasmMemoryPersistenceReplace();

  @override
  CType get candidType =>
      ICCanisterInstallModeUpgradePayloadWasmMemoryPersistence.ctype;

  @override
  dynamic get candidValue => const Variant('replace', null);

  @override
  Map<String, dynamic> toJson() => {'replace': null};
}

/// Candid variant `ICCanisterStatusResult.status`.
sealed class ICCanisterStatusResultStatus with CandidSerializable {
  const ICCanisterStatusResultStatus();

  static CType get ctype => CType.variant([
    Field(Label.named('running'), CType.null_),
    Field(Label.named('stopping'), CType.null_),
    Field(Label.named('stopped'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICCanisterStatusResultStatus.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('running')) {
      return const ICCanisterStatusResultStatusRunning();
    }
    if (json.containsKey('stopping')) {
      return const ICCanisterStatusResultStatusStopping();
    }
    if (json.containsKey('stopped')) {
      return const ICCanisterStatusResultStatusStopped();
    }
    throw OnChainErrors.icpCandid(
      'ICCanisterStatusResultStatus.fromCandid',
      reason: 'Unknown ICCanisterStatusResultStatus arm',
    );
  }

  factory ICCanisterStatusResultStatus.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterStatusResultStatus.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICCanisterStatusResult.status.running` (nullary).
final class ICCanisterStatusResultStatusRunning
    extends ICCanisterStatusResultStatus {
  const ICCanisterStatusResultStatusRunning();

  @override
  CType get candidType => ICCanisterStatusResultStatus.ctype;

  @override
  dynamic get candidValue => const Variant('running', null);

  @override
  Map<String, dynamic> toJson() => {'running': null};
}

/// Variant arm `ICCanisterStatusResult.status.stopping` (nullary).
final class ICCanisterStatusResultStatusStopping
    extends ICCanisterStatusResultStatus {
  const ICCanisterStatusResultStatusStopping();

  @override
  CType get candidType => ICCanisterStatusResultStatus.ctype;

  @override
  dynamic get candidValue => const Variant('stopping', null);

  @override
  Map<String, dynamic> toJson() => {'stopping': null};
}

/// Variant arm `ICCanisterStatusResult.status.stopped` (nullary).
final class ICCanisterStatusResultStatusStopped
    extends ICCanisterStatusResultStatus {
  const ICCanisterStatusResultStatusStopped();

  @override
  CType get candidType => ICCanisterStatusResultStatus.ctype;

  @override
  dynamic get candidValue => const Variant('stopped', null);

  @override
  Map<String, dynamic> toJson() => {'stopped': null};
}

/// Candid record `ICCanisterStatusResult.memory_metrics`.
final class ICCanisterStatusResultMemoryMetrics with CandidSerializable {
  final BigInt wasmMemorySize;
  final BigInt stableMemorySize;
  final BigInt globalMemorySize;
  final BigInt wasmBinarySize;
  final BigInt customSectionsSize;
  final BigInt canisterHistorySize;
  final BigInt wasmChunkStoreSize;
  final BigInt snapshotsSize;
  final BigInt logMemoryStoreSize;

  const ICCanisterStatusResultMemoryMetrics({
    required this.wasmMemorySize,
    required this.stableMemorySize,
    required this.globalMemorySize,
    required this.wasmBinarySize,
    required this.customSectionsSize,
    required this.canisterHistorySize,
    required this.wasmChunkStoreSize,
    required this.snapshotsSize,
    required this.logMemoryStoreSize,
  });

  static CType get ctype => CType.record([
    Field(Label.named('wasm_memory_size'), CType.nat),
    Field(Label.named('stable_memory_size'), CType.nat),
    Field(Label.named('global_memory_size'), CType.nat),
    Field(Label.named('wasm_binary_size'), CType.nat),
    Field(Label.named('custom_sections_size'), CType.nat),
    Field(Label.named('canister_history_size'), CType.nat),
    Field(Label.named('wasm_chunk_store_size'), CType.nat),
    Field(Label.named('snapshots_size'), CType.nat),
    Field(Label.named('log_memory_store_size'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'global_memory_size': globalMemorySize,
    'wasm_binary_size': wasmBinarySize,
    'custom_sections_size': customSectionsSize,
    'canister_history_size': canisterHistorySize,
    'wasm_chunk_store_size': wasmChunkStoreSize,
    'snapshots_size': snapshotsSize,
    'log_memory_store_size': logMemoryStoreSize,
  };

  Map<String, dynamic> toJson() => {
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'global_memory_size': globalMemorySize,
    'wasm_binary_size': wasmBinarySize,
    'custom_sections_size': customSectionsSize,
    'canister_history_size': canisterHistorySize,
    'wasm_chunk_store_size': wasmChunkStoreSize,
    'snapshots_size': snapshotsSize,
    'log_memory_store_size': logMemoryStoreSize,
  };

  factory ICCanisterStatusResultMemoryMetrics.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICCanisterStatusResultMemoryMetrics(
      wasmMemorySize: json.valueAsBigInt<BigInt>('wasm_memory_size'),
      stableMemorySize: json.valueAsBigInt<BigInt>('stable_memory_size'),
      globalMemorySize: json.valueAsBigInt<BigInt>('global_memory_size'),
      wasmBinarySize: json.valueAsBigInt<BigInt>('wasm_binary_size'),
      customSectionsSize: json.valueAsBigInt<BigInt>('custom_sections_size'),
      canisterHistorySize: json.valueAsBigInt<BigInt>('canister_history_size'),
      wasmChunkStoreSize: json.valueAsBigInt<BigInt>('wasm_chunk_store_size'),
      snapshotsSize: json.valueAsBigInt<BigInt>('snapshots_size'),
      logMemoryStoreSize: json.valueAsBigInt<BigInt>('log_memory_store_size'),
    );
  }

  factory ICCanisterStatusResultMemoryMetrics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterStatusResultMemoryMetrics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICCanisterStatusResult.query_stats`.
final class ICCanisterStatusResultQueryStats with CandidSerializable {
  final BigInt numCallsTotal;
  final BigInt numInstructionsTotal;
  final BigInt requestPayloadBytesTotal;
  final BigInt responsePayloadBytesTotal;

  const ICCanisterStatusResultQueryStats({
    required this.numCallsTotal,
    required this.numInstructionsTotal,
    required this.requestPayloadBytesTotal,
    required this.responsePayloadBytesTotal,
  });

  static CType get ctype => CType.record([
    Field(Label.named('num_calls_total'), CType.nat),
    Field(Label.named('num_instructions_total'), CType.nat),
    Field(Label.named('request_payload_bytes_total'), CType.nat),
    Field(Label.named('response_payload_bytes_total'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'num_calls_total': numCallsTotal,
    'num_instructions_total': numInstructionsTotal,
    'request_payload_bytes_total': requestPayloadBytesTotal,
    'response_payload_bytes_total': responsePayloadBytesTotal,
  };

  Map<String, dynamic> toJson() => {
    'num_calls_total': numCallsTotal,
    'num_instructions_total': numInstructionsTotal,
    'request_payload_bytes_total': requestPayloadBytesTotal,
    'response_payload_bytes_total': responsePayloadBytesTotal,
  };

  factory ICCanisterStatusResultQueryStats.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICCanisterStatusResultQueryStats(
      numCallsTotal: json.valueAsBigInt<BigInt>('num_calls_total'),
      numInstructionsTotal: json.valueAsBigInt<BigInt>(
        'num_instructions_total',
      ),
      requestPayloadBytesTotal: json.valueAsBigInt<BigInt>(
        'request_payload_bytes_total',
      ),
      responsePayloadBytesTotal: json.valueAsBigInt<BigInt>(
        'response_payload_bytes_total',
      ),
    );
  }

  factory ICCanisterStatusResultQueryStats.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterStatusResultQueryStats.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICHttpRequestArgs.method`.
sealed class ICHttpRequestArgsMethod with CandidSerializable {
  const ICHttpRequestArgsMethod();

  static CType get ctype => CType.variant([
    Field(Label.named('get'), CType.null_),
    Field(Label.named('head'), CType.null_),
    Field(Label.named('post'), CType.null_),
    Field(Label.named('put'), CType.null_),
    Field(Label.named('delete'), CType.null_),
    Field(Label.named('patch'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICHttpRequestArgsMethod.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('get')) {
      return const ICHttpRequestArgsMethodGet();
    }
    if (json.containsKey('head')) {
      return const ICHttpRequestArgsMethodHead();
    }
    if (json.containsKey('post')) {
      return const ICHttpRequestArgsMethodPost();
    }
    if (json.containsKey('put')) {
      return const ICHttpRequestArgsMethodPut();
    }
    if (json.containsKey('delete')) {
      return const ICHttpRequestArgsMethodDelete();
    }
    if (json.containsKey('patch')) {
      return const ICHttpRequestArgsMethodPatch();
    }
    throw OnChainErrors.icpCandid(
      'ICHttpRequestArgsMethod.fromCandid',
      reason: 'Unknown ICHttpRequestArgsMethod arm',
    );
  }

  factory ICHttpRequestArgsMethod.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICHttpRequestArgsMethod.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICHttpRequestArgs.method.get` (nullary).
final class ICHttpRequestArgsMethodGet extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodGet();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('get', null);

  @override
  Map<String, dynamic> toJson() => {'get': null};
}

/// Variant arm `ICHttpRequestArgs.method.head` (nullary).
final class ICHttpRequestArgsMethodHead extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodHead();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('head', null);

  @override
  Map<String, dynamic> toJson() => {'head': null};
}

/// Variant arm `ICHttpRequestArgs.method.post` (nullary).
final class ICHttpRequestArgsMethodPost extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodPost();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('post', null);

  @override
  Map<String, dynamic> toJson() => {'post': null};
}

/// Variant arm `ICHttpRequestArgs.method.put` (nullary).
final class ICHttpRequestArgsMethodPut extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodPut();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('put', null);

  @override
  Map<String, dynamic> toJson() => {'put': null};
}

/// Variant arm `ICHttpRequestArgs.method.delete` (nullary).
final class ICHttpRequestArgsMethodDelete extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodDelete();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('delete', null);

  @override
  Map<String, dynamic> toJson() => {'delete': null};
}

/// Variant arm `ICHttpRequestArgs.method.patch` (nullary).
final class ICHttpRequestArgsMethodPatch extends ICHttpRequestArgsMethod {
  const ICHttpRequestArgsMethodPatch();

  @override
  CType get candidType => ICHttpRequestArgsMethod.ctype;

  @override
  dynamic get candidValue => const Variant('patch', null);

  @override
  Map<String, dynamic> toJson() => {'patch': null};
}

/// Candid record `ICHttpRequestArgs.transform`.
final class ICHttpRequestArgsTransform with CandidSerializable {
  final FuncRef function;
  final List<int> context;

  const ICHttpRequestArgsTransform({
    required this.function,
    required this.context,
  });

  static CType get ctype => CType.record([
    Field(Label.named('function'), CType.func(const FunctionType([], [], []))),
    Field(Label.named('context'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'function': function, 'context': context};

  Map<String, dynamic> toJson() => {'function': function, 'context': context};

  factory ICHttpRequestArgsTransform.fromCandid(Map<String, dynamic> json) {
    return ICHttpRequestArgsTransform(
      function: json['function'],
      context: json.valueAsBytes<List<int>>(
        'context',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICHttpRequestArgsTransform.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICHttpRequestArgsTransform.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICEcdsaPublicKeyArgs.key_id`.
final class ICEcdsaPublicKeyArgsKeyId with CandidSerializable {
  final ICEcdsaCurve curve;
  final String name;

  const ICEcdsaPublicKeyArgsKeyId({required this.curve, required this.name});

  static CType get ctype => CType.record([
    LazyField(Label.named('curve'), () => ICEcdsaCurve.ctype),
    Field(Label.named('name'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'curve': curve.candidValue, 'name': name};

  Map<String, dynamic> toJson() => {'curve': curve.toJson(), 'name': name};

  factory ICEcdsaPublicKeyArgsKeyId.fromCandid(Map<String, dynamic> json) {
    return ICEcdsaPublicKeyArgsKeyId(
      curve: json.valueTo<ICEcdsaCurve, Map>(
        key: 'curve',
        parse:
            (e) => ICEcdsaCurve.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      name: json.valueAsString<String>('name'),
    );
  }

  factory ICEcdsaPublicKeyArgsKeyId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICEcdsaPublicKeyArgsKeyId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICSchnorrPublicKeyArgs.key_id`.
final class ICSchnorrPublicKeyArgsKeyId with CandidSerializable {
  final ICSchnorrAlgorithm algorithm;
  final String name;

  const ICSchnorrPublicKeyArgsKeyId({
    required this.algorithm,
    required this.name,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('algorithm'), () => ICSchnorrAlgorithm.ctype),
    Field(Label.named('name'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'algorithm': algorithm.candidValue, 'name': name};

  Map<String, dynamic> toJson() => {
    'algorithm': algorithm.toJson(),
    'name': name,
  };

  factory ICSchnorrPublicKeyArgsKeyId.fromCandid(Map<String, dynamic> json) {
    return ICSchnorrPublicKeyArgsKeyId(
      algorithm: json.valueTo<ICSchnorrAlgorithm, Map>(
        key: 'algorithm',
        parse:
            (e) => ICSchnorrAlgorithm.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      name: json.valueAsString<String>('name'),
    );
  }

  factory ICSchnorrPublicKeyArgsKeyId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSchnorrPublicKeyArgsKeyId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICVetkdPublicKeyArgs.key_id`.
final class ICVetkdPublicKeyArgsKeyId with CandidSerializable {
  final ICVetkdCurve curve;
  final String name;

  const ICVetkdPublicKeyArgsKeyId({required this.curve, required this.name});

  static CType get ctype => CType.record([
    LazyField(Label.named('curve'), () => ICVetkdCurve.ctype),
    Field(Label.named('name'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'curve': curve.candidValue, 'name': name};

  Map<String, dynamic> toJson() => {'curve': curve.toJson(), 'name': name};

  factory ICVetkdPublicKeyArgsKeyId.fromCandid(Map<String, dynamic> json) {
    return ICVetkdPublicKeyArgsKeyId(
      curve: json.valueTo<ICVetkdCurve, Map>(
        key: 'curve',
        parse:
            (e) => ICVetkdCurve.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      name: json.valueAsString<String>('name'),
    );
  }

  factory ICVetkdPublicKeyArgsKeyId.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdPublicKeyArgsKeyId.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICNodeMetricsHistoryResult.item`.
final class ICNodeMetricsHistoryResultItem with CandidSerializable {
  final BigInt timestampNanos;
  final List<ICNodeMetrics> nodeMetrics;

  const ICNodeMetricsHistoryResultItem({
    required this.timestampNanos,
    required this.nodeMetrics,
  });

  static CType get ctype => CType.record([
    Field(Label.named('timestamp_nanos'), CType.nat64),
    LazyField(
      Label.named('node_metrics'),
      () => CType.vec(ICNodeMetrics.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'timestamp_nanos': timestampNanos,
    'node_metrics': nodeMetrics.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'timestamp_nanos': timestampNanos,
    'node_metrics': nodeMetrics.map((el) => el.toJson()).toList(),
  };

  factory ICNodeMetricsHistoryResultItem.fromCandid(Map<String, dynamic> json) {
    return ICNodeMetricsHistoryResultItem(
      timestampNanos: json.valueAsBigInt<BigInt>('timestamp_nanos'),
      nodeMetrics: json.valueTo<List<ICNodeMetrics>, List>(
        key: 'node_metrics',
        parse:
            (e) =>
                e
                    .map<ICNodeMetrics>(
                      (x) => ICNodeMetrics.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory ICNodeMetricsHistoryResultItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICNodeMetricsHistoryResultItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICFetchCanisterLogsArgs.filter`.
sealed class ICFetchCanisterLogsArgsFilter with CandidSerializable {
  const ICFetchCanisterLogsArgsFilter();

  static CType get ctype => CType.variant([
    Field(
      Label.named('by_idx'),
      CType.record([
        Field(Label.named('start'), CType.nat64),
        Field(Label.named('end'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('by_timestamp_nanos'),
      CType.record([
        Field(Label.named('start'), CType.nat64),
        Field(Label.named('end'), CType.nat64),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICFetchCanisterLogsArgsFilter.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('by_idx')) {
      return ICFetchCanisterLogsArgsFilterByIdx.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['by_idx']),
      );
    }
    if (json.containsKey('by_timestamp_nanos')) {
      return ICFetchCanisterLogsArgsFilterByTimestampNanos.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['by_timestamp_nanos'],
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICFetchCanisterLogsArgsFilter.fromCandid',
      reason: 'Unknown ICFetchCanisterLogsArgsFilter arm',
    );
  }

  factory ICFetchCanisterLogsArgsFilter.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICFetchCanisterLogsArgsFilter.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICFetchCanisterLogsArgs.filter.by_idx`.
final class ICFetchCanisterLogsArgsFilterByIdx
    extends ICFetchCanisterLogsArgsFilter {
  final BigInt start;
  final BigInt end;

  const ICFetchCanisterLogsArgsFilterByIdx({
    required this.start,
    required this.end,
  });

  @override
  CType get candidType => ICFetchCanisterLogsArgsFilter.ctype;

  @override
  dynamic get candidValue => Variant('by_idx', {'start': start, 'end': end});

  @override
  Map<String, dynamic> toJson() => {
    'by_idx': {'start': start, 'end': end},
  };

  factory ICFetchCanisterLogsArgsFilterByIdx.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICFetchCanisterLogsArgsFilterByIdx(
      start: json.valueAsBigInt<BigInt>('start'),
      end: json.valueAsBigInt<BigInt>('end'),
    );
  }
}

/// Variant arm `ICFetchCanisterLogsArgs.filter.by_timestamp_nanos`.
final class ICFetchCanisterLogsArgsFilterByTimestampNanos
    extends ICFetchCanisterLogsArgsFilter {
  final BigInt start;
  final BigInt end;

  const ICFetchCanisterLogsArgsFilterByTimestampNanos({
    required this.start,
    required this.end,
  });

  @override
  CType get candidType => ICFetchCanisterLogsArgsFilter.ctype;

  @override
  dynamic get candidValue =>
      Variant('by_timestamp_nanos', {'start': start, 'end': end});

  @override
  Map<String, dynamic> toJson() => {
    'by_timestamp_nanos': {'start': start, 'end': end},
  };

  factory ICFetchCanisterLogsArgsFilterByTimestampNanos.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICFetchCanisterLogsArgsFilterByTimestampNanos(
      start: json.valueAsBigInt<BigInt>('start'),
      end: json.valueAsBigInt<BigInt>('end'),
    );
  }
}

/// Candid variant `ICReadCanisterSnapshotMetadataResponse.globals`.
sealed class ICReadCanisterSnapshotMetadataResponseGlobals
    with CandidSerializable {
  const ICReadCanisterSnapshotMetadataResponseGlobals();

  static CType get ctype => CType.variant([
    Field(Label.named('i32'), CType.int32),
    Field(Label.named('i64'), CType.int64),
    Field(Label.named('f32'), CType.float32),
    Field(Label.named('f64'), CType.float64),
    Field(Label.named('v128'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICReadCanisterSnapshotMetadataResponseGlobals.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('i32')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalsI32(
        json.valueAsInt<int>('i32'),
      );
    }
    if (json.containsKey('i64')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalsI64(
        json.valueAsBigInt<BigInt>('i64'),
      );
    }
    if (json.containsKey('f32')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalsF32(
        json.valueAsDouble<double>('f32'),
      );
    }
    if (json.containsKey('f64')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalsF64(
        json.valueAsDouble<double>('f64'),
      );
    }
    if (json.containsKey('v128')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalsV128(
        json.valueAsBigInt<BigInt>('v128'),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICReadCanisterSnapshotMetadataResponseGlobals.fromCandid',
      reason: 'Unknown ICReadCanisterSnapshotMetadataResponseGlobals arm',
    );
  }

  factory ICReadCanisterSnapshotMetadataResponseGlobals.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataResponseGlobals.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.globals.i32`.
final class ICReadCanisterSnapshotMetadataResponseGlobalsI32
    extends ICReadCanisterSnapshotMetadataResponseGlobals {
  final int value;
  const ICReadCanisterSnapshotMetadataResponseGlobalsI32(this.value);

  @override
  CType get candidType => ICReadCanisterSnapshotMetadataResponseGlobals.ctype;

  @override
  dynamic get candidValue => Variant('i32', value);

  @override
  Map<String, dynamic> toJson() => {'i32': value};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.globals.i64`.
final class ICReadCanisterSnapshotMetadataResponseGlobalsI64
    extends ICReadCanisterSnapshotMetadataResponseGlobals {
  final BigInt value;
  const ICReadCanisterSnapshotMetadataResponseGlobalsI64(this.value);

  @override
  CType get candidType => ICReadCanisterSnapshotMetadataResponseGlobals.ctype;

  @override
  dynamic get candidValue => Variant('i64', value);

  @override
  Map<String, dynamic> toJson() => {'i64': value};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.globals.f32`.
final class ICReadCanisterSnapshotMetadataResponseGlobalsF32
    extends ICReadCanisterSnapshotMetadataResponseGlobals {
  final double value;
  const ICReadCanisterSnapshotMetadataResponseGlobalsF32(this.value);

  @override
  CType get candidType => ICReadCanisterSnapshotMetadataResponseGlobals.ctype;

  @override
  dynamic get candidValue => Variant('f32', value);

  @override
  Map<String, dynamic> toJson() => {'f32': value};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.globals.f64`.
final class ICReadCanisterSnapshotMetadataResponseGlobalsF64
    extends ICReadCanisterSnapshotMetadataResponseGlobals {
  final double value;
  const ICReadCanisterSnapshotMetadataResponseGlobalsF64(this.value);

  @override
  CType get candidType => ICReadCanisterSnapshotMetadataResponseGlobals.ctype;

  @override
  dynamic get candidValue => Variant('f64', value);

  @override
  Map<String, dynamic> toJson() => {'f64': value};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.globals.v128`.
final class ICReadCanisterSnapshotMetadataResponseGlobalsV128
    extends ICReadCanisterSnapshotMetadataResponseGlobals {
  final BigInt value;
  const ICReadCanisterSnapshotMetadataResponseGlobalsV128(this.value);

  @override
  CType get candidType => ICReadCanisterSnapshotMetadataResponseGlobals.ctype;

  @override
  dynamic get candidValue => Variant('v128', value);

  @override
  Map<String, dynamic> toJson() => {'v128': value};
}

/// Candid record `ICReadCanisterSnapshotMetadataResponse.wasm_chunk_store`.
final class ICReadCanisterSnapshotMetadataResponseWasmChunkStore
    with CandidSerializable {
  final List<int> hash;

  const ICReadCanisterSnapshotMetadataResponseWasmChunkStore({
    required this.hash,
  });

  static CType get ctype =>
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory ICReadCanisterSnapshotMetadataResponseWasmChunkStore.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotMetadataResponseWasmChunkStore(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICReadCanisterSnapshotMetadataResponseWasmChunkStore.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataResponseWasmChunkStore.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ICReadCanisterSnapshotMetadataResponse.global_timer`.
sealed class ICReadCanisterSnapshotMetadataResponseGlobalTimer
    with CandidSerializable {
  const ICReadCanisterSnapshotMetadataResponseGlobalTimer();

  static CType get ctype => CType.variant([
    Field(Label.named('inactive'), CType.null_),
    Field(Label.named('active'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('inactive')) {
      return const ICReadCanisterSnapshotMetadataResponseGlobalTimerInactive();
    }
    if (json.containsKey('active')) {
      return ICReadCanisterSnapshotMetadataResponseGlobalTimerActive(
        json.valueAsBigInt<BigInt>('active'),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromCandid',
      reason: 'Unknown ICReadCanisterSnapshotMetadataResponseGlobalTimer arm',
    );
  }

  factory ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.global_timer.inactive` (nullary).
final class ICReadCanisterSnapshotMetadataResponseGlobalTimerInactive
    extends ICReadCanisterSnapshotMetadataResponseGlobalTimer {
  const ICReadCanisterSnapshotMetadataResponseGlobalTimerInactive();

  @override
  CType get candidType =>
      ICReadCanisterSnapshotMetadataResponseGlobalTimer.ctype;

  @override
  dynamic get candidValue => const Variant('inactive', null);

  @override
  Map<String, dynamic> toJson() => {'inactive': null};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.global_timer.active`.
final class ICReadCanisterSnapshotMetadataResponseGlobalTimerActive
    extends ICReadCanisterSnapshotMetadataResponseGlobalTimer {
  final BigInt value;
  const ICReadCanisterSnapshotMetadataResponseGlobalTimerActive(this.value);

  @override
  CType get candidType =>
      ICReadCanisterSnapshotMetadataResponseGlobalTimer.ctype;

  @override
  dynamic get candidValue => Variant('active', value);

  @override
  Map<String, dynamic> toJson() => {'active': value};
}

/// Candid variant `ICReadCanisterSnapshotMetadataResponse.on_low_wasm_memory_hook_status`.
sealed class ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus
    with CandidSerializable {
  const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus();

  static CType get ctype => CType.variant([
    Field(Label.named('condition_not_satisfied'), CType.null_),
    Field(Label.named('ready'), CType.null_),
    Field(Label.named('executed'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('condition_not_satisfied')) {
      return const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusConditionNotSatisfied();
    }
    if (json.containsKey('ready')) {
      return const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusReady();
    }
    if (json.containsKey('executed')) {
      return const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusExecuted();
    }

    throw OnChainErrors.icpCandid(
      'ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromCandid',
      reason:
          'Unknown ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus arm',
    );
  }

  factory ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.on_low_wasm_memory_hook_status.condition_not_satisfied` (nullary).
final class ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusConditionNotSatisfied
    extends ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus {
  const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusConditionNotSatisfied();

  @override
  CType get candidType =>
      ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.ctype;

  @override
  dynamic get candidValue => const Variant('condition_not_satisfied', null);

  @override
  Map<String, dynamic> toJson() => {'condition_not_satisfied': null};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.on_low_wasm_memory_hook_status.ready` (nullary).
final class ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusReady
    extends ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus {
  const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusReady();

  @override
  CType get candidType =>
      ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.ctype;

  @override
  dynamic get candidValue => const Variant('ready', null);

  @override
  Map<String, dynamic> toJson() => {'ready': null};
}

/// Variant arm `ICReadCanisterSnapshotMetadataResponse.on_low_wasm_memory_hook_status.executed` (nullary).
final class ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusExecuted
    extends ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus {
  const ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatusExecuted();

  @override
  CType get candidType =>
      ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.ctype;

  @override
  dynamic get candidValue => const Variant('executed', null);

  @override
  Map<String, dynamic> toJson() => {'executed': null};
}

/// Candid variant `ICReadCanisterSnapshotDataArgs.kind`.
sealed class ICReadCanisterSnapshotDataArgsKind with CandidSerializable {
  const ICReadCanisterSnapshotDataArgsKind();

  static CType get ctype => CType.variant([
    Field(
      Label.named('wasm_module'),
      CType.record([
        Field(Label.named('offset'), CType.nat64),
        Field(Label.named('size'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('wasm_memory'),
      CType.record([
        Field(Label.named('offset'), CType.nat64),
        Field(Label.named('size'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('stable_memory'),
      CType.record([
        Field(Label.named('offset'), CType.nat64),
        Field(Label.named('size'), CType.nat64),
      ]),
    ),
    Field(
      Label.named('wasm_chunk'),
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICReadCanisterSnapshotDataArgsKind.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('wasm_module')) {
      return ICReadCanisterSnapshotDataArgsKindWasmModule.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wasm_module']),
      );
    }
    if (json.containsKey('wasm_memory')) {
      return ICReadCanisterSnapshotDataArgsKindWasmMemory.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wasm_memory']),
      );
    }
    if (json.containsKey('stable_memory')) {
      return ICReadCanisterSnapshotDataArgsKindStableMemory.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['stable_memory']),
      );
    }
    if (json.containsKey('wasm_chunk')) {
      return ICReadCanisterSnapshotDataArgsKindWasmChunk.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wasm_chunk']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICReadCanisterSnapshotDataArgsKind.fromCandid',
      reason: 'Unknown ICReadCanisterSnapshotDataArgsKind arm',
    );
  }

  factory ICReadCanisterSnapshotDataArgsKind.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotDataArgsKind.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotDataArgs.kind.wasm_module`.
final class ICReadCanisterSnapshotDataArgsKindWasmModule
    extends ICReadCanisterSnapshotDataArgsKind {
  final BigInt offset;
  final BigInt size;

  const ICReadCanisterSnapshotDataArgsKindWasmModule({
    required this.offset,
    required this.size,
  });

  @override
  CType get candidType => ICReadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue =>
      Variant('wasm_module', {'offset': offset, 'size': size});

  @override
  Map<String, dynamic> toJson() => {
    'wasm_module': {'offset': offset, 'size': size},
  };

  factory ICReadCanisterSnapshotDataArgsKindWasmModule.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotDataArgsKindWasmModule(
      offset: json.valueAsBigInt<BigInt>('offset'),
      size: json.valueAsBigInt<BigInt>('size'),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotDataArgs.kind.wasm_memory`.
final class ICReadCanisterSnapshotDataArgsKindWasmMemory
    extends ICReadCanisterSnapshotDataArgsKind {
  final BigInt offset;
  final BigInt size;

  const ICReadCanisterSnapshotDataArgsKindWasmMemory({
    required this.offset,
    required this.size,
  });

  @override
  CType get candidType => ICReadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue =>
      Variant('wasm_memory', {'offset': offset, 'size': size});

  @override
  Map<String, dynamic> toJson() => {
    'wasm_memory': {'offset': offset, 'size': size},
  };

  factory ICReadCanisterSnapshotDataArgsKindWasmMemory.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotDataArgsKindWasmMemory(
      offset: json.valueAsBigInt<BigInt>('offset'),
      size: json.valueAsBigInt<BigInt>('size'),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotDataArgs.kind.stable_memory`.
final class ICReadCanisterSnapshotDataArgsKindStableMemory
    extends ICReadCanisterSnapshotDataArgsKind {
  final BigInt offset;
  final BigInt size;

  const ICReadCanisterSnapshotDataArgsKindStableMemory({
    required this.offset,
    required this.size,
  });

  @override
  CType get candidType => ICReadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue =>
      Variant('stable_memory', {'offset': offset, 'size': size});

  @override
  Map<String, dynamic> toJson() => {
    'stable_memory': {'offset': offset, 'size': size},
  };

  factory ICReadCanisterSnapshotDataArgsKindStableMemory.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotDataArgsKindStableMemory(
      offset: json.valueAsBigInt<BigInt>('offset'),
      size: json.valueAsBigInt<BigInt>('size'),
    );
  }
}

/// Variant arm `ICReadCanisterSnapshotDataArgs.kind.wasm_chunk`.
final class ICReadCanisterSnapshotDataArgsKindWasmChunk
    extends ICReadCanisterSnapshotDataArgsKind {
  final List<int> hash;

  const ICReadCanisterSnapshotDataArgsKindWasmChunk({required this.hash});

  @override
  CType get candidType => ICReadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue => Variant('wasm_chunk', {'hash': hash});

  @override
  Map<String, dynamic> toJson() => {
    'wasm_chunk': {'hash': hash},
  };

  factory ICReadCanisterSnapshotDataArgsKindWasmChunk.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotDataArgsKindWasmChunk(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }
}

/// Candid variant `ICUploadCanisterSnapshotDataArgs.kind`.
sealed class ICUploadCanisterSnapshotDataArgsKind with CandidSerializable {
  const ICUploadCanisterSnapshotDataArgsKind();

  static CType get ctype => CType.variant([
    Field(
      Label.named('wasm_module'),
      CType.record([Field(Label.named('offset'), CType.nat64)]),
    ),
    Field(
      Label.named('wasm_memory'),
      CType.record([Field(Label.named('offset'), CType.nat64)]),
    ),
    Field(
      Label.named('stable_memory'),
      CType.record([Field(Label.named('offset'), CType.nat64)]),
    ),
    Field(Label.named('wasm_chunk'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICUploadCanisterSnapshotDataArgsKind.fromCandid(
    Map<String, dynamic> json,
  ) {
    if (json.containsKey('wasm_module')) {
      return ICUploadCanisterSnapshotDataArgsKindWasmModule.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wasm_module']),
      );
    }
    if (json.containsKey('wasm_memory')) {
      return ICUploadCanisterSnapshotDataArgsKindWasmMemory.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['wasm_memory']),
      );
    }
    if (json.containsKey('stable_memory')) {
      return ICUploadCanisterSnapshotDataArgsKindStableMemory.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['stable_memory']),
      );
    }
    if (json.containsKey('wasm_chunk')) {
      return const ICUploadCanisterSnapshotDataArgsKindWasmChunk();
    }
    throw OnChainErrors.icpCandid(
      'ICUploadCanisterSnapshotDataArgsKind.fromCandid',
      reason: 'Unknown ICUploadCanisterSnapshotDataArgsKind arm',
    );
  }

  factory ICUploadCanisterSnapshotDataArgsKind.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUploadCanisterSnapshotDataArgsKind.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ICUploadCanisterSnapshotDataArgs.kind.wasm_module`.
final class ICUploadCanisterSnapshotDataArgsKindWasmModule
    extends ICUploadCanisterSnapshotDataArgsKind {
  final BigInt offset;

  const ICUploadCanisterSnapshotDataArgsKindWasmModule({required this.offset});

  @override
  CType get candidType => ICUploadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue => Variant('wasm_module', {'offset': offset});

  @override
  Map<String, dynamic> toJson() => {
    'wasm_module': {'offset': offset},
  };

  factory ICUploadCanisterSnapshotDataArgsKindWasmModule.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotDataArgsKindWasmModule(
      offset: json.valueAsBigInt<BigInt>('offset'),
    );
  }
}

/// Variant arm `ICUploadCanisterSnapshotDataArgs.kind.wasm_memory`.
final class ICUploadCanisterSnapshotDataArgsKindWasmMemory
    extends ICUploadCanisterSnapshotDataArgsKind {
  final BigInt offset;

  const ICUploadCanisterSnapshotDataArgsKindWasmMemory({required this.offset});

  @override
  CType get candidType => ICUploadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue => Variant('wasm_memory', {'offset': offset});

  @override
  Map<String, dynamic> toJson() => {
    'wasm_memory': {'offset': offset},
  };

  factory ICUploadCanisterSnapshotDataArgsKindWasmMemory.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotDataArgsKindWasmMemory(
      offset: json.valueAsBigInt<BigInt>('offset'),
    );
  }
}

/// Variant arm `ICUploadCanisterSnapshotDataArgs.kind.stable_memory`.
final class ICUploadCanisterSnapshotDataArgsKindStableMemory
    extends ICUploadCanisterSnapshotDataArgsKind {
  final BigInt offset;

  const ICUploadCanisterSnapshotDataArgsKindStableMemory({
    required this.offset,
  });

  @override
  CType get candidType => ICUploadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue => Variant('stable_memory', {'offset': offset});

  @override
  Map<String, dynamic> toJson() => {
    'stable_memory': {'offset': offset},
  };

  factory ICUploadCanisterSnapshotDataArgsKindStableMemory.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotDataArgsKindStableMemory(
      offset: json.valueAsBigInt<BigInt>('offset'),
    );
  }
}

/// Variant arm `ICUploadCanisterSnapshotDataArgs.kind.wasm_chunk` (nullary).
final class ICUploadCanisterSnapshotDataArgsKindWasmChunk
    extends ICUploadCanisterSnapshotDataArgsKind {
  const ICUploadCanisterSnapshotDataArgsKindWasmChunk();

  @override
  CType get candidType => ICUploadCanisterSnapshotDataArgsKind.ctype;

  @override
  dynamic get candidValue => const Variant('wasm_chunk', null);

  @override
  Map<String, dynamic> toJson() => {'wasm_chunk': null};
}

/// Candid variant `log_visibility`.
sealed class ICLogVisibility with CandidSerializable {
  const ICLogVisibility();

  static CType get ctype => CType.variant([
    Field(Label.named('controllers'), CType.null_),
    Field(Label.named('public'), CType.null_),
    Field(Label.named('allowed_viewers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICLogVisibility.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('controllers')) {
      return const ICLogVisibilityControllers();
    }
    if (json.containsKey('public')) {
      return const ICLogVisibilityPublic();
    }
    if (json.containsKey('allowed_viewers')) {
      return ICLogVisibilityAllowedViewers(
        json.valueTo<List<IcpPrincipalAddress>, List>(
          key: 'allowed_viewers',
          parse:
              (e) =>
                  e
                      .map<IcpPrincipalAddress>(
                        (x) => GeneratorParserUtils.principalFromCandid(x),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICLogVisibility.fromCandid',
      reason: 'Unknown ICLogVisibility arm',
    );
  }

  factory ICLogVisibility.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICLogVisibility.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `log_visibility.controllers` (nullary).
final class ICLogVisibilityControllers extends ICLogVisibility {
  const ICLogVisibilityControllers();

  @override
  CType get candidType => ICLogVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('controllers', null);

  @override
  Map<String, dynamic> toJson() => {'controllers': null};
}

/// Variant arm `log_visibility.public` (nullary).
final class ICLogVisibilityPublic extends ICLogVisibility {
  const ICLogVisibilityPublic();

  @override
  CType get candidType => ICLogVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('public', null);

  @override
  Map<String, dynamic> toJson() => {'public': null};
}

/// Variant arm `log_visibility.allowed_viewers`.
final class ICLogVisibilityAllowedViewers extends ICLogVisibility {
  final List<IcpPrincipalAddress> value;
  const ICLogVisibilityAllowedViewers(this.value);

  @override
  CType get candidType => ICLogVisibility.ctype;

  @override
  dynamic get candidValue => Variant('allowed_viewers', value);

  @override
  Map<String, dynamic> toJson() => {
    'allowed_viewers': value.map((el) => el.address).toList(),
  };
}

/// Candid variant `snapshot_visibility`.
sealed class ICSnapshotVisibility with CandidSerializable {
  const ICSnapshotVisibility();

  static CType get ctype => CType.variant([
    Field(Label.named('controllers'), CType.null_),
    Field(Label.named('public'), CType.null_),
    Field(Label.named('allowed_viewers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICSnapshotVisibility.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('controllers')) {
      return const ICSnapshotVisibilityControllers();
    }
    if (json.containsKey('public')) {
      return const ICSnapshotVisibilityPublic();
    }
    if (json.containsKey('allowed_viewers')) {
      return ICSnapshotVisibilityAllowedViewers(
        json.valueTo<List<IcpPrincipalAddress>, List>(
          key: 'allowed_viewers',
          parse:
              (e) =>
                  e
                      .map<IcpPrincipalAddress>(
                        (x) => GeneratorParserUtils.principalFromCandid(x),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICSnapshotVisibility.fromCandid',
      reason: 'Unknown ICSnapshotVisibility arm',
    );
  }

  factory ICSnapshotVisibility.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSnapshotVisibility.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `snapshot_visibility.controllers` (nullary).
final class ICSnapshotVisibilityControllers extends ICSnapshotVisibility {
  const ICSnapshotVisibilityControllers();

  @override
  CType get candidType => ICSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('controllers', null);

  @override
  Map<String, dynamic> toJson() => {'controllers': null};
}

/// Variant arm `snapshot_visibility.public` (nullary).
final class ICSnapshotVisibilityPublic extends ICSnapshotVisibility {
  const ICSnapshotVisibilityPublic();

  @override
  CType get candidType => ICSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => const Variant('public', null);

  @override
  Map<String, dynamic> toJson() => {'public': null};
}

/// Variant arm `snapshot_visibility.allowed_viewers`.
final class ICSnapshotVisibilityAllowedViewers extends ICSnapshotVisibility {
  final List<IcpPrincipalAddress> value;
  const ICSnapshotVisibilityAllowedViewers(this.value);

  @override
  CType get candidType => ICSnapshotVisibility.ctype;

  @override
  dynamic get candidValue => Variant('allowed_viewers', value);

  @override
  Map<String, dynamic> toJson() => {
    'allowed_viewers': value.map((el) => el.address).toList(),
  };
}

/// Candid record `environment_variable`.
final class ICEnvironmentVariable with CandidSerializable {
  final String name;
  final String value;

  const ICEnvironmentVariable({required this.name, required this.value});

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('value'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'value': value};

  Map<String, dynamic> toJson() => {'name': name, 'value': value};

  factory ICEnvironmentVariable.fromCandid(Map<String, dynamic> json) {
    return ICEnvironmentVariable(
      name: json.valueAsString<String>('name'),
      value: json.valueAsString<String>('value'),
    );
  }

  factory ICEnvironmentVariable.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICEnvironmentVariable.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_settings`.
final class ICCanisterSettings with CandidSerializable {
  final List<IcpPrincipalAddress>? controllers;
  final BigInt? computeAllocation;
  final BigInt? memoryAllocation;
  final BigInt? freezingThreshold;
  final BigInt? reservedCyclesLimit;
  final BigInt? minimumIncomingCanisterCallCycles;
  final ICLogVisibility? logVisibility;
  final BigInt? logMemoryLimit;
  final ICSnapshotVisibility? snapshotVisibility;
  final BigInt? wasmMemoryLimit;
  final BigInt? wasmMemoryThreshold;
  final List<ICEnvironmentVariable>? environmentVariables;

  const ICCanisterSettings({
    this.controllers,
    this.computeAllocation,
    this.memoryAllocation,
    this.freezingThreshold,
    this.reservedCyclesLimit,
    this.minimumIncomingCanisterCallCycles,
    this.logVisibility,
    this.logMemoryLimit,
    this.snapshotVisibility,
    this.wasmMemoryLimit,
    this.wasmMemoryThreshold,
    this.environmentVariables,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controllers'), CType.opt(CType.vec(CType.principal))),
    Field(Label.named('compute_allocation'), CType.opt(CType.nat)),
    Field(Label.named('memory_allocation'), CType.opt(CType.nat)),
    Field(Label.named('freezing_threshold'), CType.opt(CType.nat)),
    Field(Label.named('reserved_cycles_limit'), CType.opt(CType.nat)),
    Field(
      Label.named('minimum_incoming_canister_call_cycles'),
      CType.opt(CType.nat),
    ),
    LazyField(
      Label.named('log_visibility'),
      () => CType.opt(ICLogVisibility.ctype),
    ),
    Field(Label.named('log_memory_limit'), CType.opt(CType.nat)),
    LazyField(
      Label.named('snapshot_visibility'),
      () => CType.opt(ICSnapshotVisibility.ctype),
    ),
    Field(Label.named('wasm_memory_limit'), CType.opt(CType.nat)),
    Field(Label.named('wasm_memory_threshold'), CType.opt(CType.nat)),
    LazyField(
      Label.named('environment_variables'),
      () => CType.opt(CType.vec(ICEnvironmentVariable.ctype)),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controllers': controllers,
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'minimum_incoming_canister_call_cycles': minimumIncomingCanisterCallCycles,
    'log_visibility': logVisibility?.candidValue,
    'log_memory_limit': logMemoryLimit,
    'snapshot_visibility': snapshotVisibility?.candidValue,
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables?.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'controllers': controllers?.map((el) => el.address).toList(),
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'minimum_incoming_canister_call_cycles': minimumIncomingCanisterCallCycles,
    'log_visibility': logVisibility?.toJson(),
    'log_memory_limit': logMemoryLimit,
    'snapshot_visibility': snapshotVisibility?.toJson(),
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables?.map((el) => el.toJson()).toList(),
  };

  factory ICCanisterSettings.fromCandid(Map<String, dynamic> json) {
    return ICCanisterSettings(
      controllers: json.valueTo<List<IcpPrincipalAddress>?, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      computeAllocation: json.valueAsBigInt<BigInt?>('compute_allocation'),
      memoryAllocation: json.valueAsBigInt<BigInt?>('memory_allocation'),
      freezingThreshold: json.valueAsBigInt<BigInt?>('freezing_threshold'),
      reservedCyclesLimit: json.valueAsBigInt<BigInt?>('reserved_cycles_limit'),
      minimumIncomingCanisterCallCycles: json.valueAsBigInt<BigInt?>(
        'minimum_incoming_canister_call_cycles',
      ),
      logVisibility: json.valueTo<ICLogVisibility?, Map>(
        key: 'log_visibility',
        parse:
            (e) => ICLogVisibility.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      logMemoryLimit: json.valueAsBigInt<BigInt?>('log_memory_limit'),
      snapshotVisibility: json.valueTo<ICSnapshotVisibility?, Map>(
        key: 'snapshot_visibility',
        parse:
            (e) => ICSnapshotVisibility.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      wasmMemoryLimit: json.valueAsBigInt<BigInt?>('wasm_memory_limit'),
      wasmMemoryThreshold: json.valueAsBigInt<BigInt?>('wasm_memory_threshold'),
      environmentVariables: json.valueTo<List<ICEnvironmentVariable>?, List>(
        key: 'environment_variables',
        parse:
            (e) =>
                e
                    .map<ICEnvironmentVariable>(
                      (x) => ICEnvironmentVariable.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory ICCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `definite_canister_settings`.
final class ICDefiniteCanisterSettings with CandidSerializable {
  final List<IcpPrincipalAddress> controllers;
  final BigInt computeAllocation;
  final BigInt memoryAllocation;
  final BigInt freezingThreshold;
  final BigInt reservedCyclesLimit;
  final BigInt minimumIncomingCanisterCallCycles;
  final ICLogVisibility logVisibility;
  final BigInt logMemoryLimit;
  final ICSnapshotVisibility snapshotVisibility;
  final BigInt wasmMemoryLimit;
  final BigInt wasmMemoryThreshold;
  final List<ICEnvironmentVariable> environmentVariables;

  const ICDefiniteCanisterSettings({
    required this.controllers,
    required this.computeAllocation,
    required this.memoryAllocation,
    required this.freezingThreshold,
    required this.reservedCyclesLimit,
    required this.minimumIncomingCanisterCallCycles,
    required this.logVisibility,
    required this.logMemoryLimit,
    required this.snapshotVisibility,
    required this.wasmMemoryLimit,
    required this.wasmMemoryThreshold,
    required this.environmentVariables,
  });

  static CType get ctype => CType.record([
    Field(Label.named('controllers'), CType.vec(CType.principal)),
    Field(Label.named('compute_allocation'), CType.nat),
    Field(Label.named('memory_allocation'), CType.nat),
    Field(Label.named('freezing_threshold'), CType.nat),
    Field(Label.named('reserved_cycles_limit'), CType.nat),
    Field(Label.named('minimum_incoming_canister_call_cycles'), CType.nat),
    LazyField(Label.named('log_visibility'), () => ICLogVisibility.ctype),
    Field(Label.named('log_memory_limit'), CType.nat),
    LazyField(
      Label.named('snapshot_visibility'),
      () => ICSnapshotVisibility.ctype,
    ),
    Field(Label.named('wasm_memory_limit'), CType.nat),
    Field(Label.named('wasm_memory_threshold'), CType.nat),
    LazyField(
      Label.named('environment_variables'),
      () => CType.vec(ICEnvironmentVariable.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'controllers': controllers,
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'minimum_incoming_canister_call_cycles': minimumIncomingCanisterCallCycles,
    'log_visibility': logVisibility.candidValue,
    'log_memory_limit': logMemoryLimit,
    'snapshot_visibility': snapshotVisibility.candidValue,
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'controllers': controllers.map((el) => el.address).toList(),
    'compute_allocation': computeAllocation,
    'memory_allocation': memoryAllocation,
    'freezing_threshold': freezingThreshold,
    'reserved_cycles_limit': reservedCyclesLimit,
    'minimum_incoming_canister_call_cycles': minimumIncomingCanisterCallCycles,
    'log_visibility': logVisibility.toJson(),
    'log_memory_limit': logMemoryLimit,
    'snapshot_visibility': snapshotVisibility.toJson(),
    'wasm_memory_limit': wasmMemoryLimit,
    'wasm_memory_threshold': wasmMemoryThreshold,
    'environment_variables':
        environmentVariables.map((el) => el.toJson()).toList(),
  };

  factory ICDefiniteCanisterSettings.fromCandid(Map<String, dynamic> json) {
    return ICDefiniteCanisterSettings(
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      computeAllocation: json.valueAsBigInt<BigInt>('compute_allocation'),
      memoryAllocation: json.valueAsBigInt<BigInt>('memory_allocation'),
      freezingThreshold: json.valueAsBigInt<BigInt>('freezing_threshold'),
      reservedCyclesLimit: json.valueAsBigInt<BigInt>('reserved_cycles_limit'),
      minimumIncomingCanisterCallCycles: json.valueAsBigInt<BigInt>(
        'minimum_incoming_canister_call_cycles',
      ),
      logVisibility: json.valueTo<ICLogVisibility, Map>(
        key: 'log_visibility',
        parse:
            (e) => ICLogVisibility.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      logMemoryLimit: json.valueAsBigInt<BigInt>('log_memory_limit'),
      snapshotVisibility: json.valueTo<ICSnapshotVisibility, Map>(
        key: 'snapshot_visibility',
        parse:
            (e) => ICSnapshotVisibility.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      wasmMemoryLimit: json.valueAsBigInt<BigInt>('wasm_memory_limit'),
      wasmMemoryThreshold: json.valueAsBigInt<BigInt>('wasm_memory_threshold'),
      environmentVariables: json.valueTo<List<ICEnvironmentVariable>, List>(
        key: 'environment_variables',
        parse:
            (e) =>
                e
                    .map<ICEnvironmentVariable>(
                      (x) => ICEnvironmentVariable.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory ICDefiniteCanisterSettings.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICDefiniteCanisterSettings.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `change_origin`.
sealed class ICChangeOrigin with CandidSerializable {
  const ICChangeOrigin();

  static CType get ctype => CType.variant([
    Field(
      Label.named('from_user'),
      CType.record([Field(Label.named('user_id'), CType.principal)]),
    ),
    Field(
      Label.named('from_canister'),
      CType.record([
        Field(Label.named('canister_id'), CType.principal),
        Field(Label.named('canister_version'), CType.opt(CType.nat64)),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICChangeOrigin.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('from_user')) {
      return ICChangeOriginFromUser.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['from_user']),
      );
    }
    if (json.containsKey('from_canister')) {
      return ICChangeOriginFromCanister.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['from_canister']),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICChangeOrigin.fromCandid',
      reason: 'Unknown ICChangeOrigin arm',
    );
  }

  factory ICChangeOrigin.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChangeOrigin.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `change_origin.from_user`.
final class ICChangeOriginFromUser extends ICChangeOrigin {
  final IcpPrincipalAddress userId;

  const ICChangeOriginFromUser({required this.userId});

  @override
  CType get candidType => ICChangeOrigin.ctype;

  @override
  dynamic get candidValue => Variant('from_user', {'user_id': userId});

  @override
  Map<String, dynamic> toJson() => {
    'from_user': {'user_id': userId.address},
  };

  factory ICChangeOriginFromUser.fromCandid(Map<String, dynamic> json) {
    return ICChangeOriginFromUser(
      userId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'user_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Variant arm `change_origin.from_canister`.
final class ICChangeOriginFromCanister extends ICChangeOrigin {
  final IcpPrincipalAddress canisterId;
  final BigInt? canisterVersion;

  const ICChangeOriginFromCanister({
    required this.canisterId,
    this.canisterVersion,
  });

  @override
  CType get candidType => ICChangeOrigin.ctype;

  @override
  dynamic get candidValue => Variant('from_canister', {
    'canister_id': canisterId,
    'canister_version': canisterVersion,
  });

  @override
  Map<String, dynamic> toJson() => {
    'from_canister': {
      'canister_id': canisterId.address,
      'canister_version': canisterVersion,
    },
  };

  factory ICChangeOriginFromCanister.fromCandid(Map<String, dynamic> json) {
    return ICChangeOriginFromCanister(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      canisterVersion: json.valueAsBigInt<BigInt?>('canister_version'),
    );
  }
}

/// Candid variant `change_details`.
sealed class ICChangeDetails with CandidSerializable {
  const ICChangeDetails();

  static CType get ctype => CType.variant([
    Field(
      Label.named('creation'),
      CType.record([
        Field(Label.named('controllers'), CType.vec(CType.principal)),
        Field(
          Label.named('environment_variables_hash'),
          CType.opt(CType.vec(CType.nat8)),
        ),
      ]),
    ),
    Field(Label.named('code_uninstall'), CType.null_),
    Field(
      Label.named('code_deployment'),
      CType.record([
        Field(
          Label.named('mode'),
          CType.variant([
            Field(Label.named('install'), CType.null_),
            Field(Label.named('reinstall'), CType.null_),
            Field(Label.named('upgrade'), CType.null_),
          ]),
        ),
        Field(Label.named('module_hash'), CType.vec(CType.nat8)),
      ]),
    ),
    Field(
      Label.named('load_snapshot'),
      CType.record([
        Field(Label.named('from_canister_id'), CType.opt(CType.principal)),
        Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
        Field(Label.named('canister_version'), CType.nat64),
        Field(Label.named('taken_at_timestamp'), CType.nat64),
        Field(
          Label.named('source'),
          CType.variant([
            Field(Label.named('taken_from_canister'), CType.reserved),
            Field(Label.named('metadata_upload'), CType.reserved),
          ]),
        ),
      ]),
    ),
    Field(
      Label.named('controllers_change'),
      CType.record([
        Field(Label.named('controllers'), CType.vec(CType.principal)),
      ]),
    ),
    Field(
      Label.named('rename_canister'),
      CType.record([
        Field(Label.named('canister_id'), CType.principal),
        Field(Label.named('total_num_changes'), CType.nat64),
        Field(
          Label.named('rename_to'),
          CType.record([
            Field(Label.named('canister_id'), CType.principal),
            Field(Label.named('version'), CType.nat64),
            Field(Label.named('total_num_changes'), CType.nat64),
          ]),
        ),
        Field(Label.named('requested_by'), CType.principal),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICChangeDetails.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('creation')) {
      return ICChangeDetailsCreation.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['creation']),
      );
    }
    if (json.containsKey('code_uninstall')) {
      return const ICChangeDetailsCodeUninstall();
    }
    if (json.containsKey('code_deployment')) {
      return ICChangeDetailsCodeDeployment.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['code_deployment']),
      );
    }
    if (json.containsKey('load_snapshot')) {
      return ICChangeDetailsLoadSnapshot.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['load_snapshot']),
      );
    }
    if (json.containsKey('controllers_change')) {
      return ICChangeDetailsControllersChange.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(
          json['controllers_change'],
        ),
      );
    }
    if (json.containsKey('rename_canister')) {
      return ICChangeDetailsRenameCanister.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['rename_canister']),
      );
    }

    throw OnChainErrors.icpCandid(
      'ICChangeDetails.fromCandid',
      reason: 'Unknown ICChangeDetails arm',
    );
  }

  factory ICChangeDetails.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChangeDetails.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `change_details.creation`.
final class ICChangeDetailsCreation extends ICChangeDetails {
  final List<IcpPrincipalAddress> controllers;
  final List<int>? environmentVariablesHash;

  const ICChangeDetailsCreation({
    required this.controllers,
    this.environmentVariablesHash,
  });

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue => Variant('creation', {
    'controllers': controllers,
    'environment_variables_hash': environmentVariablesHash,
  });

  @override
  Map<String, dynamic> toJson() => {
    'creation': {
      'controllers': controllers.map((el) => el.address).toList(),
      'environment_variables_hash': environmentVariablesHash,
    },
  };

  factory ICChangeDetailsCreation.fromCandid(Map<String, dynamic> json) {
    return ICChangeDetailsCreation(
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
      environmentVariablesHash: json.valueAsBytes<List<int>?>(
        'environment_variables_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }
}

/// Variant arm `change_details.code_uninstall` (nullary).
final class ICChangeDetailsCodeUninstall extends ICChangeDetails {
  const ICChangeDetailsCodeUninstall();

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue => const Variant('code_uninstall', null);

  @override
  Map<String, dynamic> toJson() => {'code_uninstall': null};
}

/// Variant arm `change_details.code_deployment`.
final class ICChangeDetailsCodeDeployment extends ICChangeDetails {
  final ICChangeDetailsCodeDeploymentMode mode;
  final List<int> moduleHash;

  const ICChangeDetailsCodeDeployment({
    required this.mode,
    required this.moduleHash,
  });

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue => Variant('code_deployment', {
    'mode': mode.candidValue,
    'module_hash': moduleHash,
  });

  @override
  Map<String, dynamic> toJson() => {
    'code_deployment': {'mode': mode.toJson(), 'module_hash': moduleHash},
  };

  factory ICChangeDetailsCodeDeployment.fromCandid(Map<String, dynamic> json) {
    return ICChangeDetailsCodeDeployment(
      mode: json.valueTo<ICChangeDetailsCodeDeploymentMode, Map>(
        key: 'mode',
        parse:
            (e) => ICChangeDetailsCodeDeploymentMode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      moduleHash: json.valueAsBytes<List<int>>(
        'module_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }
}

/// Variant arm `change_details.load_snapshot`.
final class ICChangeDetailsLoadSnapshot extends ICChangeDetails {
  final IcpPrincipalAddress? fromCanisterId;
  final ICSnapshotId snapshotId;
  final BigInt canisterVersion;
  final BigInt takenAtTimestamp;
  final ICChangeDetailsLoadSnapshotSource source;

  const ICChangeDetailsLoadSnapshot({
    this.fromCanisterId,
    required this.snapshotId,
    required this.canisterVersion,
    required this.takenAtTimestamp,
    required this.source,
  });

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue => Variant('load_snapshot', {
    'from_canister_id': fromCanisterId,
    'snapshot_id': snapshotId,
    'canister_version': canisterVersion,
    'taken_at_timestamp': takenAtTimestamp,
    'source': source.candidValue,
  });

  @override
  Map<String, dynamic> toJson() => {
    'load_snapshot': {
      'from_canister_id': fromCanisterId?.address,
      'snapshot_id': snapshotId,
      'canister_version': canisterVersion,
      'taken_at_timestamp': takenAtTimestamp,
      'source': source.toJson(),
    },
  };

  factory ICChangeDetailsLoadSnapshot.fromCandid(Map<String, dynamic> json) {
    return ICChangeDetailsLoadSnapshot(
      fromCanisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'from_canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
      canisterVersion: json.valueAsBigInt<BigInt>('canister_version'),
      takenAtTimestamp: json.valueAsBigInt<BigInt>('taken_at_timestamp'),
      source: json.valueTo<ICChangeDetailsLoadSnapshotSource, Map>(
        key: 'source',
        parse:
            (e) => ICChangeDetailsLoadSnapshotSource.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }
}

/// Variant arm `change_details.controllers_change`.
final class ICChangeDetailsControllersChange extends ICChangeDetails {
  final List<IcpPrincipalAddress> controllers;

  const ICChangeDetailsControllersChange({required this.controllers});

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue =>
      Variant('controllers_change', {'controllers': controllers});

  @override
  Map<String, dynamic> toJson() => {
    'controllers_change': {
      'controllers': controllers.map((el) => el.address).toList(),
    },
  };

  factory ICChangeDetailsControllersChange.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICChangeDetailsControllersChange(
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
    );
  }
}

/// Variant arm `change_details.rename_canister`.
final class ICChangeDetailsRenameCanister extends ICChangeDetails {
  final IcpPrincipalAddress canisterId;
  final BigInt totalNumChanges;
  final ICChangeDetailsRenameCanisterRenameTo renameTo;
  final IcpPrincipalAddress requestedBy;

  const ICChangeDetailsRenameCanister({
    required this.canisterId,
    required this.totalNumChanges,
    required this.renameTo,
    required this.requestedBy,
  });

  @override
  CType get candidType => ICChangeDetails.ctype;

  @override
  dynamic get candidValue => Variant('rename_canister', {
    'canister_id': canisterId,
    'total_num_changes': totalNumChanges,
    'rename_to': renameTo.candidValue,
    'requested_by': requestedBy,
  });

  @override
  Map<String, dynamic> toJson() => {
    'rename_canister': {
      'canister_id': canisterId.address,
      'total_num_changes': totalNumChanges,
      'rename_to': renameTo.toJson(),
      'requested_by': requestedBy.address,
    },
  };

  factory ICChangeDetailsRenameCanister.fromCandid(Map<String, dynamic> json) {
    return ICChangeDetailsRenameCanister(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      totalNumChanges: json.valueAsBigInt<BigInt>('total_num_changes'),
      renameTo: json.valueTo<ICChangeDetailsRenameCanisterRenameTo, Map>(
        key: 'rename_to',
        parse:
            (e) => ICChangeDetailsRenameCanisterRenameTo.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      requestedBy: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'requested_by',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }
}

/// Candid record `change`.
final class ICChange with CandidSerializable {
  final BigInt timestampNanos;
  final BigInt canisterVersion;
  final ICChangeOrigin origin;
  final ICChangeDetails? details;

  const ICChange({
    required this.timestampNanos,
    required this.canisterVersion,
    required this.origin,
    this.details,
  });

  static CType get ctype => CType.record([
    Field(Label.named('timestamp_nanos'), CType.nat64),
    Field(Label.named('canister_version'), CType.nat64),
    LazyField(Label.named('origin'), () => ICChangeOrigin.ctype),
    LazyField(Label.named('details'), () => CType.opt(ICChangeDetails.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'timestamp_nanos': timestampNanos,
    'canister_version': canisterVersion,
    'origin': origin.candidValue,
    'details': details?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'timestamp_nanos': timestampNanos,
    'canister_version': canisterVersion,
    'origin': origin.toJson(),
    'details': details?.toJson(),
  };

  factory ICChange.fromCandid(Map<String, dynamic> json) {
    return ICChange(
      timestampNanos: json.valueAsBigInt<BigInt>('timestamp_nanos'),
      canisterVersion: json.valueAsBigInt<BigInt>('canister_version'),
      origin: json.valueTo<ICChangeOrigin, Map>(
        key: 'origin',
        parse:
            (e) => ICChangeOrigin.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      details: json.valueTo<ICChangeDetails?, Map>(
        key: 'details',
        parse:
            (e) => ICChangeDetails.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICChange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `chunk_hash`.
final class ICChunkHash with CandidSerializable {
  final List<int> hash;

  const ICChunkHash({required this.hash});

  static CType get ctype =>
      CType.record([Field(Label.named('hash'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'hash': hash};

  Map<String, dynamic> toJson() => {'hash': hash};

  factory ICChunkHash.fromCandid(Map<String, dynamic> json) {
    return ICChunkHash(
      hash: json.valueAsBytes<List<int>>(
        'hash',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICChunkHash.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICChunkHash.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `http_header`.
final class ICHttpHeader with CandidSerializable {
  final String name;
  final String value;

  const ICHttpHeader({required this.name, required this.value});

  static CType get ctype => CType.record([
    Field(Label.named('name'), CType.text),
    Field(Label.named('value'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'name': name, 'value': value};

  Map<String, dynamic> toJson() => {'name': name, 'value': value};

  factory ICHttpHeader.fromCandid(Map<String, dynamic> json) {
    return ICHttpHeader(
      name: json.valueAsString<String>('name'),
      value: json.valueAsString<String>('value'),
    );
  }

  factory ICHttpHeader.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICHttpHeader.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `http_request_result`.
final class ICHttpRequestResult with CandidSerializable {
  final BigInt status;
  final List<ICHttpHeader> headers;
  final List<int> body;

  const ICHttpRequestResult({
    required this.status,
    required this.headers,
    required this.body,
  });

  static CType get ctype => CType.record([
    Field(Label.named('status'), CType.nat),
    LazyField(Label.named('headers'), () => CType.vec(ICHttpHeader.ctype)),
    Field(Label.named('body'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'status': status,
    'headers': headers.map((el) => el.candidValue).toList(),
    'body': body,
  };

  Map<String, dynamic> toJson() => {
    'status': status,
    'headers': headers.map((el) => el.toJson()).toList(),
    'body': body,
  };

  factory ICHttpRequestResult.fromCandid(Map<String, dynamic> json) {
    return ICHttpRequestResult(
      status: json.valueAsBigInt<BigInt>('status'),
      headers: json.valueTo<List<ICHttpHeader>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<ICHttpHeader>(
                      (x) => ICHttpHeader.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      body: json.valueAsBytes<List<int>>(
        'body',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICHttpRequestResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICHttpRequestResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `ecdsa_curve`.
sealed class ICEcdsaCurve with CandidSerializable {
  const ICEcdsaCurve();

  static CType get ctype =>
      CType.variant([Field(Label.named('secp256k1'), CType.null_)]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICEcdsaCurve.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('secp256k1')) {
      return const ICEcdsaCurveSecp256k1();
    }

    throw OnChainErrors.icpCandid(
      'ICEcdsaCurve.fromCandid',
      reason: 'Unknown ICEcdsaCurve arm',
    );
  }

  factory ICEcdsaCurve.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICEcdsaCurve.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `ecdsa_curve.secp256k1` (nullary).
final class ICEcdsaCurveSecp256k1 extends ICEcdsaCurve {
  const ICEcdsaCurveSecp256k1();

  @override
  CType get candidType => ICEcdsaCurve.ctype;

  @override
  dynamic get candidValue => const Variant('secp256k1', null);

  @override
  Map<String, dynamic> toJson() => {'secp256k1': null};
}

/// Candid variant `vetkd_curve`.
sealed class ICVetkdCurve with CandidSerializable {
  const ICVetkdCurve();

  static CType get ctype =>
      CType.variant([Field(Label.named('bls12_381_g2'), CType.null_)]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICVetkdCurve.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('bls12_381_g2')) {
      return const ICVetkdCurveBls12381G2();
    }

    throw OnChainErrors.icpCandid(
      'ICVetkdCurve.fromCandid',
      reason: 'Unknown ICVetkdCurve arm',
    );
  }

  factory ICVetkdCurve.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdCurve.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `vetkd_curve.bls12_381_g2` (nullary).
final class ICVetkdCurveBls12381G2 extends ICVetkdCurve {
  const ICVetkdCurveBls12381G2();

  @override
  CType get candidType => ICVetkdCurve.ctype;

  @override
  dynamic get candidValue => const Variant('bls12_381_g2', null);

  @override
  Map<String, dynamic> toJson() => {'bls12_381_g2': null};
}

/// Candid variant `schnorr_algorithm`.
sealed class ICSchnorrAlgorithm with CandidSerializable {
  const ICSchnorrAlgorithm();

  static CType get ctype => CType.variant([
    Field(Label.named('bip340secp256k1'), CType.null_),
    Field(Label.named('ed25519'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICSchnorrAlgorithm.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('bip340secp256k1')) {
      return const ICSchnorrAlgorithmBip340secp256k1();
    }
    if (json.containsKey('ed25519')) {
      return const ICSchnorrAlgorithmEd25519();
    }

    throw OnChainErrors.icpCandid(
      'ICSchnorrAlgorithm.fromCandid',
      reason: 'Unknown ICSchnorrAlgorithm arm',
    );
  }

  factory ICSchnorrAlgorithm.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSchnorrAlgorithm.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `schnorr_algorithm.bip340secp256k1` (nullary).
final class ICSchnorrAlgorithmBip340secp256k1 extends ICSchnorrAlgorithm {
  const ICSchnorrAlgorithmBip340secp256k1();

  @override
  CType get candidType => ICSchnorrAlgorithm.ctype;

  @override
  dynamic get candidValue => const Variant('bip340secp256k1', null);

  @override
  Map<String, dynamic> toJson() => {'bip340secp256k1': null};
}

/// Variant arm `schnorr_algorithm.ed25519` (nullary).
final class ICSchnorrAlgorithmEd25519 extends ICSchnorrAlgorithm {
  const ICSchnorrAlgorithmEd25519();

  @override
  CType get candidType => ICSchnorrAlgorithm.ctype;

  @override
  dynamic get candidValue => const Variant('ed25519', null);

  @override
  Map<String, dynamic> toJson() => {'ed25519': null};
}

/// Candid variant `bitcoin_network`.
sealed class ICBitcoinNetwork with CandidSerializable {
  const ICBitcoinNetwork();

  static CType get ctype => CType.variant([
    Field(Label.named('mainnet'), CType.null_),
    Field(Label.named('testnet'), CType.null_),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICBitcoinNetwork.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('mainnet')) {
      return const ICBitcoinNetworkMainnet();
    }
    if (json.containsKey('testnet')) {
      return const ICBitcoinNetworkTestnet();
    }

    throw OnChainErrors.icpCandid(
      'ICBitcoinNetwork.fromCandid',
      reason: 'Unknown ICBitcoinNetwork arm',
    );
  }

  factory ICBitcoinNetwork.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinNetwork.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `bitcoin_network.mainnet` (nullary).
final class ICBitcoinNetworkMainnet extends ICBitcoinNetwork {
  const ICBitcoinNetworkMainnet();

  @override
  CType get candidType => ICBitcoinNetwork.ctype;

  @override
  dynamic get candidValue => const Variant('mainnet', null);

  @override
  Map<String, dynamic> toJson() => {'mainnet': null};
}

/// Variant arm `bitcoin_network.testnet` (nullary).
final class ICBitcoinNetworkTestnet extends ICBitcoinNetwork {
  const ICBitcoinNetworkTestnet();

  @override
  CType get candidType => ICBitcoinNetwork.ctype;

  @override
  dynamic get candidValue => const Variant('testnet', null);

  @override
  Map<String, dynamic> toJson() => {'testnet': null};
}

/// Candid record `outpoint`.
final class ICOutpoint with CandidSerializable {
  final List<int> txid;
  final int vout;

  const ICOutpoint({required this.txid, required this.vout});

  static CType get ctype => CType.record([
    Field(Label.named('txid'), CType.vec(CType.nat8)),
    Field(Label.named('vout'), CType.nat32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'txid': txid, 'vout': vout};

  Map<String, dynamic> toJson() => {'txid': txid, 'vout': vout};

  factory ICOutpoint.fromCandid(Map<String, dynamic> json) {
    return ICOutpoint(
      txid: json.valueAsBytes<List<int>>(
        'txid',
        encoding: StringEncoding.base64,
      ),
      vout: json.valueAsInt<int>('vout'),
    );
  }

  factory ICOutpoint.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICOutpoint.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `utxo`.
final class ICUtxo with CandidSerializable {
  final ICOutpoint outpoint;
  final ICSatoshi value;
  final int height;

  const ICUtxo({
    required this.outpoint,
    required this.value,
    required this.height,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('outpoint'), () => ICOutpoint.ctype),
    Field(Label.named('value'), CType.nat64),
    Field(Label.named('height'), CType.nat32),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'outpoint': outpoint.candidValue,
    'value': value,
    'height': height,
  };

  Map<String, dynamic> toJson() => {
    'outpoint': outpoint.toJson(),
    'value': value,
    'height': height,
  };

  factory ICUtxo.fromCandid(Map<String, dynamic> json) {
    return ICUtxo(
      outpoint: json.valueTo<ICOutpoint, Map>(
        key: 'outpoint',
        parse:
            (e) => ICOutpoint.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      value: json.valueAsBigInt<BigInt>('value'),
      height: json.valueAsInt<int>('height'),
    );
  }

  factory ICUtxo.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUtxo.fromCandid(JsonParser.valueEnsureAsMap<String, dynamic>(raw));
  }
}

/// Candid record `bitcoin_get_utxos_args`.
final class ICBitcoinGetUtxosArgs with CandidSerializable {
  final ICBitcoinAddress address;
  final ICBitcoinNetwork network;
  final ICBitcoinGetUtxosArgsFilter? filter;

  const ICBitcoinGetUtxosArgs({
    required this.address,
    required this.network,
    this.filter,
  });

  static CType get ctype => CType.record([
    Field(Label.named('address'), CType.text),
    LazyField(Label.named('network'), () => ICBitcoinNetwork.ctype),
    LazyField(
      Label.named('filter'),
      () => CType.opt(ICBitcoinGetUtxosArgsFilter.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'address': address,
    'network': network.candidValue,
    'filter': filter?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'address': address,
    'network': network.toJson(),
    'filter': filter?.toJson(),
  };

  factory ICBitcoinGetUtxosArgs.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinGetUtxosArgs(
      address: json.valueAsString<String>('address'),
      network: json.valueTo<ICBitcoinNetwork, Map>(
        key: 'network',
        parse:
            (e) => ICBitcoinNetwork.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      filter: json.valueTo<ICBitcoinGetUtxosArgsFilter?, Map>(
        key: 'filter',
        parse:
            (e) => ICBitcoinGetUtxosArgsFilter.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICBitcoinGetUtxosArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetUtxosArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_get_utxos_result`.
final class ICBitcoinGetUtxosResult with CandidSerializable {
  final List<ICUtxo> utxos;
  final ICBitcoinBlockHash tipBlockHash;
  final ICBitcoinBlockHeight tipHeight;
  final List<int>? nextPage;

  const ICBitcoinGetUtxosResult({
    required this.utxos,
    required this.tipBlockHash,
    required this.tipHeight,
    this.nextPage,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('utxos'), () => CType.vec(ICUtxo.ctype)),
    Field(Label.named('tip_block_hash'), CType.vec(CType.nat8)),
    Field(Label.named('tip_height'), CType.nat32),
    Field(Label.named('next_page'), CType.opt(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'utxos': utxos.map((el) => el.candidValue).toList(),
    'tip_block_hash': tipBlockHash,
    'tip_height': tipHeight,
    'next_page': nextPage,
  };

  Map<String, dynamic> toJson() => {
    'utxos': utxos.map((el) => el.toJson()).toList(),
    'tip_block_hash': tipBlockHash,
    'tip_height': tipHeight,
    'next_page': nextPage,
  };

  factory ICBitcoinGetUtxosResult.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinGetUtxosResult(
      utxos: json.valueTo<List<ICUtxo>, List>(
        key: 'utxos',
        parse:
            (e) =>
                e
                    .map<ICUtxo>(
                      (x) => ICUtxo.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      tipBlockHash: json.valueAsBytes<List<int>>(
        'tip_block_hash',
        encoding: StringEncoding.base64,
      ),
      tipHeight: json.valueAsInt<int>('tip_height'),
      nextPage: json.valueAsBytes<List<int>?>(
        'next_page',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICBitcoinGetUtxosResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetUtxosResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_get_balance_args`.
final class ICBitcoinGetBalanceArgs with CandidSerializable {
  final ICBitcoinAddress address;
  final ICBitcoinNetwork network;
  final int? minConfirmations;

  const ICBitcoinGetBalanceArgs({
    required this.address,
    required this.network,
    this.minConfirmations,
  });

  static CType get ctype => CType.record([
    Field(Label.named('address'), CType.text),
    LazyField(Label.named('network'), () => ICBitcoinNetwork.ctype),
    Field(Label.named('min_confirmations'), CType.opt(CType.nat32)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'address': address,
    'network': network.candidValue,
    'min_confirmations': minConfirmations,
  };

  Map<String, dynamic> toJson() => {
    'address': address,
    'network': network.toJson(),
    'min_confirmations': minConfirmations,
  };

  factory ICBitcoinGetBalanceArgs.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinGetBalanceArgs(
      address: json.valueAsString<String>('address'),
      network: json.valueTo<ICBitcoinNetwork, Map>(
        key: 'network',
        parse:
            (e) => ICBitcoinNetwork.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      minConfirmations: json.valueAsInt<int?>('min_confirmations'),
    );
  }

  factory ICBitcoinGetBalanceArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetBalanceArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_get_current_fee_percentiles_args`.
final class ICBitcoinGetCurrentFeePercentilesArgs with CandidSerializable {
  final ICBitcoinNetwork network;

  const ICBitcoinGetCurrentFeePercentilesArgs({required this.network});

  static CType get ctype => CType.record([
    LazyField(Label.named('network'), () => ICBitcoinNetwork.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'network': network.candidValue};

  Map<String, dynamic> toJson() => {'network': network.toJson()};

  factory ICBitcoinGetCurrentFeePercentilesArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICBitcoinGetCurrentFeePercentilesArgs(
      network: json.valueTo<ICBitcoinNetwork, Map>(
        key: 'network',
        parse:
            (e) => ICBitcoinNetwork.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICBitcoinGetCurrentFeePercentilesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetCurrentFeePercentilesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_send_transaction_args`.
final class ICBitcoinSendTransactionArgs with CandidSerializable {
  final List<int> transaction;
  final ICBitcoinNetwork network;

  const ICBitcoinSendTransactionArgs({
    required this.transaction,
    required this.network,
  });

  static CType get ctype => CType.record([
    Field(Label.named('transaction'), CType.vec(CType.nat8)),
    LazyField(Label.named('network'), () => ICBitcoinNetwork.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'transaction': transaction,
    'network': network.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'transaction': transaction,
    'network': network.toJson(),
  };

  factory ICBitcoinSendTransactionArgs.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinSendTransactionArgs(
      transaction: json.valueAsBytes<List<int>>(
        'transaction',
        encoding: StringEncoding.base64,
      ),
      network: json.valueTo<ICBitcoinNetwork, Map>(
        key: 'network',
        parse:
            (e) => ICBitcoinNetwork.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICBitcoinSendTransactionArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinSendTransactionArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_get_block_headers_args`.
final class ICBitcoinGetBlockHeadersArgs with CandidSerializable {
  final ICBitcoinBlockHeight startHeight;
  final ICBitcoinBlockHeight? endHeight;
  final ICBitcoinNetwork network;

  const ICBitcoinGetBlockHeadersArgs({
    required this.startHeight,
    this.endHeight,
    required this.network,
  });

  static CType get ctype => CType.record([
    Field(Label.named('start_height'), CType.nat32),
    Field(Label.named('end_height'), CType.opt(CType.nat32)),
    LazyField(Label.named('network'), () => ICBitcoinNetwork.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'start_height': startHeight,
    'end_height': endHeight,
    'network': network.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'start_height': startHeight,
    'end_height': endHeight,
    'network': network.toJson(),
  };

  factory ICBitcoinGetBlockHeadersArgs.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinGetBlockHeadersArgs(
      startHeight: json.valueAsInt<int>('start_height'),
      endHeight: json.valueAsInt<int?>('end_height'),
      network: json.valueTo<ICBitcoinNetwork, Map>(
        key: 'network',
        parse:
            (e) => ICBitcoinNetwork.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICBitcoinGetBlockHeadersArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetBlockHeadersArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `bitcoin_get_block_headers_result`.
final class ICBitcoinGetBlockHeadersResult with CandidSerializable {
  final ICBitcoinBlockHeight tipHeight;
  final List<int> blockHeaders;

  const ICBitcoinGetBlockHeadersResult({
    required this.tipHeight,
    required this.blockHeaders,
  });

  static CType get ctype => CType.record([
    Field(Label.named('tip_height'), CType.nat32),
    Field(Label.named('block_headers'), CType.vec(CType.vec(CType.nat8))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'tip_height': tipHeight,
    'block_headers': blockHeaders,
  };

  Map<String, dynamic> toJson() => {
    'tip_height': tipHeight,
    'block_headers': blockHeaders,
  };

  factory ICBitcoinGetBlockHeadersResult.fromCandid(Map<String, dynamic> json) {
    return ICBitcoinGetBlockHeadersResult(
      tipHeight: json.valueAsInt<int>('tip_height'),
      blockHeaders: json.valueAsBytes<List<int>>(
        'block_headers',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICBitcoinGetBlockHeadersResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICBitcoinGetBlockHeadersResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `node_metrics`.
final class ICNodeMetrics with CandidSerializable {
  final IcpPrincipalAddress nodeId;
  final BigInt numBlocksProposedTotal;
  final BigInt numBlockFailuresTotal;

  const ICNodeMetrics({
    required this.nodeId,
    required this.numBlocksProposedTotal,
    required this.numBlockFailuresTotal,
  });

  static CType get ctype => CType.record([
    Field(Label.named('node_id'), CType.principal),
    Field(Label.named('num_blocks_proposed_total'), CType.nat64),
    Field(Label.named('num_block_failures_total'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'node_id': nodeId,
    'num_blocks_proposed_total': numBlocksProposedTotal,
    'num_block_failures_total': numBlockFailuresTotal,
  };

  Map<String, dynamic> toJson() => {
    'node_id': nodeId.address,
    'num_blocks_proposed_total': numBlocksProposedTotal,
    'num_block_failures_total': numBlockFailuresTotal,
  };

  factory ICNodeMetrics.fromCandid(Map<String, dynamic> json) {
    return ICNodeMetrics(
      nodeId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'node_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      numBlocksProposedTotal: json.valueAsBigInt<BigInt>(
        'num_blocks_proposed_total',
      ),
      numBlockFailuresTotal: json.valueAsBigInt<BigInt>(
        'num_block_failures_total',
      ),
    );
  }

  factory ICNodeMetrics.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICNodeMetrics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `create_canister_args`.
final class ICCreateCanisterArgs with CandidSerializable {
  final ICCanisterSettings? settings;
  final BigInt? senderCanisterVersion;

  const ICCreateCanisterArgs({this.settings, this.senderCanisterVersion});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('settings'),
      () => CType.opt(ICCanisterSettings.ctype),
    ),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'settings': settings?.candidValue,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'settings': settings?.toJson(),
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICCreateCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return ICCreateCanisterArgs(
      settings: json.valueTo<ICCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => ICCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICCreateCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCreateCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `create_canister_result`.
final class ICCreateCanisterResult with CandidSerializable {
  final ICCanisterId canisterId;

  const ICCreateCanisterResult({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICCreateCanisterResult.fromCandid(Map<String, dynamic> json) {
    return ICCreateCanisterResult(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICCreateCanisterResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCreateCanisterResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `update_settings_args`.
final class ICUpdateSettingsArgs with CandidSerializable {
  final IcpPrincipalAddress canisterId;
  final ICCanisterSettings settings;
  final BigInt? senderCanisterVersion;

  const ICUpdateSettingsArgs({
    required this.canisterId,
    required this.settings,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    LazyField(Label.named('settings'), () => ICCanisterSettings.ctype),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'settings': settings.candidValue,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'settings': settings.toJson(),
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICUpdateSettingsArgs.fromCandid(Map<String, dynamic> json) {
    return ICUpdateSettingsArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      settings: json.valueTo<ICCanisterSettings, Map>(
        key: 'settings',
        parse:
            (e) => ICCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICUpdateSettingsArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUpdateSettingsArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `upload_chunk_args`.
final class ICUploadChunkArgs with CandidSerializable {
  final IcpPrincipalAddress canisterId;
  final List<int> chunk;

  const ICUploadChunkArgs({required this.canisterId, required this.chunk});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('chunk'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId, 'chunk': chunk};

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'chunk': chunk,
  };

  factory ICUploadChunkArgs.fromCandid(Map<String, dynamic> json) {
    return ICUploadChunkArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      chunk: json.valueAsBytes<List<int>>(
        'chunk',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICUploadChunkArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUploadChunkArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `clear_chunk_store_args`.
final class ICClearChunkStoreArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICClearChunkStoreArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICClearChunkStoreArgs.fromCandid(Map<String, dynamic> json) {
    return ICClearChunkStoreArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICClearChunkStoreArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICClearChunkStoreArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `stored_chunks_args`.
final class ICStoredChunksArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICStoredChunksArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICStoredChunksArgs.fromCandid(Map<String, dynamic> json) {
    return ICStoredChunksArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICStoredChunksArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICStoredChunksArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `canister_install_mode`.
sealed class ICCanisterInstallMode with CandidSerializable {
  const ICCanisterInstallMode();

  static CType get ctype => CType.variant([
    Field(Label.named('install'), CType.null_),
    Field(Label.named('reinstall'), CType.null_),
    LazyField(
      Label.named('upgrade'),
      () => CType.opt(ICCanisterInstallModeUpgradePayload.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICCanisterInstallMode.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('install')) {
      return const ICCanisterInstallModeInstall();
    }
    if (json.containsKey('reinstall')) {
      return const ICCanisterInstallModeReinstall();
    }
    if (json.containsKey('upgrade')) {
      final raw = json['upgrade'];
      return ICCanisterInstallModeUpgrade(
        raw == null
            ? null
            : ICCanisterInstallModeUpgradePayload.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(raw),
            ),
      );
    }

    throw OnChainErrors.icpCandid(
      'ICCanisterInstallMode.fromCandid',
      reason: 'Unknown ICCanisterInstallMode arm',
    );
  }

  factory ICCanisterInstallMode.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterInstallMode.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `canister_install_mode.install` (nullary).
final class ICCanisterInstallModeInstall extends ICCanisterInstallMode {
  const ICCanisterInstallModeInstall();

  @override
  CType get candidType => ICCanisterInstallMode.ctype;

  @override
  dynamic get candidValue => const Variant('install', null);

  @override
  Map<String, dynamic> toJson() => {'install': null};
}

/// Variant arm `canister_install_mode.reinstall` (nullary).
final class ICCanisterInstallModeReinstall extends ICCanisterInstallMode {
  const ICCanisterInstallModeReinstall();

  @override
  CType get candidType => ICCanisterInstallMode.ctype;

  @override
  dynamic get candidValue => const Variant('reinstall', null);

  @override
  Map<String, dynamic> toJson() => {'reinstall': null};
}

/// Variant arm `canister_install_mode.upgrade` (`opt record`).
final class ICCanisterInstallModeUpgrade extends ICCanisterInstallMode {
  final ICCanisterInstallModeUpgradePayload? value;
  const ICCanisterInstallModeUpgrade([this.value]);

  @override
  CType get candidType => ICCanisterInstallMode.ctype;

  @override
  dynamic get candidValue => Variant('upgrade', value?.candidValue);

  @override
  Map<String, dynamic> toJson() => {'upgrade': value?.toJson()};
}

/// Candid record `install_code_args`.
final class ICInstallCodeArgs with CandidSerializable {
  final ICCanisterInstallMode mode;
  final ICCanisterId canisterId;
  final ICWasmModule wasmModule;
  final List<int> arg;
  final BigInt? senderCanisterVersion;

  const ICInstallCodeArgs({
    required this.mode,
    required this.canisterId,
    required this.wasmModule,
    required this.arg,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('mode'), () => ICCanisterInstallMode.ctype),
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('wasm_module'), CType.vec(CType.nat8)),
    Field(Label.named('arg'), CType.vec(CType.nat8)),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'mode': mode.candidValue,
    'canister_id': canisterId,
    'wasm_module': wasmModule,
    'arg': arg,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'mode': mode.toJson(),
    'canister_id': canisterId.address,
    'wasm_module': wasmModule,
    'arg': arg,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICInstallCodeArgs.fromCandid(Map<String, dynamic> json) {
    return ICInstallCodeArgs(
      mode: json.valueTo<ICCanisterInstallMode, Map>(
        key: 'mode',
        parse:
            (e) => ICCanisterInstallMode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      wasmModule: json.valueAsBytes<List<int>>(
        'wasm_module',
        encoding: StringEncoding.base64,
      ),
      arg: json.valueAsBytes<List<int>>('arg', encoding: StringEncoding.base64),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICInstallCodeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICInstallCodeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `install_chunked_code_args`.
final class ICInstallChunkedCodeArgs with CandidSerializable {
  final ICCanisterInstallMode mode;
  final ICCanisterId targetCanister;
  final ICCanisterId? storeCanister;
  final List<ICChunkHash> chunkHashesList;
  final List<int> wasmModuleHash;
  final List<int> arg;
  final BigInt? senderCanisterVersion;

  const ICInstallChunkedCodeArgs({
    required this.mode,
    required this.targetCanister,
    this.storeCanister,
    required this.chunkHashesList,
    required this.wasmModuleHash,
    required this.arg,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('mode'), () => ICCanisterInstallMode.ctype),
    Field(Label.named('target_canister'), CType.principal),
    Field(Label.named('store_canister'), CType.opt(CType.principal)),
    LazyField(
      Label.named('chunk_hashes_list'),
      () => CType.vec(ICChunkHash.ctype),
    ),
    Field(Label.named('wasm_module_hash'), CType.vec(CType.nat8)),
    Field(Label.named('arg'), CType.vec(CType.nat8)),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'mode': mode.candidValue,
    'target_canister': targetCanister,
    'store_canister': storeCanister,
    'chunk_hashes_list': chunkHashesList.map((el) => el.candidValue).toList(),
    'wasm_module_hash': wasmModuleHash,
    'arg': arg,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'mode': mode.toJson(),
    'target_canister': targetCanister.address,
    'store_canister': storeCanister?.address,
    'chunk_hashes_list': chunkHashesList.map((el) => el.toJson()).toList(),
    'wasm_module_hash': wasmModuleHash,
    'arg': arg,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICInstallChunkedCodeArgs.fromCandid(Map<String, dynamic> json) {
    return ICInstallChunkedCodeArgs(
      mode: json.valueTo<ICCanisterInstallMode, Map>(
        key: 'mode',
        parse:
            (e) => ICCanisterInstallMode.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      targetCanister: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'target_canister',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      storeCanister: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'store_canister',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      chunkHashesList: json.valueTo<List<ICChunkHash>, List>(
        key: 'chunk_hashes_list',
        parse:
            (e) =>
                e
                    .map<ICChunkHash>(
                      (x) => ICChunkHash.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      wasmModuleHash: json.valueAsBytes<List<int>>(
        'wasm_module_hash',
        encoding: StringEncoding.base64,
      ),
      arg: json.valueAsBytes<List<int>>('arg', encoding: StringEncoding.base64),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICInstallChunkedCodeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICInstallChunkedCodeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `uninstall_code_args`.
final class ICUninstallCodeArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final BigInt? senderCanisterVersion;

  const ICUninstallCodeArgs({
    required this.canisterId,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICUninstallCodeArgs.fromCandid(Map<String, dynamic> json) {
    return ICUninstallCodeArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICUninstallCodeArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUninstallCodeArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `start_canister_args`.
final class ICStartCanisterArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICStartCanisterArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICStartCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return ICStartCanisterArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICStartCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICStartCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `stop_canister_args`.
final class ICStopCanisterArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICStopCanisterArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICStopCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return ICStopCanisterArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICStopCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICStopCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_status_args`.
final class ICCanisterStatusArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICCanisterStatusArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICCanisterStatusArgs.fromCandid(Map<String, dynamic> json) {
    return ICCanisterStatusArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICCanisterStatusArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterStatusArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_status_result`.
final class ICCanisterStatusResult with CandidSerializable {
  final ICCanisterStatusResultStatus status;
  final bool readyForMigration;
  final BigInt version;
  final ICDefiniteCanisterSettings settings;
  final List<int>? moduleHash;
  final BigInt memorySize;
  final ICCanisterStatusResultMemoryMetrics memoryMetrics;
  final BigInt cycles;
  final BigInt reservedCycles;
  final BigInt idleCyclesBurnedPerDay;
  final ICCanisterStatusResultQueryStats queryStats;

  const ICCanisterStatusResult({
    required this.status,
    required this.readyForMigration,
    required this.version,
    required this.settings,
    this.moduleHash,
    required this.memorySize,
    required this.memoryMetrics,
    required this.cycles,
    required this.reservedCycles,
    required this.idleCyclesBurnedPerDay,
    required this.queryStats,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('status'), () => ICCanisterStatusResultStatus.ctype),
    Field(Label.named('ready_for_migration'), CType.bool_),
    Field(Label.named('version'), CType.nat64),
    LazyField(Label.named('settings'), () => ICDefiniteCanisterSettings.ctype),
    Field(Label.named('module_hash'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('memory_size'), CType.nat),
    LazyField(
      Label.named('memory_metrics'),
      () => ICCanisterStatusResultMemoryMetrics.ctype,
    ),
    Field(Label.named('cycles'), CType.nat),
    Field(Label.named('reserved_cycles'), CType.nat),
    Field(Label.named('idle_cycles_burned_per_day'), CType.nat),
    LazyField(
      Label.named('query_stats'),
      () => ICCanisterStatusResultQueryStats.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'status': status.candidValue,
    'ready_for_migration': readyForMigration,
    'version': version,
    'settings': settings.candidValue,
    'module_hash': moduleHash,
    'memory_size': memorySize,
    'memory_metrics': memoryMetrics.candidValue,
    'cycles': cycles,
    'reserved_cycles': reservedCycles,
    'idle_cycles_burned_per_day': idleCyclesBurnedPerDay,
    'query_stats': queryStats.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'status': status.toJson(),
    'ready_for_migration': readyForMigration,
    'version': version,
    'settings': settings.toJson(),
    'module_hash': moduleHash,
    'memory_size': memorySize,
    'memory_metrics': memoryMetrics.toJson(),
    'cycles': cycles,
    'reserved_cycles': reservedCycles,
    'idle_cycles_burned_per_day': idleCyclesBurnedPerDay,
    'query_stats': queryStats.toJson(),
  };

  factory ICCanisterStatusResult.fromCandid(Map<String, dynamic> json) {
    return ICCanisterStatusResult(
      status: json.valueTo<ICCanisterStatusResultStatus, Map>(
        key: 'status',
        parse:
            (e) => ICCanisterStatusResultStatus.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      readyForMigration: json.valueAsBool<bool>('ready_for_migration'),
      version: json.valueAsBigInt<BigInt>('version'),
      settings: json.valueTo<ICDefiniteCanisterSettings, Map>(
        key: 'settings',
        parse:
            (e) => ICDefiniteCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      moduleHash: json.valueAsBytes<List<int>?>(
        'module_hash',
        encoding: StringEncoding.base64,
      ),
      memorySize: json.valueAsBigInt<BigInt>('memory_size'),
      memoryMetrics: json.valueTo<ICCanisterStatusResultMemoryMetrics, Map>(
        key: 'memory_metrics',
        parse:
            (e) => ICCanisterStatusResultMemoryMetrics.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      cycles: json.valueAsBigInt<BigInt>('cycles'),
      reservedCycles: json.valueAsBigInt<BigInt>('reserved_cycles'),
      idleCyclesBurnedPerDay: json.valueAsBigInt<BigInt>(
        'idle_cycles_burned_per_day',
      ),
      queryStats: json.valueTo<ICCanisterStatusResultQueryStats, Map>(
        key: 'query_stats',
        parse:
            (e) => ICCanisterStatusResultQueryStats.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICCanisterStatusResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterStatusResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_info_args`.
final class ICCanisterInfoArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final BigInt? numRequestedChanges;

  const ICCanisterInfoArgs({
    required this.canisterId,
    this.numRequestedChanges,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('num_requested_changes'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'num_requested_changes': numRequestedChanges,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'num_requested_changes': numRequestedChanges,
  };

  factory ICCanisterInfoArgs.fromCandid(Map<String, dynamic> json) {
    return ICCanisterInfoArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      numRequestedChanges: json.valueAsBigInt<BigInt?>('num_requested_changes'),
    );
  }

  factory ICCanisterInfoArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterInfoArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_info_result`.
final class ICCanisterInfoResult with CandidSerializable {
  final BigInt totalNumChanges;
  final List<ICChange> recentChanges;
  final List<int>? moduleHash;
  final List<IcpPrincipalAddress> controllers;

  const ICCanisterInfoResult({
    required this.totalNumChanges,
    required this.recentChanges,
    this.moduleHash,
    required this.controllers,
  });

  static CType get ctype => CType.record([
    Field(Label.named('total_num_changes'), CType.nat64),
    LazyField(Label.named('recent_changes'), () => CType.vec(ICChange.ctype)),
    Field(Label.named('module_hash'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('controllers'), CType.vec(CType.principal)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'total_num_changes': totalNumChanges,
    'recent_changes': recentChanges.map((el) => el.candidValue).toList(),
    'module_hash': moduleHash,
    'controllers': controllers,
  };

  Map<String, dynamic> toJson() => {
    'total_num_changes': totalNumChanges,
    'recent_changes': recentChanges.map((el) => el.toJson()).toList(),
    'module_hash': moduleHash,
    'controllers': controllers.map((el) => el.address).toList(),
  };

  factory ICCanisterInfoResult.fromCandid(Map<String, dynamic> json) {
    return ICCanisterInfoResult(
      totalNumChanges: json.valueAsBigInt<BigInt>('total_num_changes'),
      recentChanges: json.valueTo<List<ICChange>, List>(
        key: 'recent_changes',
        parse:
            (e) =>
                e
                    .map<ICChange>(
                      (x) => ICChange.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      moduleHash: json.valueAsBytes<List<int>?>(
        'module_hash',
        encoding: StringEncoding.base64,
      ),
      controllers: json.valueTo<List<IcpPrincipalAddress>, List>(
        key: 'controllers',
        parse:
            (e) =>
                e
                    .map<IcpPrincipalAddress>(
                      (x) => GeneratorParserUtils.principalFromCandid(x),
                    )
                    .toList(),
      ),
    );
  }

  factory ICCanisterInfoResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterInfoResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_metadata_args`.
final class ICCanisterMetadataArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final String name;

  const ICCanisterMetadataArgs({required this.canisterId, required this.name});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('name'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId, 'name': name};

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'name': name,
  };

  factory ICCanisterMetadataArgs.fromCandid(Map<String, dynamic> json) {
    return ICCanisterMetadataArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      name: json.valueAsString<String>('name'),
    );
  }

  factory ICCanisterMetadataArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterMetadataArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_metadata_result`.
final class ICCanisterMetadataResult with CandidSerializable {
  final List<int> value;

  const ICCanisterMetadataResult({required this.value});

  static CType get ctype =>
      CType.record([Field(Label.named('value'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'value': value};

  Map<String, dynamic> toJson() => {'value': value};

  factory ICCanisterMetadataResult.fromCandid(Map<String, dynamic> json) {
    return ICCanisterMetadataResult(
      value: json.valueAsBytes<List<int>>(
        'value',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICCanisterMetadataResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterMetadataResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `delete_canister_args`.
final class ICDeleteCanisterArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICDeleteCanisterArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICDeleteCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return ICDeleteCanisterArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICDeleteCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICDeleteCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `deposit_cycles_args`.
final class ICDepositCyclesArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICDepositCyclesArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICDepositCyclesArgs.fromCandid(Map<String, dynamic> json) {
    return ICDepositCyclesArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICDepositCyclesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICDepositCyclesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `http_request_args`.
final class ICHttpRequestArgs with CandidSerializable {
  final String url;
  final BigInt? maxResponseBytes;
  final ICHttpRequestArgsMethod method;
  final List<ICHttpHeader> headers;
  final List<int>? body;
  final ICHttpRequestArgsTransform? transform;
  final bool? isReplicated;

  const ICHttpRequestArgs({
    required this.url,
    this.maxResponseBytes,
    required this.method,
    required this.headers,
    this.body,
    this.transform,
    this.isReplicated,
  });

  static CType get ctype => CType.record([
    Field(Label.named('url'), CType.text),
    Field(Label.named('max_response_bytes'), CType.opt(CType.nat64)),
    LazyField(Label.named('method'), () => ICHttpRequestArgsMethod.ctype),
    LazyField(Label.named('headers'), () => CType.vec(ICHttpHeader.ctype)),
    Field(Label.named('body'), CType.opt(CType.vec(CType.nat8))),
    LazyField(
      Label.named('transform'),
      () => CType.opt(ICHttpRequestArgsTransform.ctype),
    ),
    Field(Label.named('is_replicated'), CType.opt(CType.bool_)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'url': url,
    'max_response_bytes': maxResponseBytes,
    'method': method.candidValue,
    'headers': headers.map((el) => el.candidValue).toList(),
    'body': body,
    'transform': transform?.candidValue,
    'is_replicated': isReplicated,
  };

  Map<String, dynamic> toJson() => {
    'url': url,
    'max_response_bytes': maxResponseBytes,
    'method': method.toJson(),
    'headers': headers.map((el) => el.toJson()).toList(),
    'body': body,
    'transform': transform?.toJson(),
    'is_replicated': isReplicated,
  };

  factory ICHttpRequestArgs.fromCandid(Map<String, dynamic> json) {
    return ICHttpRequestArgs(
      url: json.valueAsString<String>('url'),
      maxResponseBytes: json.valueAsBigInt<BigInt?>('max_response_bytes'),
      method: json.valueTo<ICHttpRequestArgsMethod, Map>(
        key: 'method',
        parse:
            (e) => ICHttpRequestArgsMethod.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      headers: json.valueTo<List<ICHttpHeader>, List>(
        key: 'headers',
        parse:
            (e) =>
                e
                    .map<ICHttpHeader>(
                      (x) => ICHttpHeader.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      body: json.valueAsBytes<List<int>?>(
        'body',
        encoding: StringEncoding.base64,
      ),
      transform: json.valueTo<ICHttpRequestArgsTransform?, Map>(
        key: 'transform',
        parse:
            (e) => ICHttpRequestArgsTransform.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      isReplicated: json.valueAsBool<bool?>('is_replicated'),
    );
  }

  factory ICHttpRequestArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICHttpRequestArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ecdsa_public_key_args`.
final class ICEcdsaPublicKeyArgs with CandidSerializable {
  final ICCanisterId? canisterId;
  final List<int> derivationPath;
  final ICEcdsaPublicKeyArgsKeyId keyId;

  const ICEcdsaPublicKeyArgs({
    this.canisterId,
    required this.derivationPath,
    required this.keyId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('derivation_path'), CType.vec(CType.vec(CType.nat8))),
    LazyField(Label.named('key_id'), () => ICEcdsaPublicKeyArgsKeyId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'derivation_path': derivationPath,
    'key_id': keyId.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'derivation_path': derivationPath,
    'key_id': keyId.toJson(),
  };

  factory ICEcdsaPublicKeyArgs.fromCandid(Map<String, dynamic> json) {
    return ICEcdsaPublicKeyArgs(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      derivationPath: json.valueAsBytes<List<int>>(
        'derivation_path',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICEcdsaPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICEcdsaPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICEcdsaPublicKeyArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICEcdsaPublicKeyArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ecdsa_public_key_result`.
final class ICEcdsaPublicKeyResult with CandidSerializable {
  final List<int> publicKey;
  final List<int> chainCode;

  const ICEcdsaPublicKeyResult({
    required this.publicKey,
    required this.chainCode,
  });

  static CType get ctype => CType.record([
    Field(Label.named('public_key'), CType.vec(CType.nat8)),
    Field(Label.named('chain_code'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'public_key': publicKey, 'chain_code': chainCode};

  Map<String, dynamic> toJson() => {
    'public_key': publicKey,
    'chain_code': chainCode,
  };

  factory ICEcdsaPublicKeyResult.fromCandid(Map<String, dynamic> json) {
    return ICEcdsaPublicKeyResult(
      publicKey: json.valueAsBytes<List<int>>(
        'public_key',
        encoding: StringEncoding.base64,
      ),
      chainCode: json.valueAsBytes<List<int>>(
        'chain_code',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICEcdsaPublicKeyResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICEcdsaPublicKeyResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `sign_with_ecdsa_args`.
final class ICSignWithEcdsaArgs with CandidSerializable {
  final List<int> messageHash;
  final List<int> derivationPath;
  final ICEcdsaPublicKeyArgsKeyId keyId;

  const ICSignWithEcdsaArgs({
    required this.messageHash,
    required this.derivationPath,
    required this.keyId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('message_hash'), CType.vec(CType.nat8)),
    Field(Label.named('derivation_path'), CType.vec(CType.vec(CType.nat8))),
    LazyField(Label.named('key_id'), () => ICEcdsaPublicKeyArgsKeyId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'message_hash': messageHash,
    'derivation_path': derivationPath,
    'key_id': keyId.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'message_hash': messageHash,
    'derivation_path': derivationPath,
    'key_id': keyId.toJson(),
  };

  factory ICSignWithEcdsaArgs.fromCandid(Map<String, dynamic> json) {
    return ICSignWithEcdsaArgs(
      messageHash: json.valueAsBytes<List<int>>(
        'message_hash',
        encoding: StringEncoding.base64,
      ),
      derivationPath: json.valueAsBytes<List<int>>(
        'derivation_path',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICEcdsaPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICEcdsaPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICSignWithEcdsaArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSignWithEcdsaArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `sign_with_ecdsa_result`.
final class ICSignWithEcdsaResult with CandidSerializable {
  final List<int> signature;

  const ICSignWithEcdsaResult({required this.signature});

  static CType get ctype =>
      CType.record([Field(Label.named('signature'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'signature': signature};

  Map<String, dynamic> toJson() => {'signature': signature};

  factory ICSignWithEcdsaResult.fromCandid(Map<String, dynamic> json) {
    return ICSignWithEcdsaResult(
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICSignWithEcdsaResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSignWithEcdsaResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `schnorr_public_key_args`.
final class ICSchnorrPublicKeyArgs with CandidSerializable {
  final ICCanisterId? canisterId;
  final List<int> derivationPath;
  final ICSchnorrPublicKeyArgsKeyId keyId;

  const ICSchnorrPublicKeyArgs({
    this.canisterId,
    required this.derivationPath,
    required this.keyId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('derivation_path'), CType.vec(CType.vec(CType.nat8))),
    LazyField(Label.named('key_id'), () => ICSchnorrPublicKeyArgsKeyId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'derivation_path': derivationPath,
    'key_id': keyId.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'derivation_path': derivationPath,
    'key_id': keyId.toJson(),
  };

  factory ICSchnorrPublicKeyArgs.fromCandid(Map<String, dynamic> json) {
    return ICSchnorrPublicKeyArgs(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      derivationPath: json.valueAsBytes<List<int>>(
        'derivation_path',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICSchnorrPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICSchnorrPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICSchnorrPublicKeyArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSchnorrPublicKeyArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `schnorr_public_key_result`.
final class ICSchnorrPublicKeyResult with CandidSerializable {
  final List<int> publicKey;
  final List<int> chainCode;

  const ICSchnorrPublicKeyResult({
    required this.publicKey,
    required this.chainCode,
  });

  static CType get ctype => CType.record([
    Field(Label.named('public_key'), CType.vec(CType.nat8)),
    Field(Label.named('chain_code'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'public_key': publicKey, 'chain_code': chainCode};

  Map<String, dynamic> toJson() => {
    'public_key': publicKey,
    'chain_code': chainCode,
  };

  factory ICSchnorrPublicKeyResult.fromCandid(Map<String, dynamic> json) {
    return ICSchnorrPublicKeyResult(
      publicKey: json.valueAsBytes<List<int>>(
        'public_key',
        encoding: StringEncoding.base64,
      ),
      chainCode: json.valueAsBytes<List<int>>(
        'chain_code',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICSchnorrPublicKeyResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSchnorrPublicKeyResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `schnorr_aux`.
sealed class ICSchnorrAux with CandidSerializable {
  const ICSchnorrAux();

  static CType get ctype => CType.variant([
    Field(
      Label.named('bip341'),
      CType.record([
        Field(Label.named('merkle_root_hash'), CType.vec(CType.nat8)),
      ]),
    ),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICSchnorrAux.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('bip341')) {
      return ICSchnorrAuxBip341.fromCandid(
        JsonParser.valueEnsureAsMap<String, dynamic>(json['bip341']),
      );
    }

    throw OnChainErrors.icpCandid(
      'ICSchnorrAux.fromCandid',
      reason: 'Unknown ICSchnorrAux arm',
    );
  }

  factory ICSchnorrAux.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSchnorrAux.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `schnorr_aux.bip341`.
final class ICSchnorrAuxBip341 extends ICSchnorrAux {
  final List<int> merkleRootHash;

  const ICSchnorrAuxBip341({required this.merkleRootHash});

  @override
  CType get candidType => ICSchnorrAux.ctype;

  @override
  dynamic get candidValue =>
      Variant('bip341', {'merkle_root_hash': merkleRootHash});

  @override
  Map<String, dynamic> toJson() => {
    'bip341': {'merkle_root_hash': merkleRootHash},
  };

  factory ICSchnorrAuxBip341.fromCandid(Map<String, dynamic> json) {
    return ICSchnorrAuxBip341(
      merkleRootHash: json.valueAsBytes<List<int>>(
        'merkle_root_hash',
        encoding: StringEncoding.base64,
      ),
    );
  }
}

/// Candid record `sign_with_schnorr_args`.
final class ICSignWithSchnorrArgs with CandidSerializable {
  final List<int> message;
  final List<int> derivationPath;
  final ICSchnorrPublicKeyArgsKeyId keyId;
  final ICSchnorrAux? aux;

  const ICSignWithSchnorrArgs({
    required this.message,
    required this.derivationPath,
    required this.keyId,
    this.aux,
  });

  static CType get ctype => CType.record([
    Field(Label.named('message'), CType.vec(CType.nat8)),
    Field(Label.named('derivation_path'), CType.vec(CType.vec(CType.nat8))),
    LazyField(Label.named('key_id'), () => ICSchnorrPublicKeyArgsKeyId.ctype),
    LazyField(Label.named('aux'), () => CType.opt(ICSchnorrAux.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'message': message,
    'derivation_path': derivationPath,
    'key_id': keyId.candidValue,
    'aux': aux?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'message': message,
    'derivation_path': derivationPath,
    'key_id': keyId.toJson(),
    'aux': aux?.toJson(),
  };

  factory ICSignWithSchnorrArgs.fromCandid(Map<String, dynamic> json) {
    return ICSignWithSchnorrArgs(
      message: json.valueAsBytes<List<int>>(
        'message',
        encoding: StringEncoding.base64,
      ),
      derivationPath: json.valueAsBytes<List<int>>(
        'derivation_path',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICSchnorrPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICSchnorrPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      aux: json.valueTo<ICSchnorrAux?, Map>(
        key: 'aux',
        parse:
            (e) => ICSchnorrAux.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICSignWithSchnorrArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSignWithSchnorrArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `sign_with_schnorr_result`.
final class ICSignWithSchnorrResult with CandidSerializable {
  final List<int> signature;

  const ICSignWithSchnorrResult({required this.signature});

  static CType get ctype =>
      CType.record([Field(Label.named('signature'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'signature': signature};

  Map<String, dynamic> toJson() => {'signature': signature};

  factory ICSignWithSchnorrResult.fromCandid(Map<String, dynamic> json) {
    return ICSignWithSchnorrResult(
      signature: json.valueAsBytes<List<int>>(
        'signature',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICSignWithSchnorrResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSignWithSchnorrResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `vetkd_public_key_args`.
final class ICVetkdPublicKeyArgs with CandidSerializable {
  final ICCanisterId? canisterId;
  final List<int> context;
  final ICVetkdPublicKeyArgsKeyId keyId;

  const ICVetkdPublicKeyArgs({
    this.canisterId,
    required this.context,
    required this.keyId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.opt(CType.principal)),
    Field(Label.named('context'), CType.vec(CType.nat8)),
    LazyField(Label.named('key_id'), () => ICVetkdPublicKeyArgsKeyId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'context': context,
    'key_id': keyId.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId?.address,
    'context': context,
    'key_id': keyId.toJson(),
  };

  factory ICVetkdPublicKeyArgs.fromCandid(Map<String, dynamic> json) {
    return ICVetkdPublicKeyArgs(
      canisterId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      context: json.valueAsBytes<List<int>>(
        'context',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICVetkdPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICVetkdPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICVetkdPublicKeyArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdPublicKeyArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `vetkd_public_key_result`.
final class ICVetkdPublicKeyResult with CandidSerializable {
  final List<int> publicKey;

  const ICVetkdPublicKeyResult({required this.publicKey});

  static CType get ctype =>
      CType.record([Field(Label.named('public_key'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'public_key': publicKey};

  Map<String, dynamic> toJson() => {'public_key': publicKey};

  factory ICVetkdPublicKeyResult.fromCandid(Map<String, dynamic> json) {
    return ICVetkdPublicKeyResult(
      publicKey: json.valueAsBytes<List<int>>(
        'public_key',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICVetkdPublicKeyResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdPublicKeyResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `vetkd_derive_key_args`.
final class ICVetkdDeriveKeyArgs with CandidSerializable {
  final List<int> input;
  final List<int> context;
  final List<int> transportPublicKey;
  final ICVetkdPublicKeyArgsKeyId keyId;

  const ICVetkdDeriveKeyArgs({
    required this.input,
    required this.context,
    required this.transportPublicKey,
    required this.keyId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('input'), CType.vec(CType.nat8)),
    Field(Label.named('context'), CType.vec(CType.nat8)),
    Field(Label.named('transport_public_key'), CType.vec(CType.nat8)),
    LazyField(Label.named('key_id'), () => ICVetkdPublicKeyArgsKeyId.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'input': input,
    'context': context,
    'transport_public_key': transportPublicKey,
    'key_id': keyId.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'input': input,
    'context': context,
    'transport_public_key': transportPublicKey,
    'key_id': keyId.toJson(),
  };

  factory ICVetkdDeriveKeyArgs.fromCandid(Map<String, dynamic> json) {
    return ICVetkdDeriveKeyArgs(
      input: json.valueAsBytes<List<int>>(
        'input',
        encoding: StringEncoding.base64,
      ),
      context: json.valueAsBytes<List<int>>(
        'context',
        encoding: StringEncoding.base64,
      ),
      transportPublicKey: json.valueAsBytes<List<int>>(
        'transport_public_key',
        encoding: StringEncoding.base64,
      ),
      keyId: json.valueTo<ICVetkdPublicKeyArgsKeyId, Map>(
        key: 'key_id',
        parse:
            (e) => ICVetkdPublicKeyArgsKeyId.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICVetkdDeriveKeyArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdDeriveKeyArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `vetkd_derive_key_result`.
final class ICVetkdDeriveKeyResult with CandidSerializable {
  final List<int> encryptedKey;

  const ICVetkdDeriveKeyResult({required this.encryptedKey});

  static CType get ctype => CType.record([
    Field(Label.named('encrypted_key'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'encrypted_key': encryptedKey};

  Map<String, dynamic> toJson() => {'encrypted_key': encryptedKey};

  factory ICVetkdDeriveKeyResult.fromCandid(Map<String, dynamic> json) {
    return ICVetkdDeriveKeyResult(
      encryptedKey: json.valueAsBytes<List<int>>(
        'encrypted_key',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICVetkdDeriveKeyResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICVetkdDeriveKeyResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `node_metrics_history_args`.
final class ICNodeMetricsHistoryArgs with CandidSerializable {
  final IcpPrincipalAddress subnetId;
  final BigInt startAtTimestampNanos;

  const ICNodeMetricsHistoryArgs({
    required this.subnetId,
    required this.startAtTimestampNanos,
  });

  static CType get ctype => CType.record([
    Field(Label.named('subnet_id'), CType.principal),
    Field(Label.named('start_at_timestamp_nanos'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'subnet_id': subnetId,
    'start_at_timestamp_nanos': startAtTimestampNanos,
  };

  Map<String, dynamic> toJson() => {
    'subnet_id': subnetId.address,
    'start_at_timestamp_nanos': startAtTimestampNanos,
  };

  factory ICNodeMetricsHistoryArgs.fromCandid(Map<String, dynamic> json) {
    return ICNodeMetricsHistoryArgs(
      subnetId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      startAtTimestampNanos: json.valueAsBigInt<BigInt>(
        'start_at_timestamp_nanos',
      ),
    );
  }

  factory ICNodeMetricsHistoryArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICNodeMetricsHistoryArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `subnet_info_args`.
final class ICSubnetInfoArgs with CandidSerializable {
  final IcpPrincipalAddress subnetId;

  const ICSubnetInfoArgs({required this.subnetId});

  static CType get ctype =>
      CType.record([Field(Label.named('subnet_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'subnet_id': subnetId};

  Map<String, dynamic> toJson() => {'subnet_id': subnetId.address};

  factory ICSubnetInfoArgs.fromCandid(Map<String, dynamic> json) {
    return ICSubnetInfoArgs(
      subnetId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'subnet_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICSubnetInfoArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSubnetInfoArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `subnet_info_result`.
final class ICSubnetInfoResult with CandidSerializable {
  final String replicaVersion;
  final BigInt registryVersion;

  const ICSubnetInfoResult({
    required this.replicaVersion,
    required this.registryVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('replica_version'), CType.text),
    Field(Label.named('registry_version'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'replica_version': replicaVersion,
    'registry_version': registryVersion,
  };

  Map<String, dynamic> toJson() => {
    'replica_version': replicaVersion,
    'registry_version': registryVersion,
  };

  factory ICSubnetInfoResult.fromCandid(Map<String, dynamic> json) {
    return ICSubnetInfoResult(
      replicaVersion: json.valueAsString<String>('replica_version'),
      registryVersion: json.valueAsBigInt<BigInt>('registry_version'),
    );
  }

  factory ICSubnetInfoResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSubnetInfoResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_id_range`.
final class ICCanisterIdRange with CandidSerializable {
  final ICCanisterId start;
  final ICCanisterId end;

  const ICCanisterIdRange({required this.start, required this.end});

  static CType get ctype => CType.record([
    Field(Label.named('start'), CType.principal),
    Field(Label.named('end'), CType.principal),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'start': start, 'end': end};

  Map<String, dynamic> toJson() => {'start': start.address, 'end': end.address};

  factory ICCanisterIdRange.fromCandid(Map<String, dynamic> json) {
    return ICCanisterIdRange(
      start: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'start',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      end: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'end',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICCanisterIdRange.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterIdRange.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `list_canisters_result`.
final class ICListCanistersResult with CandidSerializable {
  final List<ICCanisterIdRange> canisters;

  const ICListCanistersResult({required this.canisters});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('canisters'),
      () => CType.vec(ICCanisterIdRange.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canisters': canisters.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'canisters': canisters.map((el) => el.toJson()).toList(),
  };

  factory ICListCanistersResult.fromCandid(Map<String, dynamic> json) {
    return ICListCanistersResult(
      canisters: json.valueTo<List<ICCanisterIdRange>, List>(
        key: 'canisters',
        parse:
            (e) =>
                e
                    .map<ICCanisterIdRange>(
                      (x) => ICCanisterIdRange.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory ICListCanistersResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICListCanistersResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `provisional_create_canister_with_cycles_args`.
final class ICProvisionalCreateCanisterWithCyclesArgs with CandidSerializable {
  final BigInt? amount;
  final ICCanisterSettings? settings;
  final ICCanisterId? specifiedId;
  final BigInt? senderCanisterVersion;

  const ICProvisionalCreateCanisterWithCyclesArgs({
    this.amount,
    this.settings,
    this.specifiedId,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('amount'), CType.opt(CType.nat)),
    LazyField(
      Label.named('settings'),
      () => CType.opt(ICCanisterSettings.ctype),
    ),
    Field(Label.named('specified_id'), CType.opt(CType.principal)),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'amount': amount,
    'settings': settings?.candidValue,
    'specified_id': specifiedId,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'settings': settings?.toJson(),
    'specified_id': specifiedId?.address,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICProvisionalCreateCanisterWithCyclesArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICProvisionalCreateCanisterWithCyclesArgs(
      amount: json.valueAsBigInt<BigInt?>('amount'),
      settings: json.valueTo<ICCanisterSettings?, Map>(
        key: 'settings',
        parse:
            (e) => ICCanisterSettings.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      specifiedId: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'specified_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICProvisionalCreateCanisterWithCyclesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICProvisionalCreateCanisterWithCyclesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `provisional_create_canister_with_cycles_result`.
final class ICProvisionalCreateCanisterWithCyclesResult
    with CandidSerializable {
  final ICCanisterId canisterId;

  const ICProvisionalCreateCanisterWithCyclesResult({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICProvisionalCreateCanisterWithCyclesResult.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICProvisionalCreateCanisterWithCyclesResult(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICProvisionalCreateCanisterWithCyclesResult.fromBytes(
    List<int> bytes,
  ) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICProvisionalCreateCanisterWithCyclesResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `provisional_top_up_canister_args`.
final class ICProvisionalTopUpCanisterArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final BigInt amount;

  const ICProvisionalTopUpCanisterArgs({
    required this.canisterId,
    required this.amount,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('amount'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId, 'amount': amount};

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'amount': amount,
  };

  factory ICProvisionalTopUpCanisterArgs.fromCandid(Map<String, dynamic> json) {
    return ICProvisionalTopUpCanisterArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      amount: json.valueAsBigInt<BigInt>('amount'),
    );
  }

  factory ICProvisionalTopUpCanisterArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICProvisionalTopUpCanisterArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `snapshot`.
final class ICSnapshot with CandidSerializable {
  final ICSnapshotId id;
  final BigInt takenAtTimestamp;
  final BigInt totalSize;

  const ICSnapshot({
    required this.id,
    required this.takenAtTimestamp,
    required this.totalSize,
  });

  static CType get ctype => CType.record([
    Field(Label.named('id'), CType.vec(CType.nat8)),
    Field(Label.named('taken_at_timestamp'), CType.nat64),
    Field(Label.named('total_size'), CType.nat64),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'id': id,
    'taken_at_timestamp': takenAtTimestamp,
    'total_size': totalSize,
  };

  Map<String, dynamic> toJson() => {
    'id': id,
    'taken_at_timestamp': takenAtTimestamp,
    'total_size': totalSize,
  };

  factory ICSnapshot.fromCandid(Map<String, dynamic> json) {
    return ICSnapshot(
      id: json.valueAsBytes<List<int>>('id', encoding: StringEncoding.base64),
      takenAtTimestamp: json.valueAsBigInt<BigInt>('taken_at_timestamp'),
      totalSize: json.valueAsBigInt<BigInt>('total_size'),
    );
  }

  factory ICSnapshot.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICSnapshot.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `take_canister_snapshot_args`.
final class ICTakeCanisterSnapshotArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId? replaceSnapshot;
  final bool? uninstallCode;
  final BigInt? senderCanisterVersion;

  const ICTakeCanisterSnapshotArgs({
    required this.canisterId,
    this.replaceSnapshot,
    this.uninstallCode,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('replace_snapshot'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('uninstall_code'), CType.opt(CType.bool_)),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'replace_snapshot': replaceSnapshot,
    'uninstall_code': uninstallCode,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'replace_snapshot': replaceSnapshot,
    'uninstall_code': uninstallCode,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICTakeCanisterSnapshotArgs.fromCandid(Map<String, dynamic> json) {
    return ICTakeCanisterSnapshotArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      replaceSnapshot: json.valueAsBytes<List<int>?>(
        'replace_snapshot',
        encoding: StringEncoding.base64,
      ),
      uninstallCode: json.valueAsBool<bool?>('uninstall_code'),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICTakeCanisterSnapshotArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICTakeCanisterSnapshotArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `load_canister_snapshot_args`.
final class ICLoadCanisterSnapshotArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId snapshotId;
  final BigInt? senderCanisterVersion;

  const ICLoadCanisterSnapshotArgs({
    required this.canisterId,
    required this.snapshotId,
    this.senderCanisterVersion,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
    Field(Label.named('sender_canister_version'), CType.opt(CType.nat64)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
    'sender_canister_version': senderCanisterVersion,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'snapshot_id': snapshotId,
    'sender_canister_version': senderCanisterVersion,
  };

  factory ICLoadCanisterSnapshotArgs.fromCandid(Map<String, dynamic> json) {
    return ICLoadCanisterSnapshotArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
      senderCanisterVersion: json.valueAsBigInt<BigInt?>(
        'sender_canister_version',
      ),
    );
  }

  factory ICLoadCanisterSnapshotArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICLoadCanisterSnapshotArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `list_canister_snapshots_args`.
final class ICListCanisterSnapshotsArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICListCanisterSnapshotsArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICListCanisterSnapshotsArgs.fromCandid(Map<String, dynamic> json) {
    return ICListCanisterSnapshotsArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICListCanisterSnapshotsArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICListCanisterSnapshotsArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `delete_canister_snapshot_args`.
final class ICDeleteCanisterSnapshotArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId snapshotId;

  const ICDeleteCanisterSnapshotArgs({
    required this.canisterId,
    required this.snapshotId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'snapshot_id': snapshotId,
  };

  factory ICDeleteCanisterSnapshotArgs.fromCandid(Map<String, dynamic> json) {
    return ICDeleteCanisterSnapshotArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICDeleteCanisterSnapshotArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICDeleteCanisterSnapshotArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `fetch_canister_logs_args`.
final class ICFetchCanisterLogsArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICFetchCanisterLogsArgsFilter? filter;

  const ICFetchCanisterLogsArgs({required this.canisterId, this.filter});

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    LazyField(
      Label.named('filter'),
      () => CType.opt(ICFetchCanisterLogsArgsFilter.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'filter': filter?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'filter': filter?.toJson(),
  };

  factory ICFetchCanisterLogsArgs.fromCandid(Map<String, dynamic> json) {
    return ICFetchCanisterLogsArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      filter: json.valueTo<ICFetchCanisterLogsArgsFilter?, Map>(
        key: 'filter',
        parse:
            (e) => ICFetchCanisterLogsArgsFilter.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICFetchCanisterLogsArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICFetchCanisterLogsArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_log_record`.
final class ICCanisterLogRecord with CandidSerializable {
  final BigInt idx;
  final BigInt timestampNanos;
  final List<int> content;

  const ICCanisterLogRecord({
    required this.idx,
    required this.timestampNanos,
    required this.content,
  });

  static CType get ctype => CType.record([
    Field(Label.named('idx'), CType.nat64),
    Field(Label.named('timestamp_nanos'), CType.nat64),
    Field(Label.named('content'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'idx': idx,
    'timestamp_nanos': timestampNanos,
    'content': content,
  };

  Map<String, dynamic> toJson() => {
    'idx': idx,
    'timestamp_nanos': timestampNanos,
    'content': content,
  };

  factory ICCanisterLogRecord.fromCandid(Map<String, dynamic> json) {
    return ICCanisterLogRecord(
      idx: json.valueAsBigInt<BigInt>('idx'),
      timestampNanos: json.valueAsBigInt<BigInt>('timestamp_nanos'),
      content: json.valueAsBytes<List<int>>(
        'content',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICCanisterLogRecord.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterLogRecord.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `fetch_canister_logs_result`.
final class ICFetchCanisterLogsResult with CandidSerializable {
  final List<ICCanisterLogRecord> canisterLogRecords;

  const ICFetchCanisterLogsResult({required this.canisterLogRecords});

  static CType get ctype => CType.record([
    LazyField(
      Label.named('canister_log_records'),
      () => CType.vec(ICCanisterLogRecord.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_log_records':
        canisterLogRecords.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'canister_log_records':
        canisterLogRecords.map((el) => el.toJson()).toList(),
  };

  factory ICFetchCanisterLogsResult.fromCandid(Map<String, dynamic> json) {
    return ICFetchCanisterLogsResult(
      canisterLogRecords: json.valueTo<List<ICCanisterLogRecord>, List>(
        key: 'canister_log_records',
        parse:
            (e) =>
                e
                    .map<ICCanisterLogRecord>(
                      (x) => ICCanisterLogRecord.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  factory ICFetchCanisterLogsResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICFetchCanisterLogsResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `cycles_consumed`.
final class ICCyclesConsumed with CandidSerializable {
  final BigInt memory;
  final BigInt computeAllocation;
  final BigInt ingressInduction;
  final BigInt instructions;
  final BigInt requestAndResponseTransmission;
  final BigInt uninstall;
  final BigInt canisterCreation;
  final BigInt httpOutcalls;
  final BigInt burnedCycles;

  const ICCyclesConsumed({
    required this.memory,
    required this.computeAllocation,
    required this.ingressInduction,
    required this.instructions,
    required this.requestAndResponseTransmission,
    required this.uninstall,
    required this.canisterCreation,
    required this.httpOutcalls,
    required this.burnedCycles,
  });

  static CType get ctype => CType.record([
    Field(Label.named('memory'), CType.nat),
    Field(Label.named('compute_allocation'), CType.nat),
    Field(Label.named('ingress_induction'), CType.nat),
    Field(Label.named('instructions'), CType.nat),
    Field(Label.named('request_and_response_transmission'), CType.nat),
    Field(Label.named('uninstall'), CType.nat),
    Field(Label.named('canister_creation'), CType.nat),
    Field(Label.named('http_outcalls'), CType.nat),
    Field(Label.named('burned_cycles'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'memory': memory,
    'compute_allocation': computeAllocation,
    'ingress_induction': ingressInduction,
    'instructions': instructions,
    'request_and_response_transmission': requestAndResponseTransmission,
    'uninstall': uninstall,
    'canister_creation': canisterCreation,
    'http_outcalls': httpOutcalls,
    'burned_cycles': burnedCycles,
  };

  Map<String, dynamic> toJson() => {
    'memory': memory,
    'compute_allocation': computeAllocation,
    'ingress_induction': ingressInduction,
    'instructions': instructions,
    'request_and_response_transmission': requestAndResponseTransmission,
    'uninstall': uninstall,
    'canister_creation': canisterCreation,
    'http_outcalls': httpOutcalls,
    'burned_cycles': burnedCycles,
  };

  factory ICCyclesConsumed.fromCandid(Map<String, dynamic> json) {
    return ICCyclesConsumed(
      memory: json.valueAsBigInt<BigInt>('memory'),
      computeAllocation: json.valueAsBigInt<BigInt>('compute_allocation'),
      ingressInduction: json.valueAsBigInt<BigInt>('ingress_induction'),
      instructions: json.valueAsBigInt<BigInt>('instructions'),
      requestAndResponseTransmission: json.valueAsBigInt<BigInt>(
        'request_and_response_transmission',
      ),
      uninstall: json.valueAsBigInt<BigInt>('uninstall'),
      canisterCreation: json.valueAsBigInt<BigInt>('canister_creation'),
      httpOutcalls: json.valueAsBigInt<BigInt>('http_outcalls'),
      burnedCycles: json.valueAsBigInt<BigInt>('burned_cycles'),
    );
  }

  factory ICCyclesConsumed.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCyclesConsumed.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_metrics_args`.
final class ICCanisterMetricsArgs with CandidSerializable {
  final ICCanisterId canisterId;

  const ICCanisterMetricsArgs({required this.canisterId});

  static CType get ctype =>
      CType.record([Field(Label.named('canister_id'), CType.principal)]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'canister_id': canisterId};

  Map<String, dynamic> toJson() => {'canister_id': canisterId.address};

  factory ICCanisterMetricsArgs.fromCandid(Map<String, dynamic> json) {
    return ICCanisterMetricsArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICCanisterMetricsArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterMetricsArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `canister_metrics_result`.
final class ICCanisterMetricsResult with CandidSerializable {
  final ICCyclesConsumed cyclesConsumed;

  const ICCanisterMetricsResult({required this.cyclesConsumed});

  static CType get ctype => CType.record([
    LazyField(Label.named('cycles_consumed'), () => ICCyclesConsumed.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'cycles_consumed': cyclesConsumed.candidValue};

  Map<String, dynamic> toJson() => {'cycles_consumed': cyclesConsumed.toJson()};

  factory ICCanisterMetricsResult.fromCandid(Map<String, dynamic> json) {
    return ICCanisterMetricsResult(
      cyclesConsumed: json.valueTo<ICCyclesConsumed, Map>(
        key: 'cycles_consumed',
        parse:
            (e) => ICCyclesConsumed.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICCanisterMetricsResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICCanisterMetricsResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `read_canister_snapshot_metadata_args`.
final class ICReadCanisterSnapshotMetadataArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId snapshotId;

  const ICReadCanisterSnapshotMetadataArgs({
    required this.canisterId,
    required this.snapshotId,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'snapshot_id': snapshotId,
  };

  factory ICReadCanisterSnapshotMetadataArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotMetadataArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICReadCanisterSnapshotMetadataArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `read_canister_snapshot_metadata_response`.
final class ICReadCanisterSnapshotMetadataResponse with CandidSerializable {
  final ICChangeDetailsLoadSnapshotSource? source;
  final BigInt takenAtTimestamp;
  final BigInt wasmModuleSize;
  final List<ICReadCanisterSnapshotMetadataResponseGlobals?> globals;
  final BigInt wasmMemorySize;
  final BigInt stableMemorySize;
  final List<ICReadCanisterSnapshotMetadataResponseWasmChunkStore>
  wasmChunkStore;
  final BigInt canisterVersion;
  final List<int> certifiedData;
  final ICReadCanisterSnapshotMetadataResponseGlobalTimer? globalTimer;
  final ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus?
  onLowWasmMemoryHookStatus;

  const ICReadCanisterSnapshotMetadataResponse({
    this.source,
    required this.takenAtTimestamp,
    required this.wasmModuleSize,
    required this.globals,
    required this.wasmMemorySize,
    required this.stableMemorySize,
    required this.wasmChunkStore,
    required this.canisterVersion,
    required this.certifiedData,
    this.globalTimer,
    this.onLowWasmMemoryHookStatus,
  });

  static CType get ctype => CType.record([
    LazyField(
      Label.named('source'),
      () => CType.opt(ICChangeDetailsLoadSnapshotSource.ctype),
    ),
    Field(Label.named('taken_at_timestamp'), CType.nat64),
    Field(Label.named('wasm_module_size'), CType.nat64),
    LazyField(
      Label.named('globals'),
      () => CType.vec(
        CType.opt(ICReadCanisterSnapshotMetadataResponseGlobals.ctype),
      ),
    ),
    Field(Label.named('wasm_memory_size'), CType.nat64),
    Field(Label.named('stable_memory_size'), CType.nat64),
    LazyField(
      Label.named('wasm_chunk_store'),
      () =>
          CType.vec(ICReadCanisterSnapshotMetadataResponseWasmChunkStore.ctype),
    ),
    Field(Label.named('canister_version'), CType.nat64),
    Field(Label.named('certified_data'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('global_timer'),
      () => CType.opt(ICReadCanisterSnapshotMetadataResponseGlobalTimer.ctype),
    ),
    LazyField(
      Label.named('on_low_wasm_memory_hook_status'),
      () => CType.opt(
        ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'source': source?.candidValue,
    'taken_at_timestamp': takenAtTimestamp,
    'wasm_module_size': wasmModuleSize,
    'globals': globals.map((el) => el?.candidValue).toList(),
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'wasm_chunk_store': wasmChunkStore.map((el) => el.candidValue).toList(),
    'canister_version': canisterVersion,
    'certified_data': certifiedData,
    'global_timer': globalTimer?.candidValue,
    'on_low_wasm_memory_hook_status': onLowWasmMemoryHookStatus?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'taken_at_timestamp': takenAtTimestamp,
    'wasm_module_size': wasmModuleSize,
    'globals': globals.map((el) => el?.toJson()).toList(),
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'wasm_chunk_store': wasmChunkStore.map((el) => el.toJson()).toList(),
    'canister_version': canisterVersion,
    'certified_data': certifiedData,
    'global_timer': globalTimer?.toJson(),
    'on_low_wasm_memory_hook_status': onLowWasmMemoryHookStatus?.toJson(),
  };

  factory ICReadCanisterSnapshotMetadataResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotMetadataResponse(
      source: json.valueTo<ICChangeDetailsLoadSnapshotSource?, Map>(
        key: 'source',
        parse:
            (e) => ICChangeDetailsLoadSnapshotSource.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      takenAtTimestamp: json.valueAsBigInt<BigInt>('taken_at_timestamp'),
      wasmModuleSize: json.valueAsBigInt<BigInt>('wasm_module_size'),
      globals: json.valueTo<
        List<ICReadCanisterSnapshotMetadataResponseGlobals?>,
        List
      >(
        key: 'globals',
        parse:
            (e) =>
                e
                    .map<ICReadCanisterSnapshotMetadataResponseGlobals?>(
                      (x) =>
                          x == null
                              ? null
                              : ICReadCanisterSnapshotMetadataResponseGlobals.fromCandid(
                                JsonParser.valueEnsureAsMap<String, dynamic>(x),
                              ),
                    )
                    .toList(),
      ),
      wasmMemorySize: json.valueAsBigInt<BigInt>('wasm_memory_size'),
      stableMemorySize: json.valueAsBigInt<BigInt>('stable_memory_size'),
      wasmChunkStore: json.valueTo<
        List<ICReadCanisterSnapshotMetadataResponseWasmChunkStore>,
        List
      >(
        key: 'wasm_chunk_store',
        parse:
            (e) =>
                e
                    .map<ICReadCanisterSnapshotMetadataResponseWasmChunkStore>(
                      (x) =>
                          ICReadCanisterSnapshotMetadataResponseWasmChunkStore.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      canisterVersion: json.valueAsBigInt<BigInt>('canister_version'),
      certifiedData: json.valueAsBytes<List<int>>(
        'certified_data',
        encoding: StringEncoding.base64,
      ),
      globalTimer: json.valueTo<
        ICReadCanisterSnapshotMetadataResponseGlobalTimer?,
        Map
      >(
        key: 'global_timer',
        parse:
            (e) => ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      onLowWasmMemoryHookStatus: json.valueTo<
        ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus?,
        Map
      >(
        key: 'on_low_wasm_memory_hook_status',
        parse:
            (e) =>
                ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
    );
  }

  factory ICReadCanisterSnapshotMetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotMetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `read_canister_snapshot_data_args`.
final class ICReadCanisterSnapshotDataArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId snapshotId;
  final ICReadCanisterSnapshotDataArgsKind kind;

  const ICReadCanisterSnapshotDataArgs({
    required this.canisterId,
    required this.snapshotId,
    required this.kind,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('kind'),
      () => ICReadCanisterSnapshotDataArgsKind.ctype,
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
    'kind': kind.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'snapshot_id': snapshotId,
    'kind': kind.toJson(),
  };

  factory ICReadCanisterSnapshotDataArgs.fromCandid(Map<String, dynamic> json) {
    return ICReadCanisterSnapshotDataArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
      kind: json.valueTo<ICReadCanisterSnapshotDataArgsKind, Map>(
        key: 'kind',
        parse:
            (e) => ICReadCanisterSnapshotDataArgsKind.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICReadCanisterSnapshotDataArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotDataArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `read_canister_snapshot_data_response`.
final class ICReadCanisterSnapshotDataResponse with CandidSerializable {
  final List<int> chunk;

  const ICReadCanisterSnapshotDataResponse({required this.chunk});

  static CType get ctype =>
      CType.record([Field(Label.named('chunk'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'chunk': chunk};

  Map<String, dynamic> toJson() => {'chunk': chunk};

  factory ICReadCanisterSnapshotDataResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICReadCanisterSnapshotDataResponse(
      chunk: json.valueAsBytes<List<int>>(
        'chunk',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICReadCanisterSnapshotDataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICReadCanisterSnapshotDataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `upload_canister_snapshot_metadata_args`.
final class ICUploadCanisterSnapshotMetadataArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId? replaceSnapshot;
  final BigInt wasmModuleSize;
  final List<ICReadCanisterSnapshotMetadataResponseGlobals> globals;
  final BigInt wasmMemorySize;
  final BigInt stableMemorySize;
  final List<int> certifiedData;
  final ICReadCanisterSnapshotMetadataResponseGlobalTimer? globalTimer;
  final ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus?
  onLowWasmMemoryHookStatus;

  const ICUploadCanisterSnapshotMetadataArgs({
    required this.canisterId,
    this.replaceSnapshot,
    required this.wasmModuleSize,
    required this.globals,
    required this.wasmMemorySize,
    required this.stableMemorySize,
    required this.certifiedData,
    this.globalTimer,
    this.onLowWasmMemoryHookStatus,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('replace_snapshot'), CType.opt(CType.vec(CType.nat8))),
    Field(Label.named('wasm_module_size'), CType.nat64),
    LazyField(
      Label.named('globals'),
      () => CType.vec(ICReadCanisterSnapshotMetadataResponseGlobals.ctype),
    ),
    Field(Label.named('wasm_memory_size'), CType.nat64),
    Field(Label.named('stable_memory_size'), CType.nat64),
    Field(Label.named('certified_data'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('global_timer'),
      () => CType.opt(ICReadCanisterSnapshotMetadataResponseGlobalTimer.ctype),
    ),
    LazyField(
      Label.named('on_low_wasm_memory_hook_status'),
      () => CType.opt(
        ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.ctype,
      ),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'replace_snapshot': replaceSnapshot,
    'wasm_module_size': wasmModuleSize,
    'globals': globals.map((el) => el.candidValue).toList(),
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'certified_data': certifiedData,
    'global_timer': globalTimer?.candidValue,
    'on_low_wasm_memory_hook_status': onLowWasmMemoryHookStatus?.candidValue,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'replace_snapshot': replaceSnapshot,
    'wasm_module_size': wasmModuleSize,
    'globals': globals.map((el) => el.toJson()).toList(),
    'wasm_memory_size': wasmMemorySize,
    'stable_memory_size': stableMemorySize,
    'certified_data': certifiedData,
    'global_timer': globalTimer?.toJson(),
    'on_low_wasm_memory_hook_status': onLowWasmMemoryHookStatus?.toJson(),
  };

  factory ICUploadCanisterSnapshotMetadataArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotMetadataArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      replaceSnapshot: json.valueAsBytes<List<int>?>(
        'replace_snapshot',
        encoding: StringEncoding.base64,
      ),
      wasmModuleSize: json.valueAsBigInt<BigInt>('wasm_module_size'),
      globals: json.valueTo<
        List<ICReadCanisterSnapshotMetadataResponseGlobals>,
        List
      >(
        key: 'globals',
        parse:
            (e) =>
                e
                    .map<ICReadCanisterSnapshotMetadataResponseGlobals>(
                      (x) =>
                          ICReadCanisterSnapshotMetadataResponseGlobals.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                    )
                    .toList(),
      ),
      wasmMemorySize: json.valueAsBigInt<BigInt>('wasm_memory_size'),
      stableMemorySize: json.valueAsBigInt<BigInt>('stable_memory_size'),
      certifiedData: json.valueAsBytes<List<int>>(
        'certified_data',
        encoding: StringEncoding.base64,
      ),
      globalTimer: json.valueTo<
        ICReadCanisterSnapshotMetadataResponseGlobalTimer?,
        Map
      >(
        key: 'global_timer',
        parse:
            (e) => ICReadCanisterSnapshotMetadataResponseGlobalTimer.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      onLowWasmMemoryHookStatus: json.valueTo<
        ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus?,
        Map
      >(
        key: 'on_low_wasm_memory_hook_status',
        parse:
            (e) =>
                ICReadCanisterSnapshotMetadataResponseOnLowWasmMemoryHookStatus.fromCandid(
                  JsonParser.valueEnsureAsMap<String, dynamic>(e),
                ),
      ),
    );
  }

  factory ICUploadCanisterSnapshotMetadataArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUploadCanisterSnapshotMetadataArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `upload_canister_snapshot_metadata_response`.
final class ICUploadCanisterSnapshotMetadataResponse with CandidSerializable {
  final ICSnapshotId snapshotId;

  const ICUploadCanisterSnapshotMetadataResponse({required this.snapshotId});

  static CType get ctype =>
      CType.record([Field(Label.named('snapshot_id'), CType.vec(CType.nat8))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'snapshot_id': snapshotId};

  Map<String, dynamic> toJson() => {'snapshot_id': snapshotId};

  factory ICUploadCanisterSnapshotMetadataResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotMetadataResponse(
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICUploadCanisterSnapshotMetadataResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUploadCanisterSnapshotMetadataResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `upload_canister_snapshot_data_args`.
final class ICUploadCanisterSnapshotDataArgs with CandidSerializable {
  final ICCanisterId canisterId;
  final ICSnapshotId snapshotId;
  final ICUploadCanisterSnapshotDataArgsKind kind;
  final List<int> chunk;

  const ICUploadCanisterSnapshotDataArgs({
    required this.canisterId,
    required this.snapshotId,
    required this.kind,
    required this.chunk,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('snapshot_id'), CType.vec(CType.nat8)),
    LazyField(
      Label.named('kind'),
      () => ICUploadCanisterSnapshotDataArgsKind.ctype,
    ),
    Field(Label.named('chunk'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'snapshot_id': snapshotId,
    'kind': kind.candidValue,
    'chunk': chunk,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'snapshot_id': snapshotId,
    'kind': kind.toJson(),
    'chunk': chunk,
  };

  factory ICUploadCanisterSnapshotDataArgs.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICUploadCanisterSnapshotDataArgs(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      snapshotId: json.valueAsBytes<List<int>>(
        'snapshot_id',
        encoding: StringEncoding.base64,
      ),
      kind: json.valueTo<ICUploadCanisterSnapshotDataArgsKind, Map>(
        key: 'kind',
        parse:
            (e) => ICUploadCanisterSnapshotDataArgsKind.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
      chunk: json.valueAsBytes<List<int>>(
        'chunk',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICUploadCanisterSnapshotDataArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICUploadCanisterSnapshotDataArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}
