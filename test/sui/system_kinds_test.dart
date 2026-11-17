// Tests for Sui system [SuiTransactionKind] BCS models.
//
// Real-wire fixtures were captured from mainnet checkpoint 329700153
// (epoch 1269) via the Sui gRPC `LedgerService/GetCheckpoint` API
// (`Transaction.bcs.value` = BCS `TransactionData`).
//
// Run: `dart test test/sui/system_kinds_test.dart`
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

/// Mainnet `ConsensusCommitPrologueV4` (epoch 1269, round 322791,
/// commit 2026-10-03T06:12:41.137Z). Ground truth cross-checked against the
/// gRPC-parsed JSON view of the same transaction.
const String _v4Tx =
    "0009f504000000000000e7ec0400000000000031b06400a1010000208db7ddc68a2cb64f10bf112a7511519b32b04ba7bbf6806e5eeaa12e1516d7810100201a78da6bf46da3f790b94d6966c4f4e3d5d734750ed85934bbad702c6163e06d0000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000";

/// Mainnet `RandomnessStateUpdate` (epoch 1269, round 41179, 48 random bytes).
const String _randomnessTx =
    "0006f504000000000000dba000000000000030b3a6886edfa2a4a5934e164afb5ee9aa4ceab2d89b266a442638cdf03be5d8f78a496a1a388880f16bbe760665d266d230ef7013000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000";

/// Mainnet `ProgrammableSystemTransaction` (`accumulator_settlement`).
const String _programmableSystemTx =
    "000a0801010000000000000000000000000000000000000000000000000000000000000acc4710c92800000000020008f5040000000000000008278c0500000000000008000000000000000000085c14100000000000002034729f8dd6d4e9bf5243b327c6462552a2d092808c537b9bbae7ee1a0e080a3900100000000000000000000000000000000000105c1410000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000216616363756d756c61746f725f736574746c656d656e7413736574746c656d656e745f70726f6c6f677565000601000001010001020001030001030001040000000000000000000000000000000000000000000000000000000000000000000216616363756d756c61746f725f736574746c656d656e740b736574746c655f75313238010700000000000000000000000000000000000000000000000000000000000000020762616c616e63650742616c616e636501070000000000000000000000000000000000000000000000000000000000000002037375690353554900040100000105000106000107000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000";

