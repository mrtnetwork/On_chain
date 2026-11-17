import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/keys/passkey.dart';
import 'package:on_chain/sui/src/keypair/keys/zklogin.dart'
    hide SuiZkLoginInputs, SuiZkLoginClaim;
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/sui/src/proto_messages/google/protobuf/src/field_mask.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/bcs.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/checkpoint.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/event.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/executed_transaction.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/filter.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/gas_cost_summary.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/ledger_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/move_package.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/move_package_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/name_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/object.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/query_options.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature_scheme.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/signature_verification_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/state_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/subscription_service.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/system_state.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction.dart';
import 'package:on_chain/sui/src/proto_messages/sui/rpc/v2/src/transaction_execution_service.dart';
import 'package:on_chain/sui/src/rpc/core/request.dart';
import 'package:on_chain/sui/src/rpc/methods/coin/get_coin.dart';
import 'package:on_chain/sui/src/rpc/methods/methods/grpc.dart';
import 'package:on_chain/sui/src/rpc/methods/read/get_latest_checkpoint_sequence_number.dart';
import 'package:on_chain/sui/src/rpc/methods/read/get_transaction_block.dart';
import 'package:on_chain/sui/src/rpc/methods/write/dry_run_transaction_block.dart';
import 'package:on_chain/sui/src/rpc/methods/write/execute_transaction_block.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';
import 'package:on_chain/sui/src/transaction/types/types.dart';

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Sui cases: unknown digests throw instead of degrading).
enum SuiTxStatus {
  /// Effects report success.
  block,

  /// Effects report failure.
  failed,
}

