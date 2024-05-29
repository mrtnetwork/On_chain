import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';

class SPLToken2022Utils {
  static const int typeSize = 2;
  static const int lengthSize = 2;

  static List<ExtensionType> getExtensionTypes(List<int> tlvData) {
    List<int> extensionTypes = [];
    int extensionTypeIndex = 0;

    while (extensionTypeIndex < tlvData.length) {
      int entryType = IntUtils.fromBytes(
          tlvData.sublist(extensionTypeIndex, extensionTypeIndex + typeSize),
          byteOrder: Endian.little);
      extensionTypes.add(entryType);
      int entryLength = IntUtils.fromBytes(
          tlvData.sublist(extensionTypeIndex + typeSize,
              extensionTypeIndex + typeSize + lengthSize),
          byteOrder: Endian.little);
      extensionTypeIndex += entryLength + typeSize + lengthSize;
    }

    return extensionTypes.map((e) => ExtensionType.fromValue(e)).toList();
  }

  static List<int>? getExtensionData(
      {required ExtensionType extension, required List<int> tlvData}) {
    int extensionTypeIndex = 0;
    while (extensionTypeIndex + typeSize + lengthSize <= tlvData.length) {
      int entryType = IntUtils.fromBytes(
          tlvData.sublist(extensionTypeIndex, extensionTypeIndex + typeSize),
          byteOrder: Endian.little);
      int entryLength = IntUtils.fromBytes(
          tlvData.sublist(extensionTypeIndex + typeSize,
              extensionTypeIndex + typeSize + lengthSize),
          byteOrder: Endian.little);
      int typeIndex = extensionTypeIndex + typeSize + lengthSize;
      if (entryType == extension.value) {
        return tlvData.sublist(typeIndex, typeIndex + entryLength);
      }
      extensionTypeIndex = typeIndex + entryLength;
    }

    return null;
  }

  static List<int> readExtionsionBytesFromAccountData(
      {required ExtensionType extensionType,
      required List<int> accountBytes,
      SolanaTokenAccountType? type}) {
    try {
      final extensionBytesOffset = SolanaTokenAccountUtils.accountSize +
          SolanaTokenAccountUtils.accountTypeSize;
      final tlvData = accountBytes.sublist(extensionBytesOffset);
      if (tlvData.length < (extensionType.layoutSize ?? 0)) {
        throw MessageException("Account extension data length is insufficient.",
            details: {
              "Expected": extensionType.layoutSize,
              "length": tlvData.length
            });
      }
      if (type != null) {
        final accountType = SolanaTokenAccountType.fromValue(
            accountBytes[SolanaTokenAccountUtils.accountSize]);
        if (accountType != type) {
          throw MessageException("invalid account type",
              details: {"Excepted": type.name, "Type": accountType.name});
        }
      }
      final extensionBytes = SPLToken2022Utils.getExtensionData(
          extension: extensionType, tlvData: tlvData);

      return extensionBytes!;
    } catch (e) {
      throw const MessageException("Invalid extionsion bytes");
    }
  }
}
