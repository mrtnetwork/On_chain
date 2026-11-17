import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/contract/src/types.dart';
import 'package:on_chain/near/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/rpc/helper/transaction.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';
import 'package:on_chain/near/src/rpc/client/src/client.dart';
import 'package:on_chain/near/src/rpc/client/src/transaction_api.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:on_chain/near/src/types/types.dart';

abstract class NearContract {
  BaseNearAddress get contractId;
  Future<ExecuteContractResult<DECODE>>
  call<ENCODE extends Object?, DECODE extends Object?>({
    required NearQuickClient client,
    required BaseNearAddress accountId,
    required NearContractFunction<ENCODE, DECODE> function,
    required BigInt gas,
    required NearSecretKey secretKey,
    required ENCODE args,
    List<NearAction> beforeActions = const [],
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    BigInt? deposit,
  });

  Future<DECODE> read<ENCODE extends Object?, DECODE extends Object?>({
    required NearQuickClient client,
    required ENCODE args,
    required NearContractFunction<ENCODE, DECODE> function,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  });
  Future<ExecuteContractResult<List<int>>> batchCall({
    required NearQuickTransactionApi client,
    required BaseNearAddress accountId,
    required List<NearFunctionCall> actions,
    required NearSecretKey<NearPublicKey> secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
  });
}

abstract class DefaultNearContract implements NearContract {
  const DefaultNearContract();
  @override
  BaseNearAddress get contractId;
  @override
  Future<ExecuteContractResult<DECODE>>
  call<ENCODE extends Object?, DECODE extends Object?>({
    required NearQuickTransactionApi client,
    required BaseNearAddress accountId,
    required NearContractFunction<ENCODE, DECODE> function,
    required BigInt gas,
    required NearSecretKey<NearPublicKey> secretKey,
    required ENCODE args,
    List<NearAction> beforeActions = const [],
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
    BigInt? deposit,
  }) async {
    final result = await client.createAndSendFunctionCallTransaction(
      contractId: contractId,
      accountId: accountId,
      methodName: function.name,
      args: function.encode(args),
      gas: gas,
      secretKey: secretKey,
      deposit: deposit,
      waitUntil: waitUntil,
    );
    final status = result.status();
    DECODE? response;
    if (status case NearRpcFinalExecutionStatusSuccessValue(:final value)) {
      response = function.decode(StringUtils.encode(value));
    }
    return ExecuteContractResult(
      status: status,
      txResponse: result,
      result: response,
    );
  }

  @override
  Future<DECODE> read<ENCODE extends Object?, DECODE extends Object?>({
    required NearQuickClient client,
    required ENCODE args,
    required NearContractFunction<ENCODE, DECODE> function,
    NearBlockReference blockReference = NearBlockReference.optimistic,
  }) async {
    final result = await client.readFunction(
      accountId: contractId,
      argBytes: function.encode(args),
      method: function.name,
    );
    return function.decode(result.value.result);
  }

  @override
  Future<ExecuteContractResult<List<int>>> batchCall({
    required NearQuickTransactionApi client,
    required BaseNearAddress accountId,
    required List<NearFunctionCall> actions,
    required NearSecretKey<NearPublicKey> secretKey,
    NearRpcTxExecutionStatus waitUntil =
        NearRpcTxExecutionStatus.executedOptimistic,
  }) async {
    final result = await client.signAndSendTransaction(
      actions: actions.map((e) => ActionFunctionCall(e)).toList(),
      receiverId: contractId,
      accountId: accountId,
      secretKey: secretKey,
      waitUntil: waitUntil,
    );
    final status = result.status();
    List<int>? response;
    if (status case NearRpcFinalExecutionStatusSuccessValue(:final value)) {
      response = StringUtils.encode(value);
    }
    return ExecuteContractResult(
      status: status,
      txResponse: result,
      result: response,
    );
  }
}
