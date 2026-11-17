import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/sui/src/account/core/account.dart';
import 'package:on_chain/sui/src/account/public_key/keys.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/sui/src/zklogin/utils.dart';

/// Groth16 proof points as decimal strings (prover-service JSON form).
class SuiZkLoginProofPoints {
  final List<BigInt> a;
  final List<List<BigInt>> b;
  final List<BigInt> c;

  const SuiZkLoginProofPoints({
    required this.a,
    required this.b,
    required this.c,
  });

  static List<BigInt> _decList(List<dynamic> values, int expected) {
    final parsed = [for (final v in values) BigintUtils.parse(v)];
    if (parsed.length != expected) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid zkLogin proof points length.',
        details: {
          'expected': expected.toString(),
          'got': parsed.length.toString(),
        },
      );
    }
    return parsed;
  }

  factory SuiZkLoginProofPoints.fromJson(Map<String, dynamic> json) {
    return SuiZkLoginProofPoints(
      a: _decList(json['a'] as List, 3),
      b: [for (final row in (json['b'] as List)) _decList(row as List, 2)],
      c: _decList(json['c'] as List, 3),
    );
  }

  /// BCS layout-struct form. Like Sui/fastcrypto (`Bn254FrElement`
  /// serializes as a radix-10 string in EVERY encoding, BCS included),
  /// every coordinate is a decimal string — not 32-byte arrays.
  factory SuiZkLoginProofPoints.fromStruct(Map<String, dynamic> json) {
    List<BigInt> strList(List<dynamic> values, int expected) {
      final parsed = [for (final v in values) BigintUtils.parse(v.toString())];
      if (parsed.length != expected) {
        throw BuError(
          DefaultErrorType.invalidLength,
          'Invalid zkLogin proof points length.',
          details: {
            'expected': expected.toString(),
            'got': parsed.length.toString(),
          },
        );
      }
      return parsed;
    }

    Map<String, dynamic> proofJson =
        (json['proofPoints'] as Map).cast<String, dynamic>();
    return SuiZkLoginProofPoints(
      a: strList(proofJson['a'] as List, 3),
      b: [for (final row in (proofJson['b'] as List)) strList(row as List, 2)],
      c: strList(proofJson['c'] as List, 3),
    );
  }

  List<int> _fqToBytes(BigInt v) {
    return SuiZkLoginUtils.fieldToBytes32(v);
  }

  /// 256-byte uncompressed Groth16 proof (`a64 + b128 + c64`) for backend
  /// verification. G2 uses EIP-197 limb order (`x1,x0,y1,y0`); the z-coords
  /// stored in [a]/[b]/[c] are dropped (affine points).
  List<int> toUncompressedBytes() {
    return [
      ..._fqToBytes(a[0]),
      ..._fqToBytes(a[1]),
      ..._fqToBytes(b[0][1]),
      ..._fqToBytes(b[0][0]),
      ..._fqToBytes(b[1][1]),
      ..._fqToBytes(b[1][0]),
      ..._fqToBytes(c[0]),
      ..._fqToBytes(c[1]),
    ];
  }

  Map<String, dynamic> toLayoutStruct() {
    return {
      'a': [for (final e in a) e.toString()],
      'b': [
        for (final row in b) [for (final e in row) e.toString()],
      ],
      'c': [for (final e in c) e.toString()],
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    final dec = LayoutConst.bcsString();
    return LayoutConst.struct([
      LayoutConst.bcsVector(dec, property: 'a'),
      LayoutConst.bcsVector(LayoutConst.bcsVector(dec), property: 'b'),
      LayoutConst.bcsVector(dec, property: 'c'),
    ], property: property);
  }
}

/// `Claim { value: String, index_mod_4: u8 }` (BCS order per fastcrypto).
class SuiZkLoginClaim {
  final String value;
  final int indexMod4;

  const SuiZkLoginClaim({required this.value, required this.indexMod4});

  factory SuiZkLoginClaim.fromJson(Map<String, dynamic> json) {
    return SuiZkLoginClaim(
      value: json['value'] as String,
      indexMod4: (json['index_mod_4'] as num).toInt(),
    );
  }

