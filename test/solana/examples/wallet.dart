import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

class QuickWalletForTest {
  factory QuickWalletForTest({int index = 0, bool printAccount = false}) {
    final slp = Bip32Slip10Ed25519.fromSeed(BytesUtils.fromHexString(
            "379032751fabd9008d48fa167a07569c917d611e13324b64d709fb57f7608077513b32a97cec9abca3f98cc7448d6f60bf9501d4e505b4453672bb63db5ecd81"))
        .childKey(Bip32KeyIndex.hardenIndex(index));
    final w =
        QuickWalletForTest._(SolanaPrivateKey.fromSeed(slp.privateKey.raw));
    if (printAccount) {
      print(
          "wallet created with index $index:\n${w.address.address}\n${w.privateKey.seedHex()}\n=========================================");
    }
    return w;
  }
  QuickWalletForTest._(this.privateKey);
  final SolanaPrivateKey privateKey;
  late final SolAddress address = privateKey.publicKey().toAddress();
  // static final rpc = solanaRPC("https://api.devnet.solana.com");

  // Future<String> faucent([String? addr]) async {
  //   final f = await rpc.request(SolanaRPCRequestAirdrop(
  //       account: addr ?? address.address, lamports: 2000000000));
  //   return f;
  // }

  // Future<String> recentBlockhash() async {
  //   final rb = await rpc.request(SolanaRPCGetLatestBlockhash());
  //   print("result $rb");
  //   return rb.blockhash.address;
  // }

  // Future<String> submitTr(String digest) async {
  //   final th =
  //       await rpc.request(SolanaRPCSendTransaction(encodedTransaction: digest));
  //   return th;
  // }

  // Future<Map<String, dynamic>> simulateTR(String digest,
  //     {bool signVerify = false,
  //     RPCAccountConfig? config,
  //     bool replaceRecentBlockhash = true}) async {
  //   final th = await rpc.request(SolanaRPCSimulateTransaction(
  //       encodedTransaction: digest,
  //       sigVerify: signVerify,
  //       accounts: config,
  //       replaceRecentBlockhash: replaceRecentBlockhash));
  //   return th;
  // }
}
