import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class TreasuryWithdrawals with ADASerialization {
  final Map<ADARewardAddress, BigInt> withdrawals;
  TreasuryWithdrawals(Map<ADARewardAddress, BigInt> withdrawals)
      : withdrawals = withdrawals.immutable;
  factory TreasuryWithdrawals.deserialize(CborMapValue cbor) {
    return TreasuryWithdrawals({
      for (final i in cbor.valueAsMap<CborBytesValue, CborObject>().entries)
        ADAAddress.deserialize(i.key): i.value.as<CborNumeric>().toBigInt()
    });
  }
  factory TreasuryWithdrawals.fromJson(Map<String, dynamic> json) {
    return TreasuryWithdrawals({
      for (final i in json.entries)
        ADARewardAddress(i.key): BigintUtils.parse(i.value)
    });
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final i in withdrawals.entries)
        i.key.toCbor(): CborSafeIntValue(i.value)
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      for (final i in withdrawals.entries) i.key.address: i.value.toString()
    };
  }
}
