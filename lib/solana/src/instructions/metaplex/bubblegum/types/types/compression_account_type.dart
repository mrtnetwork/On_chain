import 'package:on_chain/solana/src/exception/exception.dart';

class CompressionAccountType {
  final String name;
  final int value;
  const CompressionAccountType._(this.name, this.value);
  static const CompressionAccountType uninitialized =
      CompressionAccountType._('Uninitialized', 0);
  static const CompressionAccountType concurrentMerkleTree =
      CompressionAccountType._('ConcurrentMerkleTree', 1);

  static const List<CompressionAccountType> values = [
    uninitialized,
    concurrentMerkleTree
  ];

  static CompressionAccountType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          'No CompressionAccountType found matching the specified value',
          details: {'value': value}),
    );
  }

  @override
  String toString() {
    return 'CompressionAccountType.$name';
  }
}
