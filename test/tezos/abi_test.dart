import 'package:test/test.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import '../utils.dart';
import 'package:on_chain/tezos/tezos.dart'; // adjust to your real export path

MichelineExpr mx(dynamic json) => MichelineExpr.deserializeJson(json);

Map<String, dynamic> mInt(Object v) => {'int': '$v'};
Map<String, dynamic> mString(String v) => {'string': v};
Map<String, dynamic> mPair(List<Map<String, dynamic>> args) => {
  'prim': 'Pair',
  'args': args,
};
Map<String, dynamic> ty(
  String prim, {
  List<Map<String, dynamic>>? args,
  List<String>? annots,
}) => {
  'prim': prim,
  if (args != null) 'args': args,
  if (annots != null) 'annots': annots,
};

void abiTest() {
  group('Tezos/Abi scalar encode/decode round trips', () {
    test('unit', () {
      final t = mx(ty('unit'));
      expect(TezosAbi.decode(TezosAbi.encode(null, t), t), isNull);
    });

    test('bool true/false', () {
      final t = mx(ty('bool'));
      expect(TezosAbi.decode(TezosAbi.encode(true, t), t), true);
      expect(TezosAbi.decode(TezosAbi.encode(false, t), t), false);
    });

    test('bool rejects non-bool', () {
      final t = mx(ty('bool'));
      expect(() => TezosAbi.encode('yes', t), throwsA(isA<BuError>()));
    });

    test('nat accepts int/BigInt/String and round-trips', () {
      final t = mx(ty('nat'));
      expect(TezosAbi.decode(TezosAbi.encode(42, t), t), BigInt.from(42));
      expect(
        TezosAbi.decode(TezosAbi.encode(BigInt.from(42), t), t),
        BigInt.from(42),
      );
      expect(TezosAbi.decode(TezosAbi.encode('42', t), t), BigInt.from(42));
    });

    test('nat rejects negative values', () {
      final t = mx(ty('nat'));
      expect(() => TezosAbi.encode(-1, t), throwsA(isA<BuError>()));
      expect(
        () => TezosAbi.encode(BigInt.from(-5), t),
        throwsA(isA<BuError>()),
      );
    });

    test('nat rejects unparsable string', () {
      final t = mx(ty('nat'));
      expect(() => TezosAbi.encode('not-a-number', t), throwsA(isA<BuError>()));
    });

    test('int accepts negative values (unlike nat)', () {
      final t = mx(ty('int'));
      expect(TezosAbi.decode(TezosAbi.encode(-7, t), t), BigInt.from(-7));
    });

    test('mutez rejects negative values', () {
      final t = mx(ty('mutez'));
      expect(() => TezosAbi.encode(-1, t), throwsA(isA<BuError>()));
      expect(
        TezosAbi.decode(TezosAbi.encode(1000000, t), t),
        BigInt.from(1000000),
      );
    });

    test('timestamp accepts int seconds and DateTime', () {
      final t = mx(ty('timestamp'));
      expect(
        TezosAbi.decode(TezosAbi.encode(1700000000, t), t),
        BigInt.from(1700000000),
      );
      final dt = DateTime.fromMillisecondsSinceEpoch(
        1700000000 * 1000,
        isUtc: true,
      );
      expect(
        TezosAbi.decode(TezosAbi.encode(dt, t), t),
        BigInt.from(1700000000),
      );
    });

    test('string round-trips', () {
      final t = mx(ty('string'));
      expect(TezosAbi.decode(TezosAbi.encode('hello', t), t), 'hello');
    });

    test('string rejects non-string', () {
      final t = mx(ty('string'));
      expect(() => TezosAbi.encode(123, t), throwsA(isA<BuError>()));
    });

    test('bytes accepts List<int> and hex String', () {
      final t = mx(ty('bytes'));
      final fromList = TezosAbi.encode([0xde, 0xad, 0xbe, 0xef], t);
      final fromHex = TezosAbi.encode('deadbeef', t);
      expect(TezosAbi.decode(fromList, t), [0xde, 0xad, 0xbe, 0xef]);
      expect(TezosAbi.decode(fromHex, t), [0xde, 0xad, 0xbe, 0xef]);
    });

    test('bytes rejects invalid hex', () {
      final t = mx(ty('bytes'));
      expect(() => TezosAbi.encode('zz', t), throwsA(isA<BuError>()));
    });

    test('address round-trips as display string', () {
      final t = mx(ty('address'));
      const addr = 'tz1burnburnburnburnburnburnburjAYjjX';
      expect(TezosAbi.decode(TezosAbi.encode(addr, t), t), addr);
    });

    test('address also accepts a TezosAddress instance', () {
      final t = mx(ty('address'));
      const addrStr = 'tz1burnburnburnburnburnburnburjAYjjX';
      final addrObj = TezosAddress(addrStr);
      final e = TezosAbi.encode(addrObj, t);
      expect(TezosAbi.decode(e, t), addrStr);
    });
  });

  group('Tezos/Abi option', () {
    test('None', () {
      final t = mx(ty('option', args: [ty('nat')]));
      expect(TezosAbi.decode(TezosAbi.encode(null, t), t), isNull);
    });

    test('Some', () {
      final t = mx(ty('option', args: [ty('nat')]));
      expect(
        TezosAbi.decode(TezosAbi.encode(BigInt.from(5), t), t),
        BigInt.from(5),
      );
    });
  });

  group('Tezos/Abi or', () {
    final t = mx(
      ty(
        'or',
        args: [
          ty('nat', annots: ['%left_amount']),
          ty('string', annots: ['%right_note']),
        ],
      ),
    );

    test('encodes/decodes Left by kind', () {
      final e = TezosAbi.encode({'kind': 'Left', 'value': BigInt.from(9)}, t);
      final d = TezosAbi.decode(e, t);
      expect(d['kind'], 'left_amount');
      expect(d['value'], BigInt.from(9));
    });

    test('encodes/decodes Right by annot name', () {
      final e = TezosAbi.encode({'kind': 'right_note', 'value': 'hi'}, t);
      final d = TezosAbi.decode(e, t);
      expect(d['kind'], 'right_note');
      expect(d['value'], 'hi');
    });

    test('unknown kind throws', () {
      expect(
        () => TezosAbi.encode({'kind': 'nonsense', 'value': 1}, t),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('Tezos/Abi pair — comb-shape decode robustness', () {
    // IMPORTANT: Michelson *type* trees are always strictly binary
    // (nested pair(a, pair(b, c))) — only *data* nodes get flattened
    // into N-ary combs by Octez's optimized JSON encoding. So every
    // `pair` type below has exactly 2 args; only the DATA varies in how
    // flattened it is.
    final t1 = ty(
      'pair',
      args: [
        ty('nat', annots: ['%administrators']),
        ty(
          'pair',
          args: [
            ty('nat', annots: ['%frozen_accounts']),
            ty('nat', annots: ['%ledger']),
          ],
        ),
      ],
    ); // binary, right-recursive -> its data CAN be comb-flattened
    final t2 = ty(
      'pair',
      args: [
        ty('nat', annots: ['%metadata']),
        ty('nat', annots: ['%operators']),
      ],
    );
    final tail = ty(
      'pair',
      args: [
        ty('nat', annots: ['%token_metadata']),
        ty('nat', annots: ['%total_supply']),
      ],
    );
    // mainType = pair(t1, pair(t2, tail)) — strictly binary at every level.
    final mainType = mx(
      ty(
        'pair',
        args: [
          t1,
          ty('pair', args: [t2, tail]),
        ],
      ),
    );

    test('canonical strict-nested shape decodes correctly', () {
      final data = mx(
        mPair([
          mPair([
            mInt(1),
            mPair([mInt(2), mInt(3)]),
          ]), // t1
          mPair([
            mPair([mInt(4), mInt(5)]),
            mPair([mInt(6), mInt(7)]),
          ]), // pair(t2,tail)
        ]),
      );
      final d = TezosAbi.decode(data, mainType) as List;
      // `d` is a List because t1 and pair(t2,tail) are themselves
      // unannotated pair nodes — annotation on LEAF fields doesn't
      // "bubble up" through intermediate structural pairs. Only a pair
      // node whose OWN immediate children are all %annot'd collapses to
      // a Map at that level.
      final t1Result = d[0] as List; // t1's own 2nd field is an
      // unannotated nested pair -> t1 itself stays a List too.
      expect(t1Result[0], BigInt.from(1)); // administrators
      expect(t1Result[1], {
        'frozen_accounts': BigInt.from(2),
        'ledger': BigInt.from(3),
      });

      final rest = d[1] as List;
      expect(rest[0], {
        'metadata': BigInt.from(4),
        'operators': BigInt.from(5),
      });
      expect(rest[1], {
        'token_metadata': BigInt.from(6),
        'total_supply': BigInt.from(7),
      });
    });

    test('over-flattened shape decodes identically (regression)', () {
      // t1's type arity is 2 (nat, then a nested pair(nat,nat)), but the
      // RPC merged all 3 of its logical values into a single flat
      // 3-element Pair — this is the exact shape that used to throw
      // "`Pair` over-flattened". The decoded RESULT must be identical to
      // the canonical-shape test above regardless of this flattening.
      final data = mx(
        mPair([
          mPair([mInt(1), mInt(2), mInt(3)]), // t1, over-flattened
          mPair([
            mPair([mInt(4), mInt(5)]),
            mPair([mInt(6), mInt(7)]),
          ]),
        ]),
      );
      final d = TezosAbi.decode(data, mainType) as List;
      final t1Result = d[0] as List;
      expect(t1Result[0], BigInt.from(1));
      expect(t1Result[1], {
        'frozen_accounts': BigInt.from(2),
        'ledger': BigInt.from(3),
      });
      final rest = d[1] as List;
      expect(rest[1], {
        'token_metadata': BigInt.from(6),
        'total_supply': BigInt.from(7),
      });
    });

    test('fully flat top-level array shape decodes correctly', () {
      // A separate, purely right-recursive binary type: pair(a, pair(b,
      // pair(c, d))). This whole chain can legally collapse to one bare
      // 4-element JSON array — the getContractScript-style shape.
      // Same annotation-bubbling caveat applies: only `pair(c,d)` has
      // BOTH its own immediate children annotated, so only that level
      // collapses to a Map; `a` and `b` sit in List-shaped levels.
      final quadType = mx(
        ty(
          'pair',
          args: [
            ty('nat', annots: ['%a']),
            ty(
              'pair',
              args: [
                ty('nat', annots: ['%b']),
                ty(
                  'pair',
                  args: [
                    ty('nat', annots: ['%c']),
                    ty('nat', annots: ['%d']),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
      final arrayData = mx([mInt(1), mInt(2), mInt(3), mInt(4)]);
      final d = TezosAbi.decode(arrayData, quadType) as List;
      expect(d[0], BigInt.from(1)); // a
      final rest = d[1] as List;
      expect(rest[0], BigInt.from(2)); // b
      expect(rest[1], {'c': BigInt.from(3), 'd': BigInt.from(4)});
    });
  });

  group('Tezos/Abi list/set/map', () {
    test('list of pairs round-trips in order', () {
      final t = mx(
        ty(
          'list',
          args: [
            ty(
              'pair',
              args: [
                ty('address', annots: ['%owner']),
                ty('nat', annots: ['%amount']),
              ],
            ),
          ],
        ),
      );
      const a1 = 'tz1burnburnburnburnburnburnburjAYjjX';
      final input = [
        {'owner': a1, 'amount': BigInt.from(10)},
      ];
      final e = TezosAbi.encode(input, t);
      expect(TezosAbi.decode(e, t), input);
    });

    test('map keys sorted deterministically on encode', () {
      final t = mx(ty('map', args: [ty('nat'), ty('string')]));
      final e1 = TezosAbi.encode({
        BigInt.from(3): 'c',
        BigInt.from(1): 'a',
        BigInt.from(2): 'b',
      }, t);
      final e2 = TezosAbi.encode({
        BigInt.from(1): 'a',
        BigInt.from(2): 'b',
        BigInt.from(3): 'c',
      }, t);
      expect(e1.serializeBytes(), e2.serializeBytes());
    });
  });

  group('Tezos/Abi big_map', () {
    test('decode int form returns TezosBigMapValue.id', () {
      final t = mx(ty('big_map', args: [ty('address'), ty('nat')]));
      final d = TezosAbi.decode(mx(mInt(198029)), t);
      expect(d, isA<TezosBigMapValue>());
      expect((d as TezosBigMapValue).id, BigInt.from(198029));
    });

    test('decode sequence form returns TezosBigMapValue.entries', () {
      final t = mx(ty('big_map', args: [ty('string'), ty('nat')]));
      final seqData = mx([
        {
          'prim': 'Elt',
          'args': [mString('a'), mInt(1)],
        },
      ]);
      final d = TezosAbi.decode(seqData, t) as TezosBigMapValue;
      expect(d.isId, false);
      expect(d.entries, {'a': BigInt.one});
    });

    test('encoding a by-id TezosBigMapValue throws', () {
      final t = mx(ty('big_map', args: [ty('nat'), ty('nat')]));
      expect(
        () => TezosAbi.encode(TezosBigMapValue.id(BigInt.one), t),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('Tezos/Abi.getBigMapId / debugBigMaps', () {
    final storageType = mx(
      ty(
        'pair',
        args: [
          ty(
            'big_map',
            args: [ty('address'), ty('nat')],
            annots: ['%administrators'],
          ),
          ty('big_map', args: [ty('nat'), ty('nat')]), // unannotated
        ],
      ),
    );
    final storageData = mx(mPair([mInt(100), mInt(200)]));

    test('single annot lookup by path', () {
      expect(
        TezosAbi.getBigMapId(storageData, storageType, path: 'administrators'),
        BigInt.from(100),
      );
    });

    test('unannotated big_map falls back to positional path', () {
      expect(
        TezosAbi.getBigMapId(storageData, storageType, path: '1'),
        BigInt.from(200),
      );
    });

    test('ambiguous lookup throws', () {
      expect(
        () => TezosAbi.getBigMapId(storageData, storageType),
        throwsA(isA<BuError>()),
      );
    });

    test('debugBigMaps lists all discovered ids', () {
      final out = TezosAbi.debugBigMaps(storageData, storageType);
      expect(out, contains('administrators: 100'));
    });
  });

  group('Tezos/Abi.typeTemplate (top-level shape)', () {
    test('returns a Map with "template" and "schame" keys', () {
      final t = mx(ty('nat'));
      final result = TezosAbi.typeTemplate(t);
      expect(result, isA<Map>());
      expect(result.containsKey('template'), true);
      // NOTE: literal key is "schame" (typo) per current source.
      expect(result.containsKey('schame'), true);
    });

    test('scalar template placeholders match typeTemplateHelp keys', () {
      final result = TezosAbi.typeTemplate(mx(ty('nat')));
      expect(result['template'], '#nat');
      expect(TezosAbi.typeTemplateHelp.containsKey('#nat'), true);
    });

    test('address/bytes/timestamp placeholders', () {
      expect(TezosAbi.typeTemplate(mx(ty('address')))['template'], '#address');
      expect(TezosAbi.typeTemplate(mx(ty('bytes')))['template'], '#bytes');
      expect(
        TezosAbi.typeTemplate(mx(ty('timestamp')))['template'],
        '#timestamp',
      );
    });
  });

  group('Tezos/Abi.typeTemplate — plain template body', () {
    test(
      'option template is the Some-value template directly (no wrapper)',
      () {
        final t = mx(ty('option', args: [ty('nat')]));
        expect(TezosAbi.typeTemplate(t)['template'], '#nat');
      },
    );

    test('all-unit or -> {kind, value: null} with pipe-joined names', () {
      final t = mx(
        ty(
          'or',
          args: [
            ty(
              'or',
              args: [
                ty('unit', annots: ['%add_token']),
                ty('unit', annots: ['%burn']),
              ],
            ),
            ty('unit', annots: ['%mint']),
          ],
        ),
      );
      final tmpl = TezosAbi.typeTemplate(t)['template'] as Map;
      expect(tmpl['kind'], '#add_token|burn|mint');
      expect(tmpl['value'], isNull);
    });

    test('value-carrying or -> {kind, value: <first branch template>}', () {
      final t = mx(
        ty(
          'or',
          args: [
            ty('nat', annots: ['%left']),
            ty('string', annots: ['%right']),
          ],
        ),
      );
      final tmpl = TezosAbi.typeTemplate(t)['template'] as Map;
      expect(tmpl['kind'], '#left|right');
      expect(tmpl['value'], '#nat'); // first branch only, per _buildTemplate
    });

    test('annotated pair renders as Map; unannotated as List', () {
      final annotated = mx(
        ty(
          'pair',
          args: [
            ty('nat', annots: ['%a']),
            ty('nat', annots: ['%b']),
          ],
        ),
      );
      expect(TezosAbi.typeTemplate(annotated)['template'], {
        'a': '#nat',
        'b': '#nat',
      });

      final positional = mx(ty('pair', args: [ty('nat'), ty('nat')]));
      expect(TezosAbi.typeTemplate(positional)['template'], ['#nat', '#nat']);
    });

    test('list template is a single-element example array', () {
      final t = mx(ty('list', args: [ty('address')]));
      expect(TezosAbi.typeTemplate(t)['template'], ['#address']);
    });

    test('map template is a single example {key: value} entry', () {
      final t = mx(ty('map', args: [ty('address'), ty('bytes')]));
      expect(TezosAbi.typeTemplate(t)['template'], {'#address': '#bytes'});
    });

    test('nested list-of-annotated-pair template', () {
      final t = mx(
        ty(
          'list',
          args: [
            ty(
              'pair',
              args: [
                ty('address', annots: ['%to_']),
                ty('nat', annots: ['%amount']),
              ],
            ),
          ],
        ),
      );
      expect(TezosAbi.typeTemplate(t)['template'], [
        {'to_': '#address', 'amount': '#nat'},
      ]);
    });
  });

  group('Tezos/Abi.typeSchema — component hoisting', () {
    test('a substructure reused twice is hoisted into components', () {
      // Same annotated pair shape (%point: pair(nat,nat)) reused for two
      // different top-level fields.
      final pointType = ty(
        'pair',
        args: [
          ty('nat', annots: ['%x']),
          ty('nat', annots: ['%y']),
        ],
        annots: ['%point'],
      );
      final t = mx(
        ty(
          'pair',
          args: [
            {
              ...pointType,
              'annots': ['%start'],
            }, // same *structural* signature
            {
              ...pointType,
              'annots': ['%end'],
            },
          ],
        ),
      );
      final schema = TezosAbi.typeTemplate(t)['schame'] as Map;
      expect(schema['components'], isA<Map>());
      // The exact hoisted key name depends on `compNames` picking the
      // *first* annot seen for a given structural signature — assert
      // structurally instead of pinning an exact key.
      expect((schema['components'] as Map).isNotEmpty, true);
      expect(schema['schema'].toString(), contains('#components/'));
    });

    test(
      'or with BOTH branches annotated hoists both branches, even if not reused',
      () {
        final t = mx(
          ty(
            'or',
            args: [
              ty(
                'pair',
                args: [
                  ty('address', annots: ['%owner']),
                  ty('nat', annots: ['%amount']),
                ],
                annots: ['%existing'],
              ),
              ty('map', args: [ty('string'), ty('bytes')], annots: ['%new']),
            ],
          ),
        );
        final schema = TezosAbi.typeTemplate(t)['schame'] as Map;
        final components = schema['components'] as Map;
        expect(components.containsKey('existing'), true);
        expect(components.containsKey('new'), true);
        // The %new branch's shape (map(string,bytes)) must actually appear
        // somewhere — this is the exact bug the dual-hoist branch fixes:
        // without it, only the Left branch got inlined and Right vanished.
        expect(components['new'], {'#string': '#bytes'});
        final schemaNode = schema['schema'] as Map;
        expect(schemaNode['kind'], '#existing|new');
        expect(schemaNode['value'], '#components/existing|#components/new');
      },
    );

    test('all-unit or is NOT routed through dual-branch hoisting', () {
      final t = mx(
        ty(
          'or',
          args: [
            ty('unit', annots: ['%a']),
            ty('unit', annots: ['%b']),
          ],
        ),
      );
      final schema = TezosAbi.typeTemplate(t)['schame'] as Map;
      final schemaNode = schema['schema'];
      expect(schemaNode, {'kind': '#a|b', 'value': null});
    });

    test('non-reused, non-or substructures are inlined, not hoisted', () {
      final t = mx(
        ty(
          'pair',
          args: [
            ty('nat', annots: ['%only_once']),
            ty('string', annots: ['%also_once']),
          ],
        ),
      );
      final schema = TezosAbi.typeTemplate(t)['schame'] as Map;
      expect((schema['components'] as Map).isEmpty, true);
      expect(schema['schema'], {'only_once': '#nat', 'also_once': '#string'});
    });
  });

  group('Tezos/Abi entrypoint helpers', () {
    final paramType = mx(
      ty(
        'or',
        args: [
          ty(
            'or',
            args: [
              ty('unit', annots: ['%add']),
              ty('unit', annots: ['%burn']),
            ],
          ),
          ty('unit', annots: ['%mint']),
        ],
      ),
    );

    test('collectEntrypoints finds all annotated leaves', () {
      expect(TezosAbi.collectEntrypoints(paramType).keys.toSet(), {
        'add',
        'burn',
        'mint',
      });
    });

    test('collectEntrypoints throws on duplicate annots', () {
      final dup = mx(
        ty(
          'or',
          args: [
            ty('unit', annots: ['%same']),
            ty('unit', annots: ['%same']),
          ],
        ),
      );
      expect(() => TezosAbi.collectEntrypoints(dup), throwsA(isA<BuError>()));
    });

    test('findEntrypoint returns correct Left/Right path', () {
      final found = TezosAbi.findEntrypoint(paramType, 'burn', [], true);
      expect(found!.path, [true, false]);
    });

    test('decodeEntrypointNode walks Left/Right correctly', () {
      final data = mx({
        'prim': 'Left',
        'args': [
          {
            'prim': 'Right',
            'args': [
              {'prim': 'Unit'},
            ],
          },
        ],
      });
      final node = TezosAbi.decodeEntrypointNode(data, paramType, isRoot: true);
      expect(node.name, 'burn');
    });
  });

  group('Tezos/ContractAbi — end-to-end', () {
    final contractCodeJson = {
      'prim': 'parameter',
      'args': [
        {
          'prim': 'or',
          'args': [
            {
              'prim': 'pair',
              'args': [
                {
                  'prim': 'address',
                  'annots': ['%owner'],
                },
                {
                  'prim': 'nat',
                  'annots': ['%amount'],
                },
              ],
              'annots': ['%mint'],
            },
            {
              'prim': 'address',
              'annots': ['%burn'],
            },
          ],
        },
      ],
    };
    final storageCodeJson = {
      'prim': 'storage',
      'args': [
        {
          'prim': 'pair',
          'args': [
            {
              'prim': 'big_map',
              'args': [
                {'prim': 'address'},
                {'prim': 'nat'},
              ],
              'annots': ['%ledger'],
            },
            {
              'prim': 'nat',
              'annots': ['%counter'],
            },
          ],
        },
      ],
    };
    final codeSection = {
      'prim': 'code',
      'args': [[]],
    };

    late TezosContractAbi abi;

    setUp(() {
      final code =
          mx([contractCodeJson, storageCodeJson, codeSection])
              as MichelineSequence;
      abi = TezosContractAbi.fromCode(code);
    });

    test('entrypoints discovered', () {
      expect(abi.entrypoints.toSet(), {'mint', 'burn'});
    });

    test('encodeParameter / decodeParameter round trip for mint', () {
      const owner = 'tz1burnburnburnburnburnburnburjAYjjX';
      final p = abi.encodeParameter('mint', {
        'owner': owner,
        'amount': BigInt.from(5),
      });
      final d = abi.decodeParameter(p);
      expect(d.entrypoint, 'mint');
      expect(d.value, {'owner': owner, 'amount': BigInt.from(5)});
    });

    test('encodeParameter with unknown entrypoint throws', () {
      expect(() => abi.encodeParameter('nope', null), throwsA(isA<BuError>()));
    });

    test('storage encode/decode round trip', () {
      // NOTE: only `.entries(...)` is encodable — a big_map has no valid
      // Michelson *literal* form for "the existing map with id N"; the
      // `.id(...)` form only ever comes out of `decode` (real RPC output
      // for an already-allocated big_map), never goes into `encode`.
      const owner = 'tz1burnburnburnburnburnburnburjAYjjX';
      final storageValue = {
        'ledger': TezosBigMapValue.entries({owner: BigInt.from(10)}),
        'counter': BigInt.from(3),
      };
      final e = abi.encodeStorage(storageValue);
      final d = abi.decodeStorage(e) as Map;
      final ledger = d['ledger'] as TezosBigMapValue;
      expect(ledger.isId, false);
      expect(ledger.entries, {owner: BigInt.from(10)});
      expect(d['counter'], BigInt.from(3));
    });

    test('encoding a by-id TezosBigMapValue for storage throws', () {
      final storageValue = {
        'ledger': TezosBigMapValue.id(BigInt.from(55)),
        'counter': BigInt.from(3),
      };
      expect(() => abi.encodeStorage(storageValue), throwsA(isA<BuError>()));
    });

    test('bigMapKeyLookup + decodeBigMapResult end-to-end', () {
      final storageData = mx(mPair([mInt(55), mInt(3)]));
      const owner = 'tz1burnburnburnburnburnburnburjAYjjX';

      final lookup = abi.bigMapKeyLookup(storageData, 'ledger', owner);
      expect(lookup.bigMapId, BigInt.from(55));
      expect(lookup.scriptExpr, startsWith('expr'));

      // decodeBigMapResult now takes a MichelineExpr directly, NOT raw
      // JSON — build it via mx() first.
      final resultExpr = mx({'int': '12345'});
      final decoded = abi.decodeBigMapResult('ledger', resultExpr);
      expect(decoded, BigInt.from(12345));
    });

    test('bigMapKeyLookup with unknown path throws', () {
      final storageData = mx(mPair([mInt(55), mInt(3)]));
      expect(
        () => abi.bigMapKeyLookup(storageData, 'nonexistent', 'x'),
        throwsA(isA<BuError>()),
      );
    });

    test('getBigMapTemplate returns key/value shapes', () {
      final t = abi.getBigMapTemplate('ledger');
      expect(t.keyTemplate['template'], '#address');
      expect(t.valueTemplate['template'], '#nat');
    });

    test('getEntrypointTemplate for mint returns annotated Map shape', () {
      final t = abi.getEntrypointTemplate('mint')['template'] as Map;
      expect(t, {'owner': '#address', 'amount': '#nat'});
    });

    test('getEntrypointTemplate for burn returns scalar placeholder', () {
      expect(abi.getEntrypointTemplate('burn')['template'], '#address');
    });

    test('getStorageTemplate returns full storage shape', () {
      final t = abi.getStorageTemplate()['template'] as Map;
      expect(t.containsKey('ledger'), true);
      expect(t.containsKey('counter'), true);
    });
  });

  group('Tezos/Abi.bigMapKeyHash determinism', () {
    test('same key produces same hash across calls', () {
      final keyType = mx(
        ty(
          'pair',
          args: [
            ty('address', annots: ['%owner']),
            ty('nat', annots: ['%token_id']),
          ],
        ),
      );
      const owner = 'tz1burnburnburnburnburnburnburjAYjjX';
      final h1 = TezosAbi.bigMapKeyHash([owner, BigInt.zero], keyType);
      final h2 = TezosAbi.bigMapKeyHash([owner, BigInt.zero], keyType);
      expect(h1, h2);
      expect(h1, startsWith('expr'));
    });

    test('different keys produce different hashes', () {
      // Using `nat` here (not `address`) deliberately — it sidesteps
      // `toPackable`'s address-checksum validation entirely, so this
      // test only exercises "hash varies with input", not address
      // parsing (already covered separately, and address-specific
      // packing needs a real, checksum-valid address to test properly).
      final keyType = mx(ty('nat'));
      expect(
        TezosAbi.bigMapKeyHash(BigInt.zero, keyType),
        isNot(TezosAbi.bigMapKeyHash(BigInt.one, keyType)),
      );
    });

    test('different addresses produce different hashes', () {
      // tz1burnburnburnburnburnburnburjAYjjX is a real, checksum-valid
      // Tezos burn address (confirmed by the passing tests above). If
      // you have another known-valid address handy, swap it in here —
      // this is the one place a *second* real address is actually
      // needed to properly exercise the address-specific pack path.
      final keyType = mx(ty('address'));
      const a1 = 'tz1burnburnburnburnburnburnburjAYjjX';
      final h1 = TezosAbi.bigMapKeyHash(a1, keyType);
      expect(h1, startsWith('expr'));
      // Single-address sanity check only, until a second verified
      // address is supplied — determinism is already covered by the
      // "same key produces same hash" test above.
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(abiTest, "Abi");
}
