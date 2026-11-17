// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `ic`.
abstract class ICUpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICUpdateMessage();
}

class ICUpdateCreateCanister extends ICUpdateMessage<ICCreateCanisterResult> {
  final ICCreateCanisterArgs args;
  const ICUpdateCreateCanister(this.args);

  @override
  String get methodName => 'create_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICCreateCanisterResult onResponse(List<int> bytes) {
    return ICCreateCanisterResult.fromBytes(bytes);
  }
}

class ICUpdateUpdateSettings extends ICUpdateMessage<Null> {
  final ICUpdateSettingsArgs args;
  const ICUpdateUpdateSettings(this.args);

  @override
  String get methodName => 'update_settings';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateUploadChunk extends ICUpdateMessage<ICUploadChunkResult> {
  final ICUploadChunkArgs args;
  const ICUpdateUploadChunk(this.args);

  @override
  String get methodName => 'upload_chunk';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICUploadChunkResult onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, ICUploadChunkResultCandid.ctype)
        as ICUploadChunkResult;
  }
}

class ICUpdateClearChunkStore extends ICUpdateMessage<Null> {
  final ICClearChunkStoreArgs args;
  const ICUpdateClearChunkStore(this.args);

  @override
  String get methodName => 'clear_chunk_store';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateStoredChunks extends ICUpdateMessage<ICStoredChunksResult> {
  final ICStoredChunksArgs args;
  const ICUpdateStoredChunks(this.args);

  @override
  String get methodName => 'stored_chunks';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICStoredChunksResult onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      ICStoredChunksResultCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICChunkHash.fromCandid(e)).toList();
  }
}

class ICUpdateInstallCode extends ICUpdateMessage<Null> {
  final ICInstallCodeArgs args;
  const ICUpdateInstallCode(this.args);

  @override
  String get methodName => 'install_code';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateInstallChunkedCode extends ICUpdateMessage<Null> {
  final ICInstallChunkedCodeArgs args;
  const ICUpdateInstallChunkedCode(this.args);

  @override
  String get methodName => 'install_chunked_code';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateUninstallCode extends ICUpdateMessage<Null> {
  final ICUninstallCodeArgs args;
  const ICUpdateUninstallCode(this.args);

  @override
  String get methodName => 'uninstall_code';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateStartCanister extends ICUpdateMessage<Null> {
  final ICStartCanisterArgs args;
  const ICUpdateStartCanister(this.args);

  @override
  String get methodName => 'start_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateStopCanister extends ICUpdateMessage<Null> {
  final ICStopCanisterArgs args;
  const ICUpdateStopCanister(this.args);

  @override
  String get methodName => 'stop_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateDeleteCanister extends ICUpdateMessage<Null> {
  final ICDeleteCanisterArgs args;
  const ICUpdateDeleteCanister(this.args);

  @override
  String get methodName => 'delete_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateDepositCycles extends ICUpdateMessage<Null> {
  final ICDepositCyclesArgs args;
  const ICUpdateDepositCycles(this.args);

  @override
  String get methodName => 'deposit_cycles';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateRawRand extends ICUpdateMessage<ICRawRandResult> {
  const ICUpdateRawRand();

  @override
  String get methodName => 'raw_rand';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  ICRawRandResult onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat8))
        as ICRawRandResult;
  }
}

class ICUpdateHttpRequest extends ICUpdateMessage<ICHttpRequestResult> {
  final ICHttpRequestArgs args;
  const ICUpdateHttpRequest(this.args);

  @override
  String get methodName => 'http_request';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICHttpRequestResult onResponse(List<int> bytes) {
    return ICHttpRequestResult.fromBytes(bytes);
  }
}

class ICUpdateCanisterInfo extends ICUpdateMessage<ICCanisterInfoResult> {
  final ICCanisterInfoArgs args;
  const ICUpdateCanisterInfo(this.args);

  @override
  String get methodName => 'canister_info';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICCanisterInfoResult onResponse(List<int> bytes) {
    return ICCanisterInfoResult.fromBytes(bytes);
  }
}

class ICUpdateCanisterMetadata
    extends ICUpdateMessage<ICCanisterMetadataResult> {
  final ICCanisterMetadataArgs args;
  const ICUpdateCanisterMetadata(this.args);

  @override
  String get methodName => 'canister_metadata';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICCanisterMetadataResult onResponse(List<int> bytes) {
    return ICCanisterMetadataResult.fromBytes(bytes);
  }
}

class ICUpdateEcdsaPublicKey extends ICUpdateMessage<ICEcdsaPublicKeyResult> {
  final ICEcdsaPublicKeyArgs args;
  const ICUpdateEcdsaPublicKey(this.args);

