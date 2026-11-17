// Keyless login helper (Aptos devnet, interactive once).
//
// Runs the Google OAuth code flow with PKCE on localhost (no client secret;
// loopback redirects need no console registration for Desktop clients),
// captures the ID token (JWT) whose `nonce` commits to a fresh ephemeral
// keypair, verifies the nonce, and prints/saves everything the live e2e
// test needs.
//
// You only need a Google Cloud OAuth client ID (type: Desktop app):
//   https://console.cloud.google.com/apis/credentials
//
// Run:
//   dart run tool/keyless_login.dart --client-id 1234...apps.googleusercontent.com
//   dart run tool/keyless_login.dart --client-id ... --port 18080 --out /tmp/aptos_jwt.txt
//
// REMOTE MACHINE (SSH / Codespaces): your browser's 127.0.0.1 is YOUR
// machine, not this one. Forward the port first so the Google redirect
// tunnels back here. Any ONE of:
//   - VS Code: PORTS view -> right-click 18080 -> Forward Port
//     (or it auto-forwards when the tool starts listening), then set the
//     port visibility if the browser can't reach it.
//   - CLI: gh codespace ports forward 18080:18080 -c <codespace-name>
//   - SSH: ssh -L 18080:127.0.0.1:18080 <this-host>
// The tool binds 0.0.0.0 (not loopback) precisely so forwarded traffic
// arrives; the redirect URI stays 127.0.0.1 (loopback needs no Google
// console registration for Desktop clients).
//
// Then:
//   APTOS_JWT=$(cat /tmp/aptos_jwt.txt) dart test test/live/aptos/live_keyless_e2e_test.dart

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:on_chain/aptos/aptos.dart';

String _b64u(List<int> bytes) =>
    StringUtils.decode(bytes, encoding: StringEncoding.base64UrlSafe);

Future<void> main(List<String> args) async {
  String? clientId;
  var port = 18080;
  String? outPath;
  for (int i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--client-id':
        clientId = args[++i];
      case '--port':
        port = int.parse(args[++i]);
      case '--out':
        outPath = args[++i];
      case '--help':
      case '-h':
        stdout.writeln(
          'usage: dart run tool/keyless_login.dart --client-id ID [--port 18080] [--out FILE]',
        );
        return;
    }
  }
  if (clientId == null || clientId.isEmpty) {
    stderr.writeln('missing --client-id (Google OAuth client, Desktop type).');
    exit(2);
  }

  // 1. Fresh ephemeral keypair; its nonce goes into the login request.
  final ephemeral = AptosEphemeralKeyPair();
  stdout.writeln('ephemeral expiry : ${ephemeral.expiryDateSecs}');
  stdout.writeln('ephemeral nonce  : ${ephemeral.nonce}');

  // 2. PKCE pair (no client secret needed).
  final rng = Random.secure();
  final verifierBytes = List<int>.generate(48, (_) => rng.nextInt(256));
  final verifier = _b64u(verifierBytes);
  final challenge = _b64u(QuickCrypto.sha256Hash(StringUtils.encode(verifier)));
  const state = 'aptos-keyless-login';

  final redirectUri = 'http://127.0.0.1:$port/callback';
  final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'client_id': clientId,
    'redirect_uri': redirectUri,
    'response_type': 'code',
    'scope': 'openid email profile',
    'nonce': ephemeral.nonce,
    'code_challenge': challenge,
    'code_challenge_method': 'S256',
    'state': state,
    'access_type': 'online',
    'prompt': 'select_account',
  });

  // 3. Localhost callback server. Binds all interfaces so SSH/VS Code
  // port-forwarding reaches it; browsers still use 127.0.0.1 (see header).
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  stdout.writeln('');
  stdout.writeln('OPEN THIS URL AND SIGN IN:');
  stdout.writeln(authUrl);
  stdout.writeln('');
  stdout.writeln('Waiting up to 5 minutes for the Google redirect...');
  String? code;
  String? error;
  await server.timeout(const Duration(minutes: 5)).forEach((request) async {
    try {
      if (request.uri.path != '/callback') {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('not found');
        await request.response.close();
        return;
      }
      final params = request.uri.queryParameters;
      if (params['state'] != state) {
        error = 'state mismatch';
      } else if (params.containsKey('error')) {
        error = params['error'];
      } else {
        code = params['code'];
      }
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.html
        ..write(
          code != null
              ? '<h1>Signed in. You can close this tab and return to the terminal.</h1>'
              : '<h1>Sign-in failed ($error). Close this tab and retry.</h1>',
        );
      await request.response.close();
    } finally {
      if (code != null || error != null) {
        unawaited(server.close(force: true));
      }
    }
  }).catchError((Object e) {
    error ??= 'timed out waiting for the redirect ($e)';
  });
  if (code == null) {
    stderr.writeln('login failed: ${error ?? 'unknown'}');
    exit(1);
  }

  // 4. Code + PKCE verifier -> tokens (public client, no secret).
  final tokenRes = await http.post(
    Uri.https('oauth2.googleapis.com', '/token'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'code': code!,
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
      'code_verifier': verifier,
    },
  );
  if (tokenRes.statusCode != 200) {
    stderr.writeln('token exchange failed: ${tokenRes.body}');
    exit(1);
  }
  final idToken =
      (StringUtils.toJson(tokenRes.body) as Map)['id_token'] as String?;

  // 5. Verify the JWT carries our nonce (wrong login / stale token guard).
  if (idToken == null || idToken.isEmpty) {
    stderr.writeln('no id_token in token response.');
    exit(1);
  }
  final claims = AptosJwtClaims.parse(idToken);
  final tokenNonce = claims.payload['nonce']?.toString() ?? '';
  if (tokenNonce != ephemeral.nonce) {
    stderr.writeln(
      'JWT nonce does not match this ephemeral key '
      '(got $tokenNonce). Sign in again with the printed URL.',
    );
    exit(1);
  }
  stdout.writeln('login ok: iss=${claims.iss} aud=${claims.aud}');
  if (outPath != null) {
    File(outPath).writeAsStringSync(idToken);
    stdout.writeln('JWT saved to $outPath');
  } else {
    stdout.writeln('');
    stdout.writeln('APTOS_JWT=$idToken');
  }
  stdout.writeln('');
  stdout.writeln(
    'Next: APTOS_JWT=${outPath != null ? '\$(cat $outPath)' : '<above>'} '
    'dart test test/live/aptos/live_keyless_e2e_test.dart',
  );
}
