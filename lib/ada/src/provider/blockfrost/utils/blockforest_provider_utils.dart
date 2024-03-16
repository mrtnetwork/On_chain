class BlockforestProviderUtils {
  static final RegExp _pathParamRegex = RegExp(r':\w+');
  static List<String> extractParams(String url) {
    Iterable<Match> matches = _pathParamRegex.allMatches(url);
    List<String> params = [];
    for (Match match in matches) {
      params.add(match.group(0)!);
    }
    return List<String>.unmodifiable(params);
  }
}
