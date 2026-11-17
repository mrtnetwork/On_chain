import 'package:on_chain/solana/src/address/sol_address.dart';

class ParsedInstruction {
  const ParsedInstruction({
    this.program,
    required this.programId,
    this.parsed,
    this.stackHeight,
    List<String>? accounts,
    this.data,
  }) : accounts = accounts ?? const [];

  factory ParsedInstruction.fromJson(Map<String, dynamic> json) {
    final accounts = json['accounts'];
    return ParsedInstruction(
      program: json['program'],
      programId: SolAddress.uncheckCurve(json['programId']),
      parsed: json['parsed'],
      stackHeight: json['stackHeight'],
      accounts: accounts == null ? const [] : (accounts as List).cast(),
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'program': program,
      'programId': programId.address,
      'parsed': parsed,
      'stackHeight': stackHeight,
      'accounts': accounts,
      'data': data,
    };
  }

  /// Program name (e.g. `spl-token`); only present when fully parsed.
  final String? program;

  /// Program id.
  final SolAddress programId;

  /// Parsed instruction (`{type, info}`); only present when fully parsed.
  final dynamic parsed;

  /// Stack height of a CPI inner instruction.
  final int? stackHeight;

  /// Account addresses (partially decoded shape only).
  final List<String> accounts;

  /// Base58 program input data (partially decoded shape only).
  final String? data;
}
