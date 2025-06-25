## 6.8.0

- Update dependencies.
- Add visible option for generate tron transaction as json


## 6.7.0

- Fix serialization issues in some Solana pre-instruction layouts.

## 6.6.0

- Update dependencies.
- Private keys (except sepc256r1) now using constant-time for safty generate public key
- all sign method (except sepc256r1) using constant-time for safty generate signature

## 6.5.0

- Fix solidity abi fixed-size arrays encoding/decoding
- Add more abi serialization test.

## 6.3.0

- Update dependencies.
- Support for EIP4631

## 6.2.0

- Update dependencies.

## 6.1.0

- Update dependencies.
- Added Support for aptos graphQL.
- Fix Sui multisig address validator

## 6.0.0

- Update dependencies.
- Added Sui Network support.
- Added Aptos Network support.

## 5.1.0

- Update dependencies.
- Allow deserialization ADA transaction inputs encoded as Cbor(Set).

## 5.0.0

- Minimum required Dart SDK version updated to 3.3.
- The RPC method names and service class implementations have been updated. Please refer to the examples folder for guidance.
- Update dependencies.

## 4.5.0

- Update dependencies.
- Important Notice: This is the final version supporting Dart v2. The next release will require Dart v3.3 or higher.

## 4.4.0

- Update dependencies.


## 4.3.0

- Enhanced exception handling with updated exception classes
- Update dependencies.

## 4.2.0

- Fixed Solana simulate transaction model
- Added helper methods to solana versioned messages for replacing blockchains

## 4.1.0

- Fix Solana pre-instruction serialization issues

## 4.0.1

- Resolve issues with TRON model deserialization on the web.
- Add amount to `ADATransactionOutput` model #9


## 4.0.0

- Resolve issues with TRON model deserialization.

## 3.9.0

- Fix issue with Ethereum RLP encoding related to leading zero in signature S.

## 3.8.0

- Update dependencies.

## 3.7.0

- Update dependencies.

## 3.6.0

- add signAndBuildTransactionAsync method to support building cardano transactions asynchronously.

## 3.5.0

- Update dependencies.

## 3.4.0

- Update dependencies.

## 3.3.0

- Update dependencies.
- Move Layout serialzation to blockchain_utils package.

## 3.2.0

- Introducing a Transaction Builder for Cardano: Simplify Transaction Creation and Signing.

## 3.1.0

- Update dependencies.
- Constructors for Tron Native Contracts for Deserialization from Protobuf

## 3.0.1

- Update dependencies.

## 3.0.0

- Added support for the Cardano network.

## 2.0.0

- Added support for the Solana network.

## 1.0.0

- Resolved encoding and decoding issues with Tron operations..
- Corrected Eip1559 fee calculation in ETHTransactionBuilder.
- Updated dependencies to ensure compatibility and leverage the latest features.

## 0.0.1

- TODO: Release.
