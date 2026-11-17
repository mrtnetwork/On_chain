import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/operations_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/api/wallet_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';

mixin TezosBakerApi on TezosOperationsApi, TezosPipelineApi, TezosWalletApi {
  /// Register [source] as a baker: delegation with `delegate == source`.
  TezosDelegationOperation buildRegisterBaker({required TezosAddress source}) {
    return TezosDelegationOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      delegate: source,
    );
  }

  TezosTransactionOperation buildSetDelegateParameters({
    required TezosAddress source,
    required BigInt limit,
    required BigInt edge,
  }) {
    return TezosTransactionOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: BigInt.zero,
      destination: source,
      parameters: TezosContractParameters(
        entrypoint: TezosEntrypointSetDelegateParameters(),
        value: MichelineUtils.pair(
          MichelineInt(limit),
          MichelineUtils.pair(MichelineInt(edge), MichelineUtils.unit()),
        ),
      ),
    );
  }

  TezosSetDepositsLimitOperation buildSetDepositsLimit({
    required TezosAddress source,
    BigInt? limit,
  }) {
    return TezosSetDepositsLimitOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      limit: limit,
    );
  }

  TezosUpdateConsensusKeyOperation buildUpdateConsensusKey({
    required TezosAddress source,
    required TezosPublicKey publicKey,
    TezosBlsSignature? proof,
  }) {
    return TezosUpdateConsensusKeyOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      publicKey: publicKey,
      proof: proof,
    );
  }

  TezosUpdateCompanionKeyOperation buildUpdateCompanionKey({
    required TezosAddress source,
    required TezosPublicKey publicKey,
    TezosBlsSignature? proof,
  }) {
    return TezosUpdateCompanionKeyOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      publicKey: publicKey,
      proof: proof,
    );
  }

  // ---------------------------------------------------------------------------
  // High-level send (always local forge via [_sendBaker])
  // ---------------------------------------------------------------------------

  Future<TezosInjectResult> _sendBaker({
    required List<TezosOperationContent> contents,
    required TezosOperationSource source,
    bool wait = true,
  }) async {
    return await injectOperations(
      contents: contents,
      source: source,
      wait: wait,
    );
  }

  /// Register [source] as baker (self-delegation). Required before other baker ops.
  Future<TezosInjectResult> registerBaker({
    required TezosOperationSource source,
    bool wait = true,
  }) {
    return _sendBaker(
      contents: [buildRegisterBaker(source: source.address)],
      source: source,
      wait: wait,
    );
  }

  /// Set or clear baker deposits limit (may be disabled under Adaptive Issuance).
  Future<TezosInjectResult> setDepositsLimit({
    required TezosOperationSource source,
    BigInt? limit,
    bool wait = true,
  }) {
    return _sendBaker(
      contents: [buildSetDepositsLimit(source: source.address, limit: limit)],
      source: source,
      wait: wait,
    );
  }

  /// Adaptive Issuance staking parameters for **this baker**.
  Future<TezosInjectResult> setBakerDelegateParameters({
    required TezosOperationSource source,
    required BigInt limit,
    required BigInt edge,
    bool wait = true,
  }) {
    return _sendBaker(
      contents: [
        buildSetDelegateParameters(
          source: source.address,
          limit: limit,
          edge: edge,
        ),
      ],
      source: source,
      wait: wait,
    );
  }

  /// Rotate consensus key for the baker.
  Future<TezosInjectResult> updateConsensusKey({
    required TezosOperationSource source,
    required TezosPublicKey publicKey,
    TezosBlsSignature? proof,
    bool wait = true,
  }) {
    return _sendBaker(
      contents: [
        buildUpdateConsensusKey(
          source: source.address,
          publicKey: publicKey,
          proof: proof,
        ),
      ],
      source: source,
      wait: wait,
    );
  }

  /// Rotate companion (BLS) key for the baker.
  Future<TezosInjectResult> updateCompanionKey({
    required TezosOperationSource source,
    required TezosPublicKey pk,
    TezosBlsSignature? proof,
    bool wait = true,
  }) {
    return _sendBaker(
      contents: [
        buildUpdateCompanionKey(
          source: source.address,
          publicKey: pk,
          proof: proof,
        ),
      ],
      source: source,
      wait: wait,
    );
  }
}
