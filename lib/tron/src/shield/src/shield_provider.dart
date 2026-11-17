import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/models.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/methods/methods/grpc.dart';
import 'shield_keys.dart';
import 'shield_note.dart';
import 'shield_scanner.dart';
import 'sapling_note.dart';
import 'types.dart';

mixin TronShieldClientApi {
  IGrpcProvider<
    IServiceProvider,
    BaseTronServiceRequestParams,
    TronGrpcRequestDetails
  >
  get provider;

  /// Server-side scan by ivk (returns server-decrypted notes).
  Future<TronDecryptNotes> scanNoteByIvk({
    required List<int> ivk,
    required BigInt startBlock,
    required BigInt endBlock,
  }) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletScanNoteByIvk(
          scanNoteByIvk: TronIvkDecryptParameters(
            startBlockIndex: startBlock,
            endBlockIndex: endBlock,
            ivk: ivk,
          ),
        ),
      ),
    );
  }

  Future<TronDecryptNotes> scanNoteByOvk({
    required List<int> ovk,
    required BigInt startBlock,
    required BigInt endBlock,
  }) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletScanNoteByOvk(
          scanNoteByOvk: TronOvkDecryptParameters(
            startBlockIndex: startBlock,
            endBlockIndex: endBlock,
            ovk: ovk,
          ),
        ),
      ),
    );
  }

  Future<TronDecryptNotesMarked> scanAndMarkNoteByIvk({
    required List<int> ivk,
    required List<int> ak,
    required List<int> nk,
    required BigInt startBlock,
    required BigInt endBlock,
  }) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletScanAndMarkNoteByIvk(
          scanAndMarkNoteByIvk: TronIvkDecryptAndMarkParameters(
            startBlockIndex: startBlock,
            endBlockIndex: endBlock,
            ivk: ivk,
            ak: ak,
            nk: nk,
          ),
        ),
      ),
    );
  }

  Future<TronBytesMessage> getRcm() {
    return provider.request(
      TronGrpcRequestMessage(TronWalletGetRcm(getRcm: TronEmptyMessage())),
    );
  }

  Future<TronSpendResult> isSpend(TronNoteParameters params) {
    return provider.request(
      TronGrpcRequestMessage(TronWalletIsSpend(isSpend: params)),
    );
  }

  Future<TronIncrementalMerkleVoucherInfo> getMerkleTreeVoucherInfo(
    TronOutputPointInfo params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletGetMerkleTreeVoucherInfo(getMerkleTreeVoucherInfo: params),
      ),
    );
  }

  /// NOTE(testnet): sends `ask/nsk/ovk` to the fullnode. Use throwaway
  /// shield keys + small amounts on Nile/Shasta only.
  Future<TronTransactionExtention> createShieldedTransaction(
    TronPrivateParameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletCreateShieldedTransaction(createShieldedTransaction: params),
      ),
    );
  }

  static TronPrivateParameters buildMintParams({
    required List<int> transparentFromAddress,
    required SaplingOutgoingViewingKey ovk,
    required BigInt fromAmount,
    required List<
      ({String paymentAddress, BigInt value, List<int> rcm, List<int>? memo})
    >
    receives,
    BigInt? timeout,
  }) {
    return TronPrivateParameters(
      transparentFromAddress: transparentFromAddress,
      ovk: List<int>.from(ovk.inner),
      fromAmount: fromAmount,
      shieldedReceives:
          receives
              .map(
                (r) => TronReceiveNote(
                  note: TronNote(
                    value: r.value,
                    paymentAddress: r.paymentAddress,
                    rcm: r.rcm,
                    memo: r.memo ?? List<int>.filled(512, 0),
                  ),
                ),
              )
              .toList(),
      timeout: timeout ?? BigInt.from(300),
    );
  }

  static TronSpendNote buildSpendNote({
    required TronNote note,
    required List<int> alpha,
    required TronIncrementalMerkleVoucher voucher,
  }) {
    return TronSpendNote(note: note, alpha: alpha, voucher: voucher);
  }

  Future<TronShieldedTRC20Parameters> createShieldedContractParameters(
    TronPrivateShieldedTRC20Parameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletCreateShieldedContractParameters(
          createShieldedContractParameters: params,
        ),
      ),
    );
  }

  Future<TronDecryptNotesTRC20> scanShieldedTRC20NotesByIvk(
    TronIvkDecryptTRC20Parameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletScanShieldedTRC20NotesByIvk(
          scanShieldedTRC20NotesByIvk: params,
        ),
      ),
    );
  }

  Future<TronDecryptNotesTRC20> scanShieldedTRC20NotesByOvk(
    TronOvkDecryptTRC20Parameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletScanShieldedTRC20NotesByOvk(
          scanShieldedTRC20NotesByOvk: params,
        ),
      ),
    );
  }

  Future<TronNullifierResult> isShieldedTRC20ContractNoteSpent(
    TronNfTRC20Parameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletIsShieldedTRC20ContractNoteSpent(
          isShieldedTRC20ContractNoteSpent: params,
        ),
      ),
    );
  }

  Future<TronBytesMessage> getTriggerInputForShieldedTRC20Contract(
    TronShieldedTRC20TriggerContractParameters params,
  ) {
    return provider.request(
      TronGrpcRequestMessage(
        TronWalletGetTriggerInputForShieldedTRC20Contract(
          getTriggerInputForShieldedTRC20Contract: params,
        ),
      ),
    );
  }

  static TronPrivateShieldedTRC20Parameters buildMintTRC20Params({
    required SaplingOutgoingViewingKey ovk,
    required String fromAmount,
    required List<
      ({String paymentAddress, BigInt value, List<int> rcm, List<int>? memo})
    >
    receives,
    required List<int> shieldedContractAddress,
  }) {
    return TronPrivateShieldedTRC20Parameters(
      ovk: List<int>.from(ovk.inner),
      fromAmount: fromAmount,
      shieldedReceives:
          receives
              .map(
                (r) => TronReceiveNote(
                  note: TronNote(
                    value: r.value,
                    paymentAddress: r.paymentAddress,
                    rcm: r.rcm,
                    memo: r.memo ?? List<int>.filled(512, 0),
                  ),
                ),
              )
              .toList(),
      shieldedTrc20ContractAddress: shieldedContractAddress,
    );
  }

  /// High-level: server scan + local verification via blockchain_utils.
  /// Server returns plaintext TronNote (value/payment_address/rcm/memo);
  /// we rebuild TronSaplingNote locally, recompute cmu/nullifier and only
  /// return notes that verify against one of [keys].
  Future<List<TronShieldScannedNote>> scanShieldedNotesLocal({
    required List<TronShieldScanKey> keys,
    required BigInt startBlock,
    required BigInt endBlock,
  }) async {
    final out = <TronShieldScannedNote>[];
    for (final k in keys) {
      final res = await scanNoteByIvk(
        ivk: List<int>.from(k.ivk.toBytes()),
        startBlock: startBlock,
        endBlock: endBlock,
      );
      for (final tx in res.noteTxs) {
        final note = tx.note;
        if (note == null ||
            note.paymentAddress == null ||
            note.value == null ||
            note.rcm == null) {
          continue;
        }
        try {
          late SaplingPaymentAddress addr;
          try {
            addr = TronShieldAddressCodec.fromBech32(note.paymentAddress!);
          } catch (_) {
            addr = SaplingPaymentAddress.fromBytes(
              BytesUtils.fromHexString(note.paymentAddress!),
            );
          }
          // rcm from server is commitment randomness scalar bytes.
          final rseed = TronSaplingRSeedBefore(JubJubFr.fromBytes(note.rcm!));
          final tNote = TronSaplingNote(
            recipient: addr,
            value: ShieldAmount(note.value!),
            rseed: rseed,
          );
          // Verify ownership: recompute pk_d from ivk must match.
          final derived = SaplingDiversifiedTransmissionKey.derive(
            d: addr.diversifier,
            ivk: k.ivk.inner,
          );
          if (!BytesUtils.bytesEqual(
            List<int>.from(derived.toBytes()),
            List<int>.from(addr.transmissionKey.toBytes()),
          )) {
            continue;
          }
          tNote.cmu();
          TronSaplingNullifier? nf;
          if (k.fvk != null) {
            try {
              nf = tNote.nullifier(nk: k.fvk!.vk.nk, position: tx.index ?? 0);
            } catch (_) {
              nf = null;
            }
          }
          out.add(
            TronShieldScannedNote(
              note: TronShieldDecryptedNote(
                note: tNote,
                recipient: addr,
                memo: note.memo,
                position: tx.index ?? 0,
                nullifier: nf,
                encCiphertext: const [],
                outCiphertext: const [],
                ephemeralKey: const [],
              ),
              ivk: k.ivk,
            ),
          );
        } catch (_) {
          continue;
        }
      }
    }
    return out;
  }
}

/// Nile / Shasta endpoints for real-network tests.
class TronShieldTestnet {
  static const String nileGrpc = 'grpc.nile.trongrid.io';
  static const int nileGrpcPort = 50051;
  static const String nileFullnode = 'https://nile.trongrid.io';
  static const String shastaGrpc = 'grpc.shasta.trongrid.io';
  static const int shastaGrpcPort = 50051;
  static const String shastaFullnode = 'https://api.shasta.trongrid.io';
}
