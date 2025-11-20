import 'package:blockchain_utils/utils/json/extension/json.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/provider/provider.dart';
import 'package:on_chain/solidity/address/core.dart';

import '../core/singleton.dart';
import '../types/contracts.dart';

class SafeSingletonContract extends ISafeSingletonContract {
  SafeSingletonContract(
      {required super.contract,
      required super.contractAddress,
      required super.version});

  /// Returns a descriptive version of the Safe contract.
  @override
  Future<String> getVersion(EthereumProvider provider) async {
    return queryContract<String>(
        functionName: SafeContractFunction.version, provider: provider);
  }

  /// "stateMutability": "nonpayable",
  /// Adds the owner `owner` to the Safe and updates the threshold to `threshold`.
  @override
  Future<SafeContractEncodedCall> addOwnerWithThreshold(
      {required ETHAddress address, required int threshold}) async {
    final params = [address, threshold];
    return encodeTransactionCall(
        functionName: SafeContractFunction.addOwnerWithThreshold,
        params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Marks hash [hashToApprove] as approved for `msg.sender`.
  @override
  Future<SafeContractEncodedCall> approveHash(List<int> hashToApprove) async {
    final params = [hashToApprove];
    return encodeTransactionCall(
        functionName: SafeContractFunction.approveHash, params: params);
  }

  /// "stateMutability": "view",
  /// Returns a non-zero value if the `messageHash` is approved by the `owner`
  @override
  Future<bool> approvedHashes(
      {required EthereumProvider provider,
      required ETHAddress address,
      required List<int> messageHash}) async {
    final params = [address, messageHash];
    return queryContract<bool>(
      functionName: SafeContractFunction.approvedHashes,
      params: params,
      provider: provider,
      onResponse: (result) {
        final BigInt approved =
            JsonParser.valueAsBigInt(result.elementAtOrNull(0));
        return approved > BigInt.zero;
      },
    );
  }

  /// "stateMutability": "nonpayable",
  /// Changes the threshold of the Safe to `threshold`.
  @override
  Future<SafeContractEncodedCall> changeThreshold(int threshold) async {
    final params = [threshold];
    return encodeTransactionCall(
        functionName: SafeContractFunction.changeThreshold, params: params);
  }

  /// "stateMutability": "view",
  /// Checks whether the provided signature is valid for the given hash.
  /// Reverts if the signature is invalid.
  @override
  Future<bool> checkNSignatures(
      {required List<int> dataHash,
      required List<int> data,
      required List<int> signatures,
      required BigInt requiredSignatures,
      required EthereumProvider provider}) async {
    final params = [dataHash, data, signatures, requiredSignatures];
    return queryContract<bool>(
      provider: provider,
      functionName: SafeContractFunction.checkNSignatures,
      selector: [18, 251, 104, 224],
      params: params,
      onResponse: (result) {
        return true;
      },
    );
  }

  /// "stateMutability": "view",
  /// Checks whether the provided signature is valid for the given hash.
  /// Reverts if the signature is invalid.
  @override
  Future<bool> checkNSignatures2({
    required ETHAddress address,
    required List<int> dataHash,
    required List<int> signatures,
    required BigInt requiredSignatures,
    required EthereumProvider provider,
  }) async {
    final params = [address, dataHash, signatures, requiredSignatures];
    return queryContract<bool>(
      functionName: SafeContractFunction.checkNSignatures,
      selector: [31, 202, 199, 243],
      provider: provider,
      params: params,
      onResponse: (result) {
        return true;
      },
    );
  }

  /// "stateMutability": "view",
  /// Checks whether the signature provided is valid for the provided data and hash. Reverts otherwise.
  @override
  Future<bool> checkSignatures(
      {required List<int> dataHash,
      required List<int> data,
      required List<int> signatures,
      required EthereumProvider provider}) async {
    final params = [dataHash, data, signatures];
    return queryContract<bool>(
      functionName: SafeContractFunction.checkSignatures,
      provider: provider,
      selector: [147, 79, 58, 17],
      params: params,
      onResponse: (result) {
        return true;
      },
    );
  }

  /// "stateMutability": "view",
  /// Checks whether the signature provided is valid for the provided data and hash and executor. Reverts otherwise.
  @override
  Future<bool> checkSignatures2(
      {required List<int> dataHash,
      required ETHAddress executor,
      required List<int> signatures,
      required EthereumProvider provider}) async {
    final params = [executor, dataHash, signatures];
    return queryContract<bool>(
      functionName: SafeContractFunction.checkSignatures,
      selector: [248, 85, 67, 139],
      provider: provider,
      params: params,
      onResponse: (result) {
        return true;
      },
    );
  }

  /// "stateMutability": "nonpayable",
  /// Disables the module `module` for the Safe.
  @override
  Future<SafeContractEncodedCall> disableModule(
      {required ETHAddress prevModule, required ETHAddress module}) async {
    final params = [prevModule, module];
    return encodeTransactionCall(
        functionName: SafeContractFunction.disableModule, params: params);
  }

  /// "stateMutability": "view",
  /// Returns the domain separator for this contract, as defined in the EIP-712 standard.
  @override
  Future<List<int>> domainSeparator(EthereumProvider provider) async {
    return queryContract<List<int>>(
        functionName: SafeContractFunction.domainSeparator, provider: provider);
  }

  /// "stateMutability": "nonpayable",
  /// Enables the module [module] for the Safe.
  @override
  Future<SafeContractEncodedCall> enableModule(ETHAddress module) async {
    final params = [module];
    return encodeTransactionCall(
        functionName: SafeContractFunction.enableModule, params: params);
  }

  /// "stateMutability": "payable",
  /// Parameters:
  /// - [to]: Destination address of the Safe transaction.
  /// - [value]: Native token value of the Safe transaction.
  /// - [data]: Data payload of the Safe transaction.
  /// - [operation]: Operation type of the Safe transaction.
  /// - [safeTxGas]: Gas that should be used for the Safe transaction.
  /// - [baseGas]: Base gas costs that are independent of the transaction execution.
  /// - [gasPrice]: Gas price that should be used for the payment calculation.
  /// - [gasToken]: Token address (or 0 for the native token) that is used for the payment.
  /// - [refundReceiver]: Address of the receiver of the gas payment (or 0 for `tx.origin`).
  /// - [signatures]: Signature data for the executed transaction.
  @override
  Future<SafeContractEncodedCall> execTransaction({
    required ETHAddress to,
    BigInt? value,
    List<int>? data,
    SafeContractExecutionOpration operation =
        SafeContractExecutionOpration.call,
    BigInt? safeTxGas,
    BigInt? baseGas,
    BigInt? gasPrice,
    ETHAddress? gasToken,
    ETHAddress? refundReceiver,
    required List<int> signatures,
  }) async {
    final List<Object> params = [
      to,
      value ?? BigInt.zero,
      data ?? <int>[],
      operation.value,
      safeTxGas ?? BigInt.zero,
      baseGas ?? BigInt.zero,
      gasPrice ?? BigInt.zero,
      gasToken ?? ETHAddress.zero,
      refundReceiver ?? ETHAddress.zero,
      signatures
    ];
    return encodeTransactionCall(
        functionName: SafeContractFunction.execTransaction, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Executes an [operation] to [to] with native token [value].
  ///
  /// Parameters:
  /// - [to]: Destination address of the module transaction.
  /// - [value]: Native token value of the module transaction.
  /// - [data]: Data payload of the module transaction.
  /// - [operation]: Operation type of the module transaction
  @override
  Future<SafeContractEncodedCall> execTransactionFromModule(
      {required ETHAddress to,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call}) async {
    final params = [to, value ?? BigInt.zero, data ?? <int>[], operation.value];
    return encodeTransactionCall(
        functionName: SafeContractFunction.execTransactionFromModule,
        params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Executes an `operation` on the target address `to` with the specified
  /// native token `value`, and returns the result data.
  ///
  /// Parameters:
  /// - [to]: Destination address of the module transaction.
  /// - [value]: Native token value (amount of ETH) to send with the transaction.
  /// - [data]: Data payload for the module transaction.
  /// - [operation]: Type of operation
  @override
  Future<SafeContractEncodedCall> execTransactionFromModuleReturnData(
      {required ETHAddress to,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call}) async {
    final params = [to, value ?? BigInt.zero, data ?? <int>[], operation.value];
    return encodeTransactionCall(
        functionName: SafeContractFunction.execTransactionFromModuleReturnData,
        params: params);
  }

  /// "stateMutability": "view",
  /// Returns a list of Safe owners.
  @override
  Future<List<ETHAddress>> getOwners(EthereumProvider provider) async {
    return queryContract<List<ETHAddress>>(
      functionName: SafeContractFunction.getOwners,
      provider: provider,
      onResponse: (result) {
        final owners = JsonParser.valueEnsureAsList<SolidityAddress>(
            result.elementAtOrNull(0));
        return owners.map((e) => e.toEthereumAddress()).toList();
      },
    );
  }

  /// "stateMutability": "view",
  /// [length] bytes of storage in the current contract
  @override
  Future<List<int>> getStorageAt(
      {required EthereumProvider provider,
      required int offset,
      required int length}) async {
    final params = [BigInt.from(offset), BigInt.from(length)];
    return queryContract<List<int>>(
        provider: provider,
        functionName: SafeContractFunction.getStorageAt,
        params: params);
  }

  /// "stateMutability": "view",
  ///  Returns the number of required confirmations for a Safe transaction aka the threshold.
  @override
  Future<BigInt> getThreshold(EthereumProvider provider) async {
    return queryContract<BigInt>(
        provider: provider, functionName: SafeContractFunction.getThreshold);
  }

  /// "stateMutability": "view",
  /// Returns the transaction hash that must be signed by the Safe owners.
  /// Parameters:
  /// - [to]: Destination address of the Safe transaction.
  /// - [value]: Amount of native tokens (e.g., ETH) to send with the transaction.
  /// - [data]: Data payload of the Safe transaction.
  /// - [operation]: Type of operation:
  /// - [safeTxGas]: Gas limit to be used for executing the Safe transaction.
  /// - [baseGas]: Base gas cost independent of transaction execution
  ///   (e.g., base transaction fee, signature verification, refund payment).
  /// - [gasPrice]: Gas price used for refund or payment calculation.
  /// - [gasToken]: Address of the token used to pay for gas
  ///   (`0x0` for native token such as ETH).
  /// - [refundReceiver]: Address to receive gas payment refund
  ///   (`0x0` means `tx.origin`).
  /// - [nonce]: Nonce of the Safe transaction.
  @override
  Future<List<int>> getTransactionHash(
      {required ETHAddress to,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call,
      BigInt? safeTxGas,
      BigInt? baseGas,
      BigInt? gasPrice,
      ETHAddress? gasToken,
      ETHAddress? refundReceiver,
      required BigInt nonce,
      required EthereumProvider provider}) async {
    final List<Object> params = [
      to,
      value ?? BigInt.zero,
      data ?? <int>[],
      operation.value,
      safeTxGas ?? BigInt.zero,
      baseGas ?? BigInt.zero,
      gasPrice ?? BigInt.zero,
      gasToken ?? ETHAddress.zero,
      refundReceiver ?? ETHAddress.zero,
      nonce
    ];
    return queryContract<List<int>>(
        functionName: SafeContractFunction.getTransactionHash,
        params: params,
        provider: provider);
  }

  /// "stateMutability": "view",
  /// Returns whether or not a module is enabled.
  @override
  Future<bool> isModuleEnabled(
      {required ETHAddress address, required EthereumProvider provider}) async {
    final params = [address];
    return queryContract<bool>(
      functionName: SafeContractFunction.isModuleEnabled,
      params: params,
      provider: provider,
    );
  }

  /// "stateMutability": "view",
  /// if [owner] is an owner of the Safe.
  @override
  Future<bool> isOwner(
      {required ETHAddress owner, required EthereumProvider provider}) async {
    final params = [owner];
    return queryContract<bool>(
      functionName: SafeContractFunction.isOwner,
      params: params,
      provider: provider,
    );
  }

  /// "stateMutability": "view",
  /// Returns the nonce of the Safe contract.
  @override
  Future<BigInt> nonce(EthereumProvider provider) async {
    return queryContract<BigInt>(
      functionName: SafeContractFunction.nonce,
      provider: provider,
    );
  }

  /// "stateMutability": "nonpayable",
  /// Removes the specified [owner] from the Safe and updates the signature threshold.
  ///
  /// This operation can only be performed through a Safe transaction.
  ///
  /// Parameters:
  /// - [prevOwner]: The owner address that precedes the `owner` to be removed
  ///   in the internal linked list of owners.
  ///   If the owner to remove is the first (or only) element in the list,
  ///   [prevOwner] **must** be set to the sentinel address `0x1`
  ///   (referred to as `SENTINEL_OWNERS` in the implementation).
  /// - [owner]: The owner address to remove from the Safe.
  /// - [threshold]: The new threshold value to apply after the removal.
  @override
  Future<SafeContractEncodedCall> removeOwner(
      {required ETHAddress prevOwner,
      required ETHAddress owner,
      required BigInt threshold}) async {
    final params = [prevOwner, owner, threshold];
    return encodeTransactionCall(
        functionName: SafeContractFunction.removeOwner, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Sets the fallback handler contract (`handler`) for the Safe.
  ///
  /// Notes:
  /// 1. Only fallback calls **without value** and **with data** are forwarded.
  /// 2. Changing the fallback handler can only be done through a Safe transaction.
  /// 3. The fallback handler **cannot** be set to the Safe itself.
  /// 4. ⚠️ **IMPORTANT — SECURITY RISK:**
  ///    The fallback handler can be set to any address, and **all calls will be forwarded**
  ///    to that address, bypassing the Safe’s normal access control checks.
  ///    Ensure the handler address is **trusted**, and if it can modify state,
  ///    verify it performs proper security and permission checks.
  ///
  /// Parameters:
  /// - [handler]: Address of the contract that will handle fallback calls.
  @override
  Future<SafeContractEncodedCall> setFallbackHandler(ETHAddress handler) async {
    final params = [handler];
    return encodeTransactionCall(
        functionName: SafeContractFunction.setFallbackHandler, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// A contract that manages transaction guards, which perform
  /// pre- and post-execution checks on Safe transactions.
  @override
  Future<SafeContractEncodedCall> setGuard(ETHAddress guard) async {
    final params = [guard];
    return encodeTransactionCall(
        functionName: SafeContractFunction.setGuard, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Sets the module guard (`moduleGuard`) for the Safe.
  /// Make sure you **trust** the module guard before setting it.
  ///
  /// Notes:
  /// - The module guard performs checks on transactions initiated by modules,
  ///   both **before** and **after** execution.
  /// - This action can only be performed through a Safe transaction.
  /// - ⚠️ **IMPORTANT — SECURITY RISK:**
  ///   Since a module guard can block any Safe transaction initiated via a module,
  ///   a faulty or malicious module guard can cause a **denial of service (DoS)**
  ///   for all Safe modules.
  ///   Carefully **audit** the module guard’s code and **design recovery mechanisms**.
  ///
  /// Parameters:
  /// - [moduleGuard]: Address of the module guard contract to use,
  ///   or the zero address (`0x0`) to disable the module guard.
  @override
  Future<SafeContractEncodedCall> setModuleGuard(ETHAddress moduleGuard) async {
    final params = [moduleGuard];
    return encodeTransactionCall(
        functionName: SafeContractFunction.setModuleGuard, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Initializes the Safe account with its initial storage configuration.
  ///
  /// Notes:
  /// - This method can only be called **once**.
  /// - ⚠️ **SECURITY WARNING:**
  ///   If a proxy is deployed without running `setup`, **anyone** can call `setup`
  ///   and take control of the Safe.
  /// - ⚠️ **EIP-7702 Warning:**
  ///   A Safe can set itself as an owner, which is valid for EIP-7702 delegation setups.
  ///   However, if the Safe address is **not an EOA** (Externally Owned Account) and
  ///   cannot sign for itself, this may **lock access** to the account permanently.
  ///   For example, in an `n/n` Safe (where `threshold == ownerCount`), if the Safe
  ///   includes itself as an owner without EIP-7702 delegation, no valid signature
  ///   can ever be produced, effectively bricking the Safe.
  /// - This method emits a `SafeSetup` event containing the setup parameters instead
  ///   of reading them from storage, meaning the emitted event data may not reflect
  ///   the actual state if the delegate call (`to`) modifies owners, threshold, or
  ///   fallback handler.
  ///
  /// Parameters:
  /// - [owners]: List of initial Safe owner addresses.
  /// - [threshold]: Number of required confirmations for a Safe transaction.
  /// - [to]: Optional initializer contract address; it will be called via `DELEGATECALL` with `data`.
  ///   Use the zero address (`0x0`) to skip additional initialization.
  /// - [data]: Data payload for the initializer contract.
  /// - [fallbackHandler]: Address of the fallback handler contract.
  /// - [paymentToken]: Token used for payment (`0x0` for native token, e.g., ETH).
  /// - [payment]: Amount to pay for initialization.
  /// - [paymentReceiver]: Address to receive the payment (`0x0` for `tx.origin`).
  @override
  Future<SafeContractEncodedCall> setup({
    required List<ETHAddress> owners,
    required BigInt threshold,
    ETHAddress? to,
    List<int>? data,
    ETHAddress? fallbackHandler,
    ETHAddress? paymentToken,
    BigInt? payment,
    ETHAddress? paymentReceiver,
  }) async {
    final params = [
      owners,
      threshold,
      to ?? ETHAddress.zero,
      data ?? <int>[],
      if (fallbackHandler != null) fallbackHandler,
      paymentToken ?? ETHAddress.zero,
      payment ?? BigInt.zero,
      paymentReceiver ?? ETHAddress.zero,
    ];
    return encodeTransactionCall(
        functionName: SafeContractFunction.setup, params: params);
  }

  /// "stateMutability": "view",
  /// Returns a non-zero value if the [messageHash] is signed for the Safe.
  @override
  Future<bool> signedMessages(
      {required EthereumProvider provider,
      required List<int> messageHash}) async {
    final params = [messageHash];
    return queryContract<bool>(
      functionName: SafeContractFunction.signedMessages,
      params: params,
      provider: provider,
      onResponse: (result) {
        final BigInt approved =
            JsonParser.valueAsBigInt(result.elementAtOrNull(0));
        return approved > BigInt.zero;
      },
    );
  }

  /// "stateMutability": "nonpayable",
  /// Executes a `DELEGATECALL` to the specified [targetContract]
  /// within the context of the current contract (self).
  ///
  /// Notes:
  /// - The call is internally reverted to prevent state changes,
  ///   making this method effectively **static** (read-only).
  /// - When reverted, the revert data encodes the execution result as:
  ///   `abi.encodePacked(uint256(success), uint256(response.length), bytes(response))`
  ///
  /// This means the returned data layout is:
  /// success:uint256 || response.length:uint256 || response:bytes
  ///
  /// Parameters:
  /// - [targetContract]: Address of the contract containing the code to execute.
  /// - [calldataPayload]: Calldata sent to the target contract
  ///   (includes the encoded function selector and arguments).
  @override
  Future<SafeContractEncodedCall> simulateAndRevert(
      {required ETHAddress targetContract,
      required List<int> calldataPayload}) async {
    final params = [targetContract, calldataPayload];
    return encodeTransactionCall(
        functionName: SafeContractFunction.simulateAndRevert, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Replaces an existing owner ([oldOwner]) in the Safe with a new owner ([newOwner]).
  ///
  /// Notes:
  /// - This operation can only be executed through a Safe transaction.
  /// - ⚠️ **EIP-7702 Warning:**
  ///   A Safe can set itself as an owner, which is valid for EIP-7702 delegation setups.
  ///   However, if the Safe address is **not an EOA** (Externally Owned Account) and
  ///   cannot sign for itself, this may **lock access** to the Safe.
  ///   For example, in an `n/n` Safe (where `threshold == ownerCount`), if the Safe
  ///   includes itself as an owner without EIP-7702 delegation, no valid signature
  ///   can be produced, effectively preventing further Safe transactions.
  ///
  /// Parameters:
  /// - [prevOwner]: Owner address that precedes the [oldOwner] in the linked list of owners.
  ///   If [oldOwner] is the first (or only) element, [prevOwner] **must** be the sentinel address `0x1`
  ///   (referred to as `SENTINEL_OWNERS` in the implementation).
  /// - [oldOwner]: Owner address to be replaced.
  /// - [newOwner]: New owner address to replace the old one.
  @override
  Future<SafeContractEncodedCall> swapOwner(
      {required ETHAddress prevOwner,
      required ETHAddress oldOwner,
      required ETHAddress newOwner}) async {
    final params = [prevOwner, oldOwner, newOwner];
    return encodeTransactionCall(
        functionName: SafeContractFunction.swapOwner, params: params);
  }

  /// "stateMutability": "view",
  /// The precomputed EIP-712 domain separator hash for Safe typed data hashing and signing.
  @override
  Future<List<int>> domainSeparatorTypeHash(EthereumProvider provider) async {
    return queryContract<List<int>>(
      functionName: SafeContractFunction.domainSeparatorTypeHash,
      provider: provider,
    );
  }

  /// "stateMutability": "view",
  /// The precomputed EIP-712 type hash for the Safe message type.
  @override
  Future<List<int>> safeMsgTypeHash(EthereumProvider provider) async {
    return queryContract<List<int>>(
      functionName: SafeContractFunction.safeMsgTypeHash,
      provider: provider,
    );
  }

  /// "stateMutability": "view",
  /// The precomputed EIP-712 type hash for the Safe transaction type.
  @override
  Future<List<int>> safeTxTypeHash(EthereumProvider provider) async {
    return queryContract<List<int>>(
      functionName: SafeContractFunction.safeTxTypeHash,
      provider: provider,
    );
  }

  /// "stateMutability": "view",
  /// The sentinel module value in the {ModuleManager.modules} linked list.
  @override
  Future<ETHAddress> sentinelModules(EthereumProvider provider) async {
    return queryContract<ETHAddress>(
        functionName: SafeContractFunction.sentinelModules,
        provider: provider,
        onResponse: (result) =>
            JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
                .toEthereumAddress());
  }

  /// The sentinel owner value in the {owners} linked list.
  @override
  Future<ETHAddress> sentinelOwners(EthereumProvider provider) async {
    return queryContract<ETHAddress>(
        functionName: SafeContractFunction.sentinelOwners,
        provider: provider,
        onResponse: (result) =>
            JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
                .toEthereumAddress());
  }

  /// "stateMutability": "view",
  /// Returns a descriptive version of the Safe contract.
  @override
  Future<String> name(EthereumProvider provider) async {
    return queryContract<String>(
      functionName: SafeContractFunction.name,
      provider: provider,
    );
  }

  @override
  Future<SafeContractEncodedCall> changeMasterCopy(
      ETHAddress masterCopy) async {
    final params = [masterCopy];
    return encodeTransactionCall(
        functionName: SafeContractFunction.changeMasterCopy, params: params);
  }

  /// "stateMutability": "view",
  /// Returns the hash of a message to be signed by owners.
  @override
  Future<List<int>> getMessageHash(
      {required EthereumProvider provider, required List<int> message}) async {
    final params = [message];
    return queryContract<List<int>>(
      functionName: SafeContractFunction.getMessageHash,
      params: params,
      provider: provider,
    );
  }

  @override
  Future<SafeContractEncodedCall> requiredTxGas(
      {required ETHAddress to,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call}) async {
    final params = [to, value ?? BigInt.zero, data ?? <int>[], operation.value];
    return encodeTransactionCall(
        functionName: SafeContractFunction.requiredTxGas, params: params);
  }

  /// "stateMutability": "view",
  /// Returns array of first 10 modules.
  @override
  Future<List<ETHAddress>> getModules(EthereumProvider provider) async {
    return queryContract<List<ETHAddress>>(
      functionName: SafeContractFunction.getModules,
      provider: provider,
      onResponse: (result) {
        final owners = JsonParser.valueEnsureAsList<SolidityAddress>(
            result.elementAtOrNull(0));
        return owners.map((e) => e.toEthereumAddress()).toList();
      },
    );
  }

  /// Returns an array of modules.
  ///
  /// If all entries fit into a single page, the next pointer will be `address(0x1)`.
  /// If another page is present, `next` will be the last element of the returned array.
  ///
  /// Parameters:
  /// - [start]: Start of the page. Must be a module or the start pointer (`address(0x1)`).
  /// - [pageSize]: Maximum number of modules that should be returned. Must be greater than 0.
  @override
  Future<(List<ETHAddress>, ETHAddress)> getModulesPaginated({
    required EthereumProvider provider,
    ETHAddress? start,
    required int pageSize,
  }) async {
    final params = [start ?? ETHAddress.one, BigInt.from(pageSize)];
    return queryContract<(List<ETHAddress>, ETHAddress)>(
      functionName: SafeContractFunction.getModulesPaginated,
      provider: provider,
      params: params,
      onResponse: (result) {
        final owners = JsonParser.valueEnsureAsList<SolidityAddress>(
            result.elementAtOrNull(0));
        return (
          owners.map((e) => e.toEthereumAddress()).toList(),
          JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(1))
              .toEthereumAddress()
        );
      },
    );
  }

  /// "stateMutability": "view",
  /// Returns the pre-image of the Safe transaction hash.
  /// Parameters:
  /// - [to]: Destination address of the Safe transaction.
  /// - [value]: Amount of native tokens (e.g., ETH) to send with the transaction.
  /// - [data]: Data payload of the Safe transaction.
  /// - [operation]: Type of operation:
  /// - [safeTxGas]: Gas limit to be used for executing the Safe transaction.
  /// - [baseGas]: Base gas cost independent of transaction execution
  ///   (e.g., base transaction fee, signature verification, refund payment).
  /// - [gasPrice]: Gas price used for refund or payment calculation.
  /// - [gasToken]: Address of the token used to pay for gas
  ///   (`0x0` for native token such as ETH).
  /// - [refundReceiver]: Address to receive gas payment refund
  ///   (`0x0` means `tx.origin`).
  /// - [nonce]: Nonce of the Safe transaction.
  @override
  Future<List<int>> encodeTransactionData(
      {required ETHAddress to,
      BigInt? value,
      List<int>? data,
      SafeContractExecutionOpration operation =
          SafeContractExecutionOpration.call,
      BigInt? safeTxGas,
      BigInt? baseGas,
      BigInt? gasPrice,
      ETHAddress? gasToken,
      ETHAddress? refundReceiver,
      required BigInt nonce,
      required EthereumProvider provider}) async {
    final List<Object> params = [
      to,
      value ?? BigInt.zero,
      data ?? <int>[],
      operation.value,
      safeTxGas ?? BigInt.zero,
      baseGas ?? BigInt.zero,
      gasPrice ?? BigInt.zero,
      gasToken ?? ETHAddress.zero,
      refundReceiver ?? ETHAddress.zero,
      nonce
    ];
    return queryContract<List<int>>(
        provider: provider,
        functionName: SafeContractFunction.encodeTransactionData,
        params: params);
  }

  /// "stateMutability": "nonpayable",
  @override
  Future<SafeContractEncodedCall> isValidSignature(
      {required List<int> data, required List<int> signature}) async {
    final params = [data, signature];
    return encodeTransactionCall(
        functionName: SafeContractFunction.isValidSignature, params: params);
  }

  /// "stateMutability": "nonpayable",
  /// Can be verified using EIP-1271 validation method by passing the pre-image of the message hash and empty bytes as the signature.
  @override
  Future<SafeContractEncodedCall> signMessage(List<int> data) async {
    final params = [data];
    return encodeTransactionCall(
        functionName: SafeContractFunction.signMessage, params: params);
  }

  /// Returns the ID of the chain the contract is currently deployed on.
  @override
  Future<BigInt> getChainId(EthereumProvider provider) async {
    return queryContract<BigInt>(
        provider: provider, functionName: SafeContractFunction.getChainId);
  }
}
