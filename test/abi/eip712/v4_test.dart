import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:on_chain/solidity/abi/abi.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('v4', () {
    final Eip712TypedData test1 = Eip712TypedData(
        types: {
          'EIP712Domain': [
            const Eip712TypeDetails(name: 'name', type: 'string'),
            const Eip712TypeDetails(name: 'version', type: 'string'),
            const Eip712TypeDetails(name: 'chainId', type: 'uint256'),
            const Eip712TypeDetails(name: 'verifyingContract', type: 'address'),
          ],
          'Person': [
            const Eip712TypeDetails(name: 'name', type: 'string'),
            const Eip712TypeDetails(name: 'wallet', type: 'address'),
          ],
          'Mail': [
            const Eip712TypeDetails(name: 'from', type: 'Person'),
            const Eip712TypeDetails(name: 'to', type: 'Person'),
            const Eip712TypeDetails(name: 'contents', type: 'string')
          ],
        },
        primaryType: 'Mail',
        domain: {
          'name': 'Ether Mail',
          'version': '1',
          'chainId': BigInt.from(80001),
          'verifyingContract': '0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC',
        },
        message: {
          'from': {
            'name': 'Cow',
            'wallet': '0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826'
          },
          'to': {
            'name': 'Bob',
            'wallet': '0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB'
          },
          'contents': 'Hello, Bob!',
        });

    expect(test1.encodeHex(),
        '133a8cb1be5f78d001317fe4426e33a19b1dfc687f3da76d11fc8f65884f282f');
    EIP712Base json = EIP712Base.fromJson(test1.toJson());

    expect(json.encodeHex(),
        '133a8cb1be5f78d001317fe4426e33a19b1dfc687f3da76d11fc8f65884f282f');

    final Eip712TypedData test2 = Eip712TypedData.fromJson({
      'domain': {
        'chainId': BigInt.from(80001),
        'name': 'Example App',
        'verifyingContract': '0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC',
        'version': '1',
      },
      'message': {
        'prompt':
            'Welcome! In order to authenticate to this website, sign this request and your public address will be sent to the server in a verifiable way.',
      },
      'primaryType': 'AuthRequest',
      'types': {
        'EIP712Domain': [
          {'name': 'name', 'type': 'string'},
          {'name': 'version', 'type': 'string'},
          {'name': 'chainId', 'type': 'uint256'},
          {'name': 'verifyingContract', 'type': 'address'},
        ],
        'AuthRequest': [
          {'name': 'prompt', 'type': 'string'},
        ],
      },
    });

    expect(test2.encodeHex(),
        'c782eff790ec37ff428c9718c596f8113fd6c461043196505fd9b6a917204907');
    json = EIP712Base.fromJson(test2.toJson());
    expect(json.encodeHex(),
        'c782eff790ec37ff428c9718c596f8113fd6c461043196505fd9b6a917204907');
  });

  test('v3', () {
    final Eip712TypedData test1 = Eip712TypedData.fromJson({
      'domain': {
        'chainId': BigInt.from(80001),
        'name': 'Example App',
        'version': '1',
      },
      'message': {
        'prompt':
            'Welcome! In order to authenticate to this website, sign this request and your public address will be sent to the server in a verifiable way.',
      },
      'primaryType': 'AuthRequest',
      'types': {
        'EIP712Domain': [
          {'name': 'name', 'type': 'string'},
          {'name': 'version', 'type': 'string'},
          {'name': 'chainId', 'type': 'uint256'},
          {'name': 'verifyingContract', 'type': 'address'},
        ],
        'AuthRequest': [
          {'name': 'prompt', 'type': 'string'},
        ],
      },
    }, version: EIP712Version.v3);
    expect(test1.encodeHex(),
        '184dd59e6ca7b7b98ad9b5e02c0e38ab6951bdd854a16d2cf7aaaf6a5ad485d3');

    final EIP712Base json = EIP712Base.fromJson(test1.toJson());
    expect(json.encodeHex(),
        '184dd59e6ca7b7b98ad9b5e02c0e38ab6951bdd854a16d2cf7aaaf6a5ad485d3');
  });

  test("tip-712", () {
    final Eip712TypedData test = Eip712TypedData.fromJson({
      "types": {
        'EIP712Domain': [
          {'name': 'name', 'type': 'string'},
          {'name': 'version', 'type': 'string'},
          {'name': 'chainId', 'type': 'uint256'},
          {'name': 'verifyingContract', 'type': 'address'},
        ],
        'FromPerson': [
          {'name': 'name', 'type': 'string'},
          {'name': 'wallet', 'type': 'address'},
          {'name': 'id', 'type': 'trcToken'},
        ],
        'ToPerson': [
          {'name': 'name', 'type': 'string'},
          {'name': 'wallet', 'type': 'address'},
          {'name': 'tokenAddresses', 'type': 'trcToken[]'},
        ],
        'Mail': [
          {'name': 'from', 'type': 'FromPerson'},
          {'name': 'to', 'type': 'ToPerson'},
          {'name': 'contents', 'type': 'string'},
          {'name': 'tAddr', 'type': 'address[]'},
          {'name': 'id', 'type': 'trcToken'},
          {'name': 'tokenAddresses', 'type': 'trcToken[]'},
        ],
      },
      "message": {
        'from': {
          'name': 'Cow',
          'wallet': '0xF38C6c2002426C4dF8F9B331e4BFA3B294649B1b',
          'id': '1202000',
        },
        'to': {
          'name': 'Bob',
          'wallet': '0xF3d1D61F832cfbBA4B5C35018FB1CeF626702FFb',
          'tokenAddresses': ['1202000', '1202000'],
        },
        'contents': 'Hello, Bob!',
        'tAddr': [
          '0x0f7c9973B319c827D83a465B46318BcFE8f10129',
          '0xcD48389394A670DEc62202C606D1381Acec413bf',
        ],
        'id': '1102000',
        'tokenAddresses': ['1102000', '1202000'],
      },
      'domain': {
        'name': 'MyToken',
        'version': '2',
        'chainId': '0xd698d4192c56cb6be724a558448e2684802de4d6cd8690dc',
        'verifyingContract': '0x0f7c9973B319c827D83a465B46318BcFE8f10129',
      },
      "primaryType": "Mail"
    });
    expect(test.encodeHex(),
        "996f01b1bbd731c4d31028fe84622b41a18d68c576fe99de6417cab24975ec6b");
    expect(BytesUtils.toHexString(test.hashDomain()),
        "1d52d4b34faca3165cebf89393ba8d4670e2d26dc1294bf8e13d2651abb9a181");
    expect(BytesUtils.toHexString(test.hashType("FromPerson")),
        "7da264b2f94374ff292d5aee1da0c134d8c290e6c926a3ed7fc08768cd718311");
    expect(BytesUtils.toHexString(test.hashType("ToPerson")),
        "b554ee0d26dd2f5bb78e1c8083ae666334ec67a5d40b9efb3e5f0af57c3caaf1");
    expect(BytesUtils.toHexString(test.hashType("Mail")),
        "337667e528d45c8c935a39051f16457fc87af3f31f9c562e084c90bfd0440682");
    final fromJson = Eip712TypedData.fromJson(test.toJson());
    expect(fromJson.encodeHex(),
        "996f01b1bbd731c4d31028fe84622b41a18d68c576fe99de6417cab24975ec6b");
  });
}
