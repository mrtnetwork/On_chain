import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/eip_4361/types/eip_4631.dart';
import 'package:on_chain/ethereum/src/eip_4361/exception/exception.dart';
import 'package:test/test.dart';

void main() {
  _test();
}

void _test() {
  test('EIP4631', () {
    final message = EIP4631(
        address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
        domain: "phishing.com",
        statement: "Sign-in to connect!",
        uri: "https://www.phishing.com",
        version: "1",
        nonce: "oBbLoEldZs",
        chainId: "solana:mainnet",
        issuedAt: "2025-04-06T04:32:04.194Z",
        resources: ["https://example.com", "https://phantom.app/"]);
    expect(
        message.serialize(),
        BytesUtils.fromHexString(
            "7068697368696e672e636f6d2077616e747320796f7520746f207369676e20696e207769746820796f757220536f6c616e61206163636f756e743a0a354a5765696d65444b4b7564435252514a6a59336e466d7974636533616b733536736b67536d6335664b45320a0a5369676e2d696e20746f20636f6e6e656374210a0a5552493a2068747470733a2f2f7777772e7068697368696e672e636f6d0a56657273696f6e3a20310a436861696e2049443a20736f6c616e613a6d61696e6e65740a4e6f6e63653a206f42624c6f456c645a730a4973737565642041743a20323032352d30342d30365430343a33323a30342e3139345a0a5265736f75726365733a0a2d2068747470733a2f2f6578616d706c652e636f6d0a2d2068747470733a2f2f7068616e746f6d2e6170702f"));
  });
  test('EIP4631', () {
    final message = EIP4631(
        address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
        domain: "phishing.com",
        statement: "Sign-in to connect!",
        uri: "https://www.phishing.com",
        version: "1",
        expirationTime: '2025-05-06T04:45:41.929Z',
        requestId: '100',
        nonce: "oBbLoEldZs",
        chainId: "solana:mainnet",
        issuedAt: "2025-04-06T04:45:41.929Z",
        resources: ["https://example.com", "https://phantom.app/"]);
    expect(
        message.serialize(),
        BytesUtils.fromHexString(
            "7068697368696e672e636f6d2077616e747320796f7520746f207369676e20696e207769746820796f757220536f6c616e61206163636f756e743a0a354a5765696d65444b4b7564435252514a6a59336e466d7974636533616b733536736b67536d6335664b45320a0a5369676e2d696e20746f20636f6e6e656374210a0a5552493a2068747470733a2f2f7777772e7068697368696e672e636f6d0a56657273696f6e3a20310a436861696e2049443a20736f6c616e613a6d61696e6e65740a4e6f6e63653a206f42624c6f456c645a730a4973737565642041743a20323032352d30342d30365430343a34353a34312e3932395a0a45787069726174696f6e2054696d653a20323032352d30352d30365430343a34353a34312e3932395a0a526571756573742049443a203130300a5265736f75726365733a0a2d2068747470733a2f2f6578616d706c652e636f6d0a2d2068747470733a2f2f7068616e746f6d2e6170702f"));
  });
  test('EIP4631-3', () {
    final message = EIP4631(
        address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
        domain: "phishing.com",
        statement: "Sign-in to connect!",
        uri: "https://www.phishing.com",
        version: "1",
        expirationTime: '2025-05-06T04:51:36.947Z',
        requestId: '100',
        nonce: "oBbLoEldZs",
        chainId: "solana:mainnet",
        issuedAt: "2025-04-06T04:51:36.947Z",
        resources: []);

    expect(message.toHex(),
        "7068697368696e672e636f6d2077616e747320796f7520746f207369676e20696e207769746820796f757220536f6c616e61206163636f756e743a0a354a5765696d65444b4b7564435252514a6a59336e466d7974636533616b733536736b67536d6335664b45320a0a5369676e2d696e20746f20636f6e6e656374210a0a5552493a2068747470733a2f2f7777772e7068697368696e672e636f6d0a56657273696f6e3a20310a436861696e2049443a20736f6c616e613a6d61696e6e65740a4e6f6e63653a206f42624c6f456c645a730a4973737565642041743a20323032352d30342d30365430343a35313a33362e3934375a0a45787069726174696f6e2054696d653a20323032352d30352d30365430343a35313a33362e3934375a0a526571756573742049443a203130300a5265736f75726365733a");
  });

  test("EIP4631-4", () {
    final message = EIP4631(
      address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
      domain: "localhost:3000",
      statement: "Sign-in to connect!",
    );
    expect(message.toHex(),
        "6c6f63616c686f73743a333030302077616e747320796f7520746f207369676e20696e207769746820796f757220536f6c616e61206163636f756e743a0a354a5765696d65444b4b7564435252514a6a59336e466d7974636533616b733536736b67536d6335664b45320a0a5369676e2d696e20746f20636f6e6e65637421");
  });
  test("EIP4631-5", () {
    final message = EIP4631(
      address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
      domain: "localhost:3000",
      statement: "Sign-in to connect!",
    );
    expect(message.toHex(),
        "6c6f63616c686f73743a333030302077616e747320796f7520746f207369676e20696e207769746820796f757220536f6c616e61206163636f756e743a0a354a5765696d65444b4b7564435252514a6a59336e466d7974636533616b733536736b67536d6335664b45320a0a5369676e2d696e20746f20636f6e6e65637421");
  });
  test("EIP4631 invalid version", () {
    expect(
        () => EIP4631(
            address: "5JWeimeDKKudCRRQJjY3nFmytce3aks56skgSmc5fKE2",
            domain: "localhost:3000",
            statement: "Sign-in to connect!",
            version: '2'),
        throwsA(isA<EIP4631Exception>().having(
            (e) => e.message, 'error message', contains('Invalid version.'))));
  });
}
