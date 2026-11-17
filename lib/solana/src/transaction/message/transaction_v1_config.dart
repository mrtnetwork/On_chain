import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';

/// Transaction-level resource configuration for v1 transactions (SIMD-0385).
///
/// Replaces ComputeBudget instructions: the fee and limits live in the message
/// header (`configMask` + positional `configValues`) instead of the
/// instruction stream. Included ComputeBudget instructions are no-ops on v1.
class TransactionV1Config {
  /// Total priority fee in lamports (u64 LE, occupies mask bits 0+1).
  final BigInt? priorityFeeLamports;

  /// Compute unit limit (u32 LE, mask bit 2). Unset means 0 (no default).
  final int? computeUnitLimit;

  /// Requested loaded accounts data size limit (u32 LE, mask bit 3).
  /// Unset means 0 (no 64MiB default unlike legacy/v0).
  final int? loadedAccountsDataSizeLimit;

  /// Requested heap size in bytes (u32 LE, mask bit 4). Unset means 32KiB.
  /// When set must be a multiple of 1KiB within [32KiB, 256KiB].
  final int? heapSize;

  static const int _priorityFeeBit0 = 1 << 0;
  static const int _priorityFeeBit1 = 1 << 1;
  static const int _computeUnitLimitBit = 1 << 2;
  static const int _loadedAccountsDataSizeBit = 1 << 3;
  static const int _heapSizeBit = 1 << 4;

  /// Bits currently assigned by SIMD-0385. Remaining bits are reserved.
  static const int knownBitsMask =
      _priorityFeeBit0 |
      _priorityFeeBit1 |
      _computeUnitLimitBit |
      _loadedAccountsDataSizeBit |
      _heapSizeBit;

  const TransactionV1Config({
    this.priorityFeeLamports,
    this.computeUnitLimit,
    this.loadedAccountsDataSizeLimit,
    this.heapSize,
  });

  const TransactionV1Config.empty()
    : priorityFeeLamports = null,
      computeUnitLimit = null,
      loadedAccountsDataSizeLimit = null,
      heapSize = null;

  bool get isEmpty =>
      priorityFeeLamports == null &&
      computeUnitLimit == null &&
      loadedAccountsDataSizeLimit == null &&
      heapSize == null;

  bool get isNotEmpty => !isEmpty;

  /// Bitmask as encoded on the wire (u32 LE).
  int get mask {
    var mask = 0;
    if (priorityFeeLamports != null) {
      mask |= _priorityFeeBit0 | _priorityFeeBit1;
    }
    if (computeUnitLimit != null) mask |= _computeUnitLimitBit;
    if (loadedAccountsDataSizeLimit != null) {
      mask |= _loadedAccountsDataSizeBit;
    }
    if (heapSize != null) mask |= _heapSizeBit;
    return mask;
  }

