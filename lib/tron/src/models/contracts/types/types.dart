import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

/// Account bandwidth, energy and storage resources.
class TronAccountResourceMessage extends TronProtoMessage {
  final BigInt freeNetUsed;

  final BigInt freeNetLimit;

  final BigInt netUsed;

  final BigInt netLimit;

  final Map<String, BigInt> assetNetUsed;

  final Map<String, BigInt> assetNetLimit;

  final BigInt totalNetLimit;

  final BigInt totalNetWeight;

  final BigInt totalTronPowerWeight;

  final BigInt tronPowerUsed;

  final BigInt tronPowerLimit;

  final BigInt energyUsed;

  final BigInt energyLimit;

  final BigInt totalEnergyLimit;

  final BigInt totalEnergyWeight;

  final BigInt storageUsed;

  final BigInt storageLimit;

  late final BigInt totalBandwidth;
  late final BigInt howManyEnergy;
  late final BigInt totalBandwidthUsed;

  /// Remaining votes, clamped to zero when fully used.
  int get howManyVote {
    final remaining = tronPowerLimit - tronPowerUsed;
    if (remaining <= BigInt.zero) return 0;
    return remaining.asSafeInt;
  }

  /// Remaining bandwidth, clamped to zero when fully used.
  BigInt get howManyBandwIth {
    final remaining = totalBandwidth - totalBandwidthUsed;
    return remaining < BigInt.zero ? BigInt.zero : remaining;
  }

  factory TronAccountResourceMessage.noResources() =>
      TronAccountResourceMessage(
        energyLimit: BigInt.zero,
        freeNetUsed: BigInt.zero,
        freeNetLimit: BigInt.zero,
        netUsed: BigInt.zero,
        netLimit: BigInt.zero,
        totalNetLimit: BigInt.zero,
        totalNetWeight: BigInt.zero,
        totalTronPowerWeight: BigInt.zero,
        tronPowerUsed: BigInt.zero,
        tronPowerLimit: BigInt.zero,
        energyUsed: BigInt.zero,
        totalEnergyLimit: BigInt.zero,
        totalEnergyWeight: BigInt.zero,
        storageUsed: BigInt.zero,
        storageLimit: BigInt.zero,
      );

