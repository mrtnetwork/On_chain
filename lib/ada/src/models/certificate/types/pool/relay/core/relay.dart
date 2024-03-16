import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/types/pool/relay/core/relay_type.dart';
import 'package:on_chain/ada/src/models/certificate/types/pool/relay/relays/multi_host_name.dart';
import 'package:on_chain/ada/src/models/certificate/types/pool/relay/relays/single_host_address.dart';
import 'package:on_chain/ada/src/models/certificate/types/pool/relay/relays/single_host_name.dart';

/// Abstract class representing a relay for Cardano transactions.
abstract class Relay with ADASerialization {
  /// The type of relay.
  abstract final RelayType type;

  /// Internal constructor for creating a Relay instance.
  const Relay();

  /// Deserialize a Relay instance from CBOR data.
  factory Relay.deserialize(CborListValue cbor) {
    final type = RelayType.deserialize(cbor.getIndex(0));
    switch (type) {
      case RelayType.multiHostName:
        return MultiHostName.deserialize(cbor);
      case RelayType.singleHostAddr:
        return SingleHostAddr.deserialize(cbor);
      default:
        return SingleHostName.deserialize(cbor);
    }
  }
  factory Relay.fromJson(Map<String, dynamic> json) {
    final RelayType type;
    try {
      type = RelayType.fromName(json.keys.first);
    } on StateError {
      throw MessageException("Invalid Relay json.", details: {"json": json});
    }
    switch (type) {
      case RelayType.multiHostName:
        return MultiHostName.fromJson(json);
      case RelayType.singleHostAddr:
        return SingleHostAddr.fromJson(json);
      default:
        return SingleHostName.fromJson(json);
    }
  }
}
