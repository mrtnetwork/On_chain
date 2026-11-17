import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/aptos/src/address/address.dart';
import 'package:on_chain/aptos/src/api/impl/provider.dart';
import 'package:on_chain/aptos/src/api/types/types.dart';
import 'package:on_chain/aptos/src/helper/helper.dart';
import 'package:on_chain/aptos/src/provider/methods/account/get_account.dart';
import 'package:on_chain/aptos/src/provider/methods/general/get_ledger_info.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';
import 'package:on_chain/aptos/src/transaction/encrypted/encrypted.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Encrypted mempool (AIP-144) transaction builder.
///
/// Client-side encryption only: the payload is encrypted with the network's
/// per-epoch batch key, validators decrypt after consensus. Any existing
/// entry function works — no contract changes needed.
/// Keyless, federated keyless and account-abstraction signers cannot sign
/// encrypted transactions (enforced by the node).
mixin AptosQuickApiEncryptedHelper on AptosQuickApiProviderHelper {
  /// Current batch encryption key + epoch from ledger `encryption_key`.
  /// Throws when the node does not support encrypted submission.
  Future<({AptosBatchEncryptionKey key, BigInt epoch})>
  getBatchEncryptionKey() async {
    final info = await provider.request(AptosRequestGetLedgerInfo());
    final rawKey = info.encryptionKey;
    if (rawKey is! String || rawKey.isEmpty) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'Encrypted transactions requested but the node does not provide an encryption key.',
      );
    }
    final hex = rawKey.startsWith('0x') ? rawKey.substring(2) : rawKey;
    return (
      key: AptosBatchEncryptionKey.fromHex(hex),
      epoch: BigintUtils.parse(info.epoch),
    );
  }

  /// On-chain 32-byte authentication key for [address].
  Future<List<int>> getAccountAuthKeyBytes(AptosAddress address) async {
    final account = await provider.request(
      AptosRequestGetAccount(address: address),
    );
    return BytesUtils.fromHexString(account.authenticationKey);
  }

  /// Builds an unsigned encrypted transaction for [executable].
  ///
  /// [signerAuthKeys] order is `all_signer_auth_keys`: sender first, then
  /// secondaries, fee payer last. Missing entries are fetched from chain.
  /// A zero fee-payer address counts as no on-chain fee payer for AAD.
  Future<AptosRawTransaction> buildEncryptedTransaction({
    required AptosAddress sender,
    required AptosTransactionExecutable executable,
    AptosAddress? multisigAddress,
    BigInt? replayProtectionNonce,
    AptosAddress? feePayerAddress,
    List<AptosAddress>? secondarySignerAddresses,
    List<int>? senderAuthenticationKey,
    List<List<int>?>? secondarySignerAuthenticationKeys,
    List<int>? feePayerAuthenticationKey,
    AptosClaimedEntryFunction? claimedEntryFunction,
    AptosApiBuildTransactionParams? params,
  }) async {
    final secondaries = secondarySignerAddresses ?? const [];
    if (secondarySignerAuthenticationKeys != null &&
        secondarySignerAuthenticationKeys.length != secondaries.length) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'secondarySignerAuthenticationKeys must have one entry per secondarySignerAddresses.',
      );
    }
    final hasNonZeroFeePayer =
        feePayerAddress != null && feePayerAddress != AptosAddress.zero;
    if (feePayerAuthenticationKey != null && !hasNonZeroFeePayer) {
      throw BuError(
        OnChainErrorType.aptosPlugin,
        'feePayerAuthenticationKey was set but feePayerAddress is missing or zero.',
      );
    }

    Future<List<int>> resolveAuth(
      AptosAddress address,
      List<int>? override,
    ) async {
      if (override != null) return override;
      return getAccountAuthKeyBytes(address);
    }

    final senderAuthKey = await resolveAuth(sender, senderAuthenticationKey);
    final secondaryAuthKeys = <List<int>>[];
    for (var i = 0; i < secondaries.length; i++) {
      secondaryAuthKeys.add(
        await resolveAuth(
          secondaries[i],
          secondarySignerAuthenticationKeys?[i],
        ),
      );
    }
    List<int>? feePayerAuthKey;
    final nonZeroFeePayer =
        feePayerAddress != null && feePayerAddress != AptosAddress.zero
            ? feePayerAddress
            : null;
    if (nonZeroFeePayer != null) {
      feePayerAuthKey = await resolveAuth(
        nonZeroFeePayer,
        feePayerAuthenticationKey,
      );
    }

    final signerAuthKeys = <AptosSignerAuthKeyPair>[
      AptosSignerAuthKeyPair(address: sender, authenticationKey: senderAuthKey),
      for (var i = 0; i < secondaries.length; i++)
        AptosSignerAuthKeyPair(
          address: secondaries[i],
          authenticationKey: secondaryAuthKeys[i],
        ),
      if (nonZeroFeePayer != null)
        AptosSignerAuthKeyPair(
          address: nonZeroFeePayer,
          authenticationKey: feePayerAuthKey!,
        ),
    ];

    final hasFeePayer = feePayerAddress != null;
    final hasMultisig = multisigAddress != null;
    final claim =
        claimedEntryFunction ??
        AptosEncryptedPayloadHelper.resolveClaimedEntryFunction(
          executable: executable,
          hasFeePayer: hasFeePayer,
          hasMultisig: hasMultisig,
        );

    final extraConfig = AptosTransactionExtraConfigV1(
      multisigAddress: multisigAddress,
      replayProtectionNonce: replayProtectionNonce,
    );

    final encryption = await getBatchEncryptionKey();
    final payload = AptosEncryptedPayloadHelper.build(
      executable: executable,
      extraConfig: extraConfig,
      sender: sender,
      signerAuthKeys: signerAuthKeys,
      encryptionKey: encryption.key,
      encryptionEpoch: encryption.epoch,
      claimedEntryFunction: claim,
    );

    final gasPrice = params?.gasUnitPrice ?? await getGasPrice();
    final gas = AptosEncryptedPayloadHelper.resolveGas(
      gasUnitPrice: gasPrice,
      maxGasAmount: params?.maxGasAmount ?? AptosConstants.defaultMaxGasAmount,
    );
    return AptosRawTransaction(
      sender: sender,
      sequenceNumber:
          params?.sequenceNumber ?? await getAccountSequence(sender),
      transactionPayload: payload,
      maxGasAmount: gas.maxGasAmount,
      gasUnitPrice: gas.gasUnitPrice,
      expirationTimestampSecs:
          params?.transactionExpireTime ??
          BigInt.from(DateTime.now().millisecondsSinceEpoch ~/ 1000 + 600),
      chainId: params?.chainId ?? await getChainId(),
    );
  }

  /// Encrypted `0x1::aptos_account::transfer`. No contract changes needed.
  Future<AptosRawTransaction> buildEncryptedTransfer({
    required AptosAddress sender,
    required AptosTransferParams transferParams,
    AptosApiBuildTransactionParams? params,
  }) {
    final entry = AptosHelper.createAccountTransferEntry(transferParams);
    return buildEncryptedTransaction(
      sender: sender,
      executable: AptosTransactionExecutableEntryFunction(entryFunction: entry),
      params: params,
    );
  }
}
