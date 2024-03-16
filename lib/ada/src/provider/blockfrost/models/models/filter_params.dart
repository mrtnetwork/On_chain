class BlockforestRequestOrderingResponse {
  const BlockforestRequestOrderingResponse._(this.name);
  final String name;
  static const BlockforestRequestOrderingResponse asc =
      BlockforestRequestOrderingResponse._("asc");
  static const BlockforestRequestOrderingResponse desc =
      BlockforestRequestOrderingResponse._("desc");
}

abstract class BlockforestRequestFilter {
  const BlockforestRequestFilter(this.count, this.page, this.ordering);
  final int? count;
  final int? page;
  final BlockforestRequestOrderingResponse? ordering;

  Map<String, String> toJson() {
    return {
      if (count != null) ...{"count": count!.toString()},
      if (page != null) ...{"page": page!.toString()},
      if (ordering != null) ...{"order": ordering!.name},
    };
  }
}

class BlockforestRequestFilterParams extends BlockforestRequestFilter {
  const BlockforestRequestFilterParams({
    int? count,
    int? page,
    BlockforestRequestOrderingResponse? ordering,
  }) : super(count, page, ordering);
}

class BlockforestRequestTransactionFilterParams
    extends BlockforestRequestFilter {
  const BlockforestRequestTransactionFilterParams(
      {int? count,
      int? page,
      BlockforestRequestOrderingResponse? ordering,
      this.from,
      this.to})
      : super(count, page, ordering);

  /// The block number and optionally also index from which
  /// (inclusive) to start search for results, concatenated
  /// using colon. Has to be lower than or equal to to parameter.
  final String? from;

  /// The block number and optionally also index where (inclusive) to end the search for results,
  /// concatenated using colon. Has to be higher than or equal to from parameter.
  final String? to;

  @override
  Map<String, String> toJson() {
    return super.toJson()
      ..addAll({
        if (from != null) ...{"from": from!},
        if (to != null) ...{"to": to!}
      });
  }
}
