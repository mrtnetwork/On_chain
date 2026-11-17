import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_certificate.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_hash_tree.dart';

sealed class ICPRequestStatusResult {
  const ICPRequestStatusResult();
  factory ICPRequestStatusResult.extractRequestStatus({
    required ICPCertificate cert,
    required List<int> requestId, // 32-byte content hash
  }) {
    final rStatusBytes = StringUtils.encode('request_status');
    final statusLookup = cert.lookup([
      rStatusBytes,
      requestId,
      StringUtils.encode('status'),
    ]);

    if (statusLookup is ICPLookupUnknown || statusLookup is ICPLookupAbsent) {
      return const ICPRequestStatusUnknown();
    }
    if (statusLookup is! ICPLookupFound) {
      return const ICPRequestStatusUnknown();
    }

    final status = StringUtils.decode(statusLookup.value);

    switch (status) {
      case 'replied':
        final replyLookup = cert.lookup([
          rStatusBytes,
          requestId,
          StringUtils.encode('reply'),
        ]);
        if (replyLookup is! ICPLookupFound) {
          throw OnChainErrors.icpPlugin(
            "ICPRequestStatusResult.extractRequestStatus",
            reason: 'Replied but reply path missing.',
          );
        }
        return ICPRequestStatusReplied(replyLookup.value);

      case 'rejected':
        final codeLookup = cert.lookup([
          rStatusBytes,
          requestId,
          StringUtils.encode('reject_code'),
        ]);
        final msgLookup = cert.lookup([
          rStatusBytes,
          requestId,
          StringUtils.encode('reject_message'),
        ]);
        final errLookup = cert.lookup([
          rStatusBytes,
          requestId,
          StringUtils.encode('error_code'),
        ]);
        final code =
            LEBBigIntegerLayout(
              LayoutConst.u256(),
            ).deserialize((codeLookup as ICPLookupFound).value).value;

        final msg = StringUtils.decode((msgLookup as ICPLookupFound).value);
        final err =
            errLookup is ICPLookupFound
                ? StringUtils.decode(errLookup.value)
                : null;

        return ICPRequestStatusRejected(
          rejectCode: code,
          rejectMessage: msg,
          errorCode: err,
        );

      case 'done':
        return const ICPRequestStatusDone();

      case 'received':
      case 'processing':
        return ICPRequestStatusPending(status);

      default:
        return ICPRequestStatusPending(status);
    }
  }
}

class ICPRequestStatusReplied extends ICPRequestStatusResult {
  final List<int> reply; // candid bytes
  const ICPRequestStatusReplied(this.reply);
}

class ICPRequestStatusRejected extends ICPRequestStatusResult {
  final BigInt rejectCode;
  final String rejectMessage;
  final String? errorCode;
  const ICPRequestStatusRejected({
    required this.rejectCode,
    required this.rejectMessage,
    this.errorCode,
  });
}

class ICPRequestStatusPending extends ICPRequestStatusResult {
  final String status; // received | processing
  const ICPRequestStatusPending(this.status);
}

class ICPRequestStatusDone extends ICPRequestStatusResult {
  const ICPRequestStatusDone();
}

class ICPRequestStatusUnknown extends ICPRequestStatusResult {
  const ICPRequestStatusUnknown();
}
