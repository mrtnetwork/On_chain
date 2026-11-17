// Mirror-node model parsing checks (Hedera).
//
// Fixture-first: real mainnet payloads frozen under `test_vectors/`.
// Each case parses the fixture, asserts load-bearing fields, re-serializes
// and fails on any dropped JSON key (catches generator drift where a
// `fromJson` ignores a wire field or a `toJson` omits one).
//
// Fixtures: `mirror_{nodes,blocks,exchangerate,account_0_0_2}.json`
// captured from https://mainnet.mirrornode.hedera.com.

@TestOn('vm')
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/hedera.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

Map<String, dynamic> _fixture(String name) {
  final file = File('test/hedera/test/test_vectors/mirror_$name.json');
  return StringUtils.toJson<Map<String, dynamic>>(file.readAsStringSync());
}

/// Parse -> serialize -> every input key must survive the round trip.
void _roundTrip<T>(
  String label,
  Map<String, dynamic> raw,
  T Function(Map<String, dynamic>) parse,
  Map<String, dynamic> Function(T) serialize,
) {
  final parsed = parse(raw);
  final out = serialize(parsed);
  final missing = raw.keys.where((k) => !out.containsKey(k)).toList();
  expect(missing, isEmpty, reason: '$label dropped keys: $missing');
  parse(out);
}

void mirrorParsingTest() {
  group('Hedera/Mirror fixtures (needs dart:io)', () {
    test('network nodes fixture parses (nullable grpc_proxy_endpoint)', () {
      final raw = _fixture('nodes');
      final nodes = HederaMirrorTypesNetworkNodesResponse.fromJson(raw);
      expect(nodes.nodes, hasLength(2));
      final first = nodes.nodes.first;
      expect(first.nodeId, greaterThanOrEqualTo(BigInt.zero));
      expect(first.serviceEndpoints, isNotEmpty);
      // Mainnet omits the proxy endpoint: must parse as null, not throw.
      expect(first.grpcProxyEndpoint, isNull);
      _roundTrip(
        'nodes',
        raw,
        HederaMirrorTypesNetworkNodesResponse.fromJson,
        (v) => v.toJson(),
      );
    });

    test('blocks fixture parses', () {
      final raw = _fixture('blocks');
      final blocks = HederaMirrorTypesBlocksResponse.fromJson(raw);
      expect(blocks.blocks, hasLength(2));
      expect(blocks.blocks!.first.number, greaterThan(0));
      _roundTrip(
        'blocks',
        raw,
        HederaMirrorTypesBlocksResponse.fromJson,
        (v) => v.toJson(),
      );
    });

    test('exchange rate fixture parses', () {
      final raw = _fixture('exchangerate');
      final rates = HederaMirrorTypesNetworkExchangeRateSetResponse.fromJson(
        raw,
      );
      expect(rates.currentRate?.hbarEquivalent, greaterThan(0));
      expect(rates.currentRate?.centEquivalent, greaterThan(0));
      _roundTrip(
        'exchangerate',
        raw,
        HederaMirrorTypesNetworkExchangeRateSetResponse.fromJson,
        (v) => v.toJson(),
      );
    });

    test('account info fixture parses (0.0.2)', () {
      final raw = _fixture('account_0_0_2');
      final info = HederaMirrorTypesAccountInfo.fromJson(raw);
      expect(info.account, equals('0.0.2'));
      expect(info.balance?.balance, greaterThanOrEqualTo(BigInt.zero));
      _roundTrip(
        'account',
        raw,
        HederaMirrorTypesAccountInfo.fromJson,
        (v) => v.toJson(),
      );
    });

    test('merged order enum round-trips both values', () {
      expect(
        HederaMirrorTypesOrder.fromJson('asc'),
        HederaMirrorTypesOrder.asc,
      );
      expect(
        HederaMirrorTypesOrder.fromJson('desc'),
        HederaMirrorTypesOrder.desc,
      );
      expect(HederaMirrorTypesOrder.asc.toJson(), 'asc');
      expect(
        () => HederaMirrorTypesOrder.fromJson('sideways'),
        throwsA(isA<BuError>()),
      );
    });

    test('merged contract-action entity enum round-trips', () {
      expect(
        HederaMirrorTypesContractActionCallerType.fromJson('ACCOUNT'),
        HederaMirrorTypesContractActionCallerType.aCCOUNT,
      );
      expect(
        HederaMirrorTypesContractActionCallerType.fromJson('CONTRACT'),
        HederaMirrorTypesContractActionCallerType.cONTRACT,
      );
      expect(
        () => HederaMirrorTypesContractActionCallerType.fromJson('EOA'),
        throwsA(isA<BuError>()),
      );
    });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(mirrorParsingTest, 'MirrorParsing');
}
