import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';

import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/serialization/bcs/serialization/serialization.dart';

/// Encrypted mempool (AIP-144) client-side implementation.
///
/// Ported from `aptos-core/crates/aptos-batch-encryption/ts-batch-encrypt`
/// and `@aptos-labs/ts-sdk` `core/crypto/encryption`.
/// Encrypt-only: validators decrypt, clients never decrypt.
///
/// Wire format (BCS):
/// `TransactionPayload::EncryptedPayload(5) | Encrypted(0) | Ciphertext |
///  TransactionExtraConfig | payload_hash[32] | epoch u64 |
///  Option of ClaimedEntryFunction`.
///
/// Plaintext envelope:
/// `DecryptedPlaintext { executable, decryption_nonce[16] }`,
/// `payload_hash = SHA3-256(SHA3-256("APTOS::DecryptedPlaintext") || BCS(plaintext))`.
class AptosEncryptedConstants {
  // BLS12-381 scalar field order is `JubJubFq`'s modulus (JubJub lives over
  // BLS12-381 Fr). Scalars are therefore `JubJubFq`, never `BigInt`; `BigInt`
  // only appears for u64 amounts (gas, epoch, nonces).

  /// `Id::from_verifying_key_and_ad` DST. Must match Rust `ID_HASH_DST`.
  static final List<int> idHashDst = StringUtils.encode(
    'APTOS_BATCH_ENCRYPTION_HASH_ID',
  );

  /// G2 -> G1 hash DST. Must match Rust `HASH_G2_ELEMENT_DST`.
  static final List<int> hashG2ElementDst = StringUtils.encode(
    'APTOS_BATCH_ENCRYPTION_HASH_G2_ELEMENT',
  );

  /// OTP KDF salt. Must match Rust/TS `HKDF_SALT`.
  static final List<int> hkdfSalt = StringUtils.encode(
    'APTOS_BATCH_ENCRYPTION_OTP',
  );

  static final List<int> decryptedPlaintextSalt = QuickCrypto.sha3256Hash(
    StringUtils.encode('APTOS::DecryptedPlaintext'),
  );

  static const int decryptionNonceLength = 16;
  static const int symmetricKeyLength = 16;
  static const int gcmNonceLength = 12;
  static const int g1Size = 48;
  static const int g2Size = 96;

  /// On-chain gas rules for encrypted transactions.
  static final BigInt minGasUnitPrice = BigInt.from(200);
  static final BigInt decryptionGasUnits = BigInt.from(375);
}

/// `TransactionExecutable` variants (aptos-core `types/src/transaction`).
enum AptosTransactionExecutables {
  script(value: 0),
  entryFunction(value: 1),
  empty(value: 2),
  encrypted(value: 3);

  final int value;
  const AptosTransactionExecutables({required this.value});
  static AptosTransactionExecutables fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'cannot find correct transaction executable from the given name.',
                details: {'name': name},
              ),
    );
  }
}

abstract class AptosTransactionExecutable extends BcsVariantSerialization {
  final AptosTransactionExecutables type;
  const AptosTransactionExecutable({required this.type});

