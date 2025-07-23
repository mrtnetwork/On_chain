import 'package:on_chain/tron/tron.dart';

void main() {
  final domain = TronTypedDataDomain(
    name: 'Permit2',
    chainId: BigInt.parse('728126428'),
    verifyingContract: 'TDJNTBi51CnnpCYYgi6GitoT4CJWrqim2G',
  );

  final types = {
    'PermitDetails': [
      const TronTypedDataField(name: 'token', type: 'address'),
      const TronTypedDataField(name: 'amount', type: 'uint160'),
      const TronTypedDataField(name: 'expiration', type: 'uint48'),
      const TronTypedDataField(name: 'nonce', type: 'uint48'),
    ],
    'PermitSingle': [
      const TronTypedDataField(name: 'details', type: 'PermitDetails'),
      const TronTypedDataField(name: 'spender', type: 'address'),
      const TronTypedDataField(name: 'sigDeadline', type: 'uint256'),
    ],
  };

  final value = {
    'details': {
      'token': '0xa614f803b6fd780986a42c78ec9c7f77e6ded13c',
      'amount': '1100000',
      'expiration': 0,
      'nonce': 1,
    },
    'spender': '0xbde814ebd17a0b25c39ee16a8b2ff48d1628e503',
    'sigDeadline': 1753172632,
  };

  try {
    final encoder = TronTypedDataEncoder(types);
    print('Primary Type: ${encoder.primaryType}');

    final domainHash = TronTypedDataEncoder.hashDomain(domain);
    print('Domain Hash: $domainHash');

    final structHash = encoder.hash(value);
    print('Struct Hash: $structHash');

    final finalHash = TronTypedDataEncoder.hashTypedData(domain, types, value);
    print('Final TIP-712 Hash: $finalHash');
    // expected finalHash == 9cd34058512e83f5f87643fa4388c2eda64079e4e532acfd5a184f3adf943279
  } catch (e) {
    print('Error: $e');
  }
}
