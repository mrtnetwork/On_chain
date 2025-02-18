import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/api/types/types.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/helper/helper.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/bcs/move/types/types.dart';

import 'provider.dart';

/// A helper mixin for creating various Aptos raw transactions, including transfers, batch transfers,
/// module publishing, and script executions.
///
/// This mixin extends [AptosQuickApiProviderHelper] to leverage account-related utilities.
mixin AptosQuickApiTransactionHelper on AptosQuickApiProviderHelper {
  /// Creates a raw transaction for transferring Aptos tokens from the [sender] to the specified [transferParams].
  ///
  /// - [sender]: The address initiating the transaction.
  /// - [transferParams]: The parameters defining the transfer, such as the amount and destination.
  /// - [params] (optional): Custom transaction parameters like gas fees, expiration time, etc.
  ///
  /// Throws an exception if the destination account is inactive and [allowCreate] is set to `false`.
  Future<AptosRawTransaction> createTransferTransaction({
    required AptosAddress sender,
    required AptosTransferParams transferParams,
    AptosApiBuildTransactionParams? params,
  }) async {
    final isActive = await accountIsActive(transferParams.destination);

    if (!transferParams.allowCreate && !isActive) {
      throw DartAptosPluginException(
        "Account is not active.",
        details: {"address": transferParams.destination.toString()},
      );
    }

    final entryFunction = isActive
        ? AptosHelper.createCoinTransferEntry(transferParams)
        : AptosHelper.createAccountTransferEntry(transferParams);

    final transactionPayload =
        AptosTransactionPayloadEntryFunction(entryFunction: entryFunction);

    return buildTransaction(
      sender: sender,
      transactionPayload: transactionPayload,
      params: params,
    );
  }

  /// Builds a raw transaction with the provided parameters.
  ///
  /// - [sender]: The sender's address.
  /// - [transactionPayload]: The transaction payload to be executed on-chain.
  /// - [params] (optional): Custom transaction settings like gas fees, expiration time, sequence number, etc.
  Future<AptosRawTransaction> buildTransaction({
    required AptosAddress sender,
    required AptosTransactionPayload transactionPayload,
    AptosApiBuildTransactionParams? params,
  }) async {
    final BigInt expire = params?.transactionExpireTime ??
        BigInt.from(DateTime.now()
                .add(const Duration(minutes: 2))
                .millisecondsSinceEpoch ~/
            1000);

    return AptosRawTransaction(
      sender: sender,
      sequenceNumber:
          params?.sequenceNumber ?? await getAccountSequence(sender),
      transactionPayload: transactionPayload,
      maxGasAmount: params?.maxGasAmount ?? AptosConstants.defaultMaxGasAmount,
      gasUnitPrice: params?.gasUnitPrice ?? await getGasPrice(),
      expirationTimestampSecs: expire,
      chainId: params?.chainId ?? await getChainId(),
    );
  }

  /// Creates a batch transfer transaction to send Aptos tokens to multiple recipients.
  ///
  /// - [sender]: The sender's address.
  /// - [transfers]: A list of transfer parameters for each recipient.
  /// - [params] (optional): Additional transaction settings.
  ///
  /// Throws an exception if any account is inactive and [allowCreate] is set to `false`.
  Future<AptosRawTransaction> createBatchTransferTransaction({
    required AptosAddress sender,
    required List<AptosTransferParams> transfers,
    AptosApiBuildTransactionParams? params,
  }) async {
    if (transfers.isEmpty) {
      throw DartAptosPluginException("At least one transfer required.");
    }

    for (final transfer in transfers) {
      if (!transfer.allowCreate &&
          !await accountIsActive(transfer.destination)) {
        throw DartAptosPluginException(
          "Account is not active.",
          details: {"address": transfer.destination.toString()},
        );
      }
    }

    final transactionPayload = AptosTransactionPayloadEntryFunction(
        entryFunction: AptosHelper.createBatchTransferTransferEntry(transfers));

    return buildTransaction(
        sender: sender, transactionPayload: transactionPayload, params: params);
  }

  /// Creates a transaction to publish a new module to the Aptos blockchain.
  ///
  /// - [sender]: The sender's address.
  /// - [metadataBytes]: Metadata associated with the module.
  /// - [moduleBytes]: A list of compiled module bytecode files.
  /// - [params] (optional): Additional transaction settings.
  Future<AptosRawTransaction> createPublishModuleTransaction({
    required AptosAddress sender,
    required List<int> metadataBytes,
    required List<List<int>> moduleBytes,
    AptosApiBuildTransactionParams? params,
  }) {
    final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
        moduleId: AptosConstants.publishModuleModuleId,
        functionName: AptosConstants.publishModuleFunctionName,
        args: [
          MoveU8Vector(metadataBytes),
          MoveVector<MoveVector<MoveU8>>(
              moduleBytes.map((e) => MoveVector.u8(e)).toList())
        ],
      ),
    );

    return buildTransaction(
        sender: sender, transactionPayload: transactionPayload, params: params);
  }

  /// Creates a simple transaction that calls a function from a specific Aptos module.
  ///
  /// - [sender]: The sender's address.
  /// - [moduleId]: The module containing the target function.
  /// - [functionName]: The name of the function to call.
  /// - [arguments]: The arguments to pass to the function.
  /// - [typeArgs] (optional): Type arguments for generic functions.
  /// - [params] (optional): Additional transaction settings.
  Future<AptosRawTransaction> createSimpleTransaction(
      {required AptosAddress sender,
      required AptosModuleId moduleId,
      required String functionName,
      required List<AptosEntryFunctionArguments<dynamic>> arguments,
      List<AptosTypeTag> typeArgs = const [],
      AptosApiBuildTransactionParams? params}) {
    final transactionPayload = AptosTransactionPayloadEntryFunction(
      entryFunction: AptosTransactionEntryFunction(
          moduleId: moduleId,
          functionName: functionName,
          args: arguments,
          typeArgs: typeArgs),
    );
    return buildTransaction(
        sender: sender, transactionPayload: transactionPayload, params: params);
  }

  /// Creates a script transaction to execute custom bytecode on the Aptos blockchain.
  ///
  /// - [sender]: The sender's address.
  /// - [byteCode]: The compiled bytecode to execute.
  /// - [arguments]: The script arguments required by the bytecode.
  /// - [typeArgs] (optional): Type arguments for the script, if applicable.
  /// - [params] (optional): Additional transaction settings.
  Future<AptosRawTransaction> createScriptTransaction({
    required AptosAddress sender,
    required List<int> byteCode,
    required List<AptosScriptArguments<dynamic>> arguments,
    List<AptosTypeTag> typeArgs = const [],
    AptosApiBuildTransactionParams? params,
  }) {
    final transactionPayload = AptosTransactionPayloadScript(
        script: AptosScript(
            arguments: arguments, typeArgs: typeArgs, byteCode: byteCode));

    return buildTransaction(
        sender: sender, transactionPayload: transactionPayload, params: params);
  }
}