  factory AptosTransactionExecutable.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosTransactionExecutables.fromName(decode.variantName);
    return switch (type) {
      AptosTransactionExecutables.script =>
        AptosTransactionExecutableScript.fromStruct(decode.value),
      AptosTransactionExecutables.entryFunction =>
        AptosTransactionExecutableEntryFunction.fromStruct(decode.value),
      AptosTransactionExecutables.empty => AptosTransactionExecutableEmpty(),
      AptosTransactionExecutables.encrypted =>
        AptosTransactionExecutableEncrypted(),
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
        layout: AptosTransactionExecutableScript.layout,
        property: AptosTransactionExecutables.script.name,
        index: AptosTransactionExecutables.script.value,
      ),
      LazyVariantModel(
        layout: AptosTransactionExecutableEntryFunction.layout,
        property: AptosTransactionExecutables.entryFunction.name,
        index: AptosTransactionExecutables.entryFunction.value,
      ),
      LazyVariantModel(
        layout: AptosTransactionExecutableEmpty.layout,
        property: AptosTransactionExecutables.empty.name,
        index: AptosTransactionExecutables.empty.value,
      ),
      LazyVariantModel(
        layout: AptosTransactionExecutableEncrypted.layout,
        property: AptosTransactionExecutables.encrypted.name,
        index: AptosTransactionExecutables.encrypted.value,
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosTransactionExecutableScript extends AptosTransactionExecutable {
  final AptosScript script;
  AptosTransactionExecutableScript({required this.script})
    : super(type: AptosTransactionExecutables.script);
  factory AptosTransactionExecutableScript.fromStruct(
    Map<String, dynamic> json,
  ) {
    return AptosTransactionExecutableScript(
      script: AptosScript.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('script'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosScript.layout(property: 'script'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {'script': script.toLayoutStruct()};
  }
}

class AptosTransactionExecutableEntryFunction
    extends AptosTransactionExecutable {
  final AptosTransactionEntryFunction entryFunction;
  AptosTransactionExecutableEntryFunction({required this.entryFunction})
    : super(type: AptosTransactionExecutables.entryFunction);
  factory AptosTransactionExecutableEntryFunction.fromStruct(
    Map<String, dynamic> json,
  ) {
    return AptosTransactionExecutableEntryFunction(
      entryFunction: AptosTransactionEntryFunction.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('entryFunction'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosTransactionEntryFunction.layout(property: 'entryFunction'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {'entryFunction': entryFunction.toLayoutStruct()};
  }
}

class AptosTransactionExecutableEmpty extends AptosTransactionExecutable {
  AptosTransactionExecutableEmpty()
    : super(type: AptosTransactionExecutables.empty);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

/// Server-side sentinel, never produced client-side. Deserialization only.
class AptosTransactionExecutableEncrypted extends AptosTransactionExecutable {
  AptosTransactionExecutableEncrypted()
    : super(type: AptosTransactionExecutables.encrypted);
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }
}

enum AptosTransactionExtraConfigVariants {
  v1(value: 0);

  final int value;
  const AptosTransactionExtraConfigVariants({required this.value});
  static AptosTransactionExtraConfigVariants fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'cannot find correct extra config from the given name.',
                details: {'name': name},
              ),
    );
  }
}

abstract class AptosTransactionExtraConfig extends BcsVariantSerialization {
  final AptosTransactionExtraConfigVariants type;
  const AptosTransactionExtraConfig({required this.type});
  factory AptosTransactionExtraConfig.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    final type = AptosTransactionExtraConfigVariants.fromName(
      decode.variantName,
    );
    return switch (type) {
      AptosTransactionExtraConfigVariants.v1 =>
        AptosTransactionExtraConfigV1.fromStruct(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.bcsLazyEnum([
      LazyVariantModel(
        layout: AptosTransactionExtraConfigV1.layout,
        property: AptosTransactionExtraConfigVariants.v1.name,
        index: AptosTransactionExtraConfigVariants.v1.value,
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String get variantName => type.name;
}

class AptosTransactionExtraConfigV1 extends AptosTransactionExtraConfig {
  final AptosAddress? multisigAddress;
  final BigInt? replayProtectionNonce;
  AptosTransactionExtraConfigV1({
    this.multisigAddress,
    BigInt? replayProtectionNonce,
  }) : replayProtectionNonce = replayProtectionNonce?.asU64,
       super(type: AptosTransactionExtraConfigVariants.v1);

  factory AptosTransactionExtraConfigV1.fromStruct(Map<String, dynamic> json) {
    return AptosTransactionExtraConfigV1(
      multisigAddress: json.valueTo<AptosAddress?, Map<String, dynamic>>(
        key: 'multisigAddress',
        parse: (e) => AptosAddress.fromStruct(e),
      ),
      replayProtectionNonce: json.valueTo<BigInt?, BigInt>(
        key: 'replayProtectionNonce',
        parse: (e) => e,
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.optional(AptosAddress.layout(), property: 'multisigAddress'),
      LayoutConst.optional(
        LayoutConst.u64(),
        property: 'replayProtectionNonce',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'multisigAddress': multisigAddress?.toLayoutStruct(),
      'replayProtectionNonce': replayProtectionNonce,
    };
  }
}

/// `TransactionPayload::Payload(4) + Inner::V1(0)`. Used for orderless
/// transactions; encrypted transactions reuse its `extra_config`.
class AptosTransactionPayloadInnerV1 extends AptosTransactionPayload {
  final AptosTransactionExecutable executable;
  final AptosTransactionExtraConfig extraConfig;
  AptosTransactionPayloadInnerV1({
    required this.executable,
    required this.extraConfig,
  }) : super(type: AptosTransactionPayloads.payload);

  factory AptosTransactionPayloadInnerV1.fromStruct(Map<String, dynamic> json) {
    // Layout is {innerVariant(0), executable, extraConfig}.
    // `json` here is the outer-variant value (already stripped of outer tag 4).
    return AptosTransactionPayloadInnerV1(
      executable: AptosTransactionExecutable.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('executable'),
      ),
      extraConfig: AptosTransactionExtraConfig.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('extraConfig'),
      ),
    );
  }

  /// BCS: `Payload(4) | V1(0) | executable | extraConfig`.
  /// Outer `4` is written by the parent enum; this layout writes inner `0`.
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: 'innerVariant'),
      AptosTransactionExecutable.layout(property: 'executable'),
      AptosTransactionExtraConfig.layout(property: 'extraConfig'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'innerVariant': 0,
      'executable': executable.toVariantLayoutStruct(),
      'extraConfig': extraConfig.toVariantLayoutStruct(),
    };
  }
}

/// Optional `claimed_entry_fun`: lets fee payers / multisig co-signers see
/// the module (and optionally function) without decrypting.
class AptosClaimedEntryFunction extends BcsSerialization {
  final AptosModuleId moduleId;
  final String? functionName;
  AptosClaimedEntryFunction({required this.moduleId, this.functionName});

  factory AptosClaimedEntryFunction.fromEntryFunction(
    AptosTransactionEntryFunction entry, {
    bool includeFunctionName = true,
  }) {
    return AptosClaimedEntryFunction(
      moduleId: entry.moduleId,
      functionName: includeFunctionName ? entry.functionName : null,
    );
  }

  factory AptosClaimedEntryFunction.fromStruct(Map<String, dynamic> json) {
    return AptosClaimedEntryFunction(
      moduleId: AptosModuleId.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('moduleId'),
      ),
      functionName: json['functionName'] as String?,
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosModuleId.layout(property: 'moduleId'),
      LayoutConst.optional(LayoutConst.bcsString(), property: 'functionName'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'moduleId': moduleId.toLayoutStruct(),
      'functionName': functionName,
    };
  }
}

/// `DecryptedPlaintext { executable, decryption_nonce[16] }`.
class AptosDecryptedPlaintext extends BcsSerialization {
  final AptosTransactionExecutable executable;
  final List<int> decryptionNonce;
  AptosDecryptedPlaintext({
    required this.executable,
    required List<int> decryptionNonce,
  }) : decryptionNonce = decryptionNonce.asImmutableBytes {
    if (decryptionNonce.length !=
        AptosEncryptedConstants.decryptionNonceLength) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'decryptionNonce must be ${AptosEncryptedConstants.decryptionNonceLength} bytes.',
      );
    }
  }

  factory AptosDecryptedPlaintext.generate(
    AptosTransactionExecutable executable,
  ) {
    return AptosDecryptedPlaintext(
      executable: executable,
      decryptionNonce: QuickCrypto.generateRandom(
        length: AptosEncryptedConstants.decryptionNonceLength,
      ),
    );
  }

  factory AptosDecryptedPlaintext.fromStruct(Map<String, dynamic> json) {
    return AptosDecryptedPlaintext(
      executable: AptosTransactionExecutable.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('executable'),
      ),
      decryptionNonce: json.valueAsBytes('decryptionNonce'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      AptosTransactionExecutable.layout(property: 'executable'),
      LayoutConst.fixedBlobN(
        AptosEncryptedConstants.decryptionNonceLength,
        property: 'decryptionNonce',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'executable': executable.toVariantLayoutStruct(),
      'decryptionNonce': decryptionNonce,
    };
  }

  /// `SHA3-256(salt || BCS(self))`, `salt = SHA3-256("APTOS::DecryptedPlaintext")`.
  List<int> hash() {
    final h = QuickCrypto.sha3256Hash([
      ...AptosEncryptedConstants.decryptedPlaintextSalt,
      ...toBcs(),
    ]);
    return h;
  }
}

class AptosSignerAuthKeyPair {
  final AptosAddress address;
  final List<int> authenticationKey;
  const AptosSignerAuthKeyPair({
    required this.address,
    required this.authenticationKey,
  });
}

/// `PayloadAssociatedData::V1 { sender, Vec<(address, authKey)> }`.
/// BCS: `variant(0) | sender | Vec<(address, authKey)>`, authKey as
/// length-prefixed bytes (`serde_bytes`), matching TS `serializeBytes`.
class AptosPayloadAssociatedData extends BcsSerialization {
  final AptosAddress sender;
  final List<AptosSignerAuthKeyPair> signerAuthKeys;
  AptosPayloadAssociatedData({
    required this.sender,
    required List<AptosSignerAuthKeyPair> signerAuthKeys,
  }) : signerAuthKeys = signerAuthKeys.immutable {
    if (signerAuthKeys.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'PayloadAssociatedData requires at least one signer auth key pair.',
      );
    }
    for (final e in signerAuthKeys) {
      if (e.authenticationKey.length != 32) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'authenticationKey must be 32 bytes.',
        );
      }
    }
  }

  factory AptosPayloadAssociatedData.fromStruct(Map<String, dynamic> json) {
    final keys =
        json
            .valueEnsureAsList<Map<String, dynamic>>('signerAuthKeys')
            .map(
              (e) => AptosSignerAuthKeyPair(
                address: AptosAddress.fromStruct(
                  e.valueEnsureAsMap<String, dynamic>('address'),
                ),
                authenticationKey: e.valueAsBytes<List<int>>(
                  'authenticationKey',
                ),
              ),
            )
            .toList();
    return AptosPayloadAssociatedData(
      sender: AptosAddress.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('sender'),
      ),
      signerAuthKeys: keys,
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: 'variant'),
      AptosAddress.layout(property: 'sender'),
      LayoutConst.bcsVector(
        LayoutConst.struct([
          AptosAddress.layout(property: 'address'),
          LayoutConst.bcsBytes(property: 'authenticationKey'),
        ]),
        property: 'signerAuthKeys',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'variant': 0,
      'sender': sender.toLayoutStruct(),
      'signerAuthKeys':
          signerAuthKeys
              .map(
                (e) => {
                  'address': e.address.toLayoutStruct(),
                  'authenticationKey': e.authenticationKey,
                },
              )
              .toList(),
    };
  }
}

// ---------------------------------------------------------------------------
// Batch encryption primitives (encrypt-only).
// ---------------------------------------------------------------------------

class AptosBatchSymmetricKey extends BcsSerialization {
  final List<int> key;
  AptosBatchSymmetricKey({List<int>? key})
    : key =
          (key ??
                  QuickCrypto.generateRandom(
                    length: AptosEncryptedConstants.symmetricKeyLength,
                  ))
              .asImmutableBytes {
    if (this.key.length != AptosEncryptedConstants.symmetricKeyLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid symmetric key length. Must provide a key of size 16.',
      );
    }
  }
  factory AptosBatchSymmetricKey.fromStruct(Map<String, dynamic> json) {
    return AptosBatchSymmetricKey(key: json.valueAsBytes('key'));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        AptosEncryptedConstants.symmetricKeyLength,
        property: 'key',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {'key': key};
  }

  AptosBatchSymmetricCiphertext encrypt(BcsSerialization msg) {
    final nonce = QuickCrypto.generateRandom(
      length: AptosEncryptedConstants.gcmNonceLength,
    );
    final plaintext = msg.toBcs();
    final aead = blockchainUtils.api.aed.aesGCM(key);
    final ct = aead.encrypt(nonce, plaintext).toList();
    return AptosBatchSymmetricCiphertext(nonce: nonce, ctBody: ct);
  }
}

class AptosBatchOneTimePad extends BcsSerialization {
  final List<int> otp;
  AptosBatchOneTimePad(List<int> otp) : otp = otp.asImmutableBytes {
    if (otp.length != AptosEncryptedConstants.symmetricKeyLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'One-time-pad length must be 16 bytes.',
      );
    }
  }
  factory AptosBatchOneTimePad.fromSourceBytes(List<int> otpSource) {
    final derived = AptosBatchEncryptionCrypto.hmacKdf(otpSource);
    return AptosBatchOneTimePad(derived.sublist(0, 16));
  }
  factory AptosBatchOneTimePad.fromStruct(Map<String, dynamic> json) {
    return AptosBatchOneTimePad(json.valueAsBytes('otp'));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        AptosEncryptedConstants.symmetricKeyLength,
        property: 'otp',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {'otp': otp};
  }

  AptosBatchSymmetricKey padKey(AptosBatchSymmetricKey value) {
    final out = List<int>.generate(16, (i) => value.key[i] ^ otp[i]);
    return AptosBatchSymmetricKey(key: out);
  }
}

class AptosBatchSymmetricCiphertext extends BcsSerialization {
  final List<int> nonce;
  final List<int> ctBody;
  AptosBatchSymmetricCiphertext({
    required List<int> nonce,
    required List<int> ctBody,
  }) : nonce = nonce.asImmutableBytes,
       ctBody = ctBody.asImmutableBytes {
    if (nonce.length != AptosEncryptedConstants.gcmNonceLength) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid GCM nonce length. Nonce must be 12 bytes.',
      );
    }
  }
  factory AptosBatchSymmetricCiphertext.fromStruct(Map<String, dynamic> json) {
    return AptosBatchSymmetricCiphertext(
      nonce: json.valueAsBytes('nonce'),
      ctBody: json.valueAsBytes('ctBody'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        AptosEncryptedConstants.gcmNonceLength,
        property: 'nonce',
      ),
      LayoutConst.bcsBytes(property: 'ctBody'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {'nonce': nonce, 'ctBody': ctBody};
  }
}

/// `BIBECiphertext { id: Fr scalar (32 LE bytes on the wire),
/// ctG2: 3xG2 (288 bytes, one prefix), paddedKey[16], symmetricCiphertext }`.
class AptosBatchBIBECiphertext extends BcsSerialization {
  final JubJubFq id;
  final List<G2Projective> ctG2;
  final AptosBatchSymmetricKey paddedKey;
  final AptosBatchSymmetricCiphertext symmetricCiphertext;
  AptosBatchBIBECiphertext({
    required this.id,
    required List<G2Projective> ctG2,
    required this.paddedKey,
    required this.symmetricCiphertext,
  }) : ctG2 = ctG2.immutable {
    if (ctG2.length != 3) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid BIBE ciphertext. Expected 3 G2 points.',
      );
    }
  }

  factory AptosBatchBIBECiphertext.fromStruct(Map<String, dynamic> json) {
    final id = JubJubFq.fromBytes(json.valueAsBytes<List<int>>('id'));
    final List<int> ctG2Bytes = json.valueAsBytes<List<int>>('ctG2');
    if (ctG2Bytes.length != AptosEncryptedConstants.g2Size * 3) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid BIBE ctG2 length.',
        details: {'length': '${ctG2Bytes.length}'},
      );
    }
    return AptosBatchBIBECiphertext(
      id: id,
      ctG2: [
        G2Projective.fromBytes(
          ctG2Bytes.sublist(0, AptosEncryptedConstants.g2Size),
        ),
        G2Projective.fromBytes(
          ctG2Bytes.sublist(
            AptosEncryptedConstants.g2Size,
            AptosEncryptedConstants.g2Size * 2,
          ),
        ),
        G2Projective.fromBytes(
          ctG2Bytes.sublist(AptosEncryptedConstants.g2Size * 2),
        ),
      ],
      paddedKey: AptosBatchSymmetricKey.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('paddedKey'),
      ),
      symmetricCiphertext: AptosBatchSymmetricCiphertext.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('symmetricCiphertext'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: 'id'),
      LayoutConst.bcsBytes(property: 'ctG2'),
      AptosBatchSymmetricKey.layout(property: 'paddedKey'),
      AptosBatchSymmetricCiphertext.layout(property: 'symmetricCiphertext'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    final ctG2Bytes = <int>[
      ...ctG2[0].toBytes(mode: CryptoKeyEncoding.base),
      ...ctG2[1].toBytes(mode: CryptoKeyEncoding.base),
      ...ctG2[2].toBytes(mode: CryptoKeyEncoding.base),
    ];
    return {
      'id': id.toBytes().toList(),
      'ctG2': ctG2Bytes,
      'paddedKey': paddedKey.toLayoutStruct(),
      'symmetricCiphertext': symmetricCiphertext.toLayoutStruct(),
    };
  }
}

