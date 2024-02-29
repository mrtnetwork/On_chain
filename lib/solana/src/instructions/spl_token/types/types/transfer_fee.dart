import 'package:on_chain/solana/src/layout/layout.dart';

class TransferFee extends LayoutSerializable {
  final BigInt epoch;
  final BigInt maximumFee;
  final int transferFeeBasisPoints;
  const TransferFee(
      {required this.epoch,
      required this.maximumFee,
      required this.transferFeeBasisPoints});
  factory TransferFee.fromJson(Map<String, dynamic> json) {
    return TransferFee(
        epoch: json["epoch"],
        maximumFee: json["maximumFee"],
        transferFeeBasisPoints: json["transferFeeBasisPoints"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u64('epoch'),
    LayoutUtils.u64('maximumFee'),
    LayoutUtils.u16('transferFeeBasisPoints')
  ], "transferFee");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "epoch": epoch,
      "maximumFee": maximumFee,
      "transferFeeBasisPoints": transferFeeBasisPoints
    };
  }

  @override
  String toString() {
    return "TransferFee${serialize()}";
  }
}
