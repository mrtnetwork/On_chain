import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/builder/src/signer.dart';

abstract class AlgoAccountPublicKey {
  AlgoAddress toAddress();
}

abstract class AlgoAccount<PA extends AlgoAccountPublicKey>
    implements AlgoTransactionSigner {
  PA toPublicAccount();
}
