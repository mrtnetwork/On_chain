import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';

/// Transport for faucet calls. Implement with any HTTP client
/// (e.g. `package:http` in apps/tests).
mixin SuiFaucetService {
  /// POSTs a JSON body and returns the decoded JSON response.
  Future<Map<String, dynamic>> postFaucetRequest(
    Uri url,
    Map<String, dynamic> body,
  );
}

/// Faucet provider: binds a transport to faucet calls.
class SuiFaucetProvider {
  final SuiFaucetService service;
  const SuiFaucetProvider(this.service);
}

/// Sui faucet networks with v2 (`FixedAmountRequest`) API hosts.
///
/// The public testnet faucet now requires v3 proof-of-work
/// (`GET /v3/challenge` + Argon2d grind, see https://faucet.sui.io), which
/// this client does not implement. Use [devnet] (or a self-hosted/local
/// faucet) for automated funding.
enum SuiFaucetNetwork {
  devnet('https://faucet.devnet.sui.io'),
  testnet('https://faucet.testnet.sui.io'),
  localnet('http://127.0.0.1:9123');

  const SuiFaucetNetwork(this.host);
  final String host;
}

/// One coin paid out by the faucet (`coins_sent` entry).
class SuiFaucetTransferResult {
  final BigInt amount;
  final SuiAddress id;
  final String transferTxDigest;
  const SuiFaucetTransferResult({
    required this.amount,
    required this.id,
    required this.transferTxDigest,
  });
  factory SuiFaucetTransferResult.fromJson(Map<String, dynamic> json) {
    return SuiFaucetTransferResult(
      amount: _parseAmount(json["amount"]),
      id: SuiAddress(json["id"] as String),
      transferTxDigest: json["transferTxDigest"] as String,
    );
  }

  /// Amount may arrive as a decimal string or a JSON number (small enough
  /// to stay exact either way at faucet scale).
  static BigInt _parseAmount(Object? value) {
    if (value is int) return BigInt.from(value);
    if (value is double) return BigInt.from(value.truncate());
    return BigintUtils.parse(value);
  }
}

/// Faucet response. `status` is `"Success"` or
/// `{"Failure": {"internal": reason}}`.
class SuiFaucetResponse {
  final bool success;
  final String? failure;
  final List<SuiFaucetTransferResult> coins;
  const SuiFaucetResponse({
    required this.success,
    required this.failure,
    required this.coins,
  });
  factory SuiFaucetResponse.fromJson(Map<String, dynamic> json) {
    final status = json["status"];
    final ok = status == "Success";
    String? failure;
    if (!ok && status is Map) {
      final inner = status["Failure"];
      if (inner is Map) failure = inner["internal"]?.toString();
      failure ??= status.toString();
    }
    return SuiFaucetResponse(
      success: ok,
      failure: failure,
      coins:
          (json["coins_sent"] as List? ?? const [])
              .map(
                (e) => SuiFaucetTransferResult.fromJson(
                  (e as Map).cast<String, dynamic>(),
                ),
              )
              .toList(),
    );
  }

  /// Total MIST paid across all coins.
  BigInt get totalMist => coins.fold(BigInt.zero, (sum, c) => sum + c.amount);
}

/// Minimal client for the Sui faucet v2 API (devnet/localhost).
///
/// ```dart
/// final faucet = SuiFaucetClient(
///   provider: SuiFaucetProvider(myHttpService),
/// );
/// final res = await faucet.requestSui(address);
/// ```
class SuiFaucetClient {
  SuiFaucetClient({required this.provider, String? host})
    : host = host ?? SuiFaucetNetwork.devnet.host;
  SuiFaucetClient.devnet({required this.provider})
    : host = SuiFaucetNetwork.devnet.host;
  SuiFaucetClient.testnet({required this.provider})
    : host = SuiFaucetNetwork.testnet.host;
  SuiFaucetClient.localnet({required this.provider})
    : host = SuiFaucetNetwork.localnet.host;

  final SuiFaucetProvider provider;
  final String host;

  /// Requests faucet funds for [recipient]. Throws on transport errors,
  /// rate limits and faucet-side failures.
  Future<SuiFaucetResponse> requestSui(SuiAddress recipient) async {
    late final Map<String, dynamic> parsed;
    try {
      parsed = await provider.service.postFaucetRequest(
        Uri.parse('$host/v2/gas'),
        {
          'FixedAmountRequest': {'recipient': recipient.address},
        },
      );
    } catch (e) {
      throw BuError(
        DefaultErrorType.network,
        'Sui faucet request failed.',
        details: {'host': host, 'error': '$e'},
      );
    }
    final response = SuiFaucetResponse.fromJson(parsed);
    if (!response.success) {
      throw BuError(
        DefaultErrorType.network,
        'Sui faucet request failed.',
        details: {'host': host, 'reason': response.failure ?? 'unknown'},
      );
    }
    return response;
  }
}
