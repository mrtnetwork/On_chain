import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/provider/methods/methods/methods.dart';
import 'package:on_chain/aptos/src/provider/core/core.dart';

/// This endpoint accepts an EncodeSubmissionRequest, which internally is a UserTransactionRequestInner
/// (and optionally secondary signers) encoded as JSON, validates the request format,
/// and then returns that request encoded in BCS. The client can then use this to create a transaction
/// signature to be used in a SubmitTransactionRequest, which it then passes to the /transactions POST endpoint.
/// [aptos documation](https://aptos.dev/en/build/apis/fullnode-rest-api-reference)
class AptosRequestEncodeSubmission
    extends AptosPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// A hex encoded 32 byte Aptos account address.
  /// This is represented in a string as a 64 character hex string,
  /// sometimes shortened by stripping leading 0s, and adding a 0x.
  final AptosAddress sender;
  final String sequenceNumber;
  final String maxGasAmount;
  final String gasUnitPrice;
  final String expirationTimestampSecs;
  final Object payload;
  final List<String>? secondarySigners;
  AptosRequestEncodeSubmission(
      {required this.sender,
      required this.sequenceNumber,
      required this.maxGasAmount,
      required this.gasUnitPrice,
      required this.expirationTimestampSecs,
      required this.payload,
      this.secondarySigners});
  @override
  String get method => AptosApiMethod.encodeSubmission.url;

  @override
  Map<String, dynamic> get body => {
        "sender": sender.address,
        "sequence_number": sequenceNumber,
        "max_gas_amount": maxGasAmount,
        "gas_unit_price": gasUnitPrice,
        "expiration_timestamp_secs": expirationTimestampSecs,
        "payload": payload,
        "secondary_signers": secondarySigners
      }..removeWhere((k, v) => v == null);
}
