abstract class RPCFilterConfig {
  Map<String, dynamic> toJson();
}

class RPCSizeFilterConfig implements RPCFilterConfig {
  RPCSizeFilterConfig(this.dataSize);
  final int dataSize;

  @override
  Map<String, dynamic> toJson() {
    return {"dataSize": dataSize};
  }
}

class RPCMemcmpFilterConfig implements RPCFilterConfig {
  RPCMemcmpFilterConfig({required this.offset, required this.bytes});
  final int offset;
  final String bytes;

  @override
  Map<String, dynamic> toJson() {
    return {
      "memcmp": {"offset": offset, "bytes": bytes}
    };
  }
}
