class BlockFrostProviderUtils {
  static List<String> extractParams(String url) {
    final RegExp pathParamRegex = RegExp(r':\w+');
    final Iterable<Match> matches = pathParamRegex.allMatches(url);
    final List<String> params = [];
    for (final Match match in matches) {
      params.add(match.group(0)!);
    }
    return List<String>.unmodifiable(params);
  }
}