  /// BCS layout-struct form (camelCase keys, matching [toLayoutStruct]).
  factory SuiZkLoginClaim.fromStruct(Map<String, dynamic> json) {
    return SuiZkLoginClaim(
      value: json['value'] as String,
      indexMod4: (json['indexMod4'] as num).toInt(),
    );
  }

  Map<String, dynamic> toLayoutStruct() {
    return {'value': value, 'indexMod4': indexMod4};
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsString(property: 'value'),
      LayoutConst.u8(property: 'indexMod4'),
    ], property: property);
  }
}

/// `ZkLoginInputs` (BCS order: proof_points, iss_base64_details,
/// header_base64, address_seed) as returned by the proving service
/// (`proof_points`, `iss_base64_details`, `header_base64` JSON keys).
class SuiZkLoginInputs {
  final SuiZkLoginProofPoints proofPoints;
  final SuiZkLoginClaim issBase64Details;
  final String headerBase64;
  final BigInt addressSeed;

  const SuiZkLoginInputs({
    required this.proofPoints,
    required this.issBase64Details,
    required this.headerBase64,
    required this.addressSeed,
  });

  factory SuiZkLoginInputs.fromProverJson(Map<String, dynamic> json) {
    return SuiZkLoginInputs(
      proofPoints: SuiZkLoginProofPoints.fromJson(
        (json['proof_points'] as Map).cast<String, dynamic>(),
      ),
      issBase64Details: SuiZkLoginClaim.fromJson(
        (json['iss_base64_details'] as Map).cast<String, dynamic>(),
      ),
      headerBase64: json['header_base64'] as String,
      addressSeed: BigintUtils.parse(json['address_seed'].toString()),
    );
  }

  /// BCS layout-struct form (`addressSeed` is a decimal string, like every
  /// `Bn254FrElement` in Sui BCS).
  factory SuiZkLoginInputs.fromStruct(Map<String, dynamic> json) {
    List<BigInt> strList(List<dynamic> values, int expected) {
      final parsed = [for (final v in values) BigintUtils.parse(v.toString())];
      if (parsed.length != expected) {
        throw BuError(
          DefaultErrorType.invalidLength,
          'Invalid zkLogin proof points length.',
          details: {
            'expected': expected.toString(),
            'got': parsed.length.toString(),
          },
        );
      }
      return parsed;
    }

    Map<String, dynamic> proofJson =
        (json['proofPoints'] as Map).cast<String, dynamic>();
    return SuiZkLoginInputs(
      proofPoints: SuiZkLoginProofPoints(
        a: strList(proofJson['a'] as List, 3),
        b: [
          for (final row in (proofJson['b'] as List)) strList(row as List, 2),
        ],
        c: strList(proofJson['c'] as List, 3),
      ),
      issBase64Details: SuiZkLoginClaim.fromStruct(
        (json['issBase64Details'] as Map).cast<String, dynamic>(),
      ),
      headerBase64: json['headerBase64'] as String,
      addressSeed: BigintUtils.parse(json['addressSeed']),
    );
  }

  Map<String, dynamic> toLayoutStruct() {
    return {
      'proofPoints': proofPoints.toLayoutStruct(),
      'issBase64Details': issBase64Details.toLayoutStruct(),
      'headerBase64': headerBase64,
      'addressSeed': addressSeed.toString(),
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiZkLoginProofPoints.layout(property: 'proofPoints'),
      SuiZkLoginClaim.layout(property: 'issBase64Details'),
      LayoutConst.bcsString(property: 'headerBase64'),
      LayoutConst.bcsString(property: 'addressSeed'),
    ], property: property);
  }
}

/// Ephemeral (single-key) signature inside the zkLogin envelope:
/// `{ scheme: u8 flag, signature: bytes, public_key: bytes }`.
class SuiZkLoginUserSignature {
  final SuiSigningScheme scheme;
  final BuBytes signature;
  final BuBytes publicKey;

  SuiZkLoginUserSignature({
    required this.scheme,
    required List<int> signature,
    required List<int> publicKey,
  }) : signature = signature.asImmutableBytes,
       publicKey = publicKey.asImmutableBytes;

