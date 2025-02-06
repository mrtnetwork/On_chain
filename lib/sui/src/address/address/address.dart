import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Represents a Sui blockchain address with utilities for serialization and comparison.
class SuiAddress extends MoveAddress {
  /// The string representation of the Sui address.
  final String address;

  /// Private constructor for initializing the Sui address.
  SuiAddress._(this.address, super.value);

  /// Creates a Sui address from a hexadecimal string.
  factory SuiAddress(String address) {
    final bytes = SuiAddressUtils.addressToBytes(address);
    return SuiAddress.fromBytes(bytes);
  }

  /// Creates a Sui address from a byte array.
  factory SuiAddress.fromBytes(List<int> bytes) {
    bytes = SuiAddressUtils.praseAddressBytes(bytes);
    return SuiAddress._(BytesUtils.toHexString(bytes, prefix: "0x"), bytes);
  }

  factory SuiAddress.fromStruct(Map<String, dynamic> json) {
    return SuiAddress.fromBytes(json.asBytes("value"));
  }

  /// Converts the Sui address to a byte array.
  List<int> toBytes() {
    return BytesUtils.fromHexString(address);
  }

  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(SuiAddrConst.addressBytesLength,
          property: "value"),
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

  /// Compares two Sui addresses for equality based on their string representation.
  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiAddress) return false;
    return address == other.address;
  }

  /// Returns the hash code for the Sui address, based on its string representation.
  @override
  int get hashCode => address.hashCode;
}
