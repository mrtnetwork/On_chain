class Context {
  const Context({required this.apiVersion, required this.slot});
  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(apiVersion: json["apiVersion"], slot: json["slot"]);
  }
  final String? apiVersion;
  final int slot;
}
