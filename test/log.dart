// ignore_for_file: avoid_print

class Logg {
  static bool get isDebug => true;
  static String? _tag;

  static void setTag(String? tag) {
    _tag = tag;
  }

  static void _print(String msg) {
    if (_tag == null) {
      print(msg);
      return;
    }
    print("[$_tag]: $msg");
  }

  static void log(Object? text) {
    _print('\x1B[33m$text\x1B[0m');
  }

  static void error(String text) {
    _print('\x1B[31m$text\x1B[0m');
  }

  static void webview(String text) {
    _print(text);
  }

  static T def<T>(T Function() n, String text) {
    final stopWatch = Stopwatch()..start();
    final r = n();
    stopWatch.stop();
    log("$text: ${stopWatch.elapsedMilliseconds}");
    return r;
  }

  static double benchMark(
    void Function() n,
    String text, {
    int iterations = 20,
  }) {
    n();
    final sw = Stopwatch()..start();

    for (int i = 0; i < iterations; i++) {
      n();
    }

    sw.stop();

    final aTime = sw.elapsedMilliseconds / iterations;
    log("average $text: $aTime");
    return aTime;
  }

  static Future<T> defAsync<T>(Future<T> Function() n, String text) async {
    final stopWatch = Stopwatch()..start();
    final r = await n();
    stopWatch.stop();
    log("$text: ${stopWatch.elapsedMilliseconds}");
    return r;
  }
}
