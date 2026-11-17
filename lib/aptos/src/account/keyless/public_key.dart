import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/keyless/poseidon_pack.dart';
import 'package:on_chain/aptos/src/account/keyless/signature.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';

import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';

/// Aptos keyless public key (AIP-61): `iss` + 32-byte identity commitment.
///
/// BCS: `{ iss: string, id_commitment: bytes }`.
class AptosKeylessAccountPublicKey extends AptosAccountPublicKey
    implements AptosVariantPublicKey {
  /// Identity commitment length in bytes.
  static const int idCommitmentLength = 32;

  /// `AnyPublicKey` variant index for keyless (single-key wrapped on chain).
  static const int anyPublicKeyVariant = 3;

  /// Max bytes for the packed JWT fields (mirrors the TS SDK limits).
  static const int maxAudValBytes = 120;
  static const int maxUidKeyBytes = 30;
  static const int maxUidValBytes = 330;

  /// OIDC issuer (JWT `iss`).
  final String iss;

  /// Identity commitment: `poseidon(pepper, aud, uidVal, uidKey)`.
  final BuBytes idCommitment;

  AptosKeylessAccountPublicKey._({
    required this.iss,
    required List<int> idCommitment,
  }) : idCommitment = idCommitment.asImmutableBytes,
       super(scheme: AptosSigningScheme.signleKey) {
    if (idCommitment.length != idCommitmentLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid keyless identity commitment length.',
        details: {
          'expected': idCommitmentLength.toString(),
          'length': idCommitment.length.toString(),
        },
      );
    }
  }

  /// Computes the identity commitment from JWT claims plus pepper.
  static BuBytes computeIdCommitment({
    required String uidKey,
    required String uidVal,
    required String aud,
    required List<int> pepper,
  }) {
    final fields = [
      AptosKeylessPoseidon.bytesToBigIntLE(pepper),
      AptosKeylessPoseidon.hashStrToField(aud, maxAudValBytes),
      AptosKeylessPoseidon.hashStrToField(uidVal, maxUidValBytes),
      AptosKeylessPoseidon.hashStrToField(uidKey, maxUidKeyBytes),
    ];
    return AptosKeylessPoseidon.bigIntToBytesLE(
      AptosKeylessPoseidon.hashFields(fields),
      idCommitmentLength,
    ).asImmutableBytes;
  }

  factory AptosKeylessAccountPublicKey({
    required String iss,
    required String uidKey,
    required String uidVal,
    required String aud,
    required List<int> pepper,
  }) {
    return AptosKeylessAccountPublicKey._(
      iss: iss,
      idCommitment: computeIdCommitment(
        uidKey: uidKey,
        uidVal: uidVal,
        aud: aud,
        pepper: pepper,
      ),
    );
  }

  factory AptosKeylessAccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosKeylessAccountPublicKey.fromStruct(decode);
  }
  factory AptosKeylessAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosKeylessAccountPublicKey._(
      iss: json.valueAs("iss"),
      idCommitment: json.valueAsBytes("idCommitment"),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsString(property: "iss"),
      LayoutConst.bcsBytes(property: "idCommitment"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  /// BCS bytes of this key WITHOUT the `AnyPublicKey` variant prefix.
  BuBytes toInnerBcs() {
    return toBcs();
  }

  /// Full `AnyPublicKey` BCS: `uleb128(3) ++ inner`.
  BuBytes toAnyPublicKeyBcs() {
    return [
      ...LayoutConst.lebU32().serialize(anyPublicKeyVariant),
      ...toInnerBcs(),
    ].asImmutableBytes;
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"iss": iss, "idCommitment": idCommitment};
  }

  @override
  String get variantName => "keyless";

  @override
  Map<String, dynamic> toVariantLayoutStruct() {
    return {variantName: toLayoutStruct()};
  }

  @override
  List<int> toBytes() {
    return toInnerBcs();
  }

  @override
  AptosAddress toAddress() {
    final anyPk = List<int>.from(toAnyPublicKeyBcs());
    final addressBytes = AptosAddressUtils.hashKeyBytes(
      bytes: anyPk,
      scheme: AptosAddrConst.singleKeyAddressFlag,
    );
    return AptosAddress(BytesUtils.toHexString(addressBytes, prefix: '0x'));
  }

  /// Verifies only the ephemeral Ed25519 component of a keyless signature.
  /// Full ZK verification happens on chain (no Dart-side pairing exists).
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
