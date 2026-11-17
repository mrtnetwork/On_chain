import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/on_chain.dart';

/// Hedera account-id / alias / EVM-address parsing and validation.
class HederaAddrUtils {
  /// `shard.realm.num` with optional `-checksum`.
  static final RegExp numericAccountIdRe = RegExp(
    r'^(\d+)\.(\d+)\.(\d+)(?:-([a-z]{5}))?$',
    caseSensitive: false,
  );

  /// Bare account number (implies `0.0.<num>`).
  static final RegExp bareNumRe = RegExp(r'^(\d+)(?:-([a-z]{5}))?$');

  /// `shard.realm.<hex alias>` — EVM address (40 hex) or public-key bytes.
  static final RegExp aliasAccountIdRe = RegExp(
    r'^(\d+)\.(\d+)\.((?:0x)?[a-fA-F0-9]+)(?:-([a-z]{5}))?$',
  );

  static bool looksLikeAccountId(String id) {
    final t = id.trim();
    return numericAccountIdRe.hasMatch(t) ||
        bareNumRe.hasMatch(t) ||
        tryAsEthAddress(t) != null;
  }

  static void _requireEntityComponent(BigInt v, String name) {
    if (v.isNegative || v > BinaryOps.maxInt64) {
      throw OnChainErrors.hederaAddress(
        'validateEntityComponent',
        reason: '$name out of range: $v (must be 0..${BinaryOps.maxInt64}).',
      );
    }
  }

  static HederaParsedEntity fromEthAddress({
    required BigInt shard,
    required BigInt realm,
    required ETHAddress address,
  }) {
    _requireEntityComponent(shard, 'shard');
    _requireEntityComponent(realm, 'realm');
    BigInt num = BigInt.zero;
    final addrBytes = address.toBytes();
    if (isLongZeroAddress(addrBytes)) {
      num = BigintUtils.fromBytes64(addrBytes.sublist(12));
      _requireEntityComponent(num, 'num');
    }
    return HederaParsedEntity(
      shard: shard,
      realm: realm,
      num: num,
      ethAddress: num == BigInt.zero ? address : null,
    );
  }

  /// Long-zero EVM address: first 12 bytes are 0, last 8 encode entity num.
  static bool isLongZeroAddress(List<int> bytes) {
    if (bytes.length != ETHAddress.lengthInBytes) {
      throw OnChainErrors.hederaAddress(
        'isLongZeroAddress',
        reason: 'Invalid ethereum address bytes length (${bytes.length}).',
      );
    }
    for (var i = 0; i < 12; i++) {
      if (bytes[i] != 0) return false;
    }
    return true;
  }

  static ETHAddress? tryAsEthAddress(String address) {
    final t = address.trim();
    if (StringUtils.isHexBytes(t, lengthInBytes: ETHAddress.lengthInBytes)) {
      final normalize = StringUtils.normalizeHex(t, with0x: true);
      return ETHAddress.unsafe(normalize);
    }
    return null;
  }

  /// 5-letter Hedera entity-id checksum (official SDK algorithm).
  static String calculateAccountIdChecksum(
    HederaNetwork network,
    String bareAddress,
  ) {
    const p3 = 26 * 26 * 26;
    const p5 = 26 * 26 * 26 * 26 * 26;
    const asciiA = 0x61;
    const m = 1000003;
    const w = 31;

    if (!RegExp(r'^\d+\.\d+\.\d+$').hasMatch(bareAddress)) {
      throw OnChainErrors.hederaAddress(
        'calculateAccountIdChecksum',
        reason:
            'Checksum only applies to shard.realm.num form, got "$bareAddress".',
      );
    }

    var s = 0;
    var s0 = 0;
    var s1 = 0;
    var sh = 0;

    // ledgerId + six zero bytes
    final ledgerBytes = [network.ledgerId.asU8, 0, 0, 0, 0, 0, 0];

    // Convert address to digits
    final digits = <int>[];

    for (final ch in bareAddress.split('')) {
      digits.add(ch == '.' ? 10 : IntUtils.parse(ch));
    }

    // Calculate address hash
    for (var i = 0; i < digits.length; i++) {
      final d = digits[i];

      s = (w * s + d) % p3;

      if (i % 2 == 0) {
        s0 = (s0 + d) % 11;
      } else {
        s1 = (s1 + d) % 11;
      }
    }

    // Calculate ledger hash
    for (final byte in ledgerBytes) {
      sh = (w * sh + byte) % p5;
    }

    var c =
        ((((bareAddress.length % 5) * 11 + s0) * 11 + s1) * p3 + s + sh) % p5;

    c = (c * m) % p5;

    final result = StringBuffer();

    for (var i = 0; i < 5; i++) {
      result.writeCharCode(asciiA + (c % 26));
      c ~/= 26;
    }

    return result.toString().split('').reversed.join();
  }