/// `Ciphertext { vk(bytes), bibeCt, associatedDataBytes(bytes), signature[64] }`.
class AptosBatchCiphertext extends BcsSerialization {
  final List<int> vk;
  final AptosBatchBIBECiphertext bibeCt;
  final List<int> associatedDataBytes;
  final List<int> signature;
  AptosBatchCiphertext({
    required List<int> vk,
    required this.bibeCt,
    required List<int> associatedDataBytes,
    required List<int> signature,
  }) : vk = vk.asImmutableBytes,
       associatedDataBytes = associatedDataBytes.asImmutableBytes,
       signature = signature.asImmutableBytes {
    if (vk.length != 32) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'ed25519 public key must be 32 bytes.',
      );
    }
    if (signature.length != 64) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'ed25519 signature must be 64 bytes.',
      );
    }
  }

  factory AptosBatchCiphertext.fromStruct(Map<String, dynamic> json) {
    return AptosBatchCiphertext(
      vk: json.valueAsBytes('vk'),
      bibeCt: AptosBatchBIBECiphertext.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('bibeCt'),
      ),
      associatedDataBytes: json.valueAsBytes('associatedDataBytes'),
      signature: json.valueAsBytes('signature'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: 'vk'),
      AptosBatchBIBECiphertext.layout(property: 'bibeCt'),
      LayoutConst.bcsBytes(property: 'associatedDataBytes'),
      LayoutConst.fixedBlobN(64, property: 'signature'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'vk': vk,
      'bibeCt': bibeCt.toLayoutStruct(),
      'associatedDataBytes': associatedDataBytes,
      'signature': signature,
    };
  }
}