  @override
  String get methodName => 'ecdsa_public_key';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICEcdsaPublicKeyResult onResponse(List<int> bytes) {
    return ICEcdsaPublicKeyResult.fromBytes(bytes);
  }
}

class ICUpdateSignWithEcdsa extends ICUpdateMessage<ICSignWithEcdsaResult> {
  final ICSignWithEcdsaArgs args;
  const ICUpdateSignWithEcdsa(this.args);

  @override
  String get methodName => 'sign_with_ecdsa';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICSignWithEcdsaResult onResponse(List<int> bytes) {
    return ICSignWithEcdsaResult.fromBytes(bytes);
  }
}

class ICUpdateSchnorrPublicKey
    extends ICUpdateMessage<ICSchnorrPublicKeyResult> {
  final ICSchnorrPublicKeyArgs args;
  const ICUpdateSchnorrPublicKey(this.args);

  @override
  String get methodName => 'schnorr_public_key';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICSchnorrPublicKeyResult onResponse(List<int> bytes) {
    return ICSchnorrPublicKeyResult.fromBytes(bytes);
  }
}

class ICUpdateSignWithSchnorr extends ICUpdateMessage<ICSignWithSchnorrResult> {
  final ICSignWithSchnorrArgs args;
  const ICUpdateSignWithSchnorr(this.args);

  @override
  String get methodName => 'sign_with_schnorr';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICSignWithSchnorrResult onResponse(List<int> bytes) {
    return ICSignWithSchnorrResult.fromBytes(bytes);
  }
}

class ICUpdateVetkdPublicKey extends ICUpdateMessage<ICVetkdPublicKeyResult> {
  final ICVetkdPublicKeyArgs args;
  const ICUpdateVetkdPublicKey(this.args);

  @override
  String get methodName => 'vetkd_public_key';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICVetkdPublicKeyResult onResponse(List<int> bytes) {
    return ICVetkdPublicKeyResult.fromBytes(bytes);
  }
}

class ICUpdateVetkdDeriveKey extends ICUpdateMessage<ICVetkdDeriveKeyResult> {
  final ICVetkdDeriveKeyArgs args;
  const ICUpdateVetkdDeriveKey(this.args);

  @override
  String get methodName => 'vetkd_derive_key';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICVetkdDeriveKeyResult onResponse(List<int> bytes) {
    return ICVetkdDeriveKeyResult.fromBytes(bytes);
  }
}

class ICUpdateBitcoinGetBalance
    extends ICUpdateMessage<ICBitcoinGetBalanceResult> {
  final ICBitcoinGetBalanceArgs args;
  const ICUpdateBitcoinGetBalance(this.args);

  @override
  String get methodName => 'bitcoin_get_balance';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICBitcoinGetBalanceResult onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat64)
        as ICBitcoinGetBalanceResult;
  }
}

class ICUpdateBitcoinGetUtxos extends ICUpdateMessage<ICBitcoinGetUtxosResult> {
  final ICBitcoinGetUtxosArgs args;
  const ICUpdateBitcoinGetUtxos(this.args);

  @override
  String get methodName => 'bitcoin_get_utxos';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICBitcoinGetUtxosResult onResponse(List<int> bytes) {
    return ICBitcoinGetUtxosResult.fromBytes(bytes);
  }
}

class ICUpdateBitcoinSendTransaction extends ICUpdateMessage<Null> {
  final ICBitcoinSendTransactionArgs args;
  const ICUpdateBitcoinSendTransaction(this.args);

  @override
  String get methodName => 'bitcoin_send_transaction';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateBitcoinGetCurrentFeePercentiles
    extends ICUpdateMessage<ICBitcoinGetCurrentFeePercentilesResult> {
  final ICBitcoinGetCurrentFeePercentilesArgs args;
  const ICUpdateBitcoinGetCurrentFeePercentiles(this.args);

  @override
  String get methodName => 'bitcoin_get_current_fee_percentiles';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICBitcoinGetCurrentFeePercentilesResult onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          ICBitcoinGetCurrentFeePercentilesResultCandid.ctype,
        )
        as ICBitcoinGetCurrentFeePercentilesResult;
  }
}

class ICUpdateBitcoinGetBlockHeaders
    extends ICUpdateMessage<ICBitcoinGetBlockHeadersResult> {
  final ICBitcoinGetBlockHeadersArgs args;
  const ICUpdateBitcoinGetBlockHeaders(this.args);

  @override
  String get methodName => 'bitcoin_get_block_headers';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICBitcoinGetBlockHeadersResult onResponse(List<int> bytes) {
    return ICBitcoinGetBlockHeadersResult.fromBytes(bytes);
  }
}

class ICUpdateNodeMetricsHistory
    extends ICUpdateMessage<ICNodeMetricsHistoryResult> {
  final ICNodeMetricsHistoryArgs args;
  const ICUpdateNodeMetricsHistory(this.args);

  @override
  String get methodName => 'node_metrics_history';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICNodeMetricsHistoryResult onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      ICNodeMetricsHistoryResultCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICNodeMetricsHistoryResultItem.fromCandid(e)).toList();
  }
}

