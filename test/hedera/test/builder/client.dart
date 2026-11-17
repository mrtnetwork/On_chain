import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/api/api.dart';

/// Offline client: no mirror, no node — state key resolution always "missing".
///
/// Use only for signer-detection / builder unit tests.
class FakeHederaClient implements HederaClient {
  FakeHederaClient({
    this.strategy = const HederaClientSterategy(node: null, mirror: null),
    HederaAccountID? nodeAccountID,
  }) : nodeAccountId =
           nodeAccountID ??
           HederaAccountID(
             shardNum: BigInt.zero,
             realmNum: BigInt.zero,
             accountNum: BigInt.from(3),
           );

  @override
  final HederaClientSterategy strategy;

  @override
  final HederaAccountID nodeAccountId;

  Never _offline([String where = 'FakeHederaClient']) {
    throw OnChainErrors.hederaPlugin(
      where,
      reason: 'FakeHederaClient is offline (no chain interaction).',
    );
  }

  @override
  Future<HederaTokenKeysSnapshot> getTokenKeys(HederaTokenID tokenId) =>
      _offline('getTokenKeys');

  @override
  Future<HederaContractKeysSnapshot> getContractKeys(
    HederaAddress contract, {
    HederaContractID? contractId,
  }) => _offline('getContractKeys');

  @override
  Future<HederaTopicKeysSnapshot> getTopicKeys(HederaTopicID topicId) =>
      _offline('getTopicKeys');

  @override
  Future<HederaAccountSnapshot> getAccount(HederaAddress account) =>
      _offline('getAccount');

  // Remaining HederaClient surface — not used by offline detection tests.
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      _offline(invocation.memberName.toString());
}
