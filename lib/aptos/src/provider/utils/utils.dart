class AptosProviderUtils {
  static List<String> extractParams(String url) {
    final RegExp pathParamRegex = RegExp(r'\{[^}]+\}');
    final Iterable<Match> matches = pathParamRegex.allMatches(url);
    final List<String> params = [];
    for (final Match match in matches) {
      params.add(match.group(0)!);
    }
    return List<String>.unmodifiable(params);
  }
}
