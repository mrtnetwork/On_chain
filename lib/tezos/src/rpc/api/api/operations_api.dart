import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';
import 'package:on_chain/tezos/src/rpc/api/utils/extensions.dart';

/// Build-only helpers. Use [TezosPipelineApi.injectOperations] to send.
mixin TezosOperationsApi on TezosPipelineApi {
  TezosTransactionOperation buildTransfer({
    required TezosAddress source,
    required TezosAddress destination,
    required BigInt amount,
    TezosContractParameters? parameters,
  }) {
    return TezosTransactionOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount,
      destination: destination,
      parameters: parameters,
    );
  }

  TezosDelegationOperation buildSetDelegate({
    required TezosAddress source,
    TezosAddress? delegate,
  }) {
    return TezosDelegationOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      delegate: delegate,
    );
  }

  TezosOriginationOperation buildOriginate({
    required TezosAddress source,
    required TezosScript script,
    BigInt? balance,
    TezosAddress? delegate,
  }) {
    return TezosOriginationOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      balance: balance ?? BigInt.zero,
      script: script,
      delegate: delegate,
    );
  }

  TezosRegisterGlobalConstantOperation buildRegisterGlobalConstant({
    required TezosAddress source,
    required MichelineExpr value,
  }) {
    return TezosRegisterGlobalConstantOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      value: value,
    );
  }

  TezosIncreasePaidStorageOperation buildIncreasePaidStorage({
    required TezosAddress source,
    required BigInt amount,
    required TezosAddress destination,
  }) {
    return TezosIncreasePaidStorageOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      amount: amount,
      destination: destination,
    );
  }

  Future<TezosInjectResult> _send({
    required List<TezosOperationContent> contents,
    required TezosOperationSource source,
    bool wait = true,
    Duration? timeout,
    Duration? interval,
  }) async {
    return await injectOperations(
      contents: contents,
      source: source,
      wait: wait,
      timeout: timeout,
      interval: interval,
    );
  }

  Future<TezosInjectResult> transfer({
    required TezosOperationSource source,
    required TezosAddress destination,
    required BigInt amount,
    TezosContractParameters? parameters,
    bool wait = true,
  }) {
    return _send(
      contents: [
        buildTransfer(
          source: source.address,
          destination: destination,
          amount: amount,
          parameters: parameters,
        ),
      ],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> reveal({
    required TezosOperationSource source,
    bool wait = true,
  }) async {
    final reveal = await source.getReveal();
    return _send(contents: [reveal], source: source, wait: wait);
  }

  Future<TezosInjectResult> setDelegate({
    required TezosOperationSource source,
    required TezosAddress delegate,
    bool wait = true,
  }) async {
    return await _send(
      contents: [buildSetDelegate(source: source.address, delegate: delegate)],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> undelegate({
    required TezosOperationSource source,
    bool wait = true,
  }) {
    return _send(
      contents: [buildSetDelegate(source: source.address)],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult<TezosAddress>> originate({
    required TezosOperationSource source,
    required TezosScript script,
    BigInt? balance,
    TezosAddress? delegate,
    bool wait = true,
  }) async {
    final result = await _send(
      contents: [
        buildOriginate(
          source: source.address,
          script: script,
          balance: balance,
          delegate: delegate,
        ),
      ],
      source: source,
      wait: wait,
    );
    final originate =
        result
            .getOperationSummary(TezosOperationKind.origination)
            ?.getOriginationResult();
    switch (originate) {
      case OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOriginationApplied(
        :final originatedContracts,
      ):
        for (final i
            in originatedContracts ??
                <OctezUshuaiaN025PsUshuaiContractIdOriginated>[]) {
          return result.mapResult(result: i.contractAddress());
        }
      default:
        break;
    }
    return result.mapResult();
  }

  Future<TezosInjectResult> registerGlobalConstant({
    required TezosOperationSource source,
    required MichelineExpr value,
    bool wait = true,
  }) {
    return _send(
      contents: [
        buildRegisterGlobalConstant(source: source.address, value: value),
      ],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> increasePaidStorage({
    required TezosOperationSource source,
    required TezosAddress destination,
    required BigInt amount,
    bool wait = true,
  }) {
    return _send(
      contents: [
        buildIncreasePaidStorage(
          source: source.address,
          amount: amount,
          destination: destination,
        ),
      ],
      source: source,
      wait: wait,
    );
  }
}
