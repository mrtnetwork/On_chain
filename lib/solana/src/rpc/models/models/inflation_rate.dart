class InflationRate {
  /// total inflation
  final double total;

  /// inflation allocated to validators
  final double validator;

  /// inflation allocated to the foundation
  final double foundation;

  /// epoch for which these values are valid
  final int epoch;

  const InflationRate(
      {required this.total,
      required this.validator,
      required this.foundation,
      required this.epoch});
  factory InflationRate.fromJson(Map<String, dynamic> json) {
    return InflationRate(
        total: json["total"],
        validator: json["validator"],
        foundation: json["foundation"],
        epoch: json["epoch"]);
  }
}
