import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

enum NearAddressType {
  implicit(0),
  named(1);

  final int value;
  const NearAddressType(this.value);
  static NearAddressType fromValue(int? value) => values.firstWhere(
    (e) => e.value == value,
    orElse:
        () =>
            throw OnChainErrors.nearPlugin(
              "NearAddressType.fromValue",
              reason: "Invalid NEAR address type.",
              details: {"value": "$value"},
            ),
  );
}

abstract class BaseNearAddress
    with CborTagSerializable, Equality
    implements IAddress {
  final NearAddressType type;
  const BaseNearAddress._(this.type);
  factory BaseNearAddress(String address) {
    try {
      if (StringUtils.isHexBytes(
        address,
        lengthInBytes: Ed25519KeysConst.pubKeyByteLen,
      )) {
        return NearImplicitAddress(address);
      }
      return NearNamedAddress(address);
    } catch (_) {
      throw OnChainErrors.nearPlugin(
        "BaseNearAddress",
        reason: "Invalid NEAR address.",
      );
    }
  }

  factory BaseNearAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final decode = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: [BlockchainNetwork.near.identifier],
      cborBytes: bytes,
      cborObject: object,
    );
    final type = NearAddressType.fromValue(decode.values.rawValueAt(0));
    return switch (type) {
      NearAddressType.implicit => NearImplicitAddress._deserializeIAddress(
        decode.values,
      ),
      NearAddressType.named => NearNamedAddress._deserializeIAddress(
        decode.values,
      ),
    };
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.near;
  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<dynamic> get variables => [address];

  @override
  BuBytes encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  String toString() {
    return address;
  }
}

class NearImplicitAddress extends BaseNearAddress {
  @override
  final String address;
  const NearImplicitAddress.unsafe(this.address)
    : super._(NearAddressType.implicit);
  factory NearImplicitAddress.fromBytes(List<int> ed25519PublicKey) {
    try {
      final encode = NearAddrEncoder().encodeKey(ed25519PublicKey);
      return NearImplicitAddress.unsafe(encode);
    } catch (_) {
      throw OnChainErrors.nearPlugin(
        "NearImplicitAddress.fromBytes",
        reason: "Invalid implicit address bytes.",
        details: {"length": "${ed25519PublicKey.length}"},
      );
    }
  }
  factory NearImplicitAddress(String address) {
    try {
      NearAddrDecoder().decodeAddr(address);
      return NearImplicitAddress.unsafe(address);
    } catch (_) {
      throw OnChainErrors.nearPlugin(
        "NearImplicitAddress",
        reason: "Invalid implicit address.",
        details: {"address": address},
      );
    }
  }
  factory NearImplicitAddress._deserializeIAddress(CborListValue values) {
    return NearImplicitAddress.fromBytes(values.rawValueAt(1));
  }

  List<int> toBytes() => NearAddrDecoder().decodeAddr(address);

  @override
  List<dynamic> get variables => [address];

  @override
  String? get viewType => "Implicit Address";

  @override
  List<CborObject<Object?>?> get serializationItems => [
    type.value.toCbor(),
    toBytes().toCborBytes(),
  ];
}

class NearNamedAddress extends BaseNearAddress {
  @override
  final String address;
  const NearNamedAddress.unsafe(this.address) : super._(NearAddressType.named);
  factory NearNamedAddress(String address) {
    if (!isValidAccountId(address)) {
      throw OnChainErrors.nearPlugin(
        "NearNamedAddress",
        reason: "Invalid NEAR named address.",
        details: {"address": address},
      );
    }
    return NearNamedAddress.unsafe(address);
  }

  /// Consensus-level account ID validation: 2-64 chars of `a-z 0-9 - _ .`,
  /// every dot-separated part non-empty and starting/ending alphanumeric.
  /// Empty parts (`.alice`, `alice..near`) and edge separators are rejected;
  /// registrar pricing rules (e.g. minimum part length) are intentionally
  /// not enforced here.
  static bool isValidAccountId(String address) {
    if (address.length < 2 || address.length > 64) return false;
    for (final part in address.split('.')) {
      if (part.isEmpty) return false;
      if (!_isAlphaNumeric(part.codeUnitAt(0)) ||
          !_isAlphaNumeric(part.codeUnitAt(part.length - 1))) {
        return false;
      }
      for (final c in part.codeUnits) {
        if (!_isAlphaNumeric(c) && c != 0x2D && c != 0x5F) return false;
      }
    }
    return true;
  }

  static bool _isAlphaNumeric(int c) {
    return (c >= 0x30 && c <= 0x39) || (c >= 0x61 && c <= 0x7A);
  }

  factory NearNamedAddress._deserializeIAddress(CborListValue values) {
    return NearNamedAddress(values.rawValueAt(1));
  }

  @override
  String? get viewType => null;

  @override
  List<CborObject<Object?>?> get serializationItems => [
    type.value.toCbor(),
    address.toCbor(),
  ];
}
