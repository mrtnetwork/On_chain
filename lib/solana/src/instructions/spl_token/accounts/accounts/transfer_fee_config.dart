import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.publicKey('transferFeeConfigAuthority'),
    LayoutUtils.publicKey('withdrawWithheldAuthority'),
    LayoutUtils.u64('withheldAmount'),
    LayoutUtils.wrap(TransferFee.staticLayout, property: "olderTransferFee"),
    LayoutUtils.wrap(TransferFee.staticLayout, property: "newerTransferFee"),
  ]);

  static int get accountSize => layout.span;
  static final oneInBasisPoint = BigInt.from(10000);

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
              extensionType: ExtensionType.transferFeeConfig);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw MessageException("Invalid extionsion bytes");
    }
  }
}

/// Transfer fee extension data for mints.
class TransferFeeConfig extends LayoutSerializable {
  /// Optional authority to set the fee
  final SolAddress transferFeeConfigAuthority;

  /// Withdraw from mint instructions must be signed by this key
  final SolAddress withdrawWithheldAuthority;

  /// Withheld transfer fee tokens that have been moved to the mint for
  /// withdrawal
  final BigInt withheldAmount;

  /// Older transfer fee, used if the current epoch < newerTransferFee.epoch
  final TransferFee olderTransferFee;

  /// Newer transfer fee, used if the current epoch >= newerTransferFee.epoch
  final TransferFee newerTransferFee;
  const TransferFeeConfig(
      {required this.transferFeeConfigAuthority,
      required this.withdrawWithheldAuthority,
      required this.withheldAmount,
      required this.olderTransferFee,
      required this.newerTransferFee});

  factory TransferFeeConfig.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return TransferFeeConfig(
        transferFeeConfigAuthority: decode["transferFeeConfigAuthority"],
        withdrawWithheldAuthority: decode["withdrawWithheldAuthority"],
        withheldAmount: decode["withheldAmount"],
        olderTransferFee: TransferFee.fromJson(decode["olderTransferFee"]),
        newerTransferFee: TransferFee.fromJson(decode["newerTransferFee"]));
  }
  factory TransferFeeConfig.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return TransferFeeConfig(
        transferFeeConfigAuthority: decode["transferFeeConfigAuthority"],
        withdrawWithheldAuthority: decode["withdrawWithheldAuthority"],
        withheldAmount: decode["withheldAmount"],
        olderTransferFee: TransferFee.fromJson(decode["olderTransferFee"]),
        newerTransferFee: TransferFee.fromJson(decode["newerTransferFee"]));
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "transferFeeConfigAuthority": transferFeeConfigAuthority,
      "withdrawWithheldAuthority": withdrawWithheldAuthority,
      "withheldAmount": withheldAmount,
      "olderTransferFee": olderTransferFee.serialize(),
      "newerTransferFee": newerTransferFee.serialize()
    };
  }

  @override
  String toString() {
    return "TransferFeeConfig${serialize()}";
  }

  TransferFee getEpochFee(BigInt epoch) {
    if (epoch > newerTransferFee.epoch) {
      return newerTransferFee;
    }
    return olderTransferFee;
  }

  BigInt calculateEpochFee(
      {required BigInt preFeeAmount, required BigInt epoch}) {
    final fee = getEpochFee(epoch);
    if (preFeeAmount == BigInt.zero || fee.transferFeeBasisPoints == 0) {
      return BigInt.zero;
    }
    final numerator = preFeeAmount * BigInt.from(fee.transferFeeBasisPoints);
    final rawFee = (numerator * _Utils.oneInBasisPoint - BigInt.one) ~/
        _Utils.oneInBasisPoint;
    return rawFee > fee.maximumFee ? fee.maximumFee : rawFee;
  }
}