/// Per-epoch batch encryption key: two compressed G2 points.
class AptosBatchEncryptionKey extends BcsSerialization {
  final G2Projective sigMpkG2;
  final G2Projective tauG2;
  AptosBatchEncryptionKey({required this.sigMpkG2, required this.tauG2});

  factory AptosBatchEncryptionKey.fromStruct(Map<String, dynamic> json) {
    return AptosBatchEncryptionKey(
      sigMpkG2: G2Projective.fromBytes(json.valueAsBytes('sigMpkG2')),
      tauG2: G2Projective.fromBytes(json.valueAsBytes('tauG2')),
    );
  }
  factory AptosBatchEncryptionKey.fromHex(String hex) {
    final bytes = BytesUtils.fromHexString(hex);
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosBatchEncryptionKey.fromStruct(decode);
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: 'sigMpkG2'),
      LayoutConst.bcsBytes(property: 'tauG2'),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'sigMpkG2': sigMpkG2.toBytes(mode: CryptoKeyEncoding.base).toList(),
      'tauG2': tauG2.toBytes(mode: CryptoKeyEncoding.base).toList(),
    };
  }

  AptosBatchBIBECiphertext _bibeEncrypt(
    BcsSerialization plaintext,
    JubJubFq id,
  ) {
    final r0 = AptosBatchEncryptionCrypto.getRandomFr();
    final r1 = AptosBatchEncryptionCrypto.getRandomFr();
    final g2Gen = G2Projective.generator;
    final hashedKey = AptosBatchEncryptionCrypto.hashG2Element(sigMpkG2);

    // All scalar-muls go through the point types (`point * JubJubFq`).
    // ctG2[0] = G2*r0 + sigMpk*r1
    // ctG2[1] = (G2*id - tau)*r0
    // ctG2[2] = -G2*r1
    final ct0 = g2Gen * r0 + sigMpkG2 * r1;
    final idPoint = g2Gen * id;
    final ct1 = (idPoint - tauG2) * r0;
    final ct2 = -(g2Gen * r1);

    // otpSourceGt = e(hashedKey*r1, sigMpk)^-1 (conjugate == inverse).
    final g1Point = hashedKey * r1;
    final pairing = Bls12PairingUtils.pairing(
      g1Point.toAffine(),
      sigMpkG2.toAffine(),
    );
    final otpSourceGt = -pairing;
    final otpSourceBytes = AptosBatchEncryptionCrypto.fp12ToLE(
      otpSourceGt.inner,
    );
    final otp = AptosBatchOneTimePad.fromSourceBytes(otpSourceBytes);
    final symmetricKey = AptosBatchSymmetricKey();
    final paddedKey = otp.padKey(symmetricKey);
    final symmetricCiphertext = symmetricKey.encrypt(plaintext);
    return AptosBatchBIBECiphertext(
      id: id,
      ctG2: [ct0, ct1, ct2],
      paddedKey: paddedKey,
      symmetricCiphertext: symmetricCiphertext,
    );
  }

  /// `encrypt(plaintext, associatedData)` matching Rust `CTEncrypt` +
  /// `Id::from_verifying_key_and_ad`.
  AptosBatchCiphertext encrypt(
    BcsSerialization plaintext,
    AptosPayloadAssociatedData associatedData,
  ) {
    final secret = QuickCrypto.generateRandom(length: 32);
    final priv = ED25519PrivateKey.fromBytes(secret);
    final pub = priv.publicKey.toBytes().toList();
    final adBcs = associatedData.toBcs();
    final hashPreimage = <int>[...pub, ...adBcs];
    final id = AptosBatchEncryptionCrypto.hashToFr(
      hashPreimage,
      dst: AptosEncryptedConstants.idHashDst,
    );
    final bibeCt = _bibeEncrypt(plaintext, id);
    // to_sign = BCS(BIBECiphertext) || BCS(bytes(associatedData)).
    final toSign = <int>[
      ...bibeCt.toBcs(),
      ...AptosBatchEncryptionCrypto.encodeBcsBytes(adBcs),
    ];
    // ed25519 sign (raw, same as TS noble ed25519.sign)
    final signer = ED25519Signer(priv);
    final sig = signer.sign(toSign).encoded;
    return AptosBatchCiphertext(
      vk: pub,
      bibeCt: bibeCt,
      associatedDataBytes: adBcs,
      signature: sig,
    );
  }
}

