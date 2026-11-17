import 'package:blockchain_utils/encoding/encoding.dart';

import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/on_chain.dart';

class HederaParsedEntity with CborTagSerializable, Equality {
  final BigInt shard;
  final BigInt realm;
  final BigInt num;
  final String? checksum;
  final HederaPublicKey? keyAlias;
  final ETHAddress? ethAddress;
  final String accountId;
  final String mirrorIdtity;
  HederaParsedEntity.unsafe({
    required this.accountId,
    required BigInt shard,
    required BigInt realm,
    required BigInt num,
    required this.mirrorIdtity,
    this.keyAlias,
    this.ethAddress,
    this.checksum,
  }) : shard = shard.asPositive.asI64,
       realm = realm.asPositive.asI64,
       num = num.asPositive.asI64;
  factory HederaParsedEntity({
    required BigInt shard,
    required BigInt realm,
    required BigInt num,
    HederaPublicKey? keyAlias,
    ETHAddress? ethAddress,
    String? checksum,
  }) {
    if (keyAlias != null && ethAddress != null) {
      throw OnChainErrors.hederaAddress(
        "HederaParsedEntity.from",
        reason:
            "Invalid account ID params: key alias and EVM address are mutually exclusive.",
        details: {"shard": "$shard", "realm": "$realm", "num": "$num"},
      );
    }
    String accountId = "$shard.$realm.";
    if (num > BigInt.zero) {
      accountId += "$num";
    } else if (ethAddress != null) {
      accountId += StringUtils.normalizeHex(ethAddress.address);
    } else if (keyAlias != null) {
      accountId += BytesUtils.toHexString(keyAlias.toBytes());
    } else {
      accountId += "$num";
    }
    String toMirrorEntityId() {
      if (num > BigInt.zero) {
        return '$shard.$realm.$num';
      }
      if (ethAddress != null) {
        return ethAddress.address;
      }
      if (keyAlias != null) {
        if (keyAlias.type == HederaKeyType.secp256k1) {
          return HederaAddress.fromEcdsaPublicKey(keyAlias.toBytes()).address;
        }
        return Base32Encoder.encodeNoPaddingBytes(
          keyAlias.toHederaKey().toBuffer(),
        );
      }
      return '$shard.$realm.0';
    }

    return HederaParsedEntity.unsafe(
      accountId: accountId,
      shard: shard,
      realm: realm,
      num: num,
      checksum: checksum,
      keyAlias: keyAlias,
      ethAddress: ethAddress,
      mirrorIdtity: toMirrorEntityId(),
    );
  }
  factory HederaParsedEntity.deserialize({CborObject? obj, List<int>? bytes}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: OnChainSerializationIdentifiers.hederaAccountId,
      cborBytes: bytes,
      cborObject: obj,
    );
    return HederaParsedEntity.unsafe(
      accountId: values.rawValueAt(0),
      shard: values.rawValueAt(1),
      realm: values.rawValueAt(2),
      num: values.rawValueAt(3),
      keyAlias: values.maybeRawValueAt<HederaPublicKey, List<int>>(
        4,
        (e) => HederaPublicKey.fromBytes(e),
      ),
      ethAddress: values.maybeObjectAt<ETHAddress, CborTagValue>(
        5,
        (e) => ETHAddress.deserializeIAddress(object: e),
      ),
      checksum: values.rawValueAt(6),
      mirrorIdtity: values.rawValueAt(7),
    );
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      OnChainSerializationIdentifiers.hederaAccountId;

  @override
  List<CborObject<Object?>?> get serializationItems => [
    accountId.toCbor(),
    shard.toCbor(),
    realm.toCbor(),
    num.toCbor(),
    keyAlias?.toBytes().toCborBytes(),
    ethAddress?.toCbor(),
    checksum?.toCbor(),
    mirrorIdtity.toCbor(),
  ];

  @override
  List<dynamic> get variables => [accountId];
}
