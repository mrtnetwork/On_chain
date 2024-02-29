import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.u64('withheldAmount')]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw MessageException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.transferFeeAmount);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// Transfer fee extension data for accounts.
class TransferFeeAmount extends LayoutSerializable {
  /// Amount withheld during transfers, to be harvested to the mint
  final BigInt withheldAmount;
  const TransferFeeAmount({required this.withheldAmount});

  factory TransferFeeAmount.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return TransferFeeAmount(withheldAmount: decode["withheldAmount"]);
  }
  factory TransferFeeAmount.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return TransferFeeAmount(withheldAmount: decode["withheldAmount"]);
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {"withheldAmount": withheldAmount};
  }

  @override
  String toString() {
    return "TransferFeeAmount${serialize()}";
  }
}
