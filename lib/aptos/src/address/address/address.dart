import 'package:blockchain_utils/bip/address/aptos_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/bcs/move/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosAddress extends MoveAddress {
  /// Represents the address "0x0", often used as a null or uninitialized value
  static final AptosAddress zero = AptosAddress("0x0");

  /// Represents the address "0x1", commonly reserved for core framework modules.
  static final AptosAddress one = AptosAddress("0x1");

  /// Represents the address "0x2", typically used for standard library modules.
  static final AptosAddress two = AptosAddress("0x2");

  /// Represents the address "0x3", reserved for system-level functionalities.
  static final AptosAddress three = AptosAddress("0x3");

  /// Represents the address "0x4", also used for predefined system modules.
  static final AptosAddress four = AptosAddress("0x4");

  /// Represents the address "0xA", which may be used for specialized system components
  static final AptosAddress A = AptosAddress("0xA");

  /// The address as a string (in hex format with a "0x" prefix)
  final String address;
  AptosAddress._(this.address, List<int> bytes) : super(bytes);

  factory AptosAddress(String address) {
    return AptosAddress.fromBytes(AptosAddressUtils.addressToBytes(address));
  }

  /// Factory constructor to create an AptosAddress from raw byte data
  factory AptosAddress.fromBytes(List<int> bytes) {
    final addressBytes = AptosAddressUtils.praseAddressBytes(bytes);
    return AptosAddress._(
        BytesUtils.toHexString(addressBytes, prefix: "0x"), addressBytes);
  }

  factory AptosAddress.fromStruct(Map<String, dynamic> json) {
    return AptosAddress.fromBytes(json.asBytes("value"));
  }
  static StructLayout layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(AptosAddrConst.addressBytesLength,
          property: "value"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"value": value};
  }

  /// address in raw byte format
  List<int> toBytes() {
    return value.clone();
  }

  @override
  String toString() {
    return address;
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosAddress) return false;
    return address == other.address;
  }

  @override
  int get hashCode => address.hashCode;
}