/// gRPC-only quick client. Every method returns proto types directly;
/// there is no JSON-RPC fallback and no `SuiApi*` mapping layer.
mixin SuiQuickClientApi {
  IGrpcProvider<
    IServiceProvider,
    BaseSuiServiceRequestParams,
    BaseGRPCServiceRequestParams
  >
  get provider;

  /// Read mask shared by the object shortcuts (everything the wallet
  /// needs; contents carry the Move BCS).
  static const SuiFieldMask _objectReadMask = SuiFieldMask(
    paths: [
      'object_id',
      'version',
      'digest',
      'owner',
      'object_type',
      'contents',
      'balance',
      'previous_transaction',
      'storage_rebate',
    ],
  );

  static SuiBcs _txBcs(String txBytes) {
    return SuiBcs(value: B64Decoder.decode(txBytes));
  }

  /// Builds the gRPC signature message. Simple schemes ride the proven raw
  /// BCS form; complex envelopes (multisig/zkLogin/passkey) use the
  /// structured proto mapping (their raw BCS trips the server parser).
  static SuiUserSignature _userSignature(SuiBaseSignature signature) {
    if (signature is SuiEd25519Signature ||
        signature is SuiSecp256k1Signature ||
        signature is SuiSecp256r1Signature) {
      return SuiUserSignature(
        bcs: SuiBcs(value: signature.toVariantBcs().toList()),
      );
    }
    return _signatureToProto(signature);
  }

  static SuiSignatureScheme _schemeOf(SuiSigningScheme scheme) {
    return switch (scheme) {
      SuiSigningScheme.ed25519 => SuiSignatureScheme.ed25519,
      SuiSigningScheme.secp256k1 => SuiSignatureScheme.secp256k1,
      SuiSigningScheme.secp256r1 => SuiSignatureScheme.secp256r1,
      SuiSigningScheme.multisig => SuiSignatureScheme.multisig,
      SuiSigningScheme.zklogin => SuiSignatureScheme.zklogin,
      SuiSigningScheme.passkey => SuiSignatureScheme.passkey,
    };
  }

  static SuiSimpleSignature _simpleOf(
    SuiSigningScheme scheme,
    List<int> signature,
    List<int> publicKey,
  ) {
    return SuiSimpleSignature(
      scheme: _schemeOf(scheme),
      signature: signature,
      publicKey: publicKey,
    );
  }

  static SuiZkLoginProof _proofOf(SuiZkLoginProofPoints points) {
    List<String> dec(List<BigInt> values) {
      return [for (final v in values) v.toString()];
    }

    SuiCircomG1 g1(List<BigInt> values) {
      final d = dec(values);
      return SuiCircomG1(e0: d[0], e1: d[1], e2: d[2]);
    }

    return SuiZkLoginProof(
      a: g1(points.a),
      b: SuiCircomG2(
        e00: points.b[0][0].toString(),
        e01: points.b[0][1].toString(),
        e10: points.b[1][0].toString(),
        e11: points.b[1][1].toString(),
        // Affine z (Fp2 one): the BCS proof model carries no z-coords, and
        // the server requires e20/e21 present (FIELD_MISSING otherwise).
        e20: '1',
        e21: '0',
      ),
      c: g1(points.c),
    );
  }

  static List<int> _rawPublicKeyBytes(SuiCryptoPublicKey key) {
    final inner = key.publicKey;
    if (inner is BaseEd25519PublicKey) return inner.toBytes();
    if (inner is BaseSecp256k1PublicKey) return inner.toBytes();
    if (inner is BaseSecp256r1PublicKey) return inner.toBytes();
    throw BuError(
      DefaultErrorType.unsupported,
      'Unsupported member key for proto conversion: ${key.runtimeType}.',
    );
  }

  /// BCS [SuiBaseSignature] -> proto [SuiUserSignature].
  static SuiUserSignature _signatureToProto(SuiBaseSignature signature) {
    SuiUserSignature wrap(
      SuiSignatureScheme scheme, {
      SuiSimpleSignature? simple,
      SuiMultisigAggregatedSignature? multisig,
      SuiZkLoginAuthenticator? zklogin,
      SuiPasskeyAuthenticator? passkey,
    }) {
      return SuiUserSignature(
        scheme: scheme,
        simple: simple,
        multisig: multisig,
        zklogin: zklogin,
        passkey: passkey,
      );
    }

    return switch (signature) {
      SuiEd25519Signature sig => wrap(
        SuiSignatureScheme.ed25519,
        simple: _simpleOf(
          SuiSigningScheme.ed25519,
          sig.signature.signature.toList(),
          sig.publicKey.publicKey.toBytes(),
        ),
      ),
      SuiSecp256k1Signature sig => wrap(
        SuiSignatureScheme.secp256k1,
        simple: _simpleOf(
          SuiSigningScheme.secp256k1,
          sig.signature.signature.toList(),
          sig.publicKey.publicKey.toBytes(),
        ),
      ),
      SuiSecp256r1Signature sig => wrap(
        SuiSignatureScheme.secp256r1,
        simple: _simpleOf(
          SuiSigningScheme.secp256r1,
          sig.signature.signature.toList(),
          sig.publicKey.publicKey.toBytes(),
        ),
      ),
      SuiMultisigSignature sig => wrap(
        SuiSignatureScheme.multisig,
        multisig: SuiMultisigAggregatedSignature(
          signatures: [
            for (final s in sig.signatures)
              SuiMultisigMemberSignature(
                scheme: _schemeOf(
                  SuiSigningScheme.values.firstWhere(
                    (e) => e.name == s.algorithm.name,
                  ),
                ),
                signature: s.signature.toList(),
              ),
          ],
          bitmap: sig.bitmap,
          committee: SuiMultisigCommittee(
            members: [
              for (final k in sig.publicKey.publicKeys)
                SuiMultisigMember(
                  publicKey: SuiMultisigMemberPublicKey(
                    scheme: _schemeOf(
                      SuiSigningScheme.values.firstWhere(
                        (e) => e.name == k.publicKey.algorithm.name,
                      ),
                    ),
                    publicKey: _rawPublicKeyBytes(k.publicKey),
                  ),
                  weight: k.weight,
                ),
            ],
            threshold: sig.publicKey.threshold,
          ),
        ),
      ),
      SuiZkLoginSignature sig => wrap(
        SuiSignatureScheme.zklogin,
        zklogin: SuiZkLoginAuthenticator(
          inputs: SuiZkLoginInputs(
            proofPoints: _proofOf(sig.inputs.proofPoints),
            issBase64Details: SuiZkLoginClaim(
              value: sig.inputs.issBase64Details.value,
              indexMod4: sig.inputs.issBase64Details.indexMod4,
            ),
            headerBase64: sig.inputs.headerBase64,
            addressSeed: sig.inputs.addressSeed.toString(),
          ),
          maxEpoch: sig.maxEpoch,
          signature: _simpleOf(
            sig.userSignature.scheme,
            sig.userSignature.signature,
            sig.userSignature.publicKey,
          ),
        ),
      ),
      SuiPasskeySignature sig => wrap(
        SuiSignatureScheme.passkey,
        passkey: SuiPasskeyAuthenticator(
          authenticatorData: sig.authenticatorData,
          clientDataJson: sig.clientDataJSON,
          signature: _simpleOf(
            SuiSigningScheme.secp256r1,
            sig.signature.signature.signature.toList(),
            sig.signature.publicKey.publicKey.toBytes(),
          ),
        ),
      ),
      _ =>
        throw BuError(
          DefaultErrorType.unsupported,
          'Unsupported signature for proto conversion.',
          details: {'scheme': signature.scheme.name},
        ),
    };
  }

  /// `0x...::coin::Coin<T>` object tags wrapping `coinType` exactly
  /// (short and full-length addresses compare equal).
  static bool _isCoinOfType(String objectType, String coinType) {
    final match = RegExp(
      r'^(0x[0-9a-fA-F]+)::coin::Coin<(.+)>$',
    ).firstMatch(objectType);
    if (match == null) return false;
    return _normalizeType(match.group(2)!) == _normalizeType(coinType);
  }

  static String _normalizeType(String type) {
    return type.replaceAllMapped(
      RegExp('0x[0-9a-fA-F]+'),
      (m) => '0x${m.group(0)!.substring(2).padLeft(64, '0').toLowerCase()}',
    );
  }

  /// Extracts `0x...::coin::Coin<T>`'s `T` from a full struct tag.
  static String? coinTypeOf(String objectType) {
    final match = RegExp(
      r'^(0x[0-9a-fA-F]+)::coin::Coin<(.+)>$',
    ).firstMatch(objectType);
    return match?.group(2);
  }

  /// All coin balances of `address`, one page per event.
  Stream<List<SuiBalance>> watchAccountBalances(SuiAddress address) async* {
    BuBytes? pageToken;
    do {
      final response = await provider.request(
        SuiGrpcRequestMessage(
          SuiListBalancesRequest(
            owner: address.address,
            pageSize: 50,
            pageToken: pageToken?.toList(),
          ),
        ),
      );
      if (response.balances.isNotEmpty) yield response.balances;
      pageToken = response.nextPageToken;
    } while (pageToken != null && pageToken.isNotEmpty);
  }

  /// Current reference gas price.
  Future<BigInt> getGasPrice() async {
    final epoch =
        (await provider.request(
          SuiGrpcRequestMessage(
            SuiGetEpochRequest(
              readMask: const SuiFieldMask(paths: ['reference_gas_price']),
            ),
          ),
        )).epoch;
    final price = epoch?.referenceGasPrice;
    if (price == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Epoch response has no gas price.",
      );
    }
    return price;
  }

  /// Dry-run gas used by a transaction (base64 BCS, as the wallet builds).
  Future<SuiGasCostSummary?> simulateGasUsed(String txBytes) async {
    final response = await simulateTransaction(txBytes);
    return response.transaction?.effects?.gasUsed;
  }

  /// Dry-run a transaction (base64 BCS, as the wallet builds).
  Future<SuiSimulateTransactionResponse> simulateTransaction(
    String txBytes,
  ) async {
    return provider.request(
      SuiGrpcRequestMessage(
        SuiSimulateTransactionRequest(
          transaction: SuiTransaction(bcs: _txBcs(txBytes)),
        ),
      ),
    );
  }

  /// Execute a signed transaction (base64 BCS tx + BCS signatures,
  /// as the wallet builds). Always reads `[digest, effects]`.
  Future<SuiExecuteTransactionResponse> executeTransaction({
    required String txBytes,
    required List<SuiBaseSignature> signatures,
  }) async {
    return provider.request(
      SuiGrpcRequestMessage(
        SuiExecuteTransactionRequest(
          transaction: SuiTransaction(bcs: _txBcs(txBytes)),
          signatures: [for (final s in signatures) _userSignature(s)],
          // The server default mask (effects.status,checkpoint) omits
          // the digest the wallet needs for confirmation.
          readMask: const SuiFieldMask(paths: ['digest', 'effects']),
        ),
      ),
    );
  }

  /// Move function descriptor (null when the node has no descriptor).
  Future<SuiFunctionDescriptor?> normalizeFunction({
    required String package,
    required String moduleName,
    required String functionName,
  }) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiGetFunctionRequest(
          packageId: package,
          moduleName: moduleName,
          name: functionName,
        ),
      ),
    );
    return response.function;
  }

  /// Coin metadata (null when the coin has none).
  Future<SuiCoinMetadata?> getCoinMetadata(String coinType) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(SuiGetCoinInfoRequest(coinType: coinType)),
    );
    return response.metadata;
  }

  /// Objects backing the coins of `coinType` owned by `address` (every
  /// `Coin<T>` object when `coinType` is null), one page per event.
  Stream<List<SuiObject>> watchAccountCoins(
    SuiAddress address, {
    String? coinType,
  }) async* {
    List<int>? pageToken;
    do {
      final response = await provider.request(
        SuiGrpcRequestMessage(
          SuiListOwnedObjectsRequest(
            owner: address.address,
            pageSize: 50,
            pageToken: pageToken,
            readMask: const SuiFieldMask(
              paths: [
                'object_id',
                'version',
                'digest',
                'object_type',
                'balance',
                'previous_transaction',
              ],
            ),
          ),
        ),
      );
      final page = <SuiObject>[];
      for (final object in response.objects) {
        final tag = object.objectType ?? '';
        if (coinType != null) {
          if (_isCoinOfType(tag, coinType)) page.add(object);
        } else if (coinTypeOf(tag) != null) {
          page.add(object);
        }
      }
      if (page.isNotEmpty) yield page;
      pageToken = response.nextPageToken?.toList();
    } while (pageToken != null && pageToken.isNotEmpty);
  }

  /// One page of objects owned by [owner] (for NFT discovery etc.).
  ///
  /// [objectType] optionally limits listed types. `cursor` is the base64
  /// page token; `limit` caps the page (server max applies). Always reads
  /// [_objectReadMask].
  Future<({List<SuiObject> objects, String? nextCursor})> getOwnedObjects({
    required SuiAddress owner,
    String? objectType,
    String? cursor,
    int? limit,
  }) async {
    List<int>? pageToken;
    if (cursor != null) {
      pageToken = B64Decoder.decode(cursor).toList();
    }
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiListOwnedObjectsRequest(
          owner: owner.address,
          pageSize: limit ?? 50,
          pageToken: pageToken,
          readMask: _objectReadMask,
          objectType: objectType,
        ),
      ),
    );
    final token = response.nextPageToken;
    if (token == null || token.isEmpty) {
      return (objects: response.objects, nextCursor: null);
    }
    return (
      objects: response.objects,
      nextCursor: B64Encoder.encode(token.toList()),
    );
  }

  /// Owned objects of [owner], one page per event, following cursors.
  /// Unfiltered (coin filtering happens in [watchAccountCoins] or by
  /// consumers).
  Stream<List<SuiObject>> watchOwnedObjects({
    required SuiAddress owner,
    String? objectType,
    int? limit,
  }) async* {
    String? cursor;
    do {
      final page = await getOwnedObjects(
        owner: owner,
        objectType: objectType,
        cursor: cursor,
        limit: limit,
      );
      if (page.objects.isNotEmpty) yield page.objects;
      cursor = page.nextCursor;
    } while (cursor != null);
  }

  /// Objects by id, keyed by the requested id in order.
  ///
  /// Batches are chunked (50 ids): `BatchGetObjects` rejects oversized
  /// batches. Always reads [_objectReadMask].
  Future<Map<String, SuiGetObjectResult>> getObjects(
    List<String> objectIds,
  ) async {
    final result = <String, SuiGetObjectResult>{};
    for (int i = 0; i < objectIds.length; i += 50) {
      final chunk = objectIds.sublist(
        i,
        i + 50 > objectIds.length ? objectIds.length : i + 50,
      );
      final response = await provider.request(
        SuiGrpcRequestMessage(
          SuiBatchGetObjectsRequest(
            requests: [
              for (final id in chunk) SuiGetObjectRequest(objectId: id),
            ],
            readMask: _objectReadMask,
          ),
        ),
      );
      for (int j = 0; j < chunk.length && j < response.objects.length; j++) {
        result[chunk[j]] = response.objects[j];
      }
    }
    return result;
  }

  /// Chain identifier string (for network validation).
  Future<String> getChainId() async {
    final info = await provider.request(
      SuiGrpcRequestMessage(SuiGetServiceInfoRequest()),
    );
    final decode = StringUtils.tryEncode(
      info.chainId,
      encoding: StringEncoding.base58,
    );
    return decode?.sublist(0, 4).toHex() ?? '';
  }

  /// Full transaction response (for status checks; always reads
  /// `[digest, effects]`).
  Future<SuiExecutedTransaction> getTransaction(String digest) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiGetTransactionRequest(
          digest: digest,
          readMask: const SuiFieldMask(paths: ['digest', 'effects']),
        ),
      ),
    );
    final tx = response.transaction;
    if (tx == null) {
      throw BuError(
        DefaultErrorType.notFound,
        "Transaction not found.",
        details: {"digest": digest},
      );
    }
    return tx;
  }

  /// Status of a transaction by digest: failed when effects report
  /// failure, block otherwise. Unknown digests and missing effects throw.
  Future<SuiTxStatus> getTransactionStatus(String digest) async {
    final receipt = await provider.request(
      SuiRequestGetTransactionBlock(
        transactionDigest: digest,
        options: const SuiApiTransactionBlockResponseOptions(showEffects: true),
      ),
    );
    final effects = receipt.effects;
    if (effects == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Transaction effects missing.",
        details: {"digest": digest},
      );
    }
    if (!effects.status.status.isSuccess) return SuiTxStatus.failed;
    return SuiTxStatus.block;
  }

  /// Coins of [owner] via `suix_getCoins` (optionally filtered by
  /// [coinType]).
  Future<List<SuiApiCoinResponse>> getCoins({
    required SuiAddress owner,
    String? coinType,
  }) async {
    final response = await provider.request(
      SuiRequestGetCoins(owner: owner, coinType: coinType),
    );
    return response.data;
  }

  /// Dry-runs [transaction] and returns it with a safe gas budget:
  /// computation cost plus overhead, floored at the overhead so estimation
  /// never underfunds. Failed dry-runs throw.
  Future<SuiTransactionDataV1> dryRun(SuiTransactionDataV1 transaction) async {
    final response = await provider.request(
      SuiRequestDryRunTransactionBlock(
        txBytes: StringUtils.decode(
          transaction.toVariantBcs(),
          encoding: StringEncoding.base64,
        ),
      ),
    );
    final effects = response.effects;
    if (!effects.status.status.isSuccess) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Sui transaction dry-run failed.",
        details: {"error": effects.status.error},
      );
    }
    const overhead = 1000;
    final safeOverHead = BigInt.from(overhead) * transaction.gasData.price;
    final baseOverHead = effects.gasUsed.computationCost + safeOverHead;
    BigInt budget =
        baseOverHead +
        effects.gasUsed.storageCost -
        effects.gasUsed.storageRebate;
    if (budget < baseOverHead) {
      budget = baseOverHead;
    }
    return transaction.copyWith(
      gasData: transaction.gasData.copyWith(budget: budget),
    );
  }

  /// Executes a base64-BCS transaction with raw string signatures,
  /// returning its digest. Failed executions throw.
  Future<String> sendTransaction({
    required SuiTransactionDataV1 transaction,
    required List<String> signatures,
  }) async {
    final response = await provider.request(
      SuiRequestExecuteTransactionBlock(
        txBytes: transaction.toVariantBcsBase64(),
        signatures: signatures,
        options: const SuiApiTransactionBlockResponseOptions(showEffects: true),
      ),
    );
    final effects = response.effects;
    if (effects != null && !effects.status.status.isSuccess) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Sui transaction failed.",
        details: {"error": effects.status.error},
      );
    }
    return response.digest;
  }

  /// Polls until [transactionId] succeeds, throwing with execution details
  /// on failure or on [timeout].
  Future<void> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 2),
    Duration periodicTimeOut = const Duration(seconds: 3),
  }) async {
    Timer? timer;
    try {
      final Completer<void> completer = Completer<void>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        if (completer.isCompleted) return;
        try {
          final receipt = await provider.request(
            SuiRequestGetTransactionBlock(
              transactionDigest: transactionId,
              options: const SuiApiTransactionBlockResponseOptions(
                showEffects: true,
              ),
            ),
          );
          final effects = receipt.effects;
          if (effects == null) return;
          if (effects.status.status.isSuccess) {
            completer.complete();
          } else {
            completer.completeError(
              BuError(
                OnChainErrorType.suiPlugin,
                "Sui transaction failed.",
                details: {"error": effects.status.error},
              ),
            );
          }
        } catch (_) {}
      });
      await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Transaction confirmation failed within the allotted timeout.",
        details: {'timeout': timeout.toString()},
      );
    } finally {
      timer?.cancel();
      timer = null;
    }
  }

  /// Latest checkpoint sequence number. Transport failures throw.
  Future<BigInt?> getBlockHeight() async {
    final checkpoint = await provider.request(
      const SuiRequestGetLatestCheckpointSequenceNumber(),
    );
    return BigintUtils.parse(checkpoint);
  }

  /// Active validators from the latest system state.
  Future<List<SuiValidator>> getActiveValidators() async {
    final state = await getLatestSuiSystemState();
    return state.validators?.activeValidators ?? [];
  }

  /// A checkpoint (block) by sequence number or digest.
  Future<SuiCheckpoint> getCheckpoint({
    BigInt? sequenceNumber,
    String? digest,
  }) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiGetCheckpointRequest(
          sequenceNumber: sequenceNumber,
          digest: digest,
          readMask: const SuiFieldMask(
            paths: [
              'sequence_number',
              'digest',
              'summary',
              'signature',
              'transactions',
            ],
          ),
        ),
      ),
    );
    final checkpoint = response.checkpoint;
    if (checkpoint == null) {
      throw BuError(
        DefaultErrorType.notFound,
        "Checkpoint not found.",
        details: {
          "sequenceNumber": sequenceNumber?.toString(),
          "digest": digest,
        },
      );
    }
    return checkpoint;
  }

  /// Checkpoints as one page (latest first when [descending]).
  Future<List<SuiCheckpoint>> listCheckpoints({
    bool descending = true,
    int? limit,
    BigInt? startCheckpoint,
    BigInt? endCheckpoint,
  }) async {
    final frames = await provider.requestOnce(
      SuiGrpcRequestMessage(
        SuiListCheckpointsRequest(
          readMask: const SuiFieldMask(
            paths: [
              'sequence_number',
              'digest',
              'summary',
              'signature',
              'transactions',
            ],
          ),
          startCheckpoint: startCheckpoint,
          endCheckpoint: endCheckpoint,
          options: SuiQueryOptions(
            limit: limit,
            ordering:
                descending
                    ? SuiOrdering.orderingDescending
                    : SuiOrdering.orderingAscending,
          ),
        ),
      ),
    );
    return [
      for (final f in frames)
        if (f.checkpoint != null) f.checkpoint!,
    ];
  }

  /// A single object by id.
  Future<SuiGetObjectResponse> getObject(String objectId) async {
    return provider.request(
      SuiGrpcRequestMessage(
        SuiGetObjectRequest(objectId: objectId, readMask: _objectReadMask),
      ),
    );
  }

  /// Several objects by id (order-preserving; missing ones carry errors).
  Future<List<SuiGetObjectResult>> multiGetObjects(
    List<String> objectIds,
  ) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiBatchGetObjectsRequest(
          requests: [
            for (final id in objectIds) SuiGetObjectRequest(objectId: id),
          ],
          readMask: _objectReadMask,
        ),
      ),
    );
    return response.objects;
  }

  /// Query events. Takes the native gRPC [filter] (runs unfiltered when
  /// null). `cursor` is base64 watermark bytes.
  Future<List<SuiEvent>> queryEvents({
    SuiEventFilter? filter,
    String? cursor,
    int? limit,
    bool descending = false,
  }) async {
    List<int>? after;
    if (cursor != null) {
      try {
        after = B64Decoder.decode(cursor).toList();
      } catch (_) {
        throw BuError(
          DefaultErrorType.badBase64,
          "Invalid gRPC event cursor (base64 watermark expected).",
          details: {"cursor": cursor},
        );
      }
    }
    final frames = await provider.requestOnce(
      SuiGrpcRequestMessage(
        SuiListEventsRequest(
          filter: filter,
          options: SuiQueryOptions(
            limit: limit,
            after: after,
            ordering:
                descending
                    ? SuiOrdering.orderingDescending
                    : SuiOrdering.orderingAscending,
          ),
        ),
      ),
    );
    return [
      for (final f in frames)
        if (f.event != null) f.event!,
    ];
  }

  /// Query transactions. Takes the native gRPC [filter] (runs unfiltered
  /// when null). `cursor` is base64 watermark bytes.
  Future<List<SuiExecutedTransaction>> queryTransactions({
    SuiTransactionFilter? filter,
    String? cursor,
    int? limit,
    bool descending = false,
  }) async {
    List<int>? after;
    if (cursor != null) {
      try {
        after = B64Decoder.decode(cursor).toList();
      } catch (_) {
        throw BuError(
          DefaultErrorType.badBase64,
          "Invalid gRPC transaction cursor (base64 watermark expected).",
          details: {"cursor": cursor},
        );
      }
    }
    final frames = await provider.requestOnce(
      SuiGrpcRequestMessage(
        SuiListTransactionsRequest(
          filter: filter,
          options: SuiQueryOptions(
            limit: limit,
            after: after,
            ordering:
                descending
                    ? SuiOrdering.orderingDescending
                    : SuiOrdering.orderingAscending,
          ),
        ),
      ),
    );
    return [
      for (final f in frames)
        if (f.transaction != null) f.transaction!,
    ];
  }

  /// Current system state (validators, rates, epoch).
  Future<SuiSystemState> getLatestSuiSystemState() async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiGetEpochRequest(
          readMask: const SuiFieldMask(paths: ['system_state']),
        ),
      ),
    );
    final state = response.epoch?.systemState;
    if (state == null) {
      throw BuError(OnChainErrorType.suiPlugin, "Epoch has no system state.");
    }
    return state;
  }

  /// Resolves a SuiNS name to its target address.
  Future<String> resolveName(String name) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(SuiLookupNameRequest(name: name)),
    );
    final address = response.record?.targetAddress;
    if (address == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        'SuiNS name has no record.',
        details: const {},
      );
    }
    return address;
  }

  /// Reverse-resolves an address to its SuiNS name (null when none).
  Future<String?> reverseResolveNames(SuiAddress address) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiReverseLookupNameRequest(address: address.address),
      ),
    );
    return response.record?.name;
  }

  /// Dynamic fields of `parent` (all pages).
  Future<List<SuiDynamicField>> getDynamicFields(SuiAddress parent) async {
    final fields = <SuiDynamicField>[];
    List<int>? pageToken;
    do {
      final response = await provider.request(
        SuiGrpcRequestMessage(
          SuiListDynamicFieldsRequest(
            parent: parent.address,
            pageSize: 50,
            pageToken: pageToken,
          ),
        ),
      );
      fields.addAll(response.dynamicFields);
      pageToken = response.nextPageToken?.toList();
    } while (pageToken != null && pageToken.isNotEmpty);
    return fields;
  }

  /// Balance of `coinType` (defaults to SUI) owned by `owner`.
  Future<SuiBalance> getBalance(SuiAddress owner, {String? coinType}) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiGetBalanceRequest(owner: owner.address, coinType: coinType),
      ),
    );
    final balance = response.balance;
    if (balance == null) {
      throw BuError(
        DefaultErrorType.notFound,
        "Balance not found.",
        details: {"owner": owner.address},
      );
    }
    return balance;
  }

  /// Verifies a signature via the node (`SignatureVerificationService`).
  ///
  /// [message] is raw BCS bytes tagged with [messageKind] (`TransactionData`
  /// or `PersonalMessage`); [signature] is a BCS [SuiBaseSignature] model.
  Future<bool> verifySignature({
    required List<int> message,
    required String messageKind,
    required SuiBaseSignature signature,
    String? address,
  }) async {
    final response = await provider.request(
      SuiGrpcRequestMessage(
        SuiVerifySignatureRequest(
          message: SuiBcs(name: messageKind, value: message),
          signature: _signatureToProto(signature),
          address: address,
        ),
      ),
    );
    return response.isValid ?? false;
  }

  /// Streams checkpoints (`SubscriptionService`).
  Stream<SuiSubscribeCheckpointsResponse> subscribeCheckpoints({
    SuiFieldMask? readMask,
  }) {
    return provider.requestStream(
      SuiGrpcRequestMessage(SuiSubscribeCheckpointsRequest(readMask: readMask)),
    );
  }

  /// Streams transactions (`SubscriptionService`).
  Stream<SuiSubscribeTransactionsResponse> subscribeTransactions({
    SuiFieldMask? readMask,
  }) {
    return provider.requestStream(
      SuiGrpcRequestMessage(
        SuiSubscribeTransactionsRequest(readMask: readMask),
      ),
    );
  }

  /// Streams events (`SubscriptionService`).
  Stream<SuiSubscribeEventsResponse> subscribeEvents({SuiFieldMask? readMask}) {
    return provider.requestStream(
      SuiGrpcRequestMessage(SuiSubscribeEventsRequest(readMask: readMask)),
    );
  }

  /// Move package introspection (`MovePackageService`).
  Future<SuiGetPackageResponse> getPackage(String packageId) {
    return provider.request(
      SuiGrpcRequestMessage(SuiGetPackageRequest(packageId: packageId)),
    );
  }

  /// Move datatype descriptor (`MovePackageService`).
  Future<SuiGetDatatypeResponse> getDatatype({
    required String packageId,
    required String moduleName,
    required String typeName,
  }) {
    return provider.request(
      SuiGrpcRequestMessage(
        SuiGetDatatypeRequest(
          packageId: packageId,
          moduleName: moduleName,
          name: typeName,
        ),
      ),
    );
  }

  /// Package versions (`MovePackageService`).
  Future<SuiListPackageVersionsResponse> listPackageVersions(String packageId) {
    return provider.request(
      SuiGrpcRequestMessage(
        SuiListPackageVersionsRequest(packageId: packageId),
      ),
    );
  }
}
