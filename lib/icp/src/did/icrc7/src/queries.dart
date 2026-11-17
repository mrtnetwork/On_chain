// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `ICRC7`.
abstract class ICRC7QueryMessage<RESULT> extends IICPQueryMessage<RESULT> {
  const ICRC7QueryMessage();
}

class ICRC7QueryIcrc7CollectionMetadata
    extends ICRC7QueryMessage<List<ICRC7ValueMap>> {
  const ICRC7QueryIcrc7CollectionMetadata();

  @override
  String get methodName => 'icrc7_collection_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<ICRC7ValueMap> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(ICRC7ValueMap.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => ICRC7ValueMap.fromCandid(e)).toList();
  }
}

class ICRC7QueryIcrc7Symbol extends ICRC7QueryMessage<String> {
  const ICRC7QueryIcrc7Symbol();

  @override
  String get methodName => 'icrc7_symbol';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}

class ICRC7QueryIcrc7Name extends ICRC7QueryMessage<String> {
  const ICRC7QueryIcrc7Name();

  @override
  String get methodName => 'icrc7_name';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}

class ICRC7QueryIcrc7Description extends ICRC7QueryMessage<String?> {
  const ICRC7QueryIcrc7Description();

  @override
  String get methodName => 'icrc7_description';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.text)) as String?;
  }
}

class ICRC7QueryIcrc7Logo extends ICRC7QueryMessage<String?> {
  const ICRC7QueryIcrc7Logo();

  @override
  String get methodName => 'icrc7_logo';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.text)) as String?;
  }
}

class ICRC7QueryIcrc7TotalSupply extends ICRC7QueryMessage<BigInt> {
  const ICRC7QueryIcrc7TotalSupply();

  @override
  String get methodName => 'icrc7_total_supply';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat) as BigInt;
  }
}

class ICRC7QueryIcrc7SupplyCap extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7SupplyCap();

  @override
  String get methodName => 'icrc7_supply_cap';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7MaxQueryBatchSize extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7MaxQueryBatchSize();

  @override
  String get methodName => 'icrc7_max_query_batch_size';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7MaxUpdateBatchSize extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7MaxUpdateBatchSize();

  @override
  String get methodName => 'icrc7_max_update_batch_size';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7DefaultTakeValue extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7DefaultTakeValue();

  @override
  String get methodName => 'icrc7_default_take_value';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7MaxTakeValue extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7MaxTakeValue();

  @override
  String get methodName => 'icrc7_max_take_value';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7MaxMemoSize extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7MaxMemoSize();

  @override
  String get methodName => 'icrc7_max_memo_size';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7AtomicBatchTransfers extends ICRC7QueryMessage<bool?> {
  const ICRC7QueryIcrc7AtomicBatchTransfers();

  @override
  String get methodName => 'icrc7_atomic_batch_transfers';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  bool? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.bool_)) as bool?;
  }
}

class ICRC7QueryIcrc7TxWindow extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7TxWindow();

  @override
  String get methodName => 'icrc7_tx_window';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7PermittedDrift extends ICRC7QueryMessage<BigInt?> {
  const ICRC7QueryIcrc7PermittedDrift();

  @override
  String get methodName => 'icrc7_permitted_drift';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  BigInt? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat)) as BigInt?;
  }
}

class ICRC7QueryIcrc7TokenMetadata
    extends ICRC7QueryMessage<List<List<ICRC7ValueMap>?>> {
  final List<BigInt> args;
  const ICRC7QueryIcrc7TokenMetadata(this.args);

  @override
  String get methodName => 'icrc7_token_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.vec(CType.nat), args);
  }

  @override
  List<List<ICRC7ValueMap>?> onResponse(List<int> bytes) {
    final result = JsonParser.valueAsList<List>(
      CandidUtils.decodeOneTyped(
        bytes,
        CType.vec(CType.opt(CType.vec(CType.null_))),
      ),
    );
    return result
        .map(
          (e) =>
              e == null
                  ? null
                  : (e as List)
                      .map((e) => ICRC7ValueMap.fromCandid(e))
                      .toList(),
        )
        .toList();
  }
}

class ICRC7QueryIcrc7OwnerOf extends ICRC7QueryMessage<List<ICRC7Account?>> {
  final List<BigInt> args;
  const ICRC7QueryIcrc7OwnerOf(this.args);

  @override
  String get methodName => 'icrc7_owner_of';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.vec(CType.nat), args);
  }

  @override
  List<ICRC7Account?> onResponse(List<int> bytes) {
    final result = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(CType.opt(ICRC7Account.ctype)),
    );
    return JsonParser.valueAs<List>(
      result,
    ).map((e) => e == null ? null : ICRC7Account.fromCandid(e)).toList();
  }
}

class ICRC7QueryIcrc7BalanceOf extends ICRC7QueryMessage<List<BigInt>> {
  final List<ICRC7Account> args;
  const ICRC7QueryIcrc7BalanceOf(this.args);

  @override
  String get methodName => 'icrc7_balance_of';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC7Account.ctype),
      args.map((e) => e.candidValue).toList(),
    );
  }

  @override
  List<BigInt> onResponse(List<int> bytes) {
    return JsonParser.valueEnsureAsList<BigInt>(
      CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat)),
    );
  }
}

class ICRC7QueryIcrc7Tokens extends ICRC7QueryMessage<List<BigInt>> {
  final BigInt? arg0;
  final BigInt? arg1;
  const ICRC7QueryIcrc7Tokens({required this.arg0, required this.arg1});

  @override
  String get methodName => 'icrc7_tokens';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.opt(CType.nat), CType.opt(CType.nat)],
      [arg0, arg1],
    );
  }

  @override
  List<BigInt> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat))
        as List<BigInt>;
  }
}

class ICRC7QueryIcrc7TokensOf extends ICRC7QueryMessage<List<BigInt>> {
  final ICRC7Account arg0;
  final BigInt? arg1;
  final BigInt? arg2;
  const ICRC7QueryIcrc7TokensOf({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'icrc7_tokens_of';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [ICRC7Account.ctype, CType.opt(CType.nat), CType.opt(CType.nat)],
      [arg0.candidValue, arg1, arg2],
    );
  }

  @override
  List<BigInt> onResponse(List<int> bytes) {
    return JsonParser.valueEnsureAsList<BigInt>(
      CandidUtils.decodeOneTyped(bytes, CType.vec(CType.nat)),
    );
  }
}
