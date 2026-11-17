import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solidity/contract/fragments.dart';

/// Shielded TRC20 transaction helpers.
///
/// Verified on Nile testnet against our own ShieldedTRC20 deployment:
/// - `CreateShieldedContractParameters` (server proving) for mint/transfer/burn
/// - local RedJubJub spend-auth signatures (randomized key ask+alpha)
/// - canonical ABI fragments below (byte-identical to the previous manual
///   encoders, proven by `test/tron/shield_trc20_codec_test.dart`).
/// - mint trigger input = `mint` selector + server `trigger_contract_input`.
class ShieldTRC20Codec {
  /// Keccak selectors (verified on Nile):
  /// mint(uint256,bytes32[9],bytes32[2],bytes32[21]) = 855d175e
  /// transfer(bytes32[10][],bytes32[2][],bytes32[9][],
  ///   bytes32[2],bytes32[21][]) = 9110a55b
  /// burn(bytes32[10],bytes32[2],uint256,bytes32[2],address,
  ///   bytes32[3],bytes32[9][],bytes32[21][]) = cc105875
  static const String mintSelector = '855d175e';
  static const String transferSelector = '9110a55b';
  static const String burnSelector = 'cc105875';
  static const String getPathSelector = 'e1765073';

  /// Canonical ShieldedTRC20 ABI (subset used here).
  static const List<Map<String, dynamic>> shieldedTRC20Abi = [
    {
      'name': 'mint',
      'inputs': [
        {'name': 'rawValue', 'type': 'uint256'},
        {'name': 'output', 'type': 'bytes32[9]'},
        {'name': 'bindingSig', 'type': 'bytes32[2]'},
        {'name': 'c', 'type': 'bytes32[21]'},
      ],
      'outputs': [],
      'stateMutability': 'nonpayable',
    },
    {
      'name': 'transfer',
      'inputs': [
        {'name': 'input', 'type': 'bytes32[10][]'},
        {'name': 'sigs', 'type': 'bytes32[2][]'},
        {'name': 'output', 'type': 'bytes32[9][]'},
        {'name': 'bindingSig', 'type': 'bytes32[2]'},
        {'name': 'c', 'type': 'bytes32[21][]'},
      ],
      'outputs': [],
      'stateMutability': 'nonpayable',
    },
    {
      'name': 'burn',
      'inputs': [
        {'name': 'input', 'type': 'bytes32[10]'},
        {'name': 'sig', 'type': 'bytes32[2]'},
        {'name': 'rawValue', 'type': 'uint256'},
        {'name': 'bindingSig', 'type': 'bytes32[2]'},
        {'name': 'payTo', 'type': 'address'},
        {'name': 'burnCipher', 'type': 'bytes32[3]'},
        {'name': 'output', 'type': 'bytes32[9][]'},
        {'name': 'c', 'type': 'bytes32[21][]'},
      ],
      'outputs': [],
      'stateMutability': 'nonpayable',
    },
    {
      'name': 'getPath',
      'inputs': [
        {'name': 'position', 'type': 'uint256'},
      ],
      'outputs': [
        {'name': 'root', 'type': 'bytes32'},
        {'name': 'path', 'type': 'bytes32[32]'},
      ],
      'stateMutability': 'view',
    },
    {
      'name': 'leafCount',
      'inputs': [],
      'outputs': [
        {'name': 'count', 'type': 'uint256'},
      ],
      'stateMutability': 'view',
    },
  ];

  static AbiFunctionFragment _fn(String name) {
    return AbiFunctionFragment.fromJson(
      shieldedTRC20Abi.firstWhere((e) => e['name'] == name),
    );
  }

  /// Canonical fragments (parsed once, reused by every encode/decode call).
  static final AbiFunctionFragment mintFn = _fn('mint');
  static final AbiFunctionFragment transferFn = _fn('transfer');
  static final AbiFunctionFragment burnFn = _fn('burn');
  static final AbiFunctionFragment getPathFn = _fn('getPath');
  static final AbiFunctionFragment leafCountFn = _fn('leafCount');

  /// Split bytes into 32-byte words, right zero-padded.
  static List<List<int>> toWords(List<int> bytes) {
    final out = <List<int>>[];
    for (int i = 0; i < bytes.length; i += 32) {
      final w = List<int>.filled(32, 0);
      final n = (i + 32 <= bytes.length) ? 32 : bytes.length - i;
      w.setRange(0, n, bytes.sublist(i, i + n));
      out.add(w);
    }
    return out;
  }