  Map<String, dynamic> toLayoutStruct() {
    return {
      'scheme': scheme.value,
      'signature': signature,
      'publicKey': publicKey,
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: 'scheme'),
      LayoutConst.bcsBytes(property: 'signature'),
      LayoutConst.bcsBytes(property: 'publicKey'),
    ], property: property);
  }

  factory SuiZkLoginUserSignature.fromStruct(Map<String, dynamic> json) {
    final schemeValue = json['scheme'];
    return SuiZkLoginUserSignature(
      scheme: SuiSigningScheme.values.firstWhere(
        (e) => e.value == schemeValue,
        orElse:
            () =>
                throw BuError(
                  DefaultErrorType.invalidArgument,
                  'Unknown signing scheme flag.',
                  details: {'scheme': schemeValue?.toString()},
                ),
      ),
      signature: json.valueAsBytes("signature"),
      publicKey: json.valueAsBytes("publicKey"),
    );
  }
}

/// zkLogin authenticator signature (scheme flag `0x05`).
class SuiZkLoginSignature extends SuiBaseSignature {
  final SuiZkLoginInputs inputs;
  final BigInt maxEpoch;
  final SuiZkLoginUserSignature userSignature;

  SuiZkLoginSignature({
    required this.inputs,
    required BigInt maxEpoch,
    required this.userSignature,
  }) : maxEpoch = maxEpoch.asU64,
       super(scheme: SuiSigningScheme.zklogin);

  factory SuiZkLoginSignature.fromStruct(Map<String, dynamic> json) {
    return SuiZkLoginSignature(
      inputs: SuiZkLoginInputs.fromStruct(
        (json['inputs'] as Map).cast<String, dynamic>(),
      ),
      maxEpoch: BigintUtils.parse(json['maxEpoch'].toString()),
      userSignature: SuiZkLoginUserSignature.fromStruct(
        (json['userSignature'] as Map).cast<String, dynamic>(),
      ),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiZkLoginInputs.layout(property: 'inputs'),
      LayoutConst.u64(property: 'maxEpoch'),
      SuiZkLoginUserSignature.layout(property: 'userSignature'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'inputs': inputs.toLayoutStruct(),
      'maxEpoch': maxEpoch,
      'userSignature': userSignature.toLayoutStruct(),
    };
  }

  /// Verifies the *ephemeral* signature half of a zkLogin envelope over an
  /// intent digest (transaction or personal-message digest). The Groth16 proof
  /// half is validator-side (or prover-service-side for dry runs).
  static bool verifyEphemeralSignature({
    required List<int> digest,
    required SuiZkLoginSignature signature,
    required SuiAccountPublicKey ephemeralPublicKey,
  }) {
    final userSignature = signature.userSignature;
    final expectedScheme = switch (ephemeralPublicKey) {
      SuiEd25519AccountPublicKey() => SuiSigningScheme.ed25519,
      SuiSecp256k1AccountPublicKey() => SuiSigningScheme.secp256k1,
      SuiSecp256r1AccountPublicKey() => SuiSigningScheme.secp256r1,
      _ =>
        throw BuError(
          DefaultErrorType.unsupported,
          'Unsupported ephemeral key type.',
          details: {'type': '$ephemeralPublicKey'},
        ),
    };
    if (userSignature.scheme != expectedScheme) return false;
    return ephemeralPublicKey.verify(
      message: digest,
      signature: userSignature.signature,
    );
  }
}

/// Public key of a zkLogin account: the derived address seed + issuer.
/// The on-chain address is computed, not key-derived.
class SuiZkLoginAccountPublicKey extends SuiAccountPublicKey {
  final BigInt addressSeed;
  final String iss;
  final bool legacyAddress;

  const SuiZkLoginAccountPublicKey({
    required this.addressSeed,
    required this.iss,
    this.legacyAddress = false,
  }) : super(scheme: SuiSigningScheme.zklogin);

  factory SuiZkLoginAccountPublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiZkLoginAccountPublicKey(
      addressSeed: json.valueAsBigInt("addressSeed"),
      iss: json['iss'] as String,
      legacyAddress: json.valueAsBool<bool?>("legacyAddress") ?? false,
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u256(property: 'addressSeed'),
      LayoutConst.bcsString(property: 'iss'),
      LayoutConst.boolean(property: 'legacyAddress'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'addressSeed': addressSeed,
      'iss': iss,
      'legacyAddress': legacyAddress,
    };
  }

