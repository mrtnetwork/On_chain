import 'package:on_chain/ada/ada.dart';

class ADACertificateBuilder {
  final Certificate certificate;
  final ADAAddress? signer;
  const ADACertificateBuilder({required this.certificate, this.signer});
}
