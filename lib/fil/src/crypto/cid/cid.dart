import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

class Multicodec {
  static const int identity = 0x00;
  static const int sha1 = 0x11;
  static const int sha2_256 = 0x12;
  static const int sha2_512 = 0x13;
  static const int sha3_224 = 0x17;
  static const int sha3_256 = 0x16;
  static const int sha3_384 = 0x15;
  static const int sha3_512 = 0x14;
  static const int keccak_256 = 0x1b;
  static const int blake2b_256 = 0xb220;
  static const int blake2b_512 = 0xb240;
  static const int blake2s_128 = 0xb250;
  static const int blake2s_256 = 0xb260;
  static const int blake3 = 0x1e;
  static const int dblSha2_256 = 0x56;

  static const int raw = 0x55;
  static const int dagPb = 0x70;
  static const int dagCbor = 0x71;
  static const int dagJson = 0x0129;
  static const int libp2pKey = 0x72;

  static const Map<int, String> names = {
    identity: 'identity',
    sha1: 'sha1',
    sha2_256: 'sha2-256',
    sha2_512: 'sha2-512',
    sha3_224: 'sha3-224',
    sha3_256: 'sha3-256',
    sha3_384: 'sha3-384',
    sha3_512: 'sha3-512',
    keccak_256: 'keccak-256',
    blake2b_256: 'blake2b-256',
    blake2b_512: 'blake2b-512',
    blake2s_128: 'blake2s-128',
    blake2s_256: 'blake2s-256',
    blake3: 'blake3',
    dblSha2_256: 'dbl-sha2-256',
    raw: 'raw',
    dagPb: 'dag-pb',
    dagCbor: 'dag-cbor',
    dagJson: 'dag-json',
    libp2pKey: 'libp2p-key',
  };

  static String name(BigInt code) =>
      names[code.tryAsSafeInt] ?? code.toHexaDecimal;
}

// =============================================================================
// Multihash
// =============================================================================

class Multihash with Equality {
  final BigInt code;
  final BuBytes digest;

  Multihash._(BigInt code, List<int> digest)
    : digest = digest.asImmutableBytes,
      code = code.asPositive;
  factory Multihash.from(List<int> digest, BigInt code) {
    if (code.isNegative) {
      throw OnChainErrors.filPlugin(
        'Multihash.from',
        reason: 'Invalid multihash code.',
        details: {'code': '$code'},
      );
    }
    final name = Multicodec.name(code);
    switch (code.tryAsSafeInt) {
      case Multicodec.sha2_256:
      case Multicodec.blake2b_256:
      case Multicodec.keccak_256:
        if (digest.length != QuickCrypto.sha256DigestSize) {
          throw OnChainErrors.filPlugin(
            'Multihash.from',
            reason: '$name digest must be 32 bytes, got ${digest.length}.',
          );
        }
        break;
      case Multicodec.sha2_512:
      case Multicodec.blake2b_512:
        if (digest.length != QuickCrypto.sha512DigestLength) {
          throw OnChainErrors.filPlugin(
            'Multihash.from',
            reason: '$name digest must be 64 bytes, got ${digest.length}.',
          );
        }
        break;
    }
    return Multihash._(code, digest);
  }

  factory Multihash.blake2b256(List<int> digest) {
    if (digest.length != QuickCrypto.blake2b256DigestSize) {
      throw OnChainErrors.filPlugin(
        'Multihash.blake2b256',
        reason: 'Invalid digest bytes length.',
        details: {
          'expected': '${QuickCrypto.blake2b256DigestSize}',
          'actual': '${digest.length}',
        },
      );
    }
    return Multihash._(BigInt.from(Multicodec.blake2b_256), digest);
  }

  factory Multihash.sha2256(List<int> digest) {
    if (digest.length != QuickCrypto.sha256DigestSize) {
      throw OnChainErrors.filPlugin(
        'Multihash.sha2256',
        reason: 'Invalid digest bytes length.',
        details: {
          'expected': '${QuickCrypto.sha256DigestSize}',
          'actual': '${digest.length}',
        },
      );
    }
    return Multihash._(BigInt.from(Multicodec.sha2_256), digest);
  }

  factory Multihash.identity(List<int> data) {
    return Multihash._(BigInt.from(Multicodec.identity), data);
  }

  int get length => digest.length;
  String get name => Multicodec.name(code);

  List<int> toBytes() {
    return [
      ...LayoutConst.lebU64().serialize(code),
      ...LayoutConst.lebU32().serialize(digest.length),
      ...digest,
    ];
  }

  factory Multihash.fromBytes(List<int> bytes, [int offset = 0]) {
    final (hash, _) = read(bytes, offset);
    return hash;
  }

