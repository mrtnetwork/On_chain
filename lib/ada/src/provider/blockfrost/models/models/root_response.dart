/// Root endpoint response: backend version info.
class ADARootResponse {
  final String url;
  final String version;

  ADARootResponse({required this.url, required this.version});

  factory ADARootResponse.fromJson(Map<String, dynamic> json) {
    return ADARootResponse(
      url: json['url'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'version': version};
  }

  @override
  String toString() {
    return 'ADARootResponse${toJson()}';
  }
}
