import 'package:blockchain_utils/blockchain_utils.dart';

class AccountResource {
  final BigInt freeNetUsed;
  final BigInt freeNetLimit;
  final BigInt netLimit;
  final BigInt netUsed;
  final BigInt energyLimit;
  final BigInt energyUsed;

  final int tronPowerUsed;
  final int tronPowerLimit;
  late final BigInt totalBandWith;
  late final BigInt howManyEnergy;
  late final BigInt totalBandWithUsed;
  int get howManyVote => tronPowerLimit - tronPowerUsed;
  BigInt get howManyBandwIth => totalBandWith - totalBandWithUsed;

  AccountResource({
    required this.freeNetUsed,
    required this.freeNetLimit,
    required this.netLimit,
    required this.netUsed,
    required this.energyLimit,
    required this.energyUsed,
    required this.tronPowerLimit,
    required this.tronPowerUsed,
  }) {
    totalBandWith = freeNetLimit + netLimit;
    totalBandWithUsed = netUsed + freeNetUsed;
    howManyEnergy = energyLimit - energyUsed;
    if (howManyEnergy < BigInt.zero) {
      howManyEnergy = BigInt.zero;
    }
  }

  factory AccountResource.empty() => AccountResource(
      freeNetUsed: BigInt.zero,
      freeNetLimit: BigInt.zero,
      netLimit: BigInt.zero,
      netUsed: BigInt.zero,
      energyLimit: BigInt.zero,
      energyUsed: BigInt.zero,
      tronPowerLimit: 0,
      tronPowerUsed: 0);

  factory AccountResource.fromJson(Map<String, dynamic> json) {
    return AccountResource(
      freeNetLimit: BigintUtils.tryParse(json["freeNetLimit"]) ?? BigInt.zero,
      freeNetUsed: BigintUtils.tryParse(json["freeNetUsed"]) ?? BigInt.zero,
      netLimit: BigintUtils.tryParse(json["NetLimit"]) ?? BigInt.zero,
      netUsed: BigintUtils.tryParse(json["NetUsed"]) ?? BigInt.zero,
      energyUsed: BigintUtils.tryParse(json["EnergyUsed"]) ?? BigInt.zero,
      energyLimit: BigintUtils.tryParse(json["EnergyLimit"]) ?? BigInt.zero,
      tronPowerUsed: json["tronPowerUsed"] ?? 0,
      tronPowerLimit: json["tronPowerLimit"] ?? 0,
    );
  }

  @override
  String toString() {
    return '''
      TronAccountResource {
        freeNetUsed: $freeNetUsed,
        freeNetLimit: $freeNetLimit,
        netLimit: $netLimit,
        netUsed: $netUsed,
        energyLimit: $energyLimit,
        energyUsed: $energyUsed,
        totalBandWith: $totalBandWith,
        totalBandWithUsed: $totalBandWithUsed,
        tronPowerUsed: $tronPowerUsed,
        tronPowerLimit: $tronPowerLimit,
        howManyVote: $howManyVote,
        howManyBandwIth: $howManyBandwIth,
        howManyEnergy: $howManyEnergy,
      }
    ''';
  }

  Map<String, dynamic> toJson() {
    return {
      "freeNetLimit": freeNetLimit,
      "freeNetUsed": freeNetUsed,
      "NetLimit": netLimit,
      "NetUsed": netUsed,
      "EnergyUsed": energyUsed,
      "EnergyLimit": energyLimit,
    };
  }
}