class AptosBatchEncryptionCrypto {
  AptosBatchEncryptionCrypto._();

  /// BCS `bytes`: ULEB128(len) || raw.
  static List<int> encodeBcsBytes(List<int> b) {
    var len = b.length;
    final out = <int>[];
    while (len >= 0x80) {
      out.add((len & 0x7f) | 0x80);
      len >>= 7;
    }
    out.add(len);
    out.addAll(b);
    return out;
  }

  /// Uniform 512-bit value reduced mod r (same semantics as noble's
  /// `Fr.create(randomBigint)` used by the TS port).
  static JubJubFq getRandomFr() {
    final rand = QuickCrypto.generateRandom(length: 64);
    return JubJubFq.fromBytes64(rand);
  }

  /// RFC 9380 `hash_to_field(msg, 1, {p: Fr, m: 1, k: 128, xmd/sha256})`
  /// as a `JubJubFq` scalar. Noble reduces `os2ip` (big-endian) mod r;
  /// the same integer is fed here as zero-padded LE into the 512-bit
  /// reducer (`JubJubFq.fromBytes64` takes little-endian).
  /// `log2(r) = 255`, so `L = ceil((255 + 128) / 8) = 48`.
  static JubJubFq hashToFr(List<int> input, {List<int>? dst}) {
    final d = dst ?? <int>[];
    const l = 48;
    final uniform = BlsHashToG2.expandMessageXmd(input, d, l);
    final le64 = List<int>.filled(64, 0);
    for (var i = 0; i < uniform.length; i++) {
      le64[i] = uniform[uniform.length - 1 - i];
    }
    return JubJubFq.fromBytes64(le64);
  }

