class BlockFrostProviderUtils {
  static final RegExp _pathParamRegex = RegExp(r':\w+');
  static List<String> extractParams(String url) {
    final Iterable<Match> matches = _pathParamRegex.allMatches(url);
    final List<String> params = [];
    for (final Match match in matches) {
      params.add(match.group(0)!);
    }
    return List<String>.unmodifiable(params);
  }
}