  /// Pack c = encCiphertext(580) ++ outCiphertext(80) = 660 bytes
  /// tight-packed into 21 words (last word padded).
  static List<List<int>> packCiphertext(List<int> enc, List<int> out) {
    final bytes = [...enc, ...out];
    if (bytes.length != 660) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'ShieldTRC20 ciphertext must be 660 bytes, got ${bytes.length}.',
      );
    }
    final words = toWords(bytes);
    if (words.length != 21) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid ShieldTRC20 ciphertext words: expected 21.',
      );
    }
    return words;
  }

  /// transfer(bytes32[10][] input, bytes32[2][] sigs, bytes32[9][] output,
  /// bytes32[2] bindingSig, bytes32[21][] c), without selector.
  static List<int> encodeTransfer({
    required List<List<List<int>>> inputs,
    required List<List<List<int>>> sigs,
    required List<List<List<int>>> outputs,
    required List<List<int>> bindingSig,
    required List<List<List<int>>> cs,
  }) {
    return List<int>.from(
      transferFn.encode([inputs, sigs, outputs, bindingSig, cs], false),
    );
  }

  /// mint(uint256 rawValue, bytes32[9] output, bytes32[2] bindingSig,
  /// bytes32[21] c), without selector.
  static List<int> encodeMint({
    required BigInt rawValue,
    required List<List<int>> output,
    required List<List<int>> bindingSig,
    required List<List<int>> c,
  }) {
    if (output.length != 9 || bindingSig.length != 2 || c.length != 21) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid ShieldTRC20 transfer shape: expected output[9]/bindingSig[2]/c[21].',
      );
    }
    return List<int>.from(
      mintFn.encode([rawValue, output, bindingSig, c], false),
    );
  }

  /// getPath(uint256 position), with selector.
  static List<int> encodeGetPath(BigInt position) {
    return List<int>.from(getPathFn.encode([position]));
  }

  /// leafCount(), with selector.
  static List<int> encodeLeafCount() {
    return List<int>.from(leafCountFn.encode([]));
  }

  /// Decodes getPath output into (root, 32 path words).
  static ({List<int> root, List<List<int>> path}) decodeGetPath(
    List<int> encoded,
  ) {
    if (encoded.length != 33 * 32) {
      throw BuError(
        DefaultErrorType.invalidLength,
        'Invalid getPath output length.',
        details: {'expected': '${33 * 32}', 'actual': '${encoded.length}'},
      );
    }
    final out = getPathFn.decodeOutput(encoded);
    return (
      root: List<int>.from(out[0] as List<int>),
      path:
          (out[1] as List).map((e) => List<int>.from(e as List<int>)).toList(),
    );
  }

  /// Decodes leafCount output.
  static BigInt decodeLeafCount(List<int> encoded) {
    final out = leafCountFn.decodeOutput(encoded);
    return out.single as BigInt;
  }

  /// burn(bytes32[10],bytes32[2],uint256,bytes32[2],address,bytes32[3],
  /// bytes32[9][],bytes32[21][]), without selector.
  static List<int> encodeBurn({
    required List<List<int>> input,
    required List<List<int>> sig,
    required BigInt rawValue,
    required List<List<int>> bindingSig,
    required List<int> payTo20,
    required List<List<int>> burnCipher,
    required List<List<List<int>>> outputs,
    required List<List<List<int>>> cs,
  }) {
    if (input.length != 10 || sig.length != 2 || bindingSig.length != 2) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid ShieldTRC20 burn shape: expected input[10]/sig[2]/bindingSig[2].',
      );
    }
    if (payTo20.length != 20 || burnCipher.length != 3) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid ShieldTRC20 burn shape: expected payTo20[20]/burnCipher[3].',
      );
    }
    return List<int>.from(
      burnFn.encode([
        input,
        sig,
        rawValue,
        bindingSig,
        payTo20,
        burnCipher,
        outputs,
        cs,
      ], false),
    );
  }

  /// Build a single spend input words [nf, anchor, cv, rk, proof(6)].
  static List<List<int>> spendInputWords({
    required List<int> nullifier,
    required List<int> anchor,
    required List<int> valueCommitment,
    required List<int> rk,
    required List<int> proof,
  }) {
    final words = [nullifier, anchor, valueCommitment, rk, ...toWords(proof)];
    if (words.length != 10) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid spend input words: expected 10.',
      );
    }
    return words.map(List<int>.from).toList();
  }

  /// Build a single output words [cm, cv, epk, proof(6)].
  static List<List<int>> outputWords({
    required List<int> cm,
    required List<int> cv,
    required List<int> epk,
    required List<int> proof,
  }) {
    final words = [cm, cv, epk, ...toWords(proof)];

    if (words.length != 9) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid output words: expected 9.',
      );
    }
    return words.map(List<int>.from).toList();
  }
}

/// SpendAuthSig signs messageHash with the RANDOMIZED key (ask+alpha),
/// RedJubJub spendAuth domain. Verified on Nile (transfer + burn accepted).
class ShieldTRC20Signer {
  /// Randomized signing scalar: ask + alpha (mod JubJub order).
  static List<int> randomizedKey(List<int> ask, List<int> alpha) =>
      List<int>.from(blockchainUtils.api.jubjub.scAdd(ask, alpha));

  /// 64-byte spendAuthSig (r || s) over [messageHash].
  static List<int> spendAuthSig({
    required List<int> ask,
    required List<int> alpha,
    required List<int> messageHash,
  }) {
    final sig = blockchainUtils.api.signing.jubjub.sign(
      sk: randomizedKey(ask, alpha),
      message: messageHash,
      variant: RedJubJubVariant.spendAuth,
    );
    return [...List<int>.from(sig.rBytes), ...List<int>.from(sig.sBytes)];
  }
}
