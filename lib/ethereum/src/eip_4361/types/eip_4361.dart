import 'package:blockchain_utils/blockchain_utils.dart';

/// This class performs basic validation for EIP-4361 but does not fully validate all aspects
/// of the specification. Its main purpose is to generate EIP-4361 sign-in messages for Ethereum.
class EIP4361 {
  final String domain;
  final String address;
  final String? statement;
  final String? uri;
  final String? version;
  final String? chainId;
  final String? nonce;
  final String? issuedAt;
  final String? expirationTime;
  final String? notBefore;
  final String? requestId;
  final List<String>? resources;

  bool get hasResources => resources?.isNotEmpty ?? false;
  bool get hasUri => uri != null;
  bool get hasExpirationTime => expirationTime != null;
  bool get hasNotBefore => notBefore != null;
  bool get hasNonce => nonce != null;
  bool get hasIssuedAt => issuedAt != null;
  bool get hasStatement => statement != null;
  bool get hasVersion => version != null;
  bool get hasRequestId => version != null;

  factory EIP4361({
    required String domain,
    required String address,
    String? statement,
    String? uri,
    String? version,
    String? chainId,
    String? nonce,
    String? issuedAt,
    String? expirationTime,
    String? notBefore,
    List<String>? resources,
    String? requestId,
  }) {
    if (version != null && version != '1') {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid version. The "version" field must be exactly "1".',
      );
    }
    final parse = Uri.tryParse(domain);
    if (parse == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Domain. The "Domain" must follow the format specified by RFC 3986.',
      );
    }
    if (uri != null) {
      final parse = Uri.tryParse(uri);
      if (parse == null || !parse.isAbsolute) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid URI. The "uri" must follow the format specified by RFC 3986.',
        );
      }
    }
    if (expirationTime != null) {
      final parse = DateTime.tryParse(expirationTime);
      if (parse == null) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid expirationTime: "$expirationTime". Unable to parse the date.',
        );
      }
    }

    if (notBefore != null) {
      final parse = DateTime.tryParse(notBefore);
      if (parse == null) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid notBefore: "$notBefore". Unable to parse the date.',
        );
      }
    }

    if (issuedAt != null) {
      final parse = DateTime.tryParse(issuedAt);
      if (parse == null) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid issuedAt: "$issuedAt". Unable to parse the date.',
        );
      }
    }
    if (resources != null) {
      for (final resource in resources) {
        final parse = Uri.tryParse(resource);
        if (parse == null || !parse.isAbsolute) {
          throw BuError(
            DefaultErrorType.invalidArgument,
            'Invalid resource. The "resource" must follow the format specified by RFC 3986.',
          );
        }
      }
    }

    return EIP4361._(
      domain: domain,
      address: address,
      statement: statement,
      uri: uri,
      version: version,
      chainId: chainId,
      nonce: nonce,
      issuedAt: issuedAt,
      expirationTime: expirationTime,
      notBefore: notBefore,
      requestId: requestId,
      resources: resources,
    );
  }
  factory EIP4361.fromJson(Map<String, dynamic> json) {
    return EIP4361(
      domain: json['domain'],
      address: json['address'],
      statement: json['statement'],
      uri: json['uri'],
      version: json['version'],
      chainId: json['chainId'],
      nonce: json['nonce'],
      issuedAt: json['issuedAt'],
      expirationTime: json['expirationTime'],
      notBefore: json['notBefore'],
      requestId: json['requestId'],
      resources:
          json['resources'] != null
              ? List<String>.from(json['resources'])
              : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'address': address,
      'statement': statement,
      'uri': uri,
      'version': version,
      'chainId': chainId,
      'nonce': nonce,
      'issuedAt': issuedAt,
      'expirationTime': expirationTime,
      'notBefore': notBefore,
      'requestId': requestId,
      'resources': resources,
    };
  }

  const EIP4361._({
    required this.domain,
    required this.address,
    required this.statement,
    required this.uri,
    required this.version,
    required this.chainId,
    required this.nonce,
    required this.issuedAt,
    required this.expirationTime,
    required this.notBefore,
    required this.requestId,
    required this.resources,
  });

  String toMessage({String network = "Solana"}) {
    final buffer = StringBuffer();
    buffer.writeln('$domain wants you to sign in with your $network account:');
    buffer.writeln(address);
    if (statement != null && statement!.isNotEmpty) {
      buffer.writeln('\n$statement');
    }

    if (uri != null) {
      buffer.writeln('\nURI: $uri');
    }
    if (version != null) {
      buffer.writeln('Version: $version');
    }
    if (chainId != null) buffer.writeln('Chain ID: $chainId');
    if (nonce != null) {
      buffer.writeln('Nonce: $nonce');
    }
    if (issuedAt != null) {
      buffer.writeln('Issued At: $issuedAt');
    }
    if (expirationTime != null) {
      buffer.writeln('Expiration Time: $expirationTime');
    }
    if (notBefore != null) {
      buffer.writeln('Not Before: $notBefore');
    }
    if (requestId != null) {
      buffer.writeln('Request ID: $requestId');
    }
    if (resources != null) {
      buffer.writeln('Resources:');
      for (final resource in resources!) {
        buffer.writeln('- $resource');
      }
    }

    return buffer.toString().trimRight();
  }

  BuBytes serialize({String network = "Solana"}) {
    return StringUtils.encode(toMessage(network: network)).toBytes;
  }

  String toHex({String network = "Solana"}) {
    return BytesUtils.toHexString(serialize(network: network));
  }
}
