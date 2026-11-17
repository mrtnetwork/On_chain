import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

/// Base class for all ICP addresses.
abstract class BaseIcpAddress
    with CborTagSerializable, Equality
    implements IAddress {
  final ICPAddressType type;
  const BaseIcpAddress._(this.type);

  /// Auto-detects Principal vs Account Identifier.
  factory BaseIcpAddress(String address) {
    try {
      final decoded = IcpAddrDecoder().decodeAddr(address);
      return switch (decoded.type) {
        ICPAddressType.principal => IcpPrincipalAddress.unsafe(address),
        ICPAddressType.accountIdentifier => IcpAccountIdentifier.unsafe(
          address,
        ),
      };
    } catch (_) {
      throw OnChainErrors.icpAddress(
        'BaseIcpAddress',
        reason: 'Invalid ICP address.',
        details: {'address': address},
      );
    }
  }

  factory BaseIcpAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final decode = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: [BlockchainNetwork.icp.identifier],
      cborBytes: bytes,
      cborObject: object,
    );
    final type = ICPAddressType.fromValue(decode.values.rawValueAt(0));
    return switch (type) {
      ICPAddressType.principal => IcpPrincipalAddress.deserializeIAddress(
        object: decode.tag,
      ),
      ICPAddressType.accountIdentifier =>
        IcpAccountIdentifier._deserializeIAddress(decode.values),
    };
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.icp;

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<dynamic> get variables => [address];

  @override
  BuBytes encodeAsIAddress() => toCbor().encode();

  @override
  String toString() => address;

  List<int> toBytes();

  IcpAccountIdentifier toAccountIdentifier();
}

class IcpPrincipalAddress extends BaseIcpAddress {
  static const IcpPrincipalAddress anonymous = IcpPrincipalAddress.unsafe(
    "2vxsx-fae",
  );
  static const IcpPrincipalAddress management = IcpPrincipalAddress.unsafe(
    "aaaaa-aa",
  );

  /// Canonical textual form (with dashes).
  @override
  final String address;

  const IcpPrincipalAddress.unsafe(this.address)
    : super._(ICPAddressType.principal);

  /// From already-validated bytes.
  factory IcpPrincipalAddress.fromBytes(List<int> bytes) {
    try {
      final encode = IcpAddrEncoder().encode(
        bytes,
        addrType: ICPAddressType.principal,
      );
      return IcpPrincipalAddress.unsafe(encode.address);
    } catch (_) {
      throw OnChainErrors.icpAddress(
        'IcpPrincipalAddress.fromBytes',
        reason: 'Invalid principal bytes.',
        details: {'length': '${bytes.length}'},
      );
    }
  }

  /// From textual principal.
  factory IcpPrincipalAddress(String address) {
    try {
      final decoded = IcpAddrDecoder().decodeAddr(address);
      if (decoded.type != ICPAddressType.principal) {
        throw OnChainErrors.icpAddress(
          'IcpPrincipalAddress',
          reason: 'Invalid principal address.',
          details: {'address': address, "type": decoded.type.name},
        );
      }
      return IcpPrincipalAddress.unsafe(address.toLowerCase());
    } on BuError {
      rethrow;
    } catch (_) {
      throw OnChainErrors.icpAddress(
        'IcpPrincipalAddress',
        reason: 'Invalid principal address.',
        details: {'address': address},
      );
    }
  }

  /// From a public key (Ed25519, secp256k1 or Secp256r1).
  factory IcpPrincipalAddress.fromPublicKey({
    required List<int> publicKey,
    required ICPKeyType keyType,
  }) {
    final text = IcpAddrEncoder().encodeKey(
      publicKey,
      addrType: ICPAddressType.principal,
      curveType: keyType.curveType(),
    );
    return IcpPrincipalAddress.unsafe(text);
  }

