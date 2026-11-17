import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/crypto/crypto.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';
import 'package:on_chain/solidity/address/core.dart';

/// Filecoin address hierarchy.
///
/// - [BaseFilAddress] – parses either form: native (`f…`/`t…`) or `0x`.
/// - [FilAddress] – native Filecoin addresses (ID, SECP256K1, Actor, BLS,
///   Delegated).
/// - [FilEthereumAddress] – 20-byte EVM form (`0x…`), as observed by the EVM.
///
/// Implements [IAddress] for use with the shared on-chain address APIs and
/// [FilSerialization] for CBOR encode/decode.
sealed class BaseFilAddress with Equality implements IAddress {
  /// Human-readable address string.
  @override
  final String address;

  const BaseFilAddress._(this.address);

  /// Deserialises an [IAddress]-tagged CBOR payload back into a [FilAddress].
  ///
  /// Accepts either raw [bytes] or a pre-parsed [object]. The tag must match
  /// [BlockchainNetwork.filecoin].
  factory BaseFilAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: [BlockchainNetwork.filecoin.identifier],
      cborBytes: bytes,
      cborObject: object,
    );
    if (values.values.value.length == 1) {
      return FilEthereumAddress.fromBytes(values.values.rawValueAt(0));
    }
    return FilAddress.deserializeIAddress(object: values.tag);
  }

  /// Parses [address], accepting either a native (`f…`/`t…`) address, which
  /// yields a [FilAddress], or a 20-byte `0x` address, which yields a
  /// [FilEthereumAddress].
  ///
  /// Throws [BuError] if the string matches neither form.
  factory BaseFilAddress(String address) {
    try {
      return FilEthereumAddress(address);
    } catch (_) {}
    return FilAddress(address);
  }

  @override
  String toString() {
    return address;
  }

  /// Always [BlockchainNetwork.filecoin].
  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.filecoin;

  /// Equality is based solely on the address string.
  @override
  List<dynamic> get variables => [address];

  T cast<T extends BaseFilAddress>() {
    if (this is! T) {
      throw OnChainErrors.filAddress(
        "BaseFilAddress.cast",
        reason: "Invalid address cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }
}

/// Native Filecoin address (`f…`/`t…`).
///
/// Construction paths:
/// - [FilAddress] – parse a string (`f1…`, `t0…`, …)
/// - [FilAddress.fromBytes] – decode raw protocol bytes
/// - [FilAddress.fromPublickey] – derive from a SECP/BLS public key
/// - [FilAddress.one] – Init actor (`f01` / `t01`)
class FilAddress extends BaseFilAddress with FilSerialization {
  /// Protocol / payload type of this address.
  final FilAddrType type;

  /// Network this address belongs to (mainnet `f` vs testnet `t`).
  ///
  /// The EVM form carries no network information itself; [FilEthereumAddress]
  /// stores the network context it was created with for conversions.
  final FilNetwork network;
  FilAddress._(super.address, this.type, this.network) : super._();

  /// Returns the Init actor address (`f01` / `t01`) for [network].
  ///
  /// Useful when calling **Init.Exec** to create Multisig / Paych actors.
  factory FilAddress.one({FilNetwork network = FilNetwork.mainnet}) {
    return FilAddress.fromId(BigInt.one, network: network);
  }

  factory FilAddress.fromId(
    BigInt id, {
    FilNetwork network = FilNetwork.mainnet,
  }) {
    try {
      final address = FilIdAddrEncoder().encode(id, network: network);

      return FilAddress._(address, FilAddrType.id, network);
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilAddress",
        reason: "Invalid Filecoin ID.",
        details: {"id": id.toString(), "error": e.toString()},
      );
    }
  }

  /// Parses [address] and optionally validates it against [network].
  ///
  /// Only native (`f…`/`t…`) addresses are accepted; use [BaseFilAddress] to
  /// also accept the `0x` form. Throws [BuError] if the string
  /// is malformed or does not match the expected network prefix.
  factory FilAddress(String address, {FilNetwork? network}) {
    try {
      final decode = FilAddrDecoder().decode(address, network: network);

      return FilAddress._(address, decode.type, decode.network);
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilAddress",
        reason: "Invalid Filecoin address.",
        details: {"address": address, "error": e.toString()},
      );
    }
  }

  /// Builds an address from raw payload bytes.
  ///
  /// [bytes] is expected as `[type, ...rawPayload]` (Filecoin address wire
  /// format). [type] may be supplied explicitly when the leading type byte
  /// is omitted. Defaults to [FilNetwork.mainnet].
  factory FilAddress.fromBytes(
    List<int> bytes, {
    FilNetwork network = FilNetwork.mainnet,
    FilAddrType? type,
  }) {
    try {
      final decode = FilAddrEncoder().encode(
        bytes,
        network: network,
        type: type,
      );
      return FilAddress._(decode.address, decode.type, decode.network);
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilAddress.fromBytes",
        reason: "Invalid Filecoin address bytes.",
        details: {"error": e.toString()},
      );
    }
  }

  /// Derives a Filecoin address from a public key.
  ///
  /// [keyType] selects SECP256K1 (`f1`) or BLS (`f3`). Throws
  /// [BuError] if [publicKey] is invalid for the chosen type.
  factory FilAddress.fromPublickey({
    required List<int> publicKey,
    required FilecoinKeyType keyType,
    FilNetwork network = FilNetwork.mainnet,
  }) {
    try {
      final addrType = switch (keyType) {
        FilecoinKeyType.secp256k1 => FilAddrType.secp256k1,
        FilecoinKeyType.bls12 => FilAddrType.bls,
      };
      final address = FilAddrEncoder().encodeKey(
        publicKey,
        network: network,
        type: addrType,
      );
      return FilAddress._(address, addrType, network);
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilAddress.fromPublickey",
        reason: "Invalid ${keyType.name} public key.",
        details: {"error": e.toString()},
      );
    }
  }

  /// Builds a native address from any EVM address.
  ///
  /// Masked (`isMasked == true`) → ID address (`f0…`/`t0…`).
  /// Plain → delegated `f410…`/`t410f…` (EAM namespace 10).
  /// Same dispatch as [FilEthereumAddress.toFilAddress].
  factory FilAddress.fromEthereum(
    FilEthereumAddress address, {
    FilNetwork network = FilNetwork.mainnet,
  }) {
    return address.toFilAddress(network: network);
  }

  /// Converts this address to its EVM-form [FilEthereumAddress].
  ///
  /// - ID (`f0…`/`t0…`) → masked `0xff` + 11 zero bytes + big-endian u64 ID
  ///   (see `EthAddress::from_id` in the builtin actors).
  /// - Delegated EAM (`f410…`/`t410f…`, namespace 10, 20-byte subaddress) →
  ///   the plain subaddress as `0x…`.
  /// Throws [BuError] for any other protocol. Robust
  /// (`f1`/`f2`/`f3`) addresses must first be resolved to their ID with
  /// `StateLookupID`.
  FilEthereumAddress toEthereumAddress() {
    if (type == FilAddrType.id) {
      final id = FilAddrUtils.decodeId(address).id;
      if (id != null) {
        return FilEthereumAddress._(
          ETHAddress.unsafe(FilAddrUtils.encodeMaskedEthereum(id)),
        );
      }
    } else if (type == FilAddrType.delegated) {
      final decode = FilAddrUtils.decodeDelegated(address);
      final subaddr = decode.subaddr;
      final namespace = decode.namespace;
      if (namespace == BigInt.from(10) &&
          (subaddr != null && subaddr.length == ETHAddress.lengthInBytes)) {
        return FilEthereumAddress._(ETHAddress.fromBytes(subaddr));
      }
    }
    throw OnChainErrors.filAddress(
      "FilAddress.toEthereumAddress",
      reason: "Only ID and EAM delegated addresses can be converted.",
      details: {"address": address, "type": type.name},
    );
  }

  /// Deserialises an [IAddress]-tagged CBOR payload back into a [FilAddress].
  ///
  /// Accepts either raw [bytes] or a pre-parsed [object]. The tag must match
  /// [BlockchainNetwork.filecoin].
  factory FilAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.filecoin.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return FilAddress._(
      values.rawValueAt(0),
      FilAddrType.fromValue(values.rawValueAt(1)),
      FilNetwork.fromPrefix(values.rawValueAt(2)),
    );
  }

  /// CBOR-encodes this address.
  ///
  /// - When [iAddress] is `true`, emits a tagged list
  ///   `[address, type, networkPrefix]` for cross-chain / wallet use.
  /// - Otherwise emits the compact on-chain form: `[typeByte, ...payload]`.
  @override
  CborObject toCbor({bool iAddress = false}) {
    if (iAddress) {
      return CborTagValue(
        CborTagSerializable.listFromDynamic([
          address.toCbor(),
          type.value.toCbor(),
          network.prefix.toCbor(),
        ]),
        [blockchainNetwork.identifier.id],
      );
    }
    final decode = FilAddrDecoder().decode(address);
    return [type.value, ...decode.bytes].toCborBytes();
  }

  /// Encodes this address as a tagged [IAddress] CBOR blob.
  @override
  BuBytes encodeAsIAddress() {
    return toCbor(iAddress: true).encode();
  }

  /// Human-readable type label (e.g. `"ID"`, `"SECP256K1"`).
  @override
  String? get viewType => type.displayName;
}