class ICUpdateSubnetInfo extends ICUpdateMessage<ICSubnetInfoResult> {
  final ICSubnetInfoArgs args;
  const ICUpdateSubnetInfo(this.args);

  @override
  String get methodName => 'subnet_info';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICSubnetInfoResult onResponse(List<int> bytes) {
    return ICSubnetInfoResult.fromBytes(bytes);
  }
}

class ICUpdateProvisionalCreateCanisterWithCycles
    extends ICUpdateMessage<ICProvisionalCreateCanisterWithCyclesResult> {
  final ICProvisionalCreateCanisterWithCyclesArgs args;
  const ICUpdateProvisionalCreateCanisterWithCycles(this.args);

  @override
  String get methodName => 'provisional_create_canister_with_cycles';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICProvisionalCreateCanisterWithCyclesResult onResponse(List<int> bytes) {
    return ICProvisionalCreateCanisterWithCyclesResult.fromBytes(bytes);
  }
}

class ICUpdateProvisionalTopUpCanister extends ICUpdateMessage<Null> {
  final ICProvisionalTopUpCanisterArgs args;
  const ICUpdateProvisionalTopUpCanister(this.args);

  @override
  String get methodName => 'provisional_top_up_canister';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateTakeCanisterSnapshot
    extends ICUpdateMessage<ICTakeCanisterSnapshotResult> {
  final ICTakeCanisterSnapshotArgs args;
  const ICUpdateTakeCanisterSnapshot(this.args);

  @override
  String get methodName => 'take_canister_snapshot';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICTakeCanisterSnapshotResult onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          ICTakeCanisterSnapshotResultCandid.ctype,
        )
        as ICTakeCanisterSnapshotResult;
  }
}

class ICUpdateLoadCanisterSnapshot extends ICUpdateMessage<Null> {
  final ICLoadCanisterSnapshotArgs args;
  const ICUpdateLoadCanisterSnapshot(this.args);

  @override
  String get methodName => 'load_canister_snapshot';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateReadCanisterSnapshotMetadata
    extends ICUpdateMessage<ICReadCanisterSnapshotMetadataResponse> {
  final ICReadCanisterSnapshotMetadataArgs args;
  const ICUpdateReadCanisterSnapshotMetadata(this.args);

  @override
  String get methodName => 'read_canister_snapshot_metadata';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICReadCanisterSnapshotMetadataResponse onResponse(List<int> bytes) {
    return ICReadCanisterSnapshotMetadataResponse.fromBytes(bytes);
  }
}

class ICUpdateReadCanisterSnapshotData
    extends ICUpdateMessage<ICReadCanisterSnapshotDataResponse> {
  final ICReadCanisterSnapshotDataArgs args;
  const ICUpdateReadCanisterSnapshotData(this.args);

  @override
  String get methodName => 'read_canister_snapshot_data';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICReadCanisterSnapshotDataResponse onResponse(List<int> bytes) {
    return ICReadCanisterSnapshotDataResponse.fromBytes(bytes);
  }
}

class ICUpdateUploadCanisterSnapshotMetadata
    extends ICUpdateMessage<ICUploadCanisterSnapshotMetadataResponse> {
  final ICUploadCanisterSnapshotMetadataArgs args;
  const ICUpdateUploadCanisterSnapshotMetadata(this.args);

  @override
  String get methodName => 'upload_canister_snapshot_metadata';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICUploadCanisterSnapshotMetadataResponse onResponse(List<int> bytes) {
    return ICUploadCanisterSnapshotMetadataResponse.fromBytes(bytes);
  }
}

class ICUpdateUploadCanisterSnapshotData extends ICUpdateMessage<Null> {
  final ICUploadCanisterSnapshotDataArgs args;
  const ICUpdateUploadCanisterSnapshotData(this.args);

  @override
  String get methodName => 'upload_canister_snapshot_data';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class ICUpdateListCanisterSnapshots
    extends ICUpdateMessage<ICListCanisterSnapshotsResult> {
  final ICListCanisterSnapshotsArgs args;
  const ICUpdateListCanisterSnapshots(this.args);

  @override
  String get methodName => 'list_canister_snapshots';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICListCanisterSnapshotsResult onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      ICListCanisterSnapshotsResultCandid.ctype,
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICSnapshot.fromCandid(e)).toList();
  }
}

class ICUpdateDeleteCanisterSnapshot extends ICUpdateMessage<Null> {
  final ICDeleteCanisterSnapshotArgs args;
  const ICUpdateDeleteCanisterSnapshot(this.args);

  @override
  String get methodName => 'delete_canister_snapshot';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}
