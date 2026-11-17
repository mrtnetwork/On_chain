// Sui zkLogin v1 proof end-to-end: real fastcrypto test vector
// (`test_verify_zk_login`: Google JWT proof + address_seed) verified through
// the Rust backend (FFI/WASM). The public input is computed in-Dart via
// `SuiZkLoginUtils.calculateAllInputsHashV1` — the same path production verification
// will use — so a pass validates derivation + VK + pairing together.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

// fastcrypto `test_verify_zk_login` v1 proof points (a/b/c decimal), as the
// 256B Sui blob (a64 + b128 EIP-197 + c64).
const String _proofHex =
    '10ba57499b13954745df299637dc1c2cac1a7dbec3c4d4b1fa913582fcbc75ea'
    '2806c8a8fc3055997e112cc4f3f46139f93dde81ab2c5011f1ff7ed0ad6f494b'
    '1a5f02b5db1ed7433b19f0758703de41fdf3a32d418467a68bd26644b8ac4d91'
    '1922c1a87a17b99d47743373170f544b85f6bea635a76d0162c8c0d93d421912'
    '077becbb646f6d4fc62960ca2cf6631192b7e12271992c0c619449e9136bc1fc'
    '05bdebfc940664480c5549124b7923275f6e825d183193a9831328bf538753da'
    '00dfa4662d1adb0b84d7dfc43b047d8e4ad5c6ff4d5c3ef45b883cdf2d86e071'
    '2f61528a7f9150c67aec539d395a13085365b82c87d993f86988cb77f9949353';

// Ephemeral key bytes (flag 0x00 + 32B ed25519 key).
const String _ephKeyHex =
    '0079686aa4ca7d8b8730615205effecb4023183f2434b00ff4f439bdf1c0b37f281da8';

// Google JWK RSA modulus (base64url-decoded, 256B).
const String _modulusHex =
    'c2160e14ad8e71b6e96ffcd5ca98bd49e2a2354a8a407d334ca375fba7e9093bba6'
    '5a94623cdaced72b7b5a9f8749b7dd29b543ca0f6cefc6a4f314d7f1e071c7b2b6'
    '027f6f8530b9f555325f41acc0d81bc9a80c1ca56d5ba91504b72f2d4bf62fe2'
    '146f59f40f71cd86737fbf7d038e5b9ef3572fab36825cef8e246f7d0d8d0c5d'
    '1a9d372764b718b42eee82ad4830cfa284070f7f0f10c3672137f4a63f8a8033'
    'e3ca690c1a82653b768aa69b237dbb7f007e8619d46085844b394c1053e87ea1'
    'f58747795b6222ad5cf9f974ddb89221f2eb57b754043dfd80199705c2ffdf46'
    '1adc3f369821140b8ce0fd490e7d03a69265772dcf1850b419f0426404b';

const String _headerBase64 =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6ImM5YWZkYTM2ODJlYmYwOWViMzA1NWMxYzRiZDM5Yjc1MWZiZjgxOTUiLCJ0eXAiOiJKV1QifQ';
const String _issBase64Value =
    'yJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLC';
const String _addressSeed =
    '4959624758616676340947699768172740454110375485415332267384397278368360470616';

BuBytes _hex(String h) => BuBytes(BytesUtils.fromHexString(h));

BigInt _testInputHash() {
  return SuiZkLoginUtils.calculateAllInputsHashV1(
    ephemeralPublicKeyBytes: BytesUtils.fromHexString(_ephKeyHex),
    addressSeed: BigInt.parse(_addressSeed),
    maxEpoch: BigInt.from(10000),
    issBase64Value: _issBase64Value,
    indexMod4: 1,
    headerBase64: _headerBase64,
    modulusBytes: BytesUtils.fromHexString(_modulusHex),
  );
}

void zkloginProofVerifyTest() {
  final Object? skipReason =
      blockchainUtils.backend == null
          ? 'Groth16 needs the Rust backend (ffi/wasm).'
          : null;
  group('Sui/ZkLogin proof verify', () {
    test('v1 test proof verifies (insecure v1 VK)', skip: skipReason, () {
      final inputHash = _testInputHash();
      final res = blockchainUtils.groth16.verifyBn254(
        proof: _hex(_proofHex),
        vk: _hex(SuiZkLoginVk.insecureV1Hex),
        publicInputs: BuBytes(BigintUtils.toBytes(inputHash, length: 32)),
      );
      expect(res.isOk, isTrue);
    });

    test('tampered proof fails', skip: skipReason, () {
      final bad = BytesUtils.fromHexString(_proofHex);
      bad[10] ^= 0xff;
      final res = blockchainUtils.groth16.verifyBn254(
        proof: BuBytes(bad),
        vk: _hex(SuiZkLoginVk.insecureV1Hex),
        publicInputs: BuBytes(
          BigintUtils.toBytes(_testInputHash(), length: 32),
        ),
      );
      expect(res.isErr, isTrue);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(zkloginProofVerifyTest, "Zklogin Proof Verify");
}
