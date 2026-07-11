import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/bcs/serialization.dart';
import 'package:on_chain/sui/src/exception/exception.dart';

/// Represents a Sui blockchain address with utilities for serialization and comparison.
class SuiAddress extends MoveAddress
    with CborTagSerializable, Equality
    implements IAddress {
  /// The string representation of the Sui address.
  @override
  final String address;

  static SuiAddress get one => SuiAddress(
    "0x0000000000000000000000000000000000000000000000000000000000000001",
  );

  static SuiAddress get two => SuiAddress(
    "0x0000000000000000000000000000000000000000000000000000000000000002",
  );

  /// Private constructor for initializing the Sui address.
  SuiAddress._(this.address, super.value);

  /// Creates a Sui address from a hexadecimal string.
  factory SuiAddress(String address) {
    address = StringUtils.strip0x(address);
    List<int>? toBytes = BytesUtils.tryFromHexString(
      address,
      paddingZero: address.length == 1,
    );
    if (toBytes == null) {
      throw DartSuiPluginException(
        "Invalid sui address.",
        details: {"address": address},
      );
    }

    /// handle special addresses.
    if (toBytes.length == 1) {
      final byte = toBytes[0];
      if (byte < 10) {
        toBytes = List.filled(SuiAddrConst.addressBytesLength, 0);
        toBytes.last = byte;
      }
    }
    return SuiAddress.fromBytes(toBytes);
  }

  /// Creates a Sui address from a byte array.
  factory SuiAddress.fromBytes(List<int> bytes) {
    bytes = SuiAddressUtils.praseAddressBytes(bytes);
    return SuiAddress._(BytesUtils.toHexString(bytes, prefix: "0x"), bytes);
  }

  factory SuiAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.sui.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    return SuiAddress.fromBytes(values.rawValueAt(0));
  }

  factory SuiAddress.fromStruct(Map<String, dynamic> json) {
    return SuiAddress.fromBytes(json.valueAsBytes("value"));
  }

  /// Converts the Sui address to a byte array.
  List<int> toBytes() {
    return BytesUtils.fromHexString(address);
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        SuiAddrConst.addressBytesLength,
        property: "value",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"value": toBytes()};
  }

  /// Returns the string representation of the Sui address.
  @override
  String toString() {
    return address;
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.sui;

  @override
  List<int> encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [CborBytesValue(toBytes())];

  @override
  List<dynamic> get variables => [address];

  @override
  String? get viewType => null;
}
