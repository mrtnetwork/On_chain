import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void hashMapTest() {
  group('ICP/Hash map', () {
    test('Official IC hash_of_map / request ID example', () {
      final map = <String, dynamic>{
        'request_type': 'call',
        'canister_id': [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2],
        'method_name': 'hello',
        'arg': [0x44, 0x49, 0x44, 0x4C, 0x00, 0xFD, 0x2A], // DIDL\x00\xFD*
        // optional fields must be omitted or null:
        'nonce': null,
      };

      final hash = ICPCryptoUtils.hashMap(map); // or whatever hosts hashMap

      expect(
        BytesUtils.toHexString(hash),
        '8781291c347db32a9d8c10eb62b710fce5a93be676474c42babc74c51858f94b',
      );
    });
    test('Null fields are omitted', () {
      final a = ICPCryptoUtils.hashMap({'a': 'x', 'b': null});
      final b = ICPCryptoUtils.hashMap({'a': 'x'});
      expect(a, equals(b));
    });

    test('Map order does not matter', () {
      final a = ICPCryptoUtils.hashMap({'b': '2', 'a': '1'});
      final b = ICPCryptoUtils.hashMap({'a': '1', 'b': '2'});
      expect(a, equals(b));
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(hashMapTest, "Hash Map");
}
