import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/models/models/encoding.dart';

class SolanaAccountInfo {
  factory SolanaAccountInfo.fromJson(Map<String, dynamic> json) {
    final account = SolanaAccountInfo(
        executable: json["executable"],
        lamports: BigintUtils.parse(json["lamports"]),
        owner: SolAddress.uncheckCurve(json["owner"]),
        rentEpoch: json["rentEpoch"],
        space: json["space"],
        data: json["data"]);

    return account;
  }
  Map<String, dynamic> toJson() {
    return {
      "executable": executable,
      "lamports": lamports.toString(),
      "owner": owner.address,
      "rentEpoch": rentEpoch,
      "space": space,
      "data": data
    };
  }

  const SolanaAccountInfo(
      {required this.executable,
      required this.lamports,
      required this.owner,
      required this.rentEpoch,
      required this.space,
      required this.data});

  final bool executable;
  final BigInt lamports;
  final SolAddress owner;
  final double rentEpoch;
  final int space;
  final dynamic data;

  List<int> toBytesData() {
    return SolanaRPCEncoding.decode(data);
  }
}