void systemKindsTest() {
  group('Sui/System transaction kinds (mainnet wire vectors)', () {
    test('decode + re-encode ConsensusCommitPrologueV4', () {
      final bytes = BytesUtils.fromHexString(_v4Tx);
      final data = SuiTransactionData.deserialize(bytes);
      expect(data, isA<SuiTransactionDataV1>());
      final kind = (data as SuiTransactionDataV1).kind;
      expect(kind, isA<SuiTransactionKindConsensusCommitPrologueV4>());
      final v4 = kind as SuiTransactionKindConsensusCommitPrologueV4;
      expect(v4.epoch, BigInt.from(1269));
      expect(v4.round, BigInt.from(322791));
      expect(v4.subDagIndex, isNull);
      expect(v4.commitTimestampMs, BigInt.from(1791007961137));
      expect(
        BytesUtils.toHexString(v4.consensusCommitDigest.digest),
        "8db7ddc68a2cb64f10bf112a7511519b32b04ba7bbf6806e5eeaa12e1516d781",
      );
      expect(
        v4.consensusDeterminedVersionAssignments,
        isA<SuiCancelledTransactionsV2>(),
      );
      expect(
        (v4.consensusDeterminedVersionAssignments as SuiCancelledTransactionsV2)
            .transactions,
        isEmpty,
      );
      expect(
        BytesUtils.toHexString(v4.additionalStateDigest.digest),
        "1a78da6bf46da3f790b94d6966c4f4e3d5d734750ed85934bbad702c6163e06d",
      );
      // Full round-trip: decode -> encode must reproduce the wire bytes.
      expect(BytesUtils.toHexString(data.toVariantBcs()), _v4Tx);
    });

    test('decode + re-encode RandomnessStateUpdate', () {
      final bytes = BytesUtils.fromHexString(_randomnessTx);
      final data = SuiTransactionData.deserialize(bytes);
      final kind = (data as SuiTransactionDataV1).kind;
      expect(kind, isA<SuiTransactionKindRandomnessStateUpdate>());
      final r = kind as SuiTransactionKindRandomnessStateUpdate;
      expect(r.epoch, BigInt.from(1269));
      expect(r.randomnessRound, BigInt.from(41179));
      expect(r.randomBytes.length, 48);
      expect(
        BytesUtils.toHexString(r.randomBytes).startsWith("b3a6886e"),
        isTrue,
      );
      expect(r.randomnessObjInitialSharedVersion, BigInt.from(326168368));
      expect(BytesUtils.toHexString(data.toVariantBcs()), _randomnessTx);
    });

    test('decode + re-encode ProgrammableSystemTransaction', () {
      final bytes = BytesUtils.fromHexString(_programmableSystemTx);
      final data = SuiTransactionData.deserialize(bytes);
      final kind = (data as SuiTransactionDataV1).kind;
      expect(kind, isA<SuiTransactionKindProgrammableSystemTransaction>());
      final ptb =
          (kind as SuiTransactionKindProgrammableSystemTransaction).transaction;
      expect(ptb.commands.length, 2);
      final first = ptb.commands[0];
      expect(first, isA<SuiCommandMoveCall>());
      final moveCall = (first as SuiCommandMoveCall).moveCall;
      expect(moveCall.module, "accumulator_settlement");
      expect(moveCall.function, "settlement_prologue");
      expect(
        BytesUtils.toHexString(data.toVariantBcs()),
        _programmableSystemTx,
      );
    });

    test('system transactions use zero sender + zero gas coin', () {
      final data =
          SuiTransactionData.deserialize(BytesUtils.fromHexString(_v4Tx))
              as SuiTransactionDataV1;
      expect(
        data.sender.address,
        SuiAddress(
          "0x0000000000000000000000000000000000000000000000000000000000000000",
        ).address,
      );
      expect(data.gasData.budget, BigInt.zero);
      expect(data.expiration, isA<SuiTransactionExpirationNone>());
    });

    test('genesis kind is not decodable (documented limitation)', () {
      // TransactionData{V1, kind=genesis(2)} with an empty object list.
      // Only the discriminant + empty vec are encoded; decoding must fail
      // because genesis object internals are intentionally unmodeled.
      final bytes = BytesUtils.fromHexString(
        "0002000000000000000000000000000000000000000000000000000000000000000000"
        "00010000000000000000000000000000000000000000000000000000000000000000"
        "00000000000000000000000000000000000000002000000000000000000000000000"
        "0000000000000000000000000000000000000000000000001000000000000000000"
        "000000000000000",
      );
      expect(() => SuiTransactionData.deserialize(bytes), throwsA(anything));
    });
  });

  group('Sui/System transaction kinds (synthetic round-trips)', () {
    test('ChangeEpoch with system packages', () {
      final kind = SuiTransactionKindChangeEpoch(
        epoch: BigInt.from(1270),
        protocolVersion: BigInt.from(100),
        storageCharge: BigInt.from(1000),
        computationCharge: BigInt.from(2000),
        storageRebate: BigInt.from(500),
        nonRefundableStorageFee: BigInt.from(10),
        epochStartTimestampMs: BigInt.from(1791007961137),
        systemPackages: [
          SuiSystemPackageUpgrade(
            sequenceNumber: BigInt.one,
            modules: [
              [1, 2, 3],
            ],
            dependencies: [
              SuiAddress(
                "0x0000000000000000000000000000000000000000000000000000000000000000",
              ),
            ],
          ),
        ],
      );
      final decoded = _roundTrip(kind);
      expect(decoded, isA<SuiTransactionKindChangeEpoch>());
      expect(
        (decoded as SuiTransactionKindChangeEpoch).epoch,
        BigInt.from(1270),
      );
      expect(BytesUtils.toHexString(kind.toVariantBcs()), _bcsOf(decoded));
      // Discriminant 1.
      expect(kind.toVariantBcs()[0], 1);
    });

    test('ConsensusCommitPrologue V1..V3', () {
      final v1 = SuiTransactionKindConsensusCommitPrologue(
        epoch: BigInt.from(1269),
        round: BigInt.from(1),
        commitTimestampMs: BigInt.from(1791007961137),
      );
      final v2 = SuiTransactionKindConsensusCommitPrologueV2(
        epoch: BigInt.from(1269),
        round: BigInt.from(2),
        commitTimestampMs: BigInt.from(1791007961137),
        consensusCommitDigest: SuiObjectDigest(List.filled(32, 7)),
      );
      final v3 = SuiTransactionKindConsensusCommitPrologueV3(
        epoch: BigInt.from(1269),
        round: BigInt.from(3),
        subDagIndex: BigInt.from(4),
        commitTimestampMs: BigInt.from(1791007961137),
        consensusCommitDigest: SuiObjectDigest(List.filled(32, 7)),
        consensusDeterminedVersionAssignments: SuiCancelledTransactions(
          transactions: [
            SuiCancelledTransactionEntry(
              digest: SuiObjectDigest(List.filled(32, 9)),
              assignments: [
                SuiObjectVersionAssignment(
                  objectId: SuiAddress(
                    "0x0000000000000000000000000000000000000000000000000000000000000000",
                  ),
                  version: BigInt.from(3),
                ),
              ],
            ),
          ],
        ),
      );
      for (final k in [v1, v2, v3]) {
        final decoded = _roundTrip(k);
        expect(BytesUtils.toHexString(decoded.toVariantBcs()), _bcsOf(k));
      }
      expect(v1.toVariantBcs()[0], 3);
      expect(v2.toVariantBcs()[0], 7);
      expect(v3.toVariantBcs()[0], 8);
      final v3d = _roundTrip(v3) as SuiTransactionKindConsensusCommitPrologueV3;
      expect(v3d.subDagIndex, BigInt.from(4));
      final cancelled =
          v3d.consensusDeterminedVersionAssignments as SuiCancelledTransactions;
      expect(cancelled.transactions.length, 1);
      expect(cancelled.transactions[0].assignments[0].version, BigInt.from(3));
    });

    test('AuthenticatorStateUpdate with JWK', () {
      final kind = SuiTransactionKindAuthenticatorStateUpdate(
        epoch: BigInt.from(1269),
        round: BigInt.from(322791),
        newActiveJwks: [
          SuiTxActiveJwk(
            jwkId: const SuiTxJwkId(
              iss: "https://accounts.google.com",
              kid: "1",
            ),
            jwk: const SuiTxJwk(kty: "RSA", e: "AQAB", n: "xx", alg: "RS256"),
            epoch: BigInt.from(1269),
          ),
        ],
        authenticatorObjInitialSharedVersion: BigInt.from(100),
      );
      final decoded = _roundTrip(kind);
      expect(decoded, isA<SuiTransactionKindAuthenticatorStateUpdate>());
      expect(
        (decoded as SuiTransactionKindAuthenticatorStateUpdate)
            .newActiveJwks[0]
            .jwk
            .alg,
        "RS256",
      );
      expect(BytesUtils.toHexString(decoded.toVariantBcs()), _bcsOf(kind));
      expect(kind.toVariantBcs()[0], 4);
    });

    test('EndOfEpochTransaction with mixed variants', () {
      SuiTxEndOfEpochKind unit(int i) =>
          const [
            SuiEndOfEpochAuthenticatorStateCreate(),
            SuiEndOfEpochRandomnessStateCreate(),
            SuiEndOfEpochDenyListStateCreate(),
            SuiEndOfEpochAccumulatorRootCreate(),
            SuiEndOfEpochCoinRegistryCreate(),
            SuiEndOfEpochDisplayRegistryCreate(),
            SuiEndOfEpochAddressAliasStateCreate(),
            SuiEndOfEpochForwardingAddressRegistryCreate(),
          ][i];
      final kind = SuiTransactionKindEndOfEpochTransaction(
        transactions: [
          SuiEndOfEpochChangeEpoch(
            SuiTransactionKindChangeEpoch(
              epoch: BigInt.from(1270),
              protocolVersion: BigInt.from(100),
              storageCharge: BigInt.zero,
              computationCharge: BigInt.zero,
              storageRebate: BigInt.zero,
              nonRefundableStorageFee: BigInt.zero,
              epochStartTimestampMs: BigInt.zero,
              systemPackages: [],
            ),
          ),
          unit(0),
          SuiEndOfEpochAuthenticatorStateExpire(
            minEpoch: BigInt.from(1269),
            authenticatorObjInitialSharedVersion: BigInt.from(100),
          ),
          unit(1),
          unit(2),
          const SuiEndOfEpochBridgeStateCreate("mainnet"),
          SuiEndOfEpochBridgeCommitteeInit(bridgeSharedVersion: BigInt.from(5)),
          SuiEndOfEpochStoreExecutionTimeObservations(
            SuiStoredExecutionTimeObservations(
              observations: [
                SuiTxExecutionTimeObservation(
                  key: const SuiObservationTransferObjects(),
                  estimates: [
                    SuiAuthorityTimeEstimate(
                      authority: SuiAddress(
                        "0x0000000000000000000000000000000000000000000000000000000000000000",
                      ),
                      secs: BigInt.one,
                      nanos: 2,
                    ),
                  ],
                ),
                SuiTxExecutionTimeObservation(
                  key: SuiObservationMoveEntryPoint(
                    package: SuiAddress(
                      "0x0000000000000000000000000000000000000000000000000000000000000000",
                    ),
                    module: "m",
                    function: "f",
                    typeArguments: [
                      SuiTypeInputPrimitive(SuiTypeInputs.boolean),
                    ],
                  ),
                  estimates: [],
                ),
              ],
            ),
          ),
          unit(3),
          unit(4),
          unit(5),
          unit(6),
          SuiEndOfEpochWriteAccumulatorStorageCost(
            storageCost: BigInt.from(42),
          ),
          unit(7),
        ],
      );
      final decoded = _roundTrip(kind);
      expect(decoded, isA<SuiTransactionKindEndOfEpochTransaction>());
      final txs =
          (decoded as SuiTransactionKindEndOfEpochTransaction).transactions;
      expect(txs.length, 14);
      expect(
        txs.map((e) => e.type.value).toList(),
        List.generate(14, (i) => i),
      );
      expect(BytesUtils.toHexString(decoded.toVariantBcs()), _bcsOf(kind));
      expect(kind.toVariantBcs()[0], 5);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(systemKindsTest, "System Kinds");
}

SuiTransactionKind _roundTrip(SuiTransactionKind kind) {
  final decoded = BcsVariantSerialization.deserialize(
    bytes: kind.toVariantBcs(),
    layout: SuiTransactionKind.layout(),
  );
  return SuiTransactionKind.fromStruct(decoded);
}

String _bcsOf(SuiTransactionKind kind) {
  return BytesUtils.toHexString(kind.toVariantBcs());
}
