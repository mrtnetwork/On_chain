import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/keyless/ephemeral.dart';
import 'package:on_chain/aptos/src/account/keyless/jwt.dart';
import 'package:on_chain/aptos/src/account/keyless/public_key.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';

import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';

/// Federated keyless public key (custom OIDC issuer).
///
/// Same identity commitment as standard keyless, but scoped to the
/// issuer's on-chain JWK address: BCS
/// `{ jwk_address: address, iss: string, id_commitment: bytes }`.
class AptosFederatedKeylessPublicKey extends AptosAccountPublicKey
    implements AptosVariantPublicKey {
  /// `AnyPublicKey` variant index for federated keyless.
  static const int anyPublicKeyVariant = 4;

  /// Address holding this issuer's JWK set.
  final AptosAddress jwkAddress;

  /// OIDC issuer (JWT `iss`).
  final String iss;

  /// Identity commitment (same formula as standard keyless).
  final BuBytes idCommitment;

  AptosFederatedKeylessPublicKey({
    required List<int> jwkAddress,
    required this.iss,
    required List<int> idCommitment,
  }) : jwkAddress = AptosAddress.fromBytes(jwkAddress),
       idCommitment = idCommitment.asImmutableBytes,
       super(scheme: AptosSigningScheme.signleKey) {
    if (jwkAddress.length != AptosAddrConst.addressBytesLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid federated JWK address length.',
        details: {'length': jwkAddress.length.toString()},
      );
    }
    if (idCommitment.length !=
        AptosKeylessAccountPublicKey.idCommitmentLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid keyless identity commitment length.',
        details: {'length': idCommitment.length.toString()},
      );
    }
  }

  AptosFederatedKeylessPublicKey._fromParts({
    required this.jwkAddress,
    required this.iss,
    required List<int> idCommitment,
  }) : idCommitment = idCommitment.asImmutableBytes,
       super(scheme: AptosSigningScheme.signleKey) {
    if (idCommitment.length !=
        AptosKeylessAccountPublicKey.idCommitmentLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid keyless identity commitment length.',
        details: {'length': idCommitment.length.toString()},
      );
    }
  }

  factory AptosFederatedKeylessPublicKey.fromJwtAndPepper({
    required String jwt,
    required List<int> pepper,
    required List<int> jwkAddress,
    String uidKey = 'sub',
  }) {
    final claims = AptosJwtClaims.parse(jwt);
    return AptosFederatedKeylessPublicKey(
      jwkAddress: jwkAddress,
      iss: claims.iss,
      idCommitment: AptosKeylessAccountPublicKey.computeIdCommitment(
        uidKey: uidKey,
        uidVal: claims.uidVal(uidKey),
        aud: claims.aud,
        pepper: pepper,
      ),
    );
  }

  factory AptosFederatedKeylessPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosFederatedKeylessPublicKey.fromStruct(decode);
  }
  factory AptosFederatedKeylessPublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosFederatedKeylessPublicKey._fromParts(
      jwkAddress: AptosAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('jwkAddress'),
      ),
      iss: json.valueAs('iss'),
      idCommitment: json.valueAsBytes('idCommitment'),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosAddress.layout(property: 'jwkAddress'),
      LayoutConst.bcsString(property: 'iss'),
      LayoutConst.bcsBytes(property: 'idCommitment'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'jwkAddress': jwkAddress.toLayoutStruct(),
      'iss': iss,
      'idCommitment': idCommitment,
    };
  }

  /// Full `AnyPublicKey` BCS: `uleb128(4) ++ inner`.
  BuBytes toAnyPublicKeyBcs() {
    return [
      ...LayoutConst.lebU32().serialize(anyPublicKeyVariant),
      ...toBcs(),
    ].asImmutableBytes;
  }

  @override
  String get variantName => 'federatedKeyless';

  @override
  Map<String, dynamic> toVariantLayoutStruct() {
    return {variantName: toLayoutStruct()};
  }

  @override
  List<int> toBytes() {
    return toBcs();
  }

  @override
  AptosAddress toAddress() {
    final addressBytes = AptosAddressUtils.hashKeyBytes(
      bytes: List<int>.from(toAnyPublicKeyBcs()),
      scheme: AptosAddrConst.singleKeyAddressFlag,
    );
    return AptosAddress(BytesUtils.toHexString(addressBytes, prefix: '0x'));
  }

  /// Verifies only the ephemeral Ed25519 component (full ZK is on-chain).
  @override
  bool verifySignature({
    required List<int> message,
    required List<int> signature,
  }) {
    final any = AptosAnySignature.deserialize(signature);
    if (any is! AptosKeylessAnySignature) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Expected a keyless signature.',
        details: {'type': any.type.name},
      );
    }
    final sig = any.signature;
    final verifier = ED25519Verifier(
      ED25519PublicKey.fromBytes(sig.ephemeralPublicKey.keyBytes),
    );
    return verifier.verify(
      message,
      ED25519Signature.fromBytes(sig.ephemeralSignature.signature),
    );
  }
}

/// Federated keyless account (custom issuer JWK address).
class AptosFederatedKeylessAccount
    extends
        AptosAccount<
          AptosFederatedKeylessPublicKey,
          AptosAccountAuthenticatorSingleKey,
          AptosKeylessAnySignature
        > {
  final AptosEphemeralKeyPair ephemeral;
  final AptosZeroKnowledgeSig proof;
  final String jwtHeader;

  AptosFederatedKeylessAccount({
    required super.publicKey,
    required this.ephemeral,
    required this.proof,
    required this.jwtHeader,
  }) : super(scheme: AptosSigningScheme.signleKey);

  AptosKeylessAnySignature _sign(List<int> digest) {
    return AptosKeylessAnySignature(
      AptosKeylessSignature.sign(
        ephemeral: ephemeral,
        zkSig: proof,
        jwtHeader: jwtHeader,
        digest: digest,
      ),
    );
  }

  @override
  AptosAccountAuthenticatorSingleKey signWithAuth(List<int> digest) {
    return AptosAccountAuthenticatorSingleKey(
      publicKey: publicKey,
      signature: _sign(digest),
    );
  }

  @override
  AptosKeylessAnySignature sign(List<int> digest) => _sign(digest);
}
