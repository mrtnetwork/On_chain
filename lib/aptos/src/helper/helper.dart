import 'package:blockchain_utils/utils/numbers/rational/big_rational.dart';

import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/transaction/constants/const.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/serialization/bcs/move/types/types.dart';

/// A utility class that provides helper functions for working with Aptos-related operations.
class AptosHelper {
  // The decimal precision for Aptos values, commonly 8 decimals
  static const int decimal = 8;

  // A constant BigRational representing the scaling factor for Aptos (10^8)
  static final _decimal = BigRational(BigInt.from(10).pow(decimal));

  /// Converts a string representing an Aptos amount to a BigInt in the smallest unit.
  /// This method multiplies the value by the scaling factor (10^8) to handle decimal precision.
  static BigInt toApt(String aptos) {
    try {
      final parse = BigRational.parseDecimal(aptos);
      return (parse * _decimal).toBigInt();
    } catch (e) {
      throw DartAptosPluginException("Invalid aptos amount provided.",
          details: {"amount": aptos});
    }
  }

  /// Converts a BigInt value representing an Aptos amount in the smallest unit
  /// back to a string with the standard decimal precision (8 decimal places).
  static String toAptos(BigInt apt) {
    final price = BigRational(apt);
    return (price / _decimal).toDecimal(digits: decimal);
  }

  /// Creates an Aptos transaction entry for transferring coins to another account.
  /// It sets up the required module, function, and arguments for the transaction.
  static AptosTransactionEntryFunction createCoinTransferEntry(
      AptosTransferParams transfer) {
    return AptosTransactionEntryFunction(
        moduleId: AptosConstants.systemFrameworkCoinModuleId,
        functionName: AptosConstants.transferFunctionName,
        typeArgs: [
          AptosConstants.aptosCoinTypeStructArgs,
        ],
        args: [
          transfer.destination,
          MoveU64(transfer.apt)
        ]);
  }

  /// Creates an Aptos transaction entry for transferring coins to an account.
  static AptosTransactionEntryFunction createAccountTransferEntry(
      AptosTransferParams transfer) {
    return AptosTransactionEntryFunction(
        moduleId: AptosConstants.systemFrameworkAccountModuleId,
        functionName: AptosConstants.transferFunctionName,
        args: [transfer.destination, MoveU64(transfer.apt)]);
  }

  /// Creates an Aptos transaction entry for transferring coins in bulk.
  /// This allows multiple transfers to different addresses in one transaction.
  static AptosTransactionEntryFunction createBatchTransferTransferEntry(
      List<AptosTransferParams> transfers) {
    return AptosTransactionEntryFunction(
        moduleId: AptosConstants.systemFrameworkAccountModuleId,
        functionName: AptosConstants.batchTransferFunctionName,
        typeArgs: [],
        args: [
          MoveVector<MoveAddress>(transfers.map((e) => e.destination).toList()),
          MoveVector.u64(transfers.map((e) => e.apt).toList())
        ]);
  }
}
