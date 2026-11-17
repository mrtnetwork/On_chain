/// FA1.2 token lifecycle on Shadownet (originate, mint, transfer, balances).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'fa12_contract.dart';
import 'keys.dart';

Future<void> main() async {
  final client = createClient();
  final admin = exampleAccounts[0]; // tz1
  final recipient = exampleAccounts[1]; // tz2
  final other = exampleAccounts[2]; // tz3

  final abi = TezosContractAbi.fromCode(
    MichelineExpr.deserializeJson(smartpyF12ExampleCode),
  );

  print('== originate FA1.2 ==');
  final script = abi.originationScript([
    admin.address,
    [
      {},
      [
        {},
        [
          false,
          {'token_metadata': {}, 'total_supply': BigInt.from(10000000000000)},
        ],
      ],
    ],
  ]);
  final originated = await client.originate(source: admin.source, script: script);
  final token = originated.result;
  if (token == null) {
    print('originate failed: ${originated.toJson()}');
    return;
  }
  print('token: ${token.address}');
  print(explorerContract(token));
  print('originate tx: ${originated.injected.operationHash}');

  final mintAmount = AmountConverter.xtz.toUnit('1000');
  final mint = await client.callContract(
    source: admin.source,
    contract: token,
    parameters: abi.encodeTxParameter('mint', [
      recipient.address.address,
      mintAmount,
    ]),
  );
  print('mint tx: ${mint.injected.operationHash} '
      'status=${mint.confirmation.status.name}');
  print(explorerOp(mint.injected.operationHash));

  final transferAmount = AmountConverter.xtz.toUnit('250');
  final transfer = await client.callContract(
    source: recipient.source,
    contract: token,
    parameters: abi.encodeTxParameter('transfer', [
      recipient.address.address,
      {'to': other.address.address, 'value': transferAmount},
    ]),
  );
  print('transfer tx: ${transfer.injected.operationHash} '
      'status=${transfer.confirmation.status.name}');
  print(explorerOp(transfer.injected.operationHash));

  final recipientBalance = await client.getFa12Balance(
    contract: token,
    owner: recipient.address,
  );
  final otherBalance = await client.getFa12Balance(
    contract: token,
    owner: other.address,
  );
  print('${recipient.name} token balance: $recipientBalance');
  print('${other.name} token balance: $otherBalance');
  print('done.');
}