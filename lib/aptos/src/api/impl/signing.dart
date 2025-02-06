import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';

/// A helper mixin for signing Aptos transactions with support for single, multi-agent, and fee-payer transactions.
mixin AptosQuickApiSigningHelper {
  /// Signs an Aptos raw transaction with the provided [account].
  ///
  /// - [account]: The primary account responsible for signing the transaction.
  /// - [transaction]: The raw transaction to be signed.
  /// - [feePayerAccount] (optional): An additional account that covers the transaction fee, if applicable.
  /// - [secondarySignerAccounts] (optional): A list of secondary accounts for multi-agent transactions.
  ///
  /// Returns an [AptosSignedTransaction] containing the raw transaction and its corresponding authenticator.
  AptosSignedTransaction signTransaction(
      {required AptosAccount account,
      required AptosRawTransaction transaction,
      AptosAccount? feePayerAccount,
      List<AptosAccount>? secondarySignerAccounts}) {
    final digest = transaction.signingSerialize(
        feePayerAddress: feePayerAccount?.toAddress(),
        secondarySignerAddresses:
            secondarySignerAccounts?.map((e) => e.toAddress()).toList());

    // Sign the transaction digest with the primary account
    final sender = account.signWithAuth(digest);

    // Sign with fee payer account if provided
    AptosAccountAuthenticator? feePayerAuthenticator =
        feePayerAccount?.signWithAuth(digest);

    // Sign with secondary signer accounts if provided
    List<AptosAccountAuthenticator>? secondarySignerAuthenticator =
        secondarySignerAccounts?.map((e) => e.signWithAuth(digest)).toList();

    // Build the transaction authenticator based on the provided signers
    final txAuthenticated = _toTransactionAuthenticated(
        sender: sender,
        feePayerAddress: feePayerAccount?.toAddress(),
        feePayerAuthenticator: feePayerAuthenticator,
        secondarySignerAddressess:
            secondarySignerAccounts?.map((e) => e.toAddress()).toList(),
        secondarySignerAuthenticated: secondarySignerAuthenticator);

    return AptosSignedTransaction(
        rawTransaction: transaction, authenticator: txAuthenticated);
  }

  /// Creates the appropriate transaction authenticator based on the provided signers.
  ///
  /// - [sender]: The authenticator for the primary account.
  /// - [feePayerAuthenticator] (optional): The authenticator for the fee-payer account, if applicable.
  /// - [feePayerAddress] (optional): The address of the fee-payer account.
  /// - [secondarySignerAuthenticated] (optional): List of authenticators for secondary signers in multi-agent transactions.
  /// - [secondarySignerAddressess] (optional): List of addresses corresponding to the secondary signers.
  ///
  /// Returns an [AptosTransactionAuthenticator] based on the transaction's signing structure.
  AptosTransactionAuthenticator _toTransactionAuthenticated({
    required AptosAccountAuthenticator sender,
    AptosAccountAuthenticator? feePayerAuthenticator,
    AptosAddress? feePayerAddress,
    List<AptosAccountAuthenticator>? secondarySignerAuthenticated,
    List<AptosAddress>? secondarySignerAddressess,
  }) {
    if (feePayerAuthenticator != null) {
      // Fee-payer transaction authenticator
      return AptosTransactionAuthenticatorFeePayer(
        sender: sender,
        secondarySignerAddressess: secondarySignerAddressess ?? [],
        secondarySigner: secondarySignerAuthenticated ?? [],
        feePayerAddress: feePayerAddress!,
        feePayerAuthenticator: feePayerAuthenticator,
      );
    }
    if (secondarySignerAuthenticated != null) {
      // Multi-agent transaction authenticator
      return AptosTransactionAuthenticatorMultiAgent(
        sender: sender,
        secondarySignerAddressess: secondarySignerAddressess ?? [],
        secondarySigner: secondarySignerAuthenticated,
      );
    }
    if (sender is AptosAccountAuthenticatorEd25519) {
      // Single-signer Ed25519 authenticator
      return AptosTransactionAuthenticatorEd25519(
        publicKey: sender.publicKey,
        signature: sender.signature,
      );
    } else if (sender is AptosAccountAuthenticatorMultiEd25519) {
      // Multi-signer Ed25519 authenticator
      return AptosTransactionAuthenticatorMultiEd25519(
        publicKey: sender.publicKey,
        signature: sender.signature,
      );
    } else {
      // Fallback to single-sender authenticator
      return AptosTransactionAuthenticatorSignleSender(sender);
    }
  }
}