  /// `hash_g2_element`: compressed G2 bytes -> G1 via XMD:SHA-256_SSWU_RO_.
  static G1Projective hashG2Element(G2Projective g2) {
    final bytes = g2.toBytes(mode: CryptoKeyEncoding.base).toList();
    return BlsHashToG1.hashToG1(
      bytes,
      dst: AptosEncryptedConstants.hashG2ElementDst,
    );
  }

  /// HKDF-SHA256(salt, ikm, info='', L=32), first 32 bytes.
  static List<int> hmacKdf(List<int> otpSource) {
    return QuickCrypto.hkdfDeriveSha256(
      ikm: otpSource,
      length: 32,
      salt: AptosEncryptedConstants.hkdfSalt,
      info: const [],
    );
  }

  static List<int> _fpToLE(Bls12Fp fp) {
    return fp.toBytes().reversed.toList();
  }

  static List<int> _fp2ToLE(Bls12Fp2 v) {
    return [..._fpToLE(v.c0), ..._fpToLE(v.c1)];
  }

  static List<int> _fp6ToLE(Bls12Fp6 v) {
    return [..._fp2ToLE(v.c0), ..._fp2ToLE(v.c1), ..._fp2ToLE(v.c2)];
  }

  /// `fp12ToLEBytes` matching TS: c0{c0{c0,c1},c1{...},c2{...}}, c1{...}.
  static List<int> fp12ToLE(Bls12Fp12 v) {
    return [..._fp6ToLE(v.c0), ..._fp6ToLE(v.c1)];
  }
}

