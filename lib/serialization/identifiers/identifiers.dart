import 'package:blockchain_utils/blockchain_utils.dart';

enum OnChainSerializationIdentifiers implements SerializationIdentifier {
  adaPluginError(15001),
  aptosPluginError(15002),
  ethereumPluginError(15003),
  eip4361Error(15004),
  bcsError(15005),
  solanaPlugin(15006),
  solidityAbiError(15007),
  suiPluginError(15008),
  tronPluginError(15009),
  ethereumRpcEvent(15010),
  ethereumRpcSubscribtionParams(15011),
  ethereumRpcLogSubscribtionParams(15012),
  ethereumRpcLogsFilter(15013),
  ethereumRpcHeadSubscribtionParams(15014),
  ethereumRpcPendingTxSubscribtionParams(15015),
  ethereumRpcSyncingSubscribtionParams(15016),
  ethereumRpcGenericSubscribtionParams(15017),
  nearPluginError(15018),
  algorandPluginError(15019),
  algorandAbiError(15020),
  algorandTxBuilderError(15021),
  hederaAccountId(15022),
  hederaPluginError(15023),
  hederaAddressError(15024),
  hederaTxBuilderError(15025),

  icpPluginError(15026),
  icpAddressError(15027),
  icpCandidError(15028),
  icpClientError(15029),

  filPluginError(15030),
  filAddressError(15031),

  tezosPluginError(15032),
  tezosAddressError(15033),
  tezosMichelineError(15034),
  tezosApiError(15035),
  tezosMetadataError(15036),
  tezosViewError(15037);

  @override
  final int id;
  const OnChainSerializationIdentifiers(this.id);

  static OnChainSerializationIdentifiers fromIdentifier(int? value) {
    return values.firstWhere(
      (e) => e.id == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching OnChainSerializationIdentifiers found for the given value. null",
              ),
    );
  }

  @override
  bool isValid(int? tag) {
    return tag == id;
  }
}