/// 20-byte EVM form of a Filecoin address (`0x…`).
///
/// This is the form in which the EVM observes Filecoin actors:
/// - Actor IDs appear masked as `0xff` + 11 zero bytes + big-endian u64 ID
///   (see `EthAddress::from_id` in the builtin actors).
/// - Ethereum-assignable accounts use their plain 20-byte address
///   (the subaddress of an `f410` delegated address).
class FilEthereumAddress extends BaseFilAddress
    with CborTagSerializable
    implements SolidityAddress {
  /// The underlying Ethereum address.
  final ETHAddress ethAddress;

  FilEthereumAddress._(this.ethAddress) : super._(ethAddress.address);

  /// Parses a 20-byte `0x` address.
  ///
  /// Throws [BuError] if the string is not a valid address.
  factory FilEthereumAddress(String address) {
    try {
      return FilEthereumAddress._(ETHAddress(address));
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilEthereumAddress",
        reason: "Invalid Ethereum address.",
        details: {"address": address, "error": e.toString()},
      );
    }
  }

  /// Builds the EVM form from raw 20-byte [bytes].
  ///
  /// Throws [BuError] if the length is not 20 bytes.
  factory FilEthereumAddress.fromBytes(List<int> bytes) {
    try {
      return FilEthereumAddress._(ETHAddress.fromBytes(bytes));
    } catch (e) {
      throw OnChainErrors.filAddress(
        "FilEthereumAddress.fromBytes",
        reason: "Invalid Ethereum address bytes.",
        details: {"error": e.toString()},
      );
    }
  }

  /// Converts an ID-protocol [FilAddress] (`f0…` / `t0…`) to its EVM-masked
  /// form (`0xff` + 11 zero bytes + big-endian u64 ID).
  ///
  /// Throws [BuError] for any other protocol. Robust
  /// (`f1`/`f2`/`f3`) addresses must first be resolved to their ID with
  /// `StateLookupID`.
  factory FilEthereumAddress.fromFilAddress(FilAddress address) {
    return address.toEthereumAddress();
  }

  /// Converts back to a native [FilAddress].
  ///
  /// - `0xff`-masked form → the ID address (`f0…` / `t0…`).
  /// - Any other form → the `f410` delegated address carrying these bytes
  ///   as its subaddress (EAM namespace 10).
  FilAddress toFilAddress({FilNetwork network = FilNetwork.mainnet}) {
    final bytes = ethAddress.toBytes();
    final masked = _isMasked(bytes);
    if (masked) {
      final id = BigintUtils.fromBytes(bytes, offset: 12);
      return FilAddress.fromId(id, network: network);
    }
    return FilAddress(
      FilDelegatedAddrEncoder().encode(
        bytes,
        network: network,
        nameSpace: BigInt.from(10),
      ),
    );
  }

  static bool _isMasked(BuBytes bytes) {
    return bytes.length == ETHAddress.lengthInBytes &&
        bytes[0] == 0xff &&
        bytes.sublist(1, 12).every((e) => e == 0);
  }

  /// Whether this is a masked ID address (`0xff` + 11 zero bytes + be64 ID).
  ///
  /// `true` → converts back to `f0…`/`t0…` (native-only, MetaMask can't spend).
  /// `false` → plain EVM address, converts to `f410…` (EAM namespace 10).
  bool get isMasked {
    final bytes = ethAddress.toBytes();
    return _isMasked(bytes);
  }

  /// Encodes this address as raw CBOR bytes.
  @override
  BuBytes encodeAsIAddress() {
    return toCbor().encode();
  }

  /// Human-readable type label.
  @override
  String? get viewType => "Ethereum Address";

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [
    CborBytesValue(toSolidtyBytes()),
  ];

  @override
  String toSolidityHex() {
    return ethAddress.toSolidityHex();
  }

  @override
  BuBytes toSolidtyBytes() {
    return ethAddress.toSolidtyBytes();
  }

  /// Equality is based solely on the address string.
  @override
  List<dynamic> get variables => [ethAddress];
}
