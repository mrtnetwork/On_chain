/// [Network Inflation](https://docs.solana.com/implemented-proposals/ed_overview)
class InflationGovernor {
  final double foundation;
  final double foundationTerm;
  final double initial;
  final double taper;
  final double terminal;
  const InflationGovernor(
      {required this.foundation,
      required this.foundationTerm,
      required this.initial,
      required this.taper,
      required this.terminal});
  factory InflationGovernor.fromJson(Map<String, dynamic> json) {
    return InflationGovernor(
        foundation: json['foundation'],
        foundationTerm: json['foundationTerm'],
        initial: json['initial'],
        taper: json['taper'],
        terminal: json['terminal']);
  }
}
