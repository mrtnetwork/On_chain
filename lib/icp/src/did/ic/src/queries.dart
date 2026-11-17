// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ic`.
abstract class ICQueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICQueryMessage();
}

class ICQueryCanisterStatus extends ICQueryMessage<ICCanisterStatusResult> {
  final ICCanisterStatusArgs args;
  const ICQueryCanisterStatus(this.args);

  @override
  String get methodName => 'canister_status';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICCanisterStatusResult onResponse(List<int> bytes) {
    return ICCanisterStatusResult.fromBytes(bytes);
  }
}

class ICQueryListCanisters extends ICQueryMessage<ICListCanistersResult> {
  const ICQueryListCanisters();

  @override
  String get methodName => 'list_canisters';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  ICListCanistersResult onResponse(List<int> bytes) {
    return ICListCanistersResult.fromBytes(bytes);
  }
}

class ICQueryFetchCanisterLogs
    extends ICQueryMessage<ICFetchCanisterLogsResult> {
  final ICFetchCanisterLogsArgs args;
  const ICQueryFetchCanisterLogs(this.args);

  @override
  String get methodName => 'fetch_canister_logs';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICFetchCanisterLogsResult onResponse(List<int> bytes) {
    return ICFetchCanisterLogsResult.fromBytes(bytes);
  }
}

class ICQueryCanisterMetrics extends ICQueryMessage<ICCanisterMetricsResult> {
  final ICCanisterMetricsArgs args;
  const ICQueryCanisterMetrics(this.args);

  @override
  String get methodName => 'canister_metrics';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  ICCanisterMetricsResult onResponse(List<int> bytes) {
    return ICCanisterMetricsResult.fromBytes(bytes);
  }
}
