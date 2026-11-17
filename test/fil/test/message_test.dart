import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/types/types.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void messageTest() {
  group('Filecoin/Message', () {
    test("Message", () {
      final message = FilMessage(
        to: FilAddress("f1hulmx3tvgeaw5lbrsro7y2jricztb56wsl7k4ba"),
        from: FilAddress(
          "f3welbw6mcfg6kcwgbsfs7k4lpgn77wvqsuwkmmzj2n5dfinz4reezfx3dx65mvg6qab3a5dyd4febdzo3u5tq",
        ),
        nonce: BigInt.zero,
        value: FilTokenAmount(BigInt.parse("1000000000000000000")),
        gasLimit: BigInt.from(7115073),
        gasFeeCap: FilTokenAmount.from(179660),
        gasPremium: FilTokenAmount.from(176561),
        method: BigInt.zero,
        params: "hi".codeUnits,
      );
      expect(
        message.toCbor().encode(),
        BytesUtils.fromHexString(
          "8a0055013d16cbee7531016eac31945dfc693140b330f7d6583103b1161b798229bca158c19165f5716f337ffb5612a594c6653a6f4654373c890992df63bfbaca9bd000760e8f03e148110049000de0b6b3a76400001a006c9141440002bdcc440002b1b100426869",
        ),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(messageTest, "Message");
}
