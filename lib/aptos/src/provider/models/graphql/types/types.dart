class AptosGraphQlWhereCondition {
  final String key;
  // Operators for asset_type
  final String? isEq;
  final List<String>? isIn;
  final List<String>? isNin;

  // Operators for supply
  final int? isLt;
  final int? isLte;
  final int? isGt;
  final int? isGte;

  final String? isNeq;

  // Logical operators
  final List<AptosGraphQlWhereCondition>? and;
  final List<AptosGraphQlWhereCondition>? or;

  // Constructor
  AptosGraphQlWhereCondition(
      {required this.key,
      this.isEq,
      this.isIn,
      this.isNin,
      this.isLt,
      this.isLte,
      this.isGt,
      this.isGte,
      this.isNeq,
      this.and,
      this.or});

  // Converts the object to a JSON representation
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> andConditions =
        and?.map((e) => e.toJson()).toList() ?? [];
    List<Map<String, dynamic>> orConditions =
        or?.map((e) => e.toJson()).toList() ?? [];

    final Map<String, dynamic> data = {
      '_eq': isEq,
      '_in': isIn,
      '_nin': isNin,
      '_lt': isLt,
      '_lte': isLte,
      '_gt': isGt,
      '_gte': isGte,
      '_neq': isNeq,
      '_and': andConditions.isEmpty ? null : andConditions,
      '_or': orConditions.isEmpty ? null : orConditions
    }..removeWhere((k, v) => v == null);
    if (data.isEmpty) return {};
    return data.map((k, v) => MapEntry(key, <String, dynamic>{k: v}));
  }
}
