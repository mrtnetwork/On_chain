import 'package:on_chain/on_chain.dart';

import '../types/contracts.dart';
import 'contract.dart';

abstract class ISafeSingletonContract with BaseSafeContract {
  @override
  final ETHAddress contractAddress;
  @override
  final ContractABI contract;
  @override
  final SafeContractVersion version;
  const ISafeSingletonContract(
      {required this.contract,
      required this.contractAddress,
      required this.version});

  /// "stateMutability": "view",
  /// Returns a descriptive version of the Safe contract.
  Future<String> getVersion(EthereumProvider provider);

  /// "stateMutability": "nonpayable",
  /// Adds the owner `owner` to the Safe and updates the threshold to `threshold`.
  Future<SafeContractEncodedCall> addOwnerWithThreshold({
    required ETHAddress address,
    required int threshold,
  });

  /// "stateMutability": "nonpayable",
  /// Marks hash [hashToApprove] as approved for `msg.sender`.
  Future<SafeContractEncodedCall> approveHash(List<int> hashToApprove);

  /// "stateMutability": "view",
  /// Returns a non-zero value if the `messageHash` is approved by the `owner`
  Future<bool> approvedHashes({
    required EthereumProvider provider,
    required ETHAddress address,
    required List<int> messageHash,
  });

  /// "stateMutability": "nonpayable",
  /// Changes the threshold of the Safe to `threshold`.
  Future<SafeContractEncodedCall> changeThreshold(int threshold);

