import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/operations_api.dart';
import 'package:on_chain/tezos/src/rpc/api/api/pipeline_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/types/source.dart';

mixin TezosTicketApi on TezosOperationsApi, TezosPipelineApi {
  TezosTransferTicketOperation buildTransferTicket({
    required TezosAddress source,
    required MichelineExpr ticketContents,
    required MichelineExpr ticketTy,
    required TezosAddress ticketTicketer,
    required BigInt ticketAmount,
    required TezosAddress destination,
    String entrypoint = 'default',
  }) {
    return TezosTransferTicketOperation(
      source: source,
      fee: BigInt.zero,
      counter: BigInt.zero,
      gasLimit: BigInt.zero,
      storageLimit: BigInt.zero,
      contents: ticketContents,
      ty: ticketTy,
      ticketer: ticketTicketer,
      amount: ticketAmount,
      destination: destination,
      entrypoint: entrypoint,
    );
  }

  Future<TezosInjectResult> transferTicket({
    required TezosOperationSource source,
    required MichelineExpr ticketContents,
    required MichelineExpr ticketTy,
    required TezosAddress ticketTicketer,
    required BigInt ticketAmount,
    required TezosAddress destination,
    String entrypoint = 'default',
    bool wait = true,
  }) async {
    final op = buildTransferTicket(
      source: source.address,
      ticketContents: ticketContents,
      ticketTy: ticketTy,
      ticketTicketer: ticketTicketer,
      ticketAmount: ticketAmount,
      destination: destination,
      entrypoint: entrypoint,
    );

    return await injectOperations(contents: [op], source: source, wait: wait);
  }
}
