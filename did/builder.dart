import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:onchain_proto/did_gen/did.dart';

void main() {
  final file = File(
    ServiceProviderUtils.joinPathWithRoot([
      Directory.current.path,
      "pubspec.yaml",
    ], separator: Platform.pathSeparator),
  );
  if (!file.existsSync()) {
    stderr.writeln('Please run this script from the package root directory.');
    exit(1);
  }
  generateCandid([
    ServiceProviderUtils.joinPathWithRoot([
      "did/files",
    ], separator: Platform.pathSeparator),

    "--out-dir",
    ServiceProviderUtils.joinPathWithRoot([
      "lib/icp/src/did",
    ], separator: Platform.pathSeparator),
    "--service-query-class",
    "IICPQueryMessage",
    "--service-update-class",
    "IICPUpdateMessage",
    "--types-import",
    "package:on_chain/icp/src/address/address.dart,package:on_chain/icp/src/serialization/serialization.dart,package:blockchain_utils/blockchain_utils.dart",
    "--services-import",
    "package:on_chain/icp/src/service/service.dart,package:on_chain/icp/src/address/address.dart,package:on_chain/icp/src/serialization/serialization.dart,package:blockchain_utils/blockchain_utils.dart",
  ]);
  _cleanUpImports();
}

void _cleanUpImports() {
  stderr.writeln("Clean up imports...");
  _process(
    args: ["fix", "--apply", "--code=unused_import", "--code=duplicate_import"],
  );
  stderr.writeln("Format dart code...");
  _process(args: ["format", "."]);
}

void _process({
  String command = "dart",
  List<String> args = const ["fix", "--apply", "--code=unused_import"],
  String? workingDirectory,
}) {
  final process = Process.runSync(
    command,
    args,
    runInShell: Platform.isWindows,
    workingDirectory: workingDirectory,
  );
  final exitCode = process.exitCode;
  assert(
    exitCode == 0,
    "dart ${args.join(" ")} failed with exit code $exitCode",
  );
}
