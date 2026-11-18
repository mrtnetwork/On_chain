## 9.0.2
- Split multi-hundred-KB single-line hex fixtures in tests into adjacent string chunks (byte-identical). Single huge literals forced multi-MB contiguous analyzer allocations that exhausted the heap in memory-constrained environments (pub.dev analysis timed out).

## 9.0.1
- Excluded machine-generated models/clients (NEAR, Tezos, Tron, Hedera, Algorand, ICP) and the Flutter example app from analyzer scope so `dart analyze` stays fast in constrained environments (pub.dev analysis timed out on 9.0.0). No API changes.

## 9.0.0
- BREAKING: all legacy exception classes removed; every error is now `BuError` with an `OnChainErrorType` taxonomy value (message text and `details` preserved via `OnChainErrors.*` factories).
- BREAKING: many chain RPC request/response types regenerated from OpenAPI / OpenRPC specs and tested against live nodes; field names and defaults may differ.
- BREAKING: Tron transactions now use pregenerated protobuf models (`lib/tron/src/proto_messages/`); hand-written transaction models removed.
- BREAKING: Sui JSON-RPC provider removed; Sui now speaks gRPC only (v2 proto API).
- Solana Token-2022 confidential-transfer ZK proving is Rust-backend only (`solana_zk` in blockchain_utils); Dart keeps read/decrypt helpers.
- Added Tron shielded TRC-20 (mint/transfer/burn, verified on Nile); proving requires the Rust backend of blockchain_utils (Sapling/Groth16).
- TSS-ready signing: Ethereum accepts DKLs23 threshold-ECDSA (secp256k1) signatures and Solana accepts FROST threshold-Ed25519 signatures from blockchain_utils (standard on-chain verification).
- Aptos encrypted transactions (encrypted payloads, batch-encryption keys).
- Solana: fixed `getTransaction` double-commitment params (`[signature, config]` per spec).
- Solana: added correctly-spelled `get_latest_block_hash.dart` alias (old typo file kept).
- Solana Token-2022: completed `ExtensionType` 16-28 (confidential-fee, TokenGroup/GroupMember, ConfidentialMintBurn, ScaledUiAmount, Pausable, PermissionedBurn); fixed `GroupMemberPointer` 21 -> 22.
- Solana: promoted quick client to `lib/solana/src/rpc/quick/` (both-program balances, `prepareTransaction`, `signAndSubmit`, `pollSignature`, prioritization-fee/history passthroughs, DAS asset helpers).
- Solana: added `SolanaTokenTransferHelpers` (fee-aware `transferCheckedWithFee` builder, transfer-hook extra-accounts resolution, harvest-to-mint).
- Solana: added DAS API requests (`getAsset`, `getAssetProof`, `getAssetsByOwner/ByGroup`, `searchAssets`) for compressed/Core asset indexing.
- Solana: added minimal MPL Core program (CreateV1/CreateCollectionV1/TransferV1/UpdateV1/BurnV1 + best-effort account decoder).

## 8.1.0
- Updated dependencies.
- Updated all blockchain address implementations (ADA, Ethereum, Solana, and others) to inherit from IAddress provided by blockchain_utils.
- Fixed Ethereum RLP BigInt encoding issues.
- Changed MemoLayout to use raw bytes instead of String for memo data handling.

## 8.0.0
- Update dependencies.
- Minimum required Dart SDK version updated to 3.7.
- Reduce static final variables.
- Added support for ethereum EIP-4844
- Added support for ethereum EIP-712 (ZKSync)
- Added support for ethereum EIP-7702

## 7.1.0
    - Update dependencies.

## 7.0.0
- Added support for the Cardano Conway era  
- Added support for deserializing Cardano models with different CBOR encodings
- Added support for TIP-712
- Update dependencies.
**Note:**  
Several model structures have been updated. Please review the changes before upgrading to this version.

## 6.9.0

- Update dependencies.

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
