import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/intent/intent.dart';
import 'package:on_chain/sui/src/keypair/constant/constant.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';

class SuiCryptoUtils {
  /// Generate Sui personal message digest.
  static BuBytes generatePersonalMessageDigest(List<int> message) {
    final intent = SuiIntentMessage.personalMessage(
      SuiPersonalMessage(message: message),
    );
    return QuickCrypto.blake2b256Hash(intent.toBcs());
  }

  /// Generate Sui transaction digest for signing.
  static BuBytes generateTransactionDigest({
    required List<int> txBytes,
    required bool hashDigest,
  }) {
    if (!hashDigest) return txBytes.asImmutableBytes;
    return QuickCrypto.blake2b256Hash(txBytes).asImmutableBytes;
  }

  /// get public key indexes from signature bitmat.
  static List<int> getIndexesFromBitmap(int bitMap) {
    List<int> indexes = [];
    int index = 0;

    while (bitMap != 0) {
      if ((bitMap & 1) == 1) {
        indexes.add(index);
      }
      bitMap >>= 1;
      index++;
      if (index > BinaryOps.mask8) break;
    }

    return indexes;
  }

  /// Verifies a transaction/personal-message intent digest against a
  /// serialized envelope signature, dispatching on its scheme.
  ///
  /// Single-key and multisig envelopes verify fully locally. zkLogin and
  /// passkey envelopes need their session keys — use
  /// [SuiZkLoginSignature.verifyEphemeralSignature] / [SuiPasskeySignature.verify] with the
  /// session public key instead.
  static bool verifyTransactionSignature({
    required List<int> digest,
    required List<int> signature,
  }) {
    final envelope = SuiBaseSignature.deserialize(signature);
    return switch (envelope) {
      SuiEd25519Signature sig => SuiEd25519AccountPublicKey(
        sig.publicKey,
      ).verify(message: digest, signature: sig.signature.signature),
      SuiSecp256k1Signature sig => SuiSecp256k1AccountPublicKey(
        sig.publicKey,
      ).verify(message: digest, signature: sig.signature.signature),
      SuiSecp256r1Signature sig => SuiSecp256r1AccountPublicKey(
        sig.publicKey,
      ).verify(message: digest, signature: sig.signature.signature),
      SuiMultisigSignature sig => sig.publicKey.verify(
        message: digest,
        signature: signature,
      ),
      _ =>
        throw BuError(
          OnChainErrorType.suiPlugin,
          'Local verification needs the session key for this scheme.',
          details: {'scheme': envelope.scheme.name},
        ),
    };
  }

  /// Decodes a Sui Bech32 secret key into its corresponding private key.
  static (SuiKeyAlgorithm, List<int>) decodeSuiSecretKey(String secretKey) {
    try {
      final decode = Bech32Decoder.decode(
        SuiKeypairConst.suiPrivateKeyPrefix,
        secretKey,
      );
      final algorithm = SuiKeyAlgorithm.fromFlag(decode[0]);
      return (algorithm, decode.sublist(1).asImmutableBytes);
    } on BuError {
      rethrow;
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Invalid Sui Bech32 secret key.",
        details: {"error": e.toString()},
      );
    }
  }

  /// Encodes the Sui private key to a Bech32 string.
  ///
  /// The encoded format includes the `suiprivkey` HRP,
  /// the key scheme flag, and the secret key bytes.
  static String encodeSuiSecretKey(
    List<int> secretKey, {
    CryptoKeyType? type,
    SuiKeyAlgorithm? keyScheme,
  }) {
    if (keyScheme == null && type == null) {
      throw BuError(
        OnChainErrorType.suiPlugin,
        "Key scheme or elliptic curve type required to generate Sui Bech32 secret key.",
      );
    }
    final flag =
        (keyScheme ??= SuiKeyAlgorithm.fromEllipticCurveType(type!)).flag;
    final key = IPrivateKey.fromBytes(secretKey, keyScheme.curveType);
    return key.takeSecretKey().useValue((k) {
      return Bech32Encoder.encode(SuiKeypairConst.suiPrivateKeyPrefix, [
        flag,
        ...k,
      ]);
    }, zero: true);
  }
}
