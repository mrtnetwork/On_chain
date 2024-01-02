import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import '../../models/block_tag.dart';

/// An abstract class representing Ethereum RPC request parameters.
abstract class ETHRequestParams {
// The Ethereum method associated with the request.
  abstract final EthereumMethods method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();
}

/// Represents the details of an Ethereum JSON-RPC request.
class ETHRequestDetails {
  const ETHRequestDetails({
    required this.id,
    required this.method,
    required this.params,
  });

  /// The unique identifier for the JSON-RPC request.
  final int id;

  /// The Ethereum method name for the request.
  final String method;

  /// The JSON-formatted string containing the request parameters.
  final String params;

  /// Converts the request parameters to a JSON-formatted string.
  String toRequestBody() {
    return params;
  }
}

/// An abstract class representing Ethereum lookup block requests.
abstract class LookupBlockRequest {
  /// The block number for the request, defaulting to [BlockTagOrNumber.latest].
  LookupBlockRequest({this.blockNumber = BlockTagOrNumber.latest});

  final BlockTagOrNumber? blockNumber;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();
}

/// An abstract class representing Ethereum JSON-RPC requests with generic response types.
abstract class ETHRPCRequest<T> extends LookupBlockRequest
    implements ETHRequestParams {
  ETHRPCRequest({BlockTagOrNumber? blockNumber})
      : super(blockNumber: blockNumber);

  /// A validation property (not used in this implementation).
  String? get validate => null;

  /// Converts a dynamic response to a BigInt, handling hexadecimal conversion.
  static BigInt onBigintResponse(dynamic result) {
    if (result == "0x") return BigInt.zero;
    return BigInt.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts a dynamic response to an integer, handling hexadecimal conversion.
  static int onIntResponse(dynamic result) {
    if (result == "0x") return 0;
    return int.parse(StringUtils.strip0x(result), radix: 16);
  }

  /// Converts a dynamic response to the generic type [T].
  T onResonse(dynamic result) {
    return result as T;
  }

  /// Converts the request parameters to a [ETHRequestDetails] object.
  ETHRequestDetails toRequest(int requestId) {
    List<dynamic> inJson = toJson();
    inJson.removeWhere((v) => v == null);
    inJson = inJson.map((e) {
      if (e is BlockTagOrNumber) return e.toJson();
      return e;
    }).toList();
    final params = {
      "jsonrpc": "2.0",
      "method": method.value,
      "params": inJson,
      "id": requestId,
    };
    return ETHRequestDetails(
        id: requestId,
        params: StringUtils.fromJson(params),
        method: method.value);
  }
}
