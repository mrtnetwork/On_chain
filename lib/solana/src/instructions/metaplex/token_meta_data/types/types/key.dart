import 'package:blockchain_utils/exception/exception.dart';

class MetaDataKey {
  final String name;
  final int value;
  const MetaDataKey._(this.name, this.value);
  static const MetaDataKey uninitialized = MetaDataKey._("Uninitialized", 0);

  static const MetaDataKey editionV1 = MetaDataKey._("EditionV1", 1);
  static const MetaDataKey masterEditionV1 =
      MetaDataKey._("MasterEditionV1", 2);
  static const MetaDataKey reservationListV1 =
      MetaDataKey._("ReservationListV1", 3);
  static const MetaDataKey metadataV1 = MetaDataKey._("MetadataV1", 4);
  static const MetaDataKey reservationListV2 =
      MetaDataKey._("ReservationListV2", 5);
  static const MetaDataKey masterEditionV2 =
      MetaDataKey._("MasterEditionV2", 6);
  static const MetaDataKey editionMarker = MetaDataKey._("EditionMarker", 7);
  static const MetaDataKey useAuthorityRecord =
      MetaDataKey._("UseAuthorityRecord", 8);
  static const MetaDataKey collectionAuthorityRecord =
      MetaDataKey._("CollectionAuthorityRecord", 9);
  static const MetaDataKey tokenOwnedEscrow =
      MetaDataKey._("TokenOwnedEscrow", 10);
  static const MetaDataKey tokenRecord = MetaDataKey._("TokenRecord", 11);
  static const MetaDataKey metadataDelegate =
      MetaDataKey._("MetadataDelegate", 12);
  static const MetaDataKey editionMarkerV2 =
      MetaDataKey._("EditionMarkerV2", 13);

  static const List<MetaDataKey> values = [
    uninitialized,
    editionV1,
    masterEditionV1,
    reservationListV1,
    metadataV1,
    reservationListV2,
    masterEditionV2,
    editionMarker,
    useAuthorityRecord,
    collectionAuthorityRecord,
    tokenOwnedEscrow,
    tokenRecord,
    metadataDelegate,
    editionMarkerV2
  ];

  static MetaDataKey fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No MetaDataKey found matching the specified value",
          details: {"value": value}),
    );
  }

  static MetaDataKey fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No MetaDataKey found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "Verification.$name";
  }
}
