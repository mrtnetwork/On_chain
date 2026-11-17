import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/models.dart';

export 'ada_fee_parameters.dart';

/// Signs all the signers of a transaction with a single call.
///
/// The callback receives the hash of the body of the transaction and the list
/// of the addresses that have to sign it, and it returns the witnesses of
/// every address keyed by the address itself.
///
/// An address that is not in the returned map (or that has an empty list of
/// witnesses) is considered as "not signed" and the builder throws an
/// exception when a required signature is missing.
typedef ADATransactionSigner =
    Map<ADAAddress, List<ADABaseTransactionWitness>> Function({
      required BuBytes digest,
      required List<ADAAddress> addresses,
    });

/// Asynchronous version of [ADATransactionSigner].
typedef ADATransactionSignerAsync =
    Future<Map<ADAAddress, List<ADABaseTransactionWitness>>> Function({
      required BuBytes digest,
      required List<ADAAddress> addresses,
    });