  static (Multihash, int) read(List<int> bytes, [int offset = 0]) {
    final cDecode = LayoutConst.lebU64().deserialize(bytes, offset: offset);
    offset += cDecode.consumed;
    final dLen = LayoutConst.lebU32().deserialize(bytes, offset: offset);
    offset += dLen.consumed;
    if (offset + dLen.value > bytes.length) {
      throw OnChainErrors.filPlugin(
        'Multihash.read',
        reason: 'Multihash digest truncated.',
        details: {
          'offset': '$offset',
          'expected': '${dLen.value}',
          'available': '${bytes.length - offset}',
        },
      );
    }
    final digest = bytes.sublist(offset, offset + dLen.value);
    offset += dLen.value;
    final mh = Multihash.from(digest, cDecode.value);
    return (mh, offset);
  }

  @override
  String toString() =>
      'Multihash($name, len=$length, digest=${BytesUtils.toHexString(digest)})';

  @override
  List<Object?> get variables => [code, digest];
}

enum CidVersion { v0, v1 }

class Cid with Equality {
  final String cid;
  const Cid(this.cid);
  factory Cid.fromJson(dynamic json) {
    String? cid;

    if (json is String) {
      cid = json;
    } else if (json is Map) {
      final v = json['/'] ?? json['cid'];
      if (v is String) {
        cid = v;
      }
    }
    if (cid != null) return Cid(cid);
    throw OnChainErrors.filPlugin(
      'Cid.fromJson',
      reason: 'Failed to parse Cid.',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'/': cid};

  CidBuilder builder() => CidBuilder.parse(cid);

  @override
  String toString() => cid;

  @override
  List<dynamic> get variables => [cid];
}

class CidBuilder with Equality {
  final CidVersion version;
  final BigInt codec;
  final Multihash multihash;
  final String value;

  CidBuilder._({
    required this.version,
    required this.codec,
    required this.multihash,
    required this.value,
  });

  factory CidBuilder.parse(String s) {
    if (s.startsWith('Qm') && s.length >= 46) {
      return CidBuilder._fromV0String(s);
    }
    if (s.startsWith('b')) {
      return CidBuilder._fromV1String(s);
    }
    throw OnChainErrors.filPlugin(
      'CidBuilder.parse',
      reason: 'Unsupported CID string.',
      details: {'input': s},
    );
  }

  factory CidBuilder.fromJson(dynamic json) {
    if (json is String) return CidBuilder.parse(json);
    if (json is Map) {
      final v = json['/'] ?? json['cid'];
      if (v != null) return CidBuilder.parse(JsonParser.valueAsString(v));
    }

    throw OnChainErrors.filPlugin(
      'CidBuilder.fromJson',
      reason: 'Failed to parse CidBuilder.',
    );
  }

  factory CidBuilder.v1({required BigInt codec, required Multihash multihash}) {
    final binary = _v1Binary(codec, multihash);
    final str = 'b${Base32Encoder.encodeNoPaddingBytes(binary)}'.toLowerCase();
    return CidBuilder._(
      version: CidVersion.v1,
      codec: codec,
      multihash: multihash,
      value: str,
    );
  }

  factory CidBuilder.filecoinDagCbor(List<int> cborBytes) {
    final digest = QuickCrypto.blake2b256Hash(cborBytes);
    return CidBuilder.v1(
      codec: BigInt.from(Multicodec.dagCbor),
      multihash: Multihash.blake2b256(digest),
    );
  }

