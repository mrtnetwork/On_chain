import 'package:on_chain/solana/src/exception/exception.dart';

class CleanUpAction {
  final int kind;
  final String name;
  final List<int>? fields;
  const CleanUpAction._(this.kind, this.name, this.fields);
  factory CleanUpAction.fromJson(Map<String, dynamic> json) {
    final int kind = json["cleanUpAction"];
    if (kind == 0) {
      return CleanUpAction.change((json["fields"] as List).cast());
    } else if (kind == 1) {
      return CleanUpAction.sort();
    } else if (kind == 2) {
      return CleanUpAction.none();
    }
    throw SolanaPluginException('Invalid or unknown cleanUpAction',
        details: {"kind": kind});
  }
  factory CleanUpAction.sort() => const CleanUpAction._(1, "Sort", null);
  factory CleanUpAction.none() => const CleanUpAction._(2, "NoneLayout", null);
  factory CleanUpAction.change(List<int> fields) {
    if (fields.length != 2) {
      throw SolanaPluginException("Expected exactly 2 fields",
          details: {"fields": fields});
    }
    return CleanUpAction._(0, "NoneLayout", fields);
  }

  @override
  String toString() {
    return "CleanUpAction.$name ${fields?.join(",") ?? ""}";
  }
}