  @override
  SuiAddress toAddress() {
    return SuiZkLoginUtils.computeAddressFromSeed(
      addressSeed: addressSeed,
      iss: iss,
      legacyAddress: legacyAddress,
    );
  }

  @override
  bool verifyPersonalMessage({
    required List<int> message,
    required List<int> signature,
  }) {
    throw BuError(
      OnChainErrorType.suiPlugin,
      'zkLogin personal-message verification needs the ephemeral key; '
      'verify the envelope with SuiZkLoginSignature.verifyEphemeralSignature().',
    );
  }

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    throw BuError(
      OnChainErrorType.suiPlugin,
      'zkLogin verification needs the ephemeral key and a proving-service '
      'proof; verify the envelope with SuiZkLoginSignature.verifyEphemeralSignature().',
    );
  }
}

/// A zkLogin login session: ephemeral key + proving-service inputs.
///
/// Proving stays server-side: construct with the prover response, sign with
/// the ephemeral key exactly like a normal account.
class SuiZkLoginAccount
    extends SuiAccount<SuiZkLoginAccountPublicKey, SuiZkLoginSignature> {
  final SuiAccount ephemeralAccount;
  final SuiZkLoginInputs inputs;
  final BigInt maxEpoch;

  SuiZkLoginAccount({
    required this.ephemeralAccount,
    required this.inputs,
    required BigInt maxEpoch,
    required super.publicKey,
  }) : maxEpoch = maxEpoch.asU64,
       super(scheme: SuiSigningScheme.zklogin);

  /// Derives the account for OIDC claims (address from seed).
  factory SuiZkLoginAccount.fromClaims({
    required SuiAccount ephemeralAccount,
    required SuiZkLoginInputs inputs,
    required BigInt maxEpoch,
    required String iss,
    bool legacyAddress = false,
  }) {
    return SuiZkLoginAccount(
      ephemeralAccount: ephemeralAccount,
      inputs: inputs,
      maxEpoch: maxEpoch,
      publicKey: SuiZkLoginAccountPublicKey(
        addressSeed: inputs.addressSeed,
        iss: iss,
        legacyAddress: legacyAddress,
      ),
    );
  }

  SuiZkLoginUserSignature _wrapEphemeral(SuiBaseSignature ephemeral) {
    final SuiSigningScheme scheme;
    final List<int> publicKey;
    if (ephemeral is SuiEd25519Signature) {
      scheme = SuiSigningScheme.ed25519;
      publicKey = ephemeral.publicKey.publicKey.toBytes();
    } else if (ephemeral is SuiSecp256k1Signature) {
      scheme = SuiSigningScheme.secp256k1;
      publicKey = ephemeral.publicKey.publicKey.toBytes();
    } else if (ephemeral is SuiSecp256r1Signature) {
      scheme = SuiSigningScheme.secp256r1;
      publicKey = ephemeral.publicKey.publicKey.toBytes();
    } else {
      throw BuError(
        DefaultErrorType.unsupported,
        'Unsupported ephemeral signature type.',
        details: {'type': '${ephemeral.runtimeType}'},
      );
    }
    List<int> rawSignature;
    if (ephemeral is SuiSingleKeySignature) {
      rawSignature = (ephemeral).signature.signature;
    } else {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Ephemeral account must be single-key.',
        details: {'type': '${ephemeral.runtimeType}'},
      );
    }
    return SuiZkLoginUserSignature(
      scheme: scheme,
      signature: rawSignature,
      publicKey: publicKey,
    );
  }

  @override
  SuiZkLoginSignature signTransaction(
    List<int> txbytes, {
    bool hashDigest = true,
  }) {
    final ephemeral = ephemeralAccount.signTransaction(
      txbytes,
      hashDigest: hashDigest,
    );
    return SuiZkLoginSignature(
      inputs: inputs,
      maxEpoch: maxEpoch,
      userSignature: _wrapEphemeral(ephemeral),
    );
  }

  @override
  SuiZkLoginSignature signPersonalMessage(List<int> message) {
    final ephemeral = ephemeralAccount.signPersonalMessage(message);
    return SuiZkLoginSignature(
      inputs: inputs,
      maxEpoch: maxEpoch,
      userSignature: _wrapEphemeral(ephemeral),
    );
  }

  @override
  void dispose() {
    ephemeralAccount.dispose();
  }
}
