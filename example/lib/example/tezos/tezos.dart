/// Tezos Shadownet examples (transfers, FA1.2 token, counter contract).
library;

import 'package:blockchain_utils/blockchain_utils.dart';

import 'keys.dart';

Future<void> main() async {
  final client = createClient();
  print('Tezos Shadownet | ${await client.getChainId()}');
  for (final account in exampleAccounts) {
    final balance = await client.getBalance(account.address);
    print('${account.name} ${account.address.address} '
        '${AmountConverter.xtz.toAmount(balance)} tez');
  }

  final oneTez = AmountConverter.xtz.toUnit('1');
  for (var i = 0; i < exampleAccounts.length; i++) {
    final from = exampleAccounts[i];
    final to = exampleAccounts[(i + 1) % exampleAccounts.length];
    print('\n== ${from.name} -> ${to.name} (1 tez) ==');
    final result = await client.transfer(
      source: from.source,
      destination: to.address,
      amount: oneTez,
    );
    print('tx: ${result.injected.operationHash} '
        'status=${result.confirmation.status.name} '
        'applied=${result.isApplied}');
    print(explorerOp(result.injected.operationHash));
    if (!result.isApplied) {
      print('  result: ${result.toJson()}');
      continue;
    }
    final balance = await client.getBalance(to.address);
    print('  ${to.name} balance: ${AmountConverter.xtz.toAmount(balance)} tez');
  }
  print('\ndone.');
}