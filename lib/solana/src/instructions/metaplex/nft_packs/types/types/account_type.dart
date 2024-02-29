import 'package:blockchain_utils/blockchain_utils.dart';

class NFTPacksAccountType {
  final String name;
  final int value;
  const NFTPacksAccountType._(this.name, this.value);

  static const uninitialized = NFTPacksAccountType._("Uninitialized", 0);
  static const packSet = NFTPacksAccountType._("PackSet", 1);
  static const packCard = NFTPacksAccountType._("PackCard", 2);
  static const packVoucher = NFTPacksAccountType._("PackVoucher", 3);
  static const provingProcess = NFTPacksAccountType._("ProvingProcess", 4);
  static const packConfig = NFTPacksAccountType._("PackConfig", 5);
  static const List<NFTPacksAccountType> values = [
    uninitialized,
    packSet,
    packCard,
    packVoucher,
    provingProcess,
    packConfig
  ];
  static NFTPacksAccountType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No NFTPacksAccountType found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "NFTPacksAccountType.$name";
  }
}