/// `TransactionPayload::EncryptedPayload(5) :: Encrypted(0)`.
class AptosTransactionPayloadEncrypted extends AptosTransactionPayload {
  final AptosBatchCiphertext ciphertext;
  final AptosTransactionExtraConfig extraConfig;
  final List<int> payloadHash;
  final BigInt encryptionEpoch;
  final AptosClaimedEntryFunction? claimedEntryFunction;

  AptosTransactionPayloadEncrypted({
    required this.ciphertext,
    required this.extraConfig,
    required List<int> payloadHash,
    required BigInt encryptionEpoch,
    this.claimedEntryFunction,
  }) : payloadHash = payloadHash.asImmutableBytes,
       encryptionEpoch = encryptionEpoch.asU64,
       super(type: AptosTransactionPayloads.encryptedPayload) {
    if (payloadHash.length != 32) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'payloadHash must be 32 bytes.',
      );
    }
  }

  factory AptosTransactionPayloadEncrypted.fromStruct(
    Map<String, dynamic> json,
  ) {
    // Layout is {innerVariant(0), ciphertext, extraConfig, payloadHash,
    // encryptionEpoch, claimedEntryFunction}.
    return AptosTransactionPayloadEncrypted(
      ciphertext: AptosBatchCiphertext.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('ciphertext'),
      ),
      extraConfig: AptosTransactionExtraConfig.fromStruct(
        json.valueEnsureAsMap<String, dynamic>('extraConfig'),
      ),
      payloadHash: json.valueAsBytes('payloadHash'),
      encryptionEpoch: json.valueAs('encryptionEpoch'),
      claimedEntryFunction: json
          .valueTo<AptosClaimedEntryFunction?, Map<String, dynamic>>(
            key: 'claimedEntryFunction',
            parse: (e) => AptosClaimedEntryFunction.fromStruct(e),
          ),
    );
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u8(property: 'innerVariant'),
      AptosBatchCiphertext.layout(property: 'ciphertext'),
      AptosTransactionExtraConfig.layout(property: 'extraConfig'),
      LayoutConst.fixedBlobN(32, property: 'payloadHash'),
      LayoutConst.u64(property: 'encryptionEpoch'),
      LayoutConst.optional(
        AptosClaimedEntryFunction.layout(),
        property: 'claimedEntryFunction',
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      'innerVariant': 0,
      'ciphertext': ciphertext.toLayoutStruct(),
      'extraConfig': extraConfig.toVariantLayoutStruct(),
      'payloadHash': payloadHash,
      'encryptionEpoch': encryptionEpoch,
      'claimedEntryFunction': claimedEntryFunction?.toLayoutStruct(),
    };
  }

  /// JSON body for REST `encrypted_transaction_payload` submission.
  Map<String, dynamic> toSubmitJson() {
    return {
      'type': 'encrypted_transaction_payload',
      'payload': {
        'type': 'encrypted_payload',
        'payload_hash': BytesUtils.toHexString(payloadHash, prefix: '0x'),
        'ciphertext': BytesUtils.toHexString(ciphertext.toBcs(), prefix: '0x'),
        'encryption_epoch': encryptionEpoch.toString(),
        if (claimedEntryFunction != null)
          'claimed_entry_fun': {
            'module': claimedEntryFunction!.moduleId.toString(),
            if (claimedEntryFunction!.functionName != null)
              'name': claimedEntryFunction!.functionName,
          },
      },
    };
  }
}