  factory IcpPrincipalAddress.deserializeIAddress({
    CborObject? object,
    List<int>? bytes,
  }) {
    final decode = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.icp.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    final type = ICPAddressType.fromValue(decode.rawValueAt(0));
    if (type != ICPAddressType.principal) {
      throw OnChainErrors.icpAddress(
        'IcpPrincipalAddress',
        reason: 'Invalid principal address type.',
        details: {'type': type.name},
      );
    }
    return IcpPrincipalAddress(decode.rawValueAt(1));
  }

  @override
  List<int> toBytes() => IcpAddrDecoder().decodeAddr(address).bytes;

  IcpPrincipalAddressWithSubId withSubAccountId({List<int>? subaccountId}) =>
      IcpPrincipalAddressWithSubId(this, subaccountId: subaccountId);

  /// Convert this principal to its default classic Account Identifier.
  @override
  IcpAccountIdentifier toAccountIdentifier({List<int>? subaccount}) {
    final addr = IcpAddrEncoder().encode(
      toBytes(),
      addrType: ICPAddressType.accountIdentifier,
      subaccount: subaccount,
    );
    return IcpAccountIdentifier(addr.address);
  }

  List<int> toSubaccountBytes() {
    final p = toBytes();
    final sub = List<int>.filled(IcpAddrConst.accountIdByteLen, 0);
    sub[0] = p.length;
    for (var i = 0; i < p.length && i < 31; i++) {
      sub[1 + i] = p[i];
    }
    return sub;
  }

  @override
  String? get viewType => 'Principal';

  @override
  List<CborObject?> get serializationItems => [
    type.value.toCbor(),
    address.toCbor(),
  ];
}

class IcpAccountIdentifier extends BaseIcpAddress {
  /// 64-character hex string.
  @override
  final String address;

  const IcpAccountIdentifier.unsafe(this.address)
    : super._(ICPAddressType.accountIdentifier);

  factory IcpAccountIdentifier.fromBytes(List<int> accountIdBytes) {
    if (accountIdBytes.length != IcpAddrConst.accountIdByteLen) {
      throw OnChainErrors.icpAddress(
        'IcpAccountIdentifier.fromBytes',
        reason: 'Account Identifier must be 32 bytes.',
        details: {'length': '${accountIdBytes.length}'},
      );
    }
    final hex = BytesUtils.toHexString(accountIdBytes);
    return IcpAccountIdentifier.unsafe(hex);
  }

  factory IcpAccountIdentifier(String address) {
    try {
      final decoded = IcpAddrDecoder().decodeAddr(address);
      if (decoded.type != ICPAddressType.accountIdentifier) {
        throw OnChainErrors.icpAddress(
          'IcpAccountIdentifier',
          reason: 'Invalid Account Identifier.',
          details: {'address': address},
        );
      }
      return IcpAccountIdentifier.unsafe(address.toLowerCase());
    } catch (_) {
      throw OnChainErrors.icpAddress(
        'IcpAccountIdentifier',
        reason: 'Invalid Account Identifier.',
        details: {'address': address},
      );
    }
  }

  /// From a principal (+ optional subaccount).
  factory IcpAccountIdentifier.fromPrincipal(
    IcpPrincipalAddress principal, {
    List<int>? subaccount,
  }) {
    return principal.toAccountIdentifier(subaccount: subaccount);
  }

  factory IcpAccountIdentifier._deserializeIAddress(CborListValue values) {
    return IcpAccountIdentifier(values.rawValueAt(1));
  }

  @override
  List<int> toBytes() => IcpAddrDecoder().decodeAddr(address).bytes;

  @override
  String? get viewType => 'Account Identifier';

  @override
  List<CborObject?> get serializationItems => [
    type.value.toCbor(),
    address.toCbor(),
  ];

  @override
  IcpAccountIdentifier toAccountIdentifier() {
    return this;
  }
}

class IcpPrincipalAddressWithSubId {
  final IcpPrincipalAddress address;
  final List<int>? subaccountId;
  const IcpPrincipalAddressWithSubId(this.address, {this.subaccountId});
}
