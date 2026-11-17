import 'dart:io' show Platform;

/// VM implementation: process environment first, `-D` define as fallback.
String? testEnvVar(String name, {String? defineDefault}) {
  return Platform.environment[name] ?? defineDefault;
}
