/// Browser stub: no environment access; only `-D` define defaults apply
/// (passed explicitly by the caller, since `dart test` has no `--define`
/// passthrough for browser suites — use explicit [BuTestConfig] instead).
String? testEnvVar(String name, {String? defineDefault}) => defineDefault;
