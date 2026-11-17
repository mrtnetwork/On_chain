import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';

/// Keyless ephemeral-signing message helpers (AIP-61).
abstract final class AptosKeylessMessageUtils {
  /// Domain salt for keyless ephemeral signatures: `sha3_256("APTOS::TransactionAndProof")`.
  static final BuBytes _transactionAndProofSalt =
      QuickCrypto.sha3256Hash(
        StringUtils.encode('APTOS::TransactionAndProof'),
      ).asImmutableBytes;

  /// Message the ephemeral key signs for keyless accounts (AIP-61).
  ///
  /// Unlike other schemes, the ephemeral key does NOT sign the plain
  /// transaction digest: it signs `salt ++ bcs(TransactionAndProof)`, where
  /// `TransactionAndProof = rawTxBcs ++ Option(ZkProof)` binds the ZK proof to
  /// the transaction (non-malleability). Mirrors TS `TransactionAndProof.hash()`
  /// and Rust `TransactionAndProof { message, proof }` (`CryptoHash`).
  static BuBytes keylessTransactionSigningMessage({
    required AptosRawTransaction transaction,
    required AptosZkProof proof,
    AptosAddress? feePayerAddress,
    List<AptosAddress>? secondarySignerAddresses,
  }) {
    final List<int> body;
    if (feePayerAddress != null) {
      body =
          AptosRawTransactionWithDataFeePayer(
            rawTransaction: transaction,
            secondarySignerAddresses: secondarySignerAddresses ?? [],
            feePayerAddress: feePayerAddress,
          ).toVariantBcs();
    } else if (secondarySignerAddresses != null) {
      body =
          AptosRawTransactionWithDataMultiAgent(
            rawTransaction: transaction,
            secondarySignerAddresses: secondarySignerAddresses,
          ).toVariantBcs();
    } else {
      body = transaction.toBcs();
    }
    return [
      ..._transactionAndProofSalt,
      ...body,
      0x01,
      ...proof.toVariantBcs(),
    ].asImmutableBytes;
  }
}
