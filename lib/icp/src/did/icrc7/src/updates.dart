// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `ICRC7`.
abstract class ICRC7UpdateMessage<RESULT> extends IICPUpdateMessage<RESULT> {
  const ICRC7UpdateMessage();
}

class ICRC7UpdateIcrc7Transfer
    extends ICRC7UpdateMessage<List<ICRC7TransferResult?>> {
  final List<ICRC7TransferArg> args;
  const ICRC7UpdateIcrc7Transfer(this.args);

  @override
  String get methodName => 'icrc7_transfer';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(
      CType.vec(ICRC7TransferArg.ctype),
      args.map((e) => e.candidValue).toList(),
    );
  }

  @override
  List<ICRC7TransferResult?> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(
          bytes,
          CType.vec(CType.opt(ICRC7TransferResult.ctype)),
        )
        as List<ICRC7TransferResult?>;
  }
}