  /// "stateMutability": "view",
  /// Checks whether the provided signature is valid for the given hash.
  /// Reverts if the signature is invalid.
  Future<bool> checkNSignatures({
    required List<int> dataHash,
    required List<int> data,
    required List<int> signatures,
    required BigInt requiredSignatures,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// Checks whether the provided signature is valid for the given hash.
  /// Reverts if the signature is invalid.
  Future<bool> checkNSignatures2({
    required ETHAddress address,
    required List<int> dataHash,
    required List<int> signatures,
    required BigInt requiredSignatures,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// Checks whether the signature provided is valid for the provided data and hash. Reverts otherwise.
  Future<bool> checkSignatures({
    required List<int> dataHash,
    required List<int> data,
    required List<int> signatures,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// Checks whether the signature provided is valid for the provided data and hash and executor. Reverts otherwise.
  Future<bool> checkSignatures2({
    required List<int> dataHash,
    required ETHAddress executor,
    required List<int> signatures,
    required EthereumProvider provider,
  });

  /// "stateMutability": "nonpayable",
  /// Disables the module `module` for the Safe.
  Future<SafeContractEncodedCall> disableModule({
    required ETHAddress prevModule,
    required ETHAddress module,
  });

  /// "stateMutability": "view",
  /// Returns the domain separator for this contract, as defined in the EIP-712 standard.
  Future<List<int>> domainSeparator(EthereumProvider provider);

  /// "stateMutability": "nonpayable",
  /// Enables the module [module] for the Safe.
  Future<SafeContractEncodedCall> enableModule(ETHAddress module);

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
  Future<SafeContractEncodedCall> execTransaction({
    required ETHAddress to,
    required BigInt value,
    required List<int> data,
    required SafeContractExecutionOpration operation,
    required BigInt safeTxGas,
    required BigInt baseGas,
    required BigInt gasPrice,
    required ETHAddress gasToken,
    required ETHAddress refundReceiver,
    required List<int> signatures,
  });

  /// "stateMutability": "nonpayable",
  /// Executes an [operation] to [to] with native token [value].
  ///
  /// Parameters:
  /// - [to]: Destination address of the module transaction.
  /// - [value]: Native token value of the module transaction.
  /// - [data]: Data payload of the module transaction.
  /// - [operation]: Operation type of the module transaction
  Future<SafeContractEncodedCall> execTransactionFromModule({
    required ETHAddress to,
    required BigInt value,
    required List<int> data,
    required SafeContractExecutionOpration operation,
  });

  /// "stateMutability": "nonpayable",
  /// Executes an `operation` on the target address `to` with the specified
  /// native token `value`, and returns the result data.
  ///
  /// Parameters:
  /// - [to]: Destination address of the module transaction.
  /// - [value]: Native token value (amount of ETH) to send with the transaction.
  /// - [data]: Data payload for the module transaction.
  /// - [operation]: Type of operation
  Future<SafeContractEncodedCall> execTransactionFromModuleReturnData({
    required ETHAddress to,
    required BigInt value,
    required List<int> data,
    required SafeContractExecutionOpration operation,
  });

  /// "stateMutability": "view",
  /// Returns a list of Safe owners.
  Future<List<ETHAddress>> getOwners(EthereumProvider provider);

  /// "stateMutability": "view",
  /// [length] bytes of storage in the current contract
  Future<List<int>> getStorageAt({
    required EthereumProvider provider,
    required int offset,
    required int length,
  });

  /// "stateMutability": "view",
  ///  Returns the number of required confirmations for a Safe transaction aka the threshold.
  Future<BigInt> getThreshold(EthereumProvider provider);

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
  Future<List<int>> getTransactionHash({
    required ETHAddress to,
    required BigInt value,
    required List<int> data,
    required SafeContractExecutionOpration operation,
    required BigInt safeTxGas,
    required BigInt baseGas,
    required BigInt gasPrice,
    required ETHAddress gasToken,
    required ETHAddress refundReceiver,
    required BigInt nonce,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// Returns whether or not a module is enabled.
  Future<bool> isModuleEnabled({
    required ETHAddress address,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// if [owner] is an owner of the Safe.
  Future<bool> isOwner({
    required ETHAddress owner,
    required EthereumProvider provider,
  });

  /// "stateMutability": "view",
  /// Returns the nonce of the Safe contract.
  Future<BigInt> nonce(EthereumProvider provider);

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
  Future<SafeContractEncodedCall> removeOwner({
    required ETHAddress prevOwner,
    required ETHAddress owner,
    required BigInt threshold,
  });

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
  Future<SafeContractEncodedCall> setFallbackHandler(ETHAddress handler);

  /// "stateMutability": "nonpayable",
  /// A contract that manages transaction guards, which perform
  /// pre- and post-execution checks on Safe transactions.
  Future<SafeContractEncodedCall> setGuard(ETHAddress guard);

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
  Future<SafeContractEncodedCall> setModuleGuard(ETHAddress moduleGuard);

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
  Future<SafeContractEncodedCall> setup({
    required List<ETHAddress> owners,
    required BigInt threshold,
    required ETHAddress to,
    required List<int> data,
    required ETHAddress fallbackHandler,
    required ETHAddress paymentToken,
    required BigInt payment,
    required ETHAddress paymentReceiver,
  });

  /// "stateMutability": "view",
  /// Returns a non-zero value if the [messageHash] is signed for the Safe.
  Future<bool> signedMessages({
    required EthereumProvider provider,
    required List<int> messageHash,
  });

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
  Future<SafeContractEncodedCall> simulateAndRevert({
    required ETHAddress targetContract,
    required List<int> calldataPayload,
  });

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
  Future<SafeContractEncodedCall> swapOwner({
    required ETHAddress prevOwner,
    required ETHAddress oldOwner,
    required ETHAddress newOwner,
  });

  ///

  /// "stateMutability": "view",
  /// The precomputed EIP-712 domain separator hash for Safe typed data hashing and signing.
  Future<List<int>> domainSeparatorTypeHash(EthereumProvider provider);

  /// "stateMutability": "view",
  /// The precomputed EIP-712 type hash for the Safe message type.
  Future<List<int>> safeMsgTypeHash(EthereumProvider provider);

  /// "stateMutability": "view",
  /// The precomputed EIP-712 type hash for the Safe transaction type.
  Future<List<int>> safeTxTypeHash(EthereumProvider provider);

  /// "stateMutability": "view",
  /// The sentinel module value in the {ModuleManager.modules} linked list.
  Future<ETHAddress> sentinelModules(EthereumProvider provider);

  /// "stateMutability": "view",
  /// The sentinel owner value in the {owners} linked list.
  Future<ETHAddress> sentinelOwners(EthereumProvider provider);

  /// "stateMutability": "view",
  /// Returns a descriptive version of the Safe contract.
  Future<String> name(EthereumProvider provider);

  Future<SafeContractEncodedCall> changeMasterCopy(ETHAddress masterCopy);

  /// "stateMutability": "view",
  /// Returns the hash of a message to be signed by owners.
  Future<List<int>> getMessageHash(
      {required EthereumProvider provider, required List<int> message});

  Future<SafeContractEncodedCall> requiredTxGas(
      {required ETHAddress to,
      required BigInt value,
      required List<int> data,
      required SafeContractExecutionOpration operation});

  /// "stateMutability": "view",
  /// Returns array of first 10 modules.
  Future<List<ETHAddress>> getModules(EthereumProvider provider);

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
  Future<List<int>> encodeTransactionData(
      {required ETHAddress to,
      required BigInt value,
      required List<int> data,
      required SafeContractExecutionOpration operation,
      required BigInt safeTxGas,
      required BigInt baseGas,
      required BigInt gasPrice,
      required ETHAddress gasToken,
      required ETHAddress refundReceiver,
      required BigInt nonce,
      required EthereumProvider provider});

  /// "stateMutability": "nonpayable",
  Future<SafeContractEncodedCall> isValidSignature(
      {required List<int> data, required List<int> signature});

  /// "stateMutability": "nonpayable",
  /// Can be verified using EIP-1271 validation method by passing the pre-image of the message hash and empty bytes as the signature.
  Future<SafeContractEncodedCall> signMessage(List<int> data);

  /// Returns an array of modules.
  ///
  /// If all entries fit into a single page, the next pointer will be `address(0x1)`.
  /// If another page is present, `next` will be the last element of the returned array.
  ///
  /// Parameters:
  /// - [start]: Start of the page. Must be a module or the start pointer (`address(0x1)`).
  /// - [pageSize]: Maximum number of modules that should be returned. Must be greater than 0.
  Future<(List<ETHAddress>, ETHAddress)> getModulesPaginated({
    required EthereumProvider provider,
    ETHAddress? start,
    required int pageSize,
  });

  /// Returns the ID of the chain the contract is currently deployed on.
  Future<BigInt> getChainId(EthereumProvider provider);
}