  TronAccountResourceMessage({
    required this.freeNetUsed,
    required this.freeNetLimit,
    required this.netUsed,
    required this.netLimit,
    this.assetNetUsed = const {},
    this.assetNetLimit = const {},
    required this.totalNetLimit,
    required this.totalNetWeight,
    required this.totalTronPowerWeight,
    required this.tronPowerUsed,
    required this.tronPowerLimit,
    required this.energyUsed,
    required this.energyLimit,
    required this.totalEnergyLimit,
    required this.totalEnergyWeight,
    required this.storageUsed,
    required this.storageLimit,
  }) {
    totalBandwidth = freeNetLimit + netLimit;
    totalBandwidthUsed = netUsed + freeNetUsed;
    howManyEnergy = energyLimit - energyUsed;
    if (howManyEnergy < BigInt.zero) {
      howManyEnergy = BigInt.zero;
    }
  }

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.map(
          fieldNumber: 5,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 6,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.int64(13),
        ProtoFieldConfig.int64(14),
        ProtoFieldConfig.int64(15),
        ProtoFieldConfig.int64(16),
        ProtoFieldConfig.int64(21),
        ProtoFieldConfig.int64(22),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    freeNetUsed,
    freeNetLimit,
    netUsed,
    netLimit,
    assetNetUsed,
    assetNetLimit,
    totalNetLimit,
    totalNetWeight,
    totalTronPowerWeight,
    tronPowerUsed,
    tronPowerLimit,
    energyUsed,
    energyLimit,
    totalEnergyLimit,
    totalEnergyWeight,
    storageUsed,
    storageLimit,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'freeNetUsed': config.encodeBigint(freeNetUsed),
      'freeNetLimit': config.encodeBigint(freeNetLimit),
      'NetUsed': config.encodeBigint(netUsed),
      'NetLimit': config.encodeBigint(netLimit),
      'assetNetUsed': assetNetUsed.map(
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'assetNetLimit': assetNetLimit.map(
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'TotalNetLimit': config.encodeBigint(totalNetLimit),
      'TotalNetWeight': config.encodeBigint(totalNetWeight),
      'TotalTronPowerWeight': config.encodeBigint(totalTronPowerWeight),
      'tronPowerUsed': config.encodeBigint(tronPowerUsed),
      'tronPowerLimit': config.encodeBigint(tronPowerLimit),
      'EnergyUsed': config.encodeBigint(energyUsed),
      'EnergyLimit': config.encodeBigint(energyLimit),
      'TotalEnergyLimit': config.encodeBigint(totalEnergyLimit),
      'TotalEnergyWeight': config.encodeBigint(totalEnergyWeight),
      'storageUsed': config.encodeBigint(storageUsed),
      'storageLimit': config.encodeBigint(storageLimit),
    }.notNullValue;
  }

  factory TronAccountResourceMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountResourceMessage(
      freeNetUsed: json.valueAsBigInt<BigInt>(
        'freeNetUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      freeNetLimit: json.valueAsBigInt<BigInt>(
        'freeNetLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      netUsed: json.valueAsBigInt<BigInt>(
        'NetUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      netLimit: json.valueAsBigInt<BigInt>(
        'NetLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      assetNetUsed: (json.valueAsMap<Map<dynamic, dynamic>>(
        'assetNetUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => {},
      )).map(
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      assetNetLimit: (json.valueAsMap<Map<dynamic, dynamic>>(
        'assetNetLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => {},
      )).map(
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      totalNetLimit: json.valueAsBigInt<BigInt>(
        'TotalNetLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      totalNetWeight: json.valueAsBigInt<BigInt>(
        'TotalNetWeight',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      totalTronPowerWeight: json.valueAsBigInt<BigInt>(
        'TotalTronPowerWeight',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      tronPowerUsed: json.valueAsBigInt<BigInt>(
        'tronPowerUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      tronPowerLimit: json.valueAsBigInt<BigInt>(
        'tronPowerLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      energyUsed: json.valueAsBigInt<BigInt>(
        'EnergyUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      energyLimit: json.valueAsBigInt<BigInt>(
        'EnergyLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      totalEnergyLimit: json.valueAsBigInt<BigInt>(
        'TotalEnergyLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      totalEnergyWeight: json.valueAsBigInt<BigInt>(
        'TotalEnergyWeight',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      storageUsed: json.valueAsBigInt<BigInt>(
        'storageUsed',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
      storageLimit: json.valueAsBigInt<BigInt>(
        'storageLimit',
        normalizeKeyLookup: config.normalizeKeys,
        onMissing: () => BigInt.zero,
      ),
    );
  }

  factory TronAccountResourceMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountResourceMessage(
      freeNetUsed: decode.getBigInt<BigInt>(1),
      freeNetLimit: decode.getBigInt<BigInt>(2),
      netUsed: decode.getBigInt<BigInt>(3),
      netLimit: decode.getBigInt<BigInt>(4),
      assetNetUsed: decode.getMap<String, BigInt>(5),
      assetNetLimit: decode.getMap<String, BigInt>(6),
      totalNetLimit: decode.getBigInt<BigInt>(7),
      totalNetWeight: decode.getBigInt<BigInt>(8),
      totalTronPowerWeight: decode.getBigInt<BigInt>(9),
      tronPowerUsed: decode.getBigInt<BigInt>(10),
      tronPowerLimit: decode.getBigInt<BigInt>(11),
      energyUsed: decode.getBigInt<BigInt>(13),
      energyLimit: decode.getBigInt<BigInt>(14),
      totalEnergyLimit: decode.getBigInt<BigInt>(15),
      totalEnergyWeight: decode.getBigInt<BigInt>(16),
      storageUsed: decode.getBigInt<BigInt>(21),
      storageLimit: decode.getBigInt<BigInt>(22),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountResourceMessage;
}
