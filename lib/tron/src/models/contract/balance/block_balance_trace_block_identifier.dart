import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class BlockBalanceTraceBlockIdentifier extends TronProtocolBufferImpl {
  /// Create a new [BlockBalanceTraceBlockIdentifier] instance with specified parameters.
  BlockBalanceTraceBlockIdentifier({List<int>? hash, this.number})
      : hash = BytesUtils.tryToBytes(hash, unmodifiable: true);

  /// Create a new [BlockBalanceTraceBlockIdentifier] instance by parsing a JSON map.
  factory BlockBalanceTraceBlockIdentifier.fromJson(Map<String, dynamic> json) {
    return BlockBalanceTraceBlockIdentifier(
      hash: BytesUtils.tryFromHexString(json['hash']),
      number: BigintUtils.tryParse(json['number']),
    );
  }
  factory BlockBalanceTraceBlockIdentifier.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return BlockBalanceTraceBlockIdentifier(
        hash: decode.getField(1), number: decode.getField(2));
  }

  /// block hash
  final List<int>? hash;

  /// block number
  final BigInt? number;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [hash, number];

  /// Convert the [BlockBalanceTraceBlockIdentifier] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'hash': BytesUtils.tryToHexString(hash),
      'number': number?.toString(),
    };
  }

  /// Convert the [BlockBalanceTraceBlockIdentifier] object to its string representation.
  @override
  String toString() {
    return 'BlockBalanceTraceBlockIdentifier{${toJson()}}';
  }
}
