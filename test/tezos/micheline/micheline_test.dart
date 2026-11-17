import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/tezos.dart';
import 'package:test/test.dart';

import 'test_vector.dart';

import '../../utils.dart';

void michelineTest() {
  group('Tezos/Micheline', () {
    test("test vector", () {
      for (final i in michelineNestedTestVector) {
        final m = MichelineExpr.deserializeJson(i.valueAs("json"));
        final encode = m.serializeHex();
        expect(encode, i.valueAsString("hex"));
        expect(m.toJson(), i.valueAs("json"));
        final decode = MichelineExpr.deserialize(
          i.valueAsBytes("hex", allowHex: true),
        );
        expect(decode.toJson(), i.valueAs("json"));
        expect(decode, m);
        expect(decode.serializeHex(), i.valueAsString("hex"));
      }
    });

    test("invalid prim", () {
      expect(() => MichelinePrimNoArgsNoAnnots("t"), throwsA(isA<BuError>()));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(michelineTest, "Micheline");
}
