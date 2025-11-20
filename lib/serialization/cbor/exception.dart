import 'package:on_chain/exception/exception.dart';

class CborSerializationException extends OnChainPluginException {
  CborSerializationException(super.message, {super.details});
}
