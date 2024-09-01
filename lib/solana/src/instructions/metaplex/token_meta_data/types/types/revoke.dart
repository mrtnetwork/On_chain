import 'package:on_chain/solana/src/exception/exception.dart';

class Revoke {
  final String name;
  final int value;
  const Revoke._(this.name, this.value);
  static const Revoke collectionV1 = Revoke._("CollectionV1", 0);
  static const Revoke saleV1 = Revoke._("SaleV1", 1);
  static const Revoke transferV1 = Revoke._("TransferV1", 2);
  static const Revoke dataV1 = Revoke._("DataV1", 3);
  static const Revoke utilityV1 = Revoke._("UtilityV1", 4);
  static const Revoke stakingV1 = Revoke._("StakingV1", 5);
  static const Revoke standardV1 = Revoke._("StandardV1", 6);
  static const Revoke lockedTransferV1 = Revoke._("LockedTransferV1", 7);
  static const Revoke programmableConfigV1 =
      Revoke._("ProgrammableConfigV1", 8);
  static const Revoke migrationV1 = Revoke._("MigrationV1", 9);
  static const Revoke authorityItemV1 = Revoke._("AuthorityItemV1", 10);
  static const Revoke dataItemV1 = Revoke._("DataItemV1", 11);
  static const Revoke collectionItemV1 = Revoke._("CollectionItemV1", 12);
  static const Revoke programmableConfigItemV1 =
      Revoke._("ProgrammableConfigItemV1", 13);
  static const Revoke printDelegateV1 = Revoke._("PrintDelegateV1", 14);

  static const List<Revoke> values = [
    collectionV1,
    saleV1,
    transferV1,
    dataV1,
    utilityV1,
    stakingV1,
    standardV1,
    lockedTransferV1,
    programmableConfigV1,
    migrationV1,
    authorityItemV1,
    dataItemV1,
    collectionItemV1,
    programmableConfigItemV1
  ];

  static Revoke fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No MetaDataTokenStandard found matching the specified value",
          details: {"value": value}),
    );
  }

  static Revoke fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw SolanaPluginException(
          "No Revoke found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "Revoke.$name";
  }
}
