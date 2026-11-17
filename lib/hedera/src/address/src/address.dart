import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/types.dart';
import 'package:on_chain/hedera/src/address/src/utils.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/types/network.dart';
import 'package:on_chain/solidity/address/core.dart';

class HederaAddress
    with CborTagSerializable, Equality
    implements IAddress, SolidityAddress {
  @override
  String get address => entity.accountId;
  final HederaParsedEntity entity;
  const HederaAddress._(this.entity);

  /// Parse any supported form: `0.0.123`, `0.0.123-abcde`, bare num,
  /// EVM hex, or `0.0.<alias-hex>`. Pass [HederaNetwork] to verify checksums.
  factory HederaAddress(String address, {HederaNetwork? network}) {
    final entity = HederaAddrUtils.parseId(address, network: network);
    return HederaAddress._(entity);
  }

  factory HederaAddress.fromEthAddress(
    ETHAddress address, {
    BigInt? shard,
    BigInt? realm,
  }) {
    final entity = HederaAddrUtils.fromEthAddress(
      shard: shard ?? BigInt.zero,
      realm: realm ?? BigInt.zero,
      address: address,
    );
    return HederaAddress._(entity);
  }
  factory HederaAddress.deserializeIAddress({
    CborObject<Object?>? obj,
    List<int>? bytes,
  }) {
    final entity = HederaParsedEntity.deserialize(obj: obj, bytes: bytes);
    return HederaAddress._(entity);
  }
  factory HederaAddress.fromEcdsaPublicKey(
    List<int> pubKeyBytes, {
    BigInt? shard,
    BigInt? realm,
  }) {
    final entity = HederaAddrUtils.fromEthAddress(
      shard: shard ?? BigInt.zero,
      realm: realm ?? BigInt.zero,
      address: ETHAddress.fromPublicKey(pubKeyBytes),
    );
    return HederaAddress._(entity);
  }
  factory HederaAddress.alias(
    HederaPublicKey pk, {
    BigInt? shard,
    BigInt? realm,
  }) {
    final entity = HederaParsedEntity(
      shard: shard ?? BigInt.zero,
      realm: realm ?? BigInt.zero,
      num: BigInt.zero,
      keyAlias: pk,
    );
    return HederaAddress._(entity);
  }

  /// Build from numeric shard.realm.num.
  factory HederaAddress.fromNum({
    BigInt? shard,
    BigInt? realm,
    required BigInt num,
  }) {
    return HederaAddress._(
      HederaParsedEntity(
        shard: shard ?? BigInt.zero,
        realm: realm ?? BigInt.zero,
        num: num,
      ),
    );
  }
  factory HederaAddress.fromTokenId(HederaTokenID entity) {
    final num = entity.tokenNum ?? BigInt.zero;
    return HederaAddress.fromNum(
      shard: entity.shardNum ?? BigInt.zero,
      realm: entity.realmNum ?? BigInt.zero,
      num: num,
    );
  }
  factory HederaAddress.fromFileId(HederaFileID entity) {
    final num = entity.fileNum ?? BigInt.zero;
    return HederaAddress.fromNum(
      shard: entity.shardNum ?? BigInt.zero,
      realm: entity.realmNum ?? BigInt.zero,
      num: num,
    );
  }
  factory HederaAddress.fromContractId(HederaContractID id) {
    final num = id.contractNum;
    if (num != null && num > BigInt.zero) {
      return HederaAddress.fromNum(
        shard: id.shardNum ?? BigInt.zero,
        realm: id.realmNum ?? BigInt.zero,
        num: num,
      );
    }
    final evm = id.evmAddress;
    if (evm != null && evm.length == ETHAddress.lengthInBytes) {
      return HederaAddress.fromEthAddress(
        ETHAddress.fromBytes(evm),
        shard: id.shardNum ?? BigInt.zero,
        realm: id.realmNum ?? BigInt.zero,
      );
    }
    throw OnChainErrors.hederaTx(
      'fromContractAddress',
      reason: 'ContractID has neither contractNum nor evmAddress.',
    );
  }
  factory HederaAddress.fromTopicId(HederaTopicID entity) {
    final num = entity.topicNum ?? BigInt.zero;
    return HederaAddress.fromNum(
      shard: entity.shardNum ?? BigInt.zero,
      realm: entity.realmNum ?? BigInt.zero,
      num: num,
    );
  }
  factory HederaAddress.fromAccountId(HederaAccountID entity) {
    ETHAddress? ethAddress;
    HederaPublicKey? keyAlias;

    final num = entity.accountNum ?? BigInt.zero;
    final aliasBytes = entity.alias;
    if (aliasBytes != null) {
      if (aliasBytes.length == ETHAddress.lengthInBytes) {
        ethAddress = ETHAddress.fromBytes(aliasBytes);
      } else {
        final key = HederaKey.deserialize(aliasBytes);
        keyAlias = HederaPublicKey.fromHederaKey(key);
      }
    }
    return HederaAddress._(
      HederaParsedEntity(
        shard: entity.shardNum ?? BigInt.zero,
        realm: entity.realmNum ?? BigInt.zero,
        num: num,
        ethAddress: ethAddress,
        keyAlias: keyAlias,
      ),
    );
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.hedera;

  String withChecksum(HederaNetwork network) {
    if (entity.keyAlias != null || entity.ethAddress != null) {
      throw OnChainErrors.hederaAddress(
        'withChecksum',
        reason: 'Cannot derive checksum for an alias / EVM account entity.',
      );
    }
    return HederaAddrUtils.accountIdWithChecksum(
      network,
      '${entity.shard}.${entity.realm}.${entity.num}',
    );
  }

  /// Long-zero or explicit EVM address for this account.
  ETHAddress toEthereumAddress() {
    final ethAddress = entity.ethAddress;
    if (ethAddress != null) return ethAddress;
    return HederaAddrUtils.toEthereumAddress(entity.num);
  }

  ETHAddress? toNonLongZeroEthereumAddress() {
    final addr = toEthereumAddress();
    if (!HederaAddrUtils.isLongZeroAddress(addr.toBytes())) {
      return addr;
    }
    return null;
  }

  HederaAddress? toOnChainAddress() {
    if (isOnChainAccount()) return this;
    return null;
  }

  /// Hex string for mirror REST (`0x` + 40 hex). Prefer this over hand-built strings.
  String toMirrorEvmHex() => HederaAddrUtils.toMirrorEvmHex(entity);

  /// Entity form for mirror paths that accept `shard.realm.num` or alias.
  String toMirrorEntityId() {
    return entity.mirrorIdtity;
  }

  @override
  BuBytes encodeAsIAddress() => entity.toCbor().encode();

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject<Object?>?> get serializationItems => [entity.toCbor()];

  @override
  List<dynamic> get variables => [entity];

  @override
  String? get viewType => null;

  @override
  String toString() => address;

  @override
  String toSolidityHex() =>
      BytesUtils.toHexString(toSolidtyBytes(), prefix: "0x");

  @override
  BuBytes toSolidtyBytes() {
    final eth = entity.ethAddress;
    final keyAlias = entity.keyAlias;
    if (eth != null) {
      return eth.toBytes();
    } else if (keyAlias != null && keyAlias.type == HederaKeyType.secp256k1) {
      return ETHAddress.fromPublicKey(keyAlias.toBytes()).toBytes();
    }
    return HederaAddrUtils.toSolidityBytes(
      shard: entity.shard,
      realm: entity.realm,
      num: entity.num,
    );
  }

  HederaAccountID toAccoutId() {
    final key = entity.keyAlias;
    final eth = entity.ethAddress;
    return HederaAccountID(
      accountNum: entity.num == BigInt.zero ? null : entity.num,
      realmNum: entity.realm,
      shardNum: entity.shard,
      alias:
          entity.num == BigInt.zero
              ? (eth?.toBytes() ?? key?.toHederaKey().toBuffer())
              : null,
    );
  }

  void _ensureIsId(String operation) {
    final key = entity.keyAlias;
    final eth = entity.ethAddress;
    if (key != null || eth != null) {
      throw OnChainErrors.hederaAddress(
        operation,
        reason: 'Cannot derive entity for an alias / EVM account entity.',
      );
    }
  }

  HederaTokenID toTokenId() {
    _ensureIsId("toTokenId");
    return HederaTokenID(
      tokenNum: entity.num,
      realmNum: entity.realm,
      shardNum: entity.shard,
    );
  }

  HederaFileID toFileId() {
    _ensureIsId("toFileId");
    return HederaFileID(
      fileNum: entity.num,
      realmNum: entity.realm,
      shardNum: entity.shard,
    );
  }

  HederaContractID toContractId() {
    final key = entity.keyAlias;
    if (key != null) {
      throw OnChainErrors.hederaAddress(
        'toTokenId',
        reason: 'Cannot derive token entity for an alias / EVM account entity.',
      );
    }
    final eth = entity.ethAddress;

    return HederaContractID(
      contractNum: entity.num,
      realmNum: entity.realm,
      shardNum: entity.shard,
      evmAddress: entity.num == BigInt.zero ? eth?.toBytes() : null,
    );
  }

  HederaTopicID toTopicId() {
    _ensureIsId("toTopicId");
    return HederaTopicID(
      topicNum: entity.num,
      realmNum: entity.realm,
      shardNum: entity.shard,
    );
  }

  /// Alias for the typo’d method name used across the package.
  HederaAccountID toAccountId() => toAccoutId();

  bool isOnChainAccount() => entity.num != BigInt.zero;

  bool get isEvmAlias => entity.ethAddress != null && entity.num == BigInt.zero;

  bool get isKeyAlias => entity.keyAlias != null && entity.num == BigInt.zero;
}
