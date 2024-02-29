/// RPC Object class for Request a slice of the account's data.
class RPCDataSliceConfig {
  const RPCDataSliceConfig({required this.length, required this.offset});

  /// number of bytes to return
  final int length;

  /// byte offset from which to start reading
  final int offset;
  Map<String, dynamic> toJson() {
    return {
      "dataSlice": {"length": length, "offset": offset}
    };
  }
}
