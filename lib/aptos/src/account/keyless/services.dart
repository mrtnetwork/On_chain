import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/keyless/ephemeral.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';

/// Official keyless service endpoints (mirrors `@aptos-labs/ts-sdk`
/// `NetworkToPepperAPI` / `NetworkToProverAPI`). Transport stays with the
/// caller; these are defaults, always overridable.
class AptosKeylessServiceUrls {
  static const String mainnetPepper =
      'https://api.mainnet.aptoslabs.com/keyless/pepper/v0';
  static const String mainnetProver =
      'https://api.mainnet.aptoslabs.com/keyless/prover/v0';
  static const String testnetPepper =
      'https://api.testnet.aptoslabs.com/keyless/pepper/v0';
  static const String testnetProver =
      'https://api.testnet.aptoslabs.com/keyless/prover/v0';
  static const String devnetPepper =
      'https://api.devnet.aptoslabs.com/keyless/pepper/v0';
  static const String devnetProver =
      'https://api.devnet.aptoslabs.com/keyless/prover/v0';

  /// Default BIP-44 derivation path for per-dApp account derivation.
  static const String defaultDerivationPath = "m/44'/637'/0'/0'/0";
}

/// Keyless pepper/prover service request builders and response parsers.
abstract final class AptosKeylessServiceUtils {
  /// Pepper-service `fetch` request body builder.
  static Map<String, dynamic> buildPepperFetchBody({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    String uidKey = 'sub',
    String? derivationPath,
  }) {
    return {
      'jwt_b64': jwt,
      'epk': BytesUtils.toHexString(ephemeral.ephemeralPublicKeyBcs),
      'exp_date_secs': ephemeral.expiryDateSecs,
      'epk_blinder': BytesUtils.toHexString(ephemeral.blinder),
      'uid_key': uidKey,
      if (derivationPath != null) 'derivation_path': derivationPath,
    };
  }

  /// Pepper-service `fetch` response parser (31-byte hex pepper).
  static List<int> parsePepperFetchResponse(Map<String, dynamic> json) {
    final pepper = BytesUtils.fromHexString(json['pepper'] as String);
    if (pepper.length != 31) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid pepper length.',
        details: {'length': pepper.length.toString()},
      );
    }
    return pepper;
  }

  /// Prover-service `prove` request body builder.
  static Map<String, dynamic> buildProofRequestBody({
    required String jwt,
    required AptosEphemeralKeyPair ephemeral,
    required List<int> pepper,
    required int expHorizonSecs,
    String uidKey = 'sub',
  }) {
    return {
      'jwt_b64': jwt,
      'epk': BytesUtils.toHexString(ephemeral.ephemeralPublicKeyBcs),
      'epk_blinder': BytesUtils.toHexString(ephemeral.blinder),
      'exp_date_secs': ephemeral.expiryDateSecs,
      'exp_horizon_secs': expHorizonSecs,
      'pepper': BytesUtils.toHexString(pepper),
      'uid_key': uidKey,
    };
  }

  /// Prover-service `prove` response parser.
  static AptosZeroKnowledgeSig parseProofResponse(
    Map<String, dynamic> json, {
    required int expHorizonSecs,
  }) {
    final proof = (json['proof'] as Map).cast<String, dynamic>();
    List<int> point(String name, int length) {
      final bytes = BytesUtils.fromHexString(proof[name] as String);
      if (bytes.length != length) {
        throw BuError(
          DefaultErrorType.invalidLength,
          'Invalid proof point length.',
          details: {'field': name, 'length': bytes.length.toString()},
        );
      }
      return bytes;
    }

    final tws = json['training_wheels_signature'];
    return AptosZeroKnowledgeSig(
      proof: AptosZkProof(
        AptosGroth16Zkp(
          a: point('a', 32),
          b: point('b', 64),
          c: point('c', 32),
        ),
      ),
      expHorizonSecs: BigInt.from(expHorizonSecs),
      trainingWheelsSignature:
          tws == null ? null : _parseTrainingWheels(tws as String),
    );
  }

  /// Normalizes the prover `training_wheels_signature` to the canonical 66-byte
  /// `EphemeralSignature` BCS (`0x00` variant ++ `0x40`-prefixed raw signature).
  /// A bare 64-byte signature is wrapped; anything else is rejected.
  static BuBytes _parseTrainingWheels(String hex) {
    final bytes = BytesUtils.fromHexString(hex);
    if (bytes.length == 66) return bytes;
    if (bytes.length == 64) return [0x00, 0x40, ...bytes].asImmutableBytes;
    throw BuError(
      DefaultErrorType.invalidLength,
      'Invalid training-wheels signature length.',
      details: {'length': bytes.length.toString()},
    );
  }
}
