import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';

class ResultWithContext<T> {
  const ResultWithContext({required this.result, required this.context});
  final T result;
  final Context? context;
}

/// An abstract class representing Solana RPC request parameters.
abstract class SolanaRequestParams {
// The Solana method associated with the request.
  abstract final String method;

  /// Converts the request parameters to a JSON representation.
  List<dynamic> toJson();
}

/// Represents the details of an Ethereum JSON-RPC request.
class SolanaRequestDetails {
  const SolanaRequestDetails({
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

/// An abstract class representing a request to lookup ledger data.
abstract class LoockupLedgerRequest {
  /// Constructs a [LoockupLedgerRequest] with optional parameters.
  ///
  /// [commitment]: The desired commitment level for the request.
  ///
  /// [encoding]: The encoding format of the data.
  ///
  /// [minContextSlot]: The minimum context slot for the request.
  const LoockupLedgerRequest({
    this.commitment,
    this.encoding,
    this.minContextSlot,
  });

  /// The desired commitment level for the request.
  final Commitment? commitment;

  /// The minimum context slot for the request.
  final MinContextSlot? minContextSlot;

  /// The encoding format of the data.
  final SolanaRPCEncoding? encoding;

  /// Converts the request to JSON format.
  List<dynamic> toJson() {
    return [];
  }
}

/// An abstract class representing Solana JSON-RPC requests with generic response types.
abstract class SolanaRPCRequest<T> extends LoockupLedgerRequest
    implements SolanaRequestParams {
  const SolanaRPCRequest(
      {MinContextSlot? minContextSlot,
      Commitment? commitment,
      SolanaRPCEncoding? encoding})
      : super(
          minContextSlot: minContextSlot,
          commitment: commitment,
          encoding: encoding,
        );

  /// A validation property (not used in this implementation).
  String? get validate => null;

  /// Converts a dynamic response to the generic type [T].
  T onResonse(dynamic result) {
    return result as T;
  }

  /// Converts the request parameters to a [SolanaRequestDetails] object.
  SolanaRequestDetails toRequest(int requestId) {
    final List<dynamic> inJson = [...toJson(), ...super.toJson()];
    inJson.removeWhere((v) => v == null);
    final params = {
      "jsonrpc": "2.0",
      "method": method,
      "params": inJson,
      "id": requestId,
    };

    return SolanaRequestDetails(
        id: requestId, params: StringUtils.fromJson(params), method: method);
  }
}