  factory CidBuilder.v0(List<int> sha256Digest) {
    if (sha256Digest.length != QuickCrypto.sha256DigestSize) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.v0',
        reason: 'CIDv0 requires 32-byte sha2-256 digest.',
      );
    }
    final mh = Multihash.sha2256(sha256Digest);
    final binary = mh.toBytes();
    final str = Base58Encoder.encode(binary);
    if (!str.startsWith('Qm')) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.v0',
        reason: 'Invalid CIDv0 encoding.',
      );
    }
    return CidBuilder._(
      version: CidVersion.v0,
      codec: BigInt.from(Multicodec.dagPb),
      multihash: mh,
      value: str,
    );
  }

  factory CidBuilder._fromV0String(String s) {
    late final List<int> binary;
    try {
      binary = Base58Decoder.decode(s);
    } catch (_) {
      throw OnChainErrors.filPlugin(
        'CidBuilder._fromV0String',
        reason: 'Invalid CIDv0 base58 string.',
      );
    }
    final mh = Multihash.fromBytes(binary);
    if (mh.code.tryAsSafeInt != Multicodec.sha2_256 ||
        mh.digest.length != QuickCrypto.sha256DigestSize) {
      throw OnChainErrors.filPlugin(
        'CidBuilder._fromV0String',
        reason:
            'CIDv0 must be sha2-256 / ${QuickCrypto.sha256DigestSize} bytes.',
      );
    }
    return CidBuilder._(
      version: CidVersion.v0,
      codec: BigInt.from(Multicodec.dagPb),
      multihash: mh,
      value: s,
    );
  }

  factory CidBuilder._fromV1String(String s) {
    if (!s.startsWith('b')) {
      throw OnChainErrors.filPlugin(
        'CidBuilder._fromV1String',
        reason: 'Only base32 CIDv1 (b...) supported.',
      );
    }
    late final List<int> binary;
    try {
      binary = Base32Decoder.decode(
        s.substring(1),
        Base32Alphabet.cidBase32Alphabet,
      );
    } catch (_) {
      throw OnChainErrors.filPlugin(
        'CidBuilder._fromV1String',
        reason: 'Invalid CIDv1 base32 string.',
      );
    }
    return CidBuilder.fromBinary(binary, human: s.toLowerCase());
  }

  factory CidBuilder.fromBinary(List<int> binary, {String? human}) {
    if (binary.isEmpty) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromBinary',
        reason: 'Empty CID binary.',
      );
    }

    // CIDv0 heuristic: multihash sha2-256 with 32-byte digest (34 bytes total)
    if (binary[0] == Multicodec.sha2_256 && binary.length == 34) {
      final mh = Multihash.fromBytes(binary);
      if (mh.code.tryAsSafeInt == Multicodec.sha2_256 &&
          mh.digest.length == QuickCrypto.sha256DigestSize) {
        final str = human ?? Base58Encoder.encode(binary);
        return CidBuilder._(
          version: CidVersion.v0,
          codec: BigInt.from(Multicodec.dagPb),
          multihash: mh,
          value: str,
        );
      }
    }

    var offset = 0;
    final dVersion = LayoutConst.lebU64().deserialize(binary, offset: offset);
    offset += dVersion.consumed;
    if (dVersion.value != BigInt.one) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromBinary',
        reason: 'Unsupported CID version: ${dVersion.value}.',
      );
    }
    final dCode = LayoutConst.lebU64().deserialize(binary, offset: offset);
    offset += dCode.consumed;
    final (mh, end) = Multihash.read(binary, offset);
    if (end != binary.length) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromBinary',
        reason: 'Trailing bytes in CID binary.',
      );
    }
    final str =
        human ?? 'b${Base32Encoder.encodeNoPaddingBytes(binary)}'.toLowerCase();
    return CidBuilder._(
      version: CidVersion.v1,
      codec: dCode.value,
      multihash: mh,
      value: str,
    );
  }

  static List<int> _v1Binary(BigInt codec, Multihash mh) {
    final encoder = LayoutConst.lebU64();
    return [
      ...encoder.serialize(BigInt.one),
      ...encoder.serialize(codec),
      ...mh.toBytes(),
    ];
  }

  List<int> toBinary() {
    if (version == CidVersion.v0) {
      return multihash.toBytes();
    }
    return _v1Binary(codec, multihash);
  }

  CborObject toCbor() {
    final payload = [0x00, ...toBinary()];
    return CborTagValue(CborBytesValue(payload), [42]);
  }

  factory CidBuilder.fromCbor(CborObject obj) {
    if (obj is! CborTagValue) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromCbor',
        reason: 'Expected CBOR tag 42 for CID.',
      );
    }

    if (!BytesUtils.bytesEqual([42], obj.tags)) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromCbor',
        reason: 'CID CBOR must use tag 42.',
      );
    }

    final inner = obj.value;
    if (inner is! CborBytesValue) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromCbor',
        reason: 'CID tag 42 payload must be bytes.',
      );
    }

    final bytes = inner.value;
    if (bytes.isEmpty || bytes[0] != 0x00) {
      throw OnChainErrors.filPlugin(
        'CidBuilder.fromCbor',
        reason: 'CID link missing identity multibase 0x00.',
      );
    }
    return CidBuilder.fromBinary(bytes.sublist(1));
  }

  void validate() {
    if (version == CidVersion.v0) {
      if (codec.tryAsSafeInt != Multicodec.dagPb) {
        throw OnChainErrors.filPlugin(
          'CidBuilder.validate',
          reason: 'CIDv0 codec must be dag-pb.',
        );
      }
      if (multihash.code.tryAsSafeInt != Multicodec.sha2_256 ||
          multihash.length != QuickCrypto.sha256DigestSize) {
        throw OnChainErrors.filPlugin(
          'CidBuilder.validate',
          reason: 'CIDv0 must be sha2-256/32.',
        );
      }
      if (!value.startsWith('Qm')) {
        throw OnChainErrors.filPlugin(
          'CidBuilder.validate',
          reason: 'CIDv0 string must start with Qm.',
        );
      }
    } else {
      if (!value.startsWith('b')) {
        throw OnChainErrors.filPlugin(
          'CidBuilder.validate',
          reason: 'CIDv1 string must start with b (base32).',
        );
      }
      final bin = toBinary();
      if (bin.isEmpty || bin[0] != 0x01) {
        throw OnChainErrors.filPlugin(
          'CidBuilder.validate',
          reason: 'CIDv1 binary must start with version 1.',
        );
      }
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'/': value};

  @override
  String toString() => value;

  @override
  List<Object?> get variables => [version, codec, multihash, value];
}
