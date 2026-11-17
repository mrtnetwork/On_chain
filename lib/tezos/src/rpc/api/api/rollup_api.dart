import 'package:blockchain_utils/chain/address/address.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/operations_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';
import 'package:on_chain/tezos/src/rpc/api/utils/extensions.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';

mixin TezosRollupApi on TezosOperationsApi, TezosPipelineApi {
  TezosSmartRollupOriginateOperation buildSmartRollupOriginate({
    required TezosAddress source,
    required TezosSmartRollupKind pvmKind,
    required List<int> kernel,
    required MichelineExpr parametersTy,
    List<TezosAddress>? whitelist,
  }) {
    return TezosSmartRollupOriginateOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      kind: pvmKind,
      bootSector: kernel,
      parametersTy: parametersTy,
      whitelist: whitelist,
    );
  }

  TezosSmartRollupAddMessagesOperation buildSmartRollupAddMessages({
    required TezosAddress source,
    required List<List<int>> message,
  }) {
    return TezosSmartRollupAddMessagesOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      messages: message,
    );
  }

  TezosSmartRollupCementOperation buildSmartRollupCement({
    required TezosAddress source,
    required TezosAddress rollup,
  }) {
    return TezosSmartRollupCementOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
    );
  }

  TezosSmartRollupPublishOperation buildSmartRollupPublish({
    required TezosAddress source,
    required TezosAddress rollup,
    required TezosSmartRollupCommitment commitment,
  }) {
    return TezosSmartRollupPublishOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
      commitment: commitment,
    );
  }

  TezosSmartRollupExecuteOutboxMessageOperation
  buildSmartRollupExecuteOutboxMessage({
    required TezosAddress source,
    required TezosAddress rollup,
    required List<int> cementedCommitment,
    required List<int> outputProof,
  }) {
    return TezosSmartRollupExecuteOutboxMessageOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
      cementedCommitment: cementedCommitment,
      outputProof: outputProof,
    );
  }

  TezosSmartRollupRecoverBondOperation buildSmartRollupRecoverBond({
    required TezosAddress source,
    required TezosAddress rollup,
    required TezosAddress staker,
  }) {
    return TezosSmartRollupRecoverBondOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
      staker: staker,
    );
  }

  TezosSmartRollupRefuteOperation buildSmartRollupRefute({
    required TezosAddress source,
    required TezosAddress rollup,
    required TezosAddress opponent,
    required TezosSmartRollupRefutation refutation,
  }) {
    return TezosSmartRollupRefuteOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
      opponent: opponent,
      refutation: refutation,
    );
  }

  TezosSmartRollupTimeoutOperation buildSmartRollupTimeout({
    required TezosAddress source,
    required TezosAddress rollup,
    required TezosAddress alice,
    required TezosAddress bob,
  }) {
    return TezosSmartRollupTimeoutOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      rollup: rollup,
      stakers: TezosSmartRollupGameIndex(alice: alice, bob: bob),
    );
  }

  Future<TezosInjectResult> _sendRollup({
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

  Future<TezosInjectResult<TezosAddress>> smartRollupOriginate({
    required TezosOperationSource source,

    required TezosSmartRollupKind pvmKind,
    required List<int> kernel,
    required MichelineExpr parametersTy,
    List<TezosAddress>? whitelist,
    bool wait = true,
  }) async {
    final result = await _sendRollup(
      contents: [
        buildSmartRollupOriginate(
          source: source.address,
          pvmKind: pvmKind,
          kernel: kernel,
          parametersTy: parametersTy,
          whitelist: whitelist,
        ),
      ],
      source: source,
      wait: wait,
    );
    final originate =
        result
            .getOperationSummary(TezosOperationKind.smartRollupOriginate)
            ?.getSmartRollupOriginationResult();
    switch (originate) {
      case OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginateApplied(
        :final address,
      ):
        return result.mapResult(
          result: address.fold(
            onString: TezosAddress.new,
            onBytes:
                (e) => TezosAddress.fromBytes(e, type: XtzAddrPrefixes.sr1),
          ),
        );
      default:
        break;
    }
    return result.mapResult();
  }

  Future<TezosInjectResult> smartRollupAddMessages({
    required TezosOperationSource source,
    required List<List<int>> message,
    bool wait = true,
  }) {
    return _sendRollup(
      contents: [
        buildSmartRollupAddMessages(source: source.address, message: message),
      ],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> smartRollupCement({
    required TezosOperationSource source,

    required TezosAddress rollup,
    bool wait = true,
  }) {
    return _sendRollup(
      contents: [
        buildSmartRollupCement(source: source.address, rollup: rollup),
      ],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> smartRollupPublish({
    required TezosOperationSource source,
    required TezosAddress rollup,
    required TezosSmartRollupCommitment commitment,
    bool wait = true,
  }) {
    return _sendRollup(
      contents: [
        buildSmartRollupPublish(
          source: source.address,
          rollup: rollup,
          commitment: commitment,
        ),
      ],
      source: source,
      wait: wait,
    );
  }

  Future<TezosInjectResult> smartRollupRecoverBond({
    required TezosOperationSource source,
    required TezosAddress rollup,
    required TezosAddress staker,
    bool wait = true,
  }) {
    return _sendRollup(
      contents: [
        buildSmartRollupRecoverBond(
          source: source.address,
          rollup: rollup,
          staker: staker,
        ),
      ],
      source: source,
      wait: wait,
    );
  }
}
