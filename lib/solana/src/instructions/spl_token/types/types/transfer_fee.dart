import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
        epoch: json['epoch'],
        maximumFee: json['maximumFee'],
        transferFeeBasisPoints: json['transferFeeBasisPoints']);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: 'epoch'),
    LayoutConst.u64(property: 'maximumFee'),
    LayoutConst.u16(property: 'transferFeeBasisPoints')
  ], property: 'transferFee');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'epoch': epoch,
      'maximumFee': maximumFee,
      'transferFeeBasisPoints': transferFeeBasisPoints
    };
  }

  @override
  String toString() {
    return 'TransferFee${serialize()}';
  }
}