/// High-level builder matching TS `buildEncryptedPayload`.
class AptosEncryptedPayloadHelper {
  const AptosEncryptedPayloadHelper._();

  /// Enforces encrypted gas rules: floor 200 Octas + 375 decryption units.
  static ({BigInt gasUnitPrice, BigInt maxGasAmount}) resolveGas({
    required BigInt gasUnitPrice,
    required BigInt maxGasAmount,
  }) {
    final price =
        gasUnitPrice < AptosEncryptedConstants.minGasUnitPrice
            ? AptosEncryptedConstants.minGasUnitPrice
            : gasUnitPrice;
    return (
      gasUnitPrice: price,
      maxGasAmount: maxGasAmount + AptosEncryptedConstants.decryptionGasUnits,
    );
  }

  /// Builds an encrypted payload from an executable + signer auth keys.
  ///
  /// [signerAuthKeys] must be in `all_signer_auth_keys` order:
  /// sender first, then secondaries, then fee payer last.
  /// [encryptionKey]/[encryptionEpoch] come from ledger `encryption_key`.
  static AptosTransactionPayloadEncrypted build({
    required AptosTransactionExecutable executable,
    required AptosTransactionExtraConfig extraConfig,
    required AptosAddress sender,
    required List<AptosSignerAuthKeyPair> signerAuthKeys,
    required AptosBatchEncryptionKey encryptionKey,
    required BigInt encryptionEpoch,
    AptosClaimedEntryFunction? claimedEntryFunction,
  }) {
    if (signerAuthKeys.isEmpty) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'signerAuthKeys must not be empty.',
      );
    }
    if (signerAuthKeys.first.address != sender) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'First signerAuthKey must be the sender.',
      );
    }
    final plaintext = AptosDecryptedPlaintext.generate(executable);
    final associatedData = AptosPayloadAssociatedData(
      sender: sender,
      signerAuthKeys: signerAuthKeys,
    );
    final ciphertext = encryptionKey.encrypt(plaintext, associatedData);
    return AptosTransactionPayloadEncrypted(
      ciphertext: ciphertext,
      extraConfig: extraConfig,
      payloadHash: plaintext.hash(),
      encryptionEpoch: encryptionEpoch,
      claimedEntryFunction: claimedEntryFunction,
    );
  }

  /// Convenience for a plain entry function (e.g. `0x1::aptos_account::transfer`).
  /// No contract changes needed: validators decrypt then execute as normal.
  static AptosTransactionPayloadEncrypted buildEntryFunction({
    required AptosTransactionEntryFunction entryFunction,
    required AptosAddress sender,
    required List<AptosSignerAuthKeyPair> signerAuthKeys,
    required AptosBatchEncryptionKey encryptionKey,
    required BigInt encryptionEpoch,
    AptosAddress? multisigAddress,
    BigInt? replayProtectionNonce,
    AptosClaimedEntryFunction? claimedEntryFunction,
  }) {
    return build(
      executable: AptosTransactionExecutableEntryFunction(
        entryFunction: entryFunction,
      ),
      extraConfig: AptosTransactionExtraConfigV1(
        multisigAddress: multisigAddress,
        replayProtectionNonce: replayProtectionNonce,
      ),
      sender: sender,
      signerAuthKeys: signerAuthKeys,
      encryptionKey: encryptionKey,
      encryptionEpoch: encryptionEpoch,
      claimedEntryFunction: claimedEntryFunction,
    );
  }

  /// Auto-derives `claimed_entry_fun` for sponsored/multisig flows.
  /// Returns null for plain sender-only transactions.
  static AptosClaimedEntryFunction? resolveClaimedEntryFunction({
    required AptosTransactionExecutable executable,
    required bool hasFeePayer,
    required bool hasMultisig,
    AptosClaimedEntryFunction? override,
  }) {
    if (!hasFeePayer && !hasMultisig) return null;
    if (override != null) return override;
    if (executable is AptosTransactionExecutableEntryFunction) {
      return AptosClaimedEntryFunction.fromEntryFunction(
        executable.entryFunction,
      );
    }
    return null;
  }
}