  void validate() {
    if (priorityFeeLamports != null) {
      if (priorityFeeLamports! < BigInt.zero ||
          priorityFeeLamports! >= (BigInt.one << 64)) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'Invalid v1 priority fee: must fit in u64.',
        );
      }
    }
    for (final entry
        in {
          'computeUnitLimit': computeUnitLimit,
          'loadedAccountsDataSizeLimit': loadedAccountsDataSizeLimit,
        }.entries) {
      final v = entry.value;
      if (v != null && (v < 0 || v > 0xFFFFFFFF)) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid v1 ${entry.key}: must fit in u32.',
        );
      }
    }
    if (heapSize != null) {
      final v = heapSize!;
      if (v % 1024 != 0 ||
          v < SolanaTransactionConstant.minHeapFrameBytes ||
          v > SolanaTransactionConstant.maxHeapFrameBytes) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'Invalid v1 heap size: must be a multiple of 1KiB within [32KiB, 256KiB].',
        );
      }
    }
  }

  /// Encoded positional config values (4-byte words, priority fee = 8 bytes).
  List<int> encodeValues() {
    validate();
    final out = <int>[];
    if (priorityFeeLamports != null) {
      out.addAll(
        BigintUtils.toBytes(
          priorityFeeLamports!.toUnsigned(64),
          length: 8,
          byteOrder: Endian.little,
        ),
      );
    }

    if (computeUnitLimit != null) {
      out.addAll(
        IntUtils.toBytes(
          computeUnitLimit!,
          length: 4,
          byteOrder: Endian.little,
        ),
      );
    }
    if (loadedAccountsDataSizeLimit != null) {
      out.addAll(
        IntUtils.toBytes(
          loadedAccountsDataSizeLimit!,
          length: 4,
          byteOrder: Endian.little,
        ),
      );
    }
    if (heapSize != null) {
      out.addAll(
        IntUtils.toBytes(heapSize!, length: 4, byteOrder: Endian.little),
      );
    }
    return out;
  }

  /// Number of 4-byte words for [mask].
  static int wordsForMask(int mask) {
    var count = 0;
    for (var i = 0; i < 32; i++) {
      if ((mask & (1 << i)) != 0) count++;
    }
    return count;
  }

  factory TransactionV1Config.fromMaskAndValues(int mask, List<int> values) {
    if ((mask & ~knownBitsMask) != 0) {
      throw BuError(
        DefaultErrorType.unsupported,
        'Unsupported v1 config bits.',
        details: {'mask': mask.toString()},
      );
    }
    final hasFeeLow = (mask & _priorityFeeBit0) != 0;
    final hasFeeHigh = (mask & _priorityFeeBit1) != 0;
    if (hasFeeLow != hasFeeHigh) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid v1 config: priority fee requires both bits 0 and 1.',
      );
    }
    final expected = wordsForMask(mask) * 4;
    if (values.length != expected) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid v1 config values length.',
        details: {
          'expected': expected.toString(),
          'actual': values.length.toString(),
        },
      );
    }
    var offset = 0;
    BigInt? fee;
    int? cuLimit;
    int? loadedSize;
    int? heap;
    if (hasFeeLow) {
      fee = BigintUtils.fromBytes(
        values,
        offset: offset,
        length: 8,
        byteOrder: Endian.little,
      );
      offset += 8;
    }
    int readU32() {
      final v = IntUtils.fromBytes32(
        values,
        offset: offset,
        byteOrder: Endian.little,
      );
      offset += 4;
      return v;
    }

    if ((mask & _computeUnitLimitBit) != 0) cuLimit = readU32();
    if ((mask & _loadedAccountsDataSizeBit) != 0) loadedSize = readU32();
    if ((mask & _heapSizeBit) != 0) heap = readU32();
    final config = TransactionV1Config(
      priorityFeeLamports: fee,
      computeUnitLimit: cuLimit,
      loadedAccountsDataSizeLimit: loadedSize,
      heapSize: heap,
    );
    config.validate();
    return config;
  }

  /// Parses the RPC `transactionConfig` projection.
  /// Accepts both `priorityFee` (RPC) and `priorityFeeLamports` spellings.
  factory TransactionV1Config.fromJson(Map<String, dynamic> json) {
    BigInt? fee;
    final rawFee = json['priorityFee'] ?? json['priorityFeeLamports'];
    if (rawFee != null) {
      if (rawFee is BigInt) {
        fee = rawFee;
      } else if (rawFee is num) {
        fee = BigInt.from(rawFee.toInt());
      } else {
        fee = BigintUtils.tryParse(rawFee.toString());
      }
    }
    int? u32(dynamic v) => v == null ? null : (v as num).toInt();
    final config = TransactionV1Config(
      priorityFeeLamports: fee,
      computeUnitLimit: u32(json['computeUnitLimit']),
      loadedAccountsDataSizeLimit: u32(json['loadedAccountsDataSizeLimit']),
      heapSize: u32(json['heapSize']),
    );
    config.validate();
    return config;
  }

  Map<String, dynamic> toJson() {
    return {
      'priorityFee':
          priorityFeeLamports == null
              ? null
              : IntUtils.tryParse(priorityFeeLamports.toString()) ??
                  priorityFeeLamports.toString(),
      'computeUnitLimit': computeUnitLimit,
      'loadedAccountsDataSizeLimit': loadedAccountsDataSizeLimit,
      'heapSize': heapSize,
    };
  }

  @override
  String toString() => 'TransactionV1Config${toJson()}';

  @override
  bool operator ==(Object other) =>
      other is TransactionV1Config &&
      other.priorityFeeLamports == priorityFeeLamports &&
      other.computeUnitLimit == computeUnitLimit &&
      other.loadedAccountsDataSizeLimit == loadedAccountsDataSizeLimit &&
      other.heapSize == heapSize;

  @override
  int get hashCode => Object.hash(
    priorityFeeLamports,
    computeUnitLimit,
    loadedAccountsDataSizeLimit,
    heapSize,
  );
}
