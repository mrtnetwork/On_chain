import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

class WitnessesAccount {
  final TronAddress address;
  final BigInt? voteCount;
  final String url;
  final int? totalProduced;
  final int? totalMissed;
  final int? latestBlockNum;
  final int? latestSlotNum;
  final bool? isJobs;

  WitnessesAccount({
    required this.address,
    required this.voteCount,
    required this.url,
    required this.totalProduced,
    required this.totalMissed,
    required this.latestBlockNum,
    required this.latestSlotNum,
    required this.isJobs,
  });

  factory WitnessesAccount.fromJson(Map<String, dynamic> json) {
    return WitnessesAccount(
      address: TronAddress(json['address']),
      voteCount: BigintUtils.tryParse(json['voteCount']),
      url: json['url'],
      totalProduced: json['totalProduced'],
      totalMissed: json['totalMissed'],
      latestBlockNum: json['latestBlockNum'],
      latestSlotNum: json['latestSlotNum'],
      isJobs: json['isJobs'],
    );
  }

  @override
  String toString() {
    return 'MyData {'
        ' address: $address,'
        ' voteCount: $voteCount,'
        ' url: $url,'
        ' totalProduced: $totalProduced,'
        ' totalMissed: $totalMissed,'
        ' latestBlockNum: $latestBlockNum,'
        ' latestSlotNum: $latestSlotNum,'
        ' isJobs: $isJobs'
        '}';
  }
}
