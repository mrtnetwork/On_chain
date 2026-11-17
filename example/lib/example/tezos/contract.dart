/// Counter contract lifecycle on Shadownet (originate, increment/decrement).
library;

import 'package:on_chain/on_chain.dart';

import 'keys.dart';

/// Michelson:
///
///   parameter (or (unit %increment) (unit %decrement)) ;
///   storage int ;
///   code { UNPAIR ;
///          IF_LEFT
///            { DROP ; PUSH int 1 ; ADD }
///            { DROP ; PUSH int 1 ; SWAP ; SUB } ;
///          NIL operation ;
///          PAIR }
final List<Map<String, dynamic>> counterCode = [
  {
    'prim': 'parameter',
    'args': [
      {
        'prim': 'or',
        'args': [
          {
            'prim': 'unit',
            'annots': ['%increment']
          },
          {
            'prim': 'unit',
            'annots': ['%decrement']
          },
        ],
      },
    ],
  },
  {
    'prim': 'storage',
    'args': [
      {'prim': 'int'},
    ]
  },
  {
    'prim': 'code',
    'args': [
      [
        {'prim': 'UNPAIR'},
        {
          'prim': 'IF_LEFT',
          'args': [
            [
              {'prim': 'DROP'},
              {
                'prim': 'PUSH',
                'args': [
                  {'prim': 'int'},
                  {'int': '1'},
                ]
              },
              {'prim': 'ADD'},
            ],
            [
              {'prim': 'DROP'},
              {
                'prim': 'PUSH',
                'args': [
                  {'prim': 'int'},
                  {'int': '1'},
                ]
              },
              {'prim': 'SWAP'},
              {'prim': 'SUB'},
            ],
          ],
        },
        {
          'prim': 'NIL',
          'args': [
            {'prim': 'operation'},
          ]
        },
        {'prim': 'PAIR'},
      ],
    ],
  },
];

Future<void> main() async {
  final client = createClient();
  final admin = exampleAccounts[0]; // tz1

  final code = MichelineExpr.deserializeJson(counterCode);
  final abi = TezosContractAbi.fromCode(code);
  final script = abi.originationScript(BigInt.zero);

  print('== originate counter ==');
  final originated = await client.originate(
    source: admin.source,
    script: script,
  );
  final counter = originated.result;
  if (counter == null) {
    print('originate failed: ${originated.toJson()}');
    return;
  }
  print('counter: ${counter.address}');
  print(explorerContract(counter));
  print('originate tx: ${originated.injected.operationHash}');
  print('storage: ${await _storage(client, counter)}');

  for (final entry in ['increment', 'decrement']) {
    print('\n== $entry ==');
    final result = await client.callContract(
      source: admin.source,
      contract: counter,
      parameters: abi.encodeTxParameter(entry, null),
    );
    print('tx: ${result.injected.operationHash} '
        'status=${result.confirmation.status.name}');
    print(explorerOp(result.injected.operationHash));
    if (result.isApplied) {
      print('storage: ${await _storage(client, counter)}');
    } else {
      print('  result: ${result.toJson()}');
    }
  }
  print('\ndone.');
}

Future<String> _storage(
    DefaultTezosClient client, TezosAddress contract) async {
  final expr = await client.getContractStorage(contract);
  return switch (expr) {
    MichelineInt(value: final value) => '$value',
    _ => expr.toString(),
  };
}