  static String accountIdWithChecksum(
    HederaNetwork network,
    String bareAddress,
  ) {
    final checksum = calculateAccountIdChecksum(network, bareAddress);
    return '$bareAddress-$checksum';
  }

  /// Parse and validate an account id / alias / EVM address.
  ///
  /// Supported forms:
  /// - `0.0.1234`
  /// - `0.0.1234-abcde` (checksum; verified when [HederaNetwork] is set)
  /// - `1234` → `0.0.1234`
  /// - `0x` + 40 hex (EVM address / long-zero)
  /// - `0.0.<40 hex>` (EVM alias on shard.realm)
  /// - `0.0.<pubkey hex>` (key alias)
  static HederaParsedEntity parseId(String text, {HederaNetwork? network}) {
    final id = _parseId(text.trim());
    final checksum = id.checksum;
    if (network != null && checksum != null) {
      if (id.num == BigInt.zero) {
        if ((id.ethAddress != null || id.keyAlias != null)) return id;
      }
      final bare = '${id.shard}.${id.realm}.${id.num}';
      final expected = calculateAccountIdChecksum(network, bare);
      if (checksum != expected) {
        throw OnChainErrors.hederaAddress(
          'parseAccountId',
          reason: 'Checksum mismatch: expected "$expected", got "$checksum".',
          details: {'address': bare},
        );
      }
    }
    return id;
  }

  static HederaParsedEntity _parseId(String text) {
    if (text.isEmpty) {
      throw OnChainErrors.hederaAddress(
        'parseIdentity',
        reason: 'Empty account id.',
      );
    }

    // Pure EVM address (with or without 0x)
    final ETHAddress? pureEth = tryAsEthAddress(text);
    if (pureEth != null) {
      return fromEthAddress(
        shard: BigInt.zero,
        realm: BigInt.zero,
        address: pureEth,
      );
    }

    // Numeric shard.realm.num[-checksum]
    final numMatch = numericAccountIdRe.firstMatch(text);
    if (numMatch != null) {
      final shard = BigintUtils.parse(numMatch.group(1)!);
      final realm = BigintUtils.parse(numMatch.group(2)!);
      final num = BigintUtils.parse(numMatch.group(3)!);
      _requireEntityComponent(shard, 'shard');
      _requireEntityComponent(realm, 'realm');
      _requireEntityComponent(num, 'num');
      return HederaParsedEntity(
        shard: shard,
        realm: realm,
        num: num,
        checksum: numMatch.group(4)?.toLowerCase(),
      );
    }

    // Bare number → 0.0.num
    final bare = bareNumRe.firstMatch(text);
    if (bare != null) {
      final num = BigintUtils.parse(bare.group(1)!);
      _requireEntityComponent(num, 'num');
      return HederaParsedEntity(
        shard: BigInt.zero,
        realm: BigInt.zero,
        num: num,
        checksum: bare.group(2)?.toLowerCase(),
      );
    }

    // shard.realm.<hex alias>
    final aliasMatch = aliasAccountIdRe.firstMatch(text);
    if (aliasMatch != null) {
      final shard = BigintUtils.parse(aliasMatch.group(1)!);
      final realm = BigintUtils.parse(aliasMatch.group(2)!);
      final hexPart = aliasMatch.group(3)!;
      final checksum = aliasMatch.group(4)?.toLowerCase();
      _requireEntityComponent(shard, 'shard');
      _requireEntityComponent(realm, 'realm');

      if (checksum != null) {
        throw OnChainErrors.hederaAddress(
          'parseIdentity',
          reason: 'Checksum is not allowed on alias account ids.',
          details: {'entity': text},
        );
      }

      final eth = tryAsEthAddress(hexPart);
      if (eth != null) {
        return fromEthAddress(shard: shard, realm: realm, address: eth);
      }

      // Key alias (public key bytes as hex)
      try {
        final keyBytes = BytesUtils.fromHexString(
          hexPart.startsWith('0x') ? hexPart.substring(2) : hexPart,
        );
        final publicKey = HederaPublicKey.fromBytes(keyBytes);
        return HederaParsedEntity(
          shard: shard,
          realm: realm,
          num: BigInt.zero,
          keyAlias: publicKey,
        );
      } catch (e) {
        throw OnChainErrors.hederaAddress(
          'parseIdentity',
          reason: 'Invalid key alias / EVM hex in account id.',
          details: {'entity': text, 'error': e.toString()},
        );
      }
    }

    throw OnChainErrors.hederaAddress(
      'parseIdentity',
      reason:
          'Invalid entity id. Expected shard.realm.num, bare num, '
          'EVM address, or shard.realm.<alias-hex>.',
      details: {'entity': text},
    );
  }

  /// Long-zero EVM address for a numeric entity (`0.0.num` → 20 bytes).
  static ETHAddress toEthereumAddress(BigInt num) {
    _requireEntityComponent(num, 'num');
    final bytes = List<int>.filled(20, 0);
    final numBytes = BigintUtils.toBytes(num, length: 8);
    bytes.setAll(12, numBytes);
    return ETHAddress.fromBytes(bytes);
  }

  /// Solidity / EVM 20-byte encoding for shard.realm.num (not long-zero form).
  /// Layout: shard u32 | realm u64 | num u64 (big-endian) packed into 20 bytes
  /// as used by Hedera Solidity address mapping for entity ids.
  static BuBytes toSolidityBytes({
    required BigInt shard,
    required BigInt realm,
    required BigInt num,
  }) {
    _requireEntityComponent(shard, 'shard');
    _requireEntityComponent(realm, 'realm');
    _requireEntityComponent(num, 'num');
    final bytes = BuBytes.fill(20, 0);
    // first 4 bytes shard, next 8 realm, last 8 num.
    final shardB = BigintUtils.toBytes(shard, length: 4);
    final realmB = BigintUtils.toBytes(realm, length: 8);
    final numB = BigintUtils.toBytes(num, length: 8);
    bytes.setAll(0, shardB);
    bytes.setAll(4, realmB);
    bytes.setAll(12, numB);
    return bytes;
  }

  /// Hex form expected by mirror REST (`0x` + 40 hex), lower-case.
  static String toMirrorEvmHex(HederaParsedEntity id) {
    if (id.ethAddress != null) {
      return id.ethAddress!.address;
    }
    if (id.keyAlias != null && id.keyAlias!.type == HederaKeyType.secp256k1) {
      // secp256k1 alias → Ethereum address of the key
      final eth = ETHAddress.fromPublicKey(id.keyAlias!.toBytes());
      return StringUtils.normalizeHex(eth.address, with0x: true);
    }
    // Numeric entity → long-zero EVM address
    final eth = toEthereumAddress(id.num);
    return StringUtils.normalizeHex(eth.address, with0x: true);
  }

  static String normalizeHederaId(BigInt? shard, BigInt? realm, BigInt? num) {
    return '${shard ?? '0'}.${realm ?? '0'}.${num ?? '0'}';
  }

  static String normalizeTokenId(HederaTokenID id) {
    return normalizeHederaId(id.shardNum, id.realmNum, id.tokenNum);
  }

  static String normalizeTopicId(HederaTopicID id) {
    return normalizeHederaId(id.shardNum, id.realmNum, id.topicNum);
  }
}
