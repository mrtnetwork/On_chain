import 'package:on_chain/utils/utils/number_utils.dart';

/// Represents the fee history in the context of Ethereum, including base fee per gas, gas used ratio, oldest block, and reward details.
class FeeHistory {
  final List<BigInt> baseFeePerGas;
  final List<double> gasUsedRatio;
  final int oldestBlock;
  final List<List<BigInt>> reward;

  const FeeHistory({
    required this.baseFeePerGas,
    required this.gasUsedRatio,
    required this.oldestBlock,
    required this.reward,
  });

  /// Constructs a [FeeHistory] object from JSON.
  factory FeeHistory.fromJson(Map<String, dynamic> json) {
    final List<BigInt> baseFeePerGas = (json['baseFeePerGas'] as List?)
            ?.map((fee) => PluginBigintUtils.hexToBigint(fee))
            .toList() ??
        <BigInt>[];
    final List<double> gasUsedRatio = (json['gasUsedRatio'] as List<dynamic>)
        .map<double>((e) => PluginIntUtils.toDouble(e))
        .toList();
    final List<List<BigInt>> reward = (json['reward'] as List).map((r) {
      return (r as List)
          .map((value) => PluginBigintUtils.hexToBigint(value))
          .toList();
    }).toList();

    return FeeHistory(
      baseFeePerGas: baseFeePerGas,
      gasUsedRatio: gasUsedRatio,
      oldestBlock: PluginIntUtils.hexToInt(json['oldestBlock']),
      reward: reward,
    );
  }

  @override
  String toString() {
    return '''
      FeeHistory {
        baseFeePerGas: $baseFeePerGas,
        gasUsedRatio: $gasUsedRatio,
        oldestBlock: $oldestBlock,
        reward: $reward,
      }
    ''';
  }

  /// Converts the fee history to [FeeHistorical] with priority fee levels.
  FeeHistorical toFee() {
    FeeHistorical toPriority(List<_FeeHistorical> priorities, BigInt baseFee) {
      BigInt avg(List<BigInt> arr) {
        BigInt sum = arr.reduce((a, v) => a + v);
        return sum ~/ BigInt.from(arr.length);
      }

      BigInt slow = avg(priorities.map((b) {
        return b.priorityFeePerGas[0];
      }).toList());
      BigInt average =
          avg(priorities.map((b) => b.priorityFeePerGas[1]).toList());
      BigInt fast = avg(priorities.map((b) => b.priorityFeePerGas[2]).toList());
      return FeeHistorical(
          slow: slow, high: fast, normal: average, baseFee: baseFee);
    }

    int minLength = [gasUsedRatio.length, baseFeePerGas.length, reward.length]
        .reduce((min, current) => current < min ? current : min);
    final List<_FeeHistorical> historical = List.generate(
        minLength,
        (index) => _FeeHistorical(
            baseFeePerGas: baseFeePerGas[index],
            gasUsedRatio: gasUsedRatio[index],
            priorityFeePerGas: reward[index]));
    return toPriority(historical, baseFeePerGas.last);
  }
}

/// Represents historical fee details for a specific block in Ethereum.
class _FeeHistorical {
  const _FeeHistorical(
      {required this.baseFeePerGas,
      required this.gasUsedRatio,
      required this.priorityFeePerGas});

  final BigInt baseFeePerGas;
  final double gasUsedRatio;
  final List<BigInt> priorityFeePerGas;
}

/// Represents the historical fee levels with slow, normal, high, and base fee details.
class FeeHistorical {
  const FeeHistorical(
      {required this.slow,
      required this.normal,
      required this.high,
      required this.baseFee});
  final BigInt slow;
  final BigInt normal;
  final BigInt high;
  final BigInt baseFee;

  @override
  String toString() {
    return '''
      FeeHistorical {
        slow: $slow,
        normal: $normal,
        high: $high,
      }
    ''';
  }
}
