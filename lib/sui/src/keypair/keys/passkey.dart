import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/account/core/account.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/keys/secp256r1.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';

/// Passkey authenticator signature:
/// `{ authenticatorData: bytes, clientDataJSON: utf8-string,
///   signature: secp256r1 }`.
class SuiPasskeySignature extends SuiBaseSignature {
  final List<int> authenticatorData;
  final String clientDataJSON;
  final SuiSecp256r1Signature signature;

  SuiPasskeySignature({
    required List<int> authenticatorData,
    required this.clientDataJSON,
    required this.signature,
  }) : authenticatorData = authenticatorData.asImmutableBytes,
       super(scheme: SuiSigningScheme.passkey);

  /// Message the authenticator signs.
  static List<int> signedPayload({
    required List<int> authenticatorData,
    required String clientDataJSON,
  }) {
    final clientHash = QuickCrypto.sha256Hash(
      StringUtils.encode(clientDataJSON),
    );
    return [...authenticatorData, ...clientHash];
  }

  factory SuiPasskeySignature.fromStruct(Map<String, dynamic> json) {
    return SuiPasskeySignature(
      authenticatorData: json.valueAsBytes("authenticatorData"),
      clientDataJSON: json.valueAs("clientDataJSON"),
      signature: SuiSecp256r1Signature.fromStruct(
        json.valueEnsureAsMap<String, dynamic>("signature"),
      ),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "authenticatorData"),
      LayoutConst.bcsString(property: "clientDataJSON"),
      SuiSecp256r1Signature.layout(property: "signature"),
    ], property: property);
  }

  /// Verifies a passkey envelope: recomputes the signed payload
  /// (`authenticatorData || sha256(clientDataJSON)`) and checks the
  /// secp256r1 signature with the repo's standard hash-inside convention
  /// (matches real WebAuthn output). Fully local; no authenticator needed.
  static bool verify({
    required SuiPasskeySignature signature,
    required SuiPasskeyAccountPublicKey publicKey,
  }) {
    final payload = SuiPasskeySignature.signedPayload(
      authenticatorData: signature.authenticatorData,
      clientDataJSON: signature.clientDataJSON,
    );
    return publicKey.verify(
      message: payload,
      signature: signature.signature.signature.signature,
    );
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "authenticatorData": authenticatorData,
      "clientDataJSON": clientDataJSON,
      "signature": signature.toLayoutStruct(),
    };
  }
}

/// Public key of a passkey account: the secp256r1 credential key.
/// Address derivation is the standard secp256r1 path.
class SuiPasskeyAccountPublicKey extends SuiSecp256r1AccountPublicKey {
  const SuiPasskeyAccountPublicKey(super.publicKey);

  @override
  SuiSigningScheme get scheme => SuiSigningScheme.passkey;

  factory SuiPasskeyAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiPasskeyAccountPublicKey(SuiSecp256r1PublicKey.fromStruct(json));
  }
}

/// A passkey login session: secp256r1 credential key + WebAuthn assertion
/// assembly. The browser/authenticator produces `authenticatorData` (with
/// the challenge) — this class does the Sui-side crypto.
class SuiPasskeyAccount
    extends SuiAccount<SuiPasskeyAccountPublicKey, SuiPasskeySignature> {
  final SuiSecp256r1PrivateKey credentialKey;

  SuiPasskeyAccount({required this.credentialKey, required super.publicKey})
    : super(scheme: SuiSigningScheme.passkey);

  factory SuiPasskeyAccount.fromPrivateKey(SuiSecp256r1PrivateKey key) {
    return SuiPasskeyAccount(
      credentialKey: key,
      publicKey: SuiPasskeyAccountPublicKey(key.publicKey),
    );
  }

  /// Assembles a passkey signature from a WebAuthn assertion.
  ///
  /// Uses the repo's hash-inside signing convention, matching what a real
  /// authenticator produces for the same payload.
  SuiPasskeySignature signWithAssertion({
    required List<int> authenticatorData,
    required String clientDataJSON,
  }) {
    final payload = SuiPasskeySignature.signedPayload(
      authenticatorData: authenticatorData,
      clientDataJSON: clientDataJSON,
    );
    final signature = credentialKey.sign(payload);
    return SuiPasskeySignature(
      authenticatorData: authenticatorData,
      clientDataJSON: clientDataJSON,
      signature: SuiSecp256r1Signature(
        signature: SuiGenericSignature(
          signature: signature.signature,
          algorithm: SuiKeyAlgorithm.secp256r1,
        ),
        publicKey: credentialKey.publicKey,
      ),
    );
  }

  @override
  SuiPasskeySignature signTransaction(
    List<int> txbytes, {
    bool hashDigest = true,
  }) {
    throw BuError(
      OnChainErrorType.suiPlugin,
      'Passkey signing needs a WebAuthn assertion; '
      'use signWithAssertion(authenticatorData: clientDataJSON:).',
    );
  }

  @override
  SuiPasskeySignature signPersonalMessage(List<int> message) {
    throw BuError(
      OnChainErrorType.suiPlugin,
      'Passkey signing needs a WebAuthn assertion; '
      'use signWithAssertion(authenticatorData: clientDataJSON:).',
    );
  }

  @override
  void dispose() {
    credentialKey.dispose();
  }
}
