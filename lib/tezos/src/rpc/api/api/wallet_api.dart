import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/operations_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';

mixin TezosWalletApi on TezosOperationsApi, TezosPipelineApi {
  TezosTransactionOperation buildStake({
    required TezosAddress source,
    required BigInt amount,
  }) {
    return TezosTransactionOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount,
      destination: source,
      parameters: TezosContractParameters(
        entrypoint: TezosEntrypointStake(),
        value: MichelineUtils.unit(),
      ),
    );
  }

  TezosTransactionOperation buildUnstake({
    required TezosAddress source,
    required BigInt amount,
  }) {
    return TezosTransactionOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount,
      destination: source,
      parameters: TezosContractParameters(
        entrypoint: TezosEntrypointUnstake(),
        value: MichelineUtils.unit(),
      ),
    );
  }

  TezosTransactionOperation buildFinalizeUnstake({
    required TezosAddress source,
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
        entrypoint: TezosEntrypointFinalizeUnstake(),
        value: MichelineUtils.unit(),
      ),
    );
  }

  Future<TezosInjectResult> _sendWallet({
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

  Future<TezosInjectResult> stake({
    required TezosOperationSource source,
    required BigInt amount,
    bool wait = true,
  }) => _sendWallet(
    contents: [buildStake(source: source.address, amount: amount)],
    source: source,
    wait: wait,
  );

  Future<TezosInjectResult> unstake({
    required TezosOperationSource source,
    required BigInt amount,
    bool wait = true,
  }) => _sendWallet(
    contents: [buildUnstake(source: source.address, amount: amount)],
    source: source,
    wait: wait,
  );

  Future<TezosInjectResult> finalizeUnstake({
    required TezosOperationSource source,
    bool wait = true,
  }) => _sendWallet(
    contents: [buildFinalizeUnstake(source: source.address)],
    source: source,
    wait: wait,
  );
}
