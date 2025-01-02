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
}
