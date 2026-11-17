import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/crypto/crypto/crypto.dart';
import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/crypto.dart';
import 'icp_hash_tree.dart';

class ICPCertificate {
  final ICPHashTree tree;
  final List<int> signature; // BLS signature (G2)
  final ICPCertificateDelegation? delegation;

  ICPCertificate({
    required this.tree,
    required List<int> signature,
    this.delegation,
  }) : signature = signature.asImmutableBytes;

  factory ICPCertificate.deserialize(List<int> bytes) {
    final content = CborObject.deserialize(bytes);

    // certificate blob is often itself a CBOR map (sometimes tagged)
    final raw = content.getValue();
    final json = JsonParser.valueEnsureAsMap<String, dynamic>(
      raw is Map ? raw : (content as CborTagValue).value.getValue(),
    );
    return ICPCertificate.fromJson(json);
  }

  factory ICPCertificate.fromJson(Map<String, dynamic> json) {
    final treeRaw = json['tree'];
    final tree = ICPHashTree.deserializeNode(treeRaw);

    final sig = json.valueAsBytes<List<int>>('signature');

    ICPCertificateDelegation? delegation;
    if (json.hasValue('delegation')) {
      final d = json.valueEnsureAsMap<String, dynamic>('delegation');
      delegation = ICPCertificateDelegation.fromJson(d);
    }

    return ICPCertificate(tree: tree, signature: sig, delegation: delegation);
  }

  CborMapValue toCborMap() {
    final map = <CborObject, CborObject>{
      CborStringValue('tree'): tree.toCbor(),
      CborStringValue('signature'): CborBytesValue(signature),
    };
    if (delegation != null) {
      map[CborStringValue('delegation')] = delegation!.toCborMap();
    }
    return CborMapValue.definite(map);
  }

  CborTagValue toCbor() => CborTagValue(toCborMap(), [55799]);

  ICPLookupResult lookup(List<List<int>> path) =>
      ICPHashTreeUtils.lookupPath(path, tree);

  List<int>? tryGetNodePublicKey({
    required IcpPrincipalAddress nodeId,
    required List<int> rootKey,
  }) {
    List<int>? subId = delegation?.subnetId.toBytes();
    subId ??= ICPCryptoUtils.selfAuthenticatingHash(rootKey);
    final path = [
      "subnet".codeUnits,
      subId, // Principal bytes
      "node".codeUnits,
      nodeId.toBytes(), // from query signature
      "public_key".codeUnits,
    ];
    final pk = lookup(path);
    return switch (pk) {
      ICPLookupFound(:final value) => value,
      _ => null,
    };
  }

  /// Returns true if the certificate is valid under [rootKey] (DER or raw BLS).
  ///
  Future<bool> verify({
    required List<int> rootKey,
    CbBlsVerificationKey? verificationKey,
  }) async {
    // 1. resolve the key that signed this certificate
    final blsKey = await _delegationKey(
      rootKey: rootKey,
      verificationKey: verificationKey,
    );
    if (blsKey == null) return false;

    // 2. reconstruct root hash
    final rootHash = tree.reconstruct();

    // 3. message = domain_sep("ic-state-root") ‖ root_hash
    final message = ICPCryptoUtils.icStateRootMessage(rootHash);
    // IC threshold signatures use the G1 NUL ciphersuite
    // (BLS_SIG_BLS12381G1_XMD:SHA-256_SSWU_RO_NUL_), not the POP default.
    return blsKey.verify(
      Bls12G2VerifiyingParams(
        signature: Bls12G2Signature(G1Projective.fromBytes(signature)),
        signingParams: Bls12SigningParams(
          message: message,
          dst: BlsG1Constants.defaultDst,
        ),
      ),
    );
  }

  /// Spec: delegation_key
  Future<IBlsMinSigVerificationKey?> _delegationKey({
    required List<int> rootKey,
    CbBlsVerificationKey? verificationKey,
  }) async {
    final delegation = this.delegation;
    if (delegation == null) {
      if (verificationKey != null) return verificationKey(rootKey);
      return Bls12G2PublicKey.fromDer(rootKey);
    }

    // delegation certificate must itself verify under the root (no further delegation)
    if (delegation.certificate.delegation != null) return null;
    final verify = await delegation.certificate.verify(
      rootKey: rootKey,
      verificationKey: verificationKey,
    );
    if (!verify) {
      return null;
    }

    final pkLookup = delegation.certificate.lookup([
      'subnet'.codeUnits,
      delegation.subnetId.toBytes(),
      'public_key'.codeUnits,
    ]);
    if (pkLookup is! ICPLookupFound) return null;
    if (verificationKey != null) return verificationKey(pkLookup.value);
    return Bls12G2PublicKey.fromDer(pkLookup.value);
  }
}

class ICPCertificateDelegation {
  final IcpPrincipalAddress subnetId; // Principal bytes
  final ICPCertificate certificate; // cert under the root

  const ICPCertificateDelegation({
    required this.subnetId,
    required this.certificate,
  });

  factory ICPCertificateDelegation.fromJson(Map<String, dynamic> json) {
    return ICPCertificateDelegation(
      subnetId: IcpPrincipalAddress.fromBytes(json.valueAsBytes('subnet_id')),
      certificate: ICPCertificate.deserialize(json.valueAsBytes("certificate")),
    );
  }

  CborMapValue toCborMap() {
    return CborMapValue.definite({
      CborStringValue('subnet_id'): CborBytesValue(subnetId.toBytes()),
      CborStringValue('certificate'): certificate.toCborMap(),
    });
  }
}
