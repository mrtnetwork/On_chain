# ON CHAIN Dart Package

Cross-platform Dart toolkit for building, signing, and submitting blockchain transactions across 12 networks — Ethereum, Tron, Solana, Cardano, Aptos, Sui, NEAR, Tezos, Algorand, Hedera, ICP, and Filecoin — plus Solidity ABI/Move codecs and a unified transaction-builder pipeline.

This package is the expanded successor of the original
[mrtnetwork/On_chain](https://github.com/mrtnetwork/On_chain), which covered
Ethereum, Tron, Solana, Cardano, Aptos, and Sui. Everything from that release is
still here; the networks, pipeline, and serialization layers below are new.

## Crypto engine: `blockchain_utils` dual backend

`on_chain` delegates all cryptography to
[`blockchain_utils`](https://github.com/mrtnetwork/blockchain_utils), which now runs a
**dual backend behind one typed API**: pure Dart by default, optional
zero-dependency Rust backend (FFI on native, WASM on web, via
`blockchain_utils_connector`).

- Details, backend support tables, and breaking changes live in the
  [`blockchain_utils` README](https://github.com/mrtnetwork/blockchain_utils).
- The Rust core is maintained at
  [mrtnetwork/blockchain-utils](https://github.com/mrtnetwork/blockchain-utils).
- When the Rust backend is set (`blockchainUtils.setRustApi()`), **all
  high-level APIs route through Rust** — `QuickCrypto`, keys, signing, ciphers,
  hashes, KDFs, and protocol helpers execute in Rust instead of Dart.
- Rust-only: Groth16 verification (no Dart pairing implementation).
- `on_chain` tests run against both backends (`test/test_backend.dart`,
  `one_shot_suite.dart`, browser WASM tests).

## Capability matrix

Details live in the per-network sections below; "—" means the chain has no
native concept, not a missing feature.

### Transactions & accounts

| Network | Transactions | Addresses | HD wallet |
|---|---|---|---|
| Ethereum / EVM | Legacy, EIP-1559, EIP-2930, EIP-4844, EIP-7702 | ✅ | ✅ |
| Tron | Native + TVM, visible-JSON mode | ✅ | ✅ |
| Solana | Versioned (legacy, v0, v1) | ✅ | ✅ |
| Cardano | Byron / Shelley / Conway, async signing | Base, reward, pointer, enterprise, Byron | Icarus / Legacy seeds |
| Aptos | Script, entry, multisig, encrypted | ed25519, single/multi-key, MultiED25519, keyless | ✅ |
| Sui | Programmable | ed25519, secp256k1/r1, multisig, zkLogin | ✅ |
| NEAR | All actions | Implicit + named | ✅ |
| Tezos | Operations | tz1 / tz2 / tz3 | ✅ |
| Algorand | ✅ | ✅ | ✅ |
| Hedera | Protobuf-native | ✅ | ✅ |
| ICP | Query / update | Principals, accounts, ICRC | ✅ |
| Filecoin | ✅ | secp / BLS / delegated | ✅ |

### Assets, staking & signing

| Network | Tokens / NFTs | Staking / governance | Multisig |
|---|---|---|---|
| Ethereum / EVM | ERC-20 / 721 / 1155, 4626 | ✅ | ✅ + DKLs23 TSS keys |
| Tron | TRC-10 / 20, shielded TRC-20¹ | Votes, resources, witnesses | ✅ |
| Solana | SPL, Token-2022², Metaplex, DAS | Stake / stake-pool, vote | ✅ + FROST TSS keys |
| Cardano | Mint, Plutus, native scripts | Stake / pool / MIR certs | ✅ |
| Aptos | Coin management | — | MultiAgent, FeePayer, keyless |
| Sui | Coin management | ✅ staking txs | Multisig, zkLogin |
| NEAR | NEP-141 / 171 | ✅ | ✅ |
| Tezos | FA1.2 / FA2 | Delegation | ✅ |
| Algorand | ASA | Participation | ✅ multisig |
| Hedera | HTS | ✅ | Threshold keys |
| ICP | ICRC-1 / 2 / 7…, ledger, cycles | NNS governance | ✅ |
| Filecoin | ✅ | — | ✅ |

### Programmability & connectivity

| Network | Contracts / programs | Provider |
|---|---|---|
| Ethereum / EVM | Solidity ABI, EIP-712 (legacy/v3/v4, ZKSync), EIP-4361 | JSON-RPC |
| Tron | Native contracts, TVM | HTTP + gRPC full node |
| Solana | 15+ prebuilt instructions, buffer layouts, MPL Core | RPC + quick client |
| Cardano | Plutus, metadata, withdrawals | RPC |
| Aptos | Move codecs | RPC + GraphQL |
| Sui | Move codecs | gRPC (v2 proto) |
| NEAR | Contract calls | RPC + mixins |
| Tezos | Michelson codecs + token helpers | RPC |
| Algorand | ABI codecs | RPC |
| Hedera | Smart contracts | gRPC |
| ICP | Candid / DID codegen (`did/`) | RPC |
| Filecoin | ✅ | RPC |

> ¹ Shielded TRC-20 proving needs the Rust backend of `blockchain_utils`
> (`SaplingApi`, Groth16). ² Token-2022 confidential-transfer proving needs the
> Rust backend (`solana_zk`); balance read/decrypt stays in Dart.

## What's new vs the old `mrtnetwork/On_chain` release

- **6 new networks:** NEAR, Tezos, Algorand, Hedera, ICP, Filecoin.
- **Unified pipeline:** `IOnchainTxBuilder` (`build → fill → sign → finalize → submit`) with typed params/results per chain (`lib/transaction/`).
- **Serialization:** BCS + CBOR layers (`lib/serialization/`); Solana buffer layouts; ICP Candid/DID code generation from `did/files` into `lib/icp/src/did`.
- **Ethereum:** EIP-4844 (blob txs), EIP-7702, EIP-712 ZKSync profile, EIP-4626 helpers, RLP BigInt fix.
- **Tron:** TIP-712, visible-JSON transaction mode.
- **Solana:** Token-2022 extensions (16–28), DAS API (`getAsset`, proofs, owner/group search), minimal MPL Core program, fee-aware transfer helpers, promoted quick client (`prepareTransaction`, `signAndSubmit`, `pollSignature`).
- **Cardano:** Conway era, CBOR-variant-tolerant deserialization, async transaction builder, memo as raw bytes.
- **Aptos:** GraphQL client alongside RPC; **keyless accounts** (OIDC JWT + Groth16 zk-proofs, ephemeral keypair sessions); **encrypted transactions** (encrypted payloads + batch-encryption keys).
- **Sui:** **zkLogin** (OIDC JWT + Groth16 zk-proofs, JWK fetching, address derivation, zk authenticators).
- **Addresses:** ADA, Ethereum, Solana, and others now inherit `IAddress` from `blockchain_utils`.
- **Threshold (TSS) signing via `blockchain_utils`:** FROST (secp256k1 + Ed25519) and DKLs23 threshold ECDSA now available from the crypto engine; both produce standard chain signatures, so **Ethereum transactions can be signed/verified with DKLs23-shared secp256k1 keys** and **Solana transactions with FROST-shared Ed25519 keys** — no single private key ever reconstructed.

## Breaking changes

- **All legacy exception classes removed — every error is `BuError`.** Per-chain `*Exception` types are gone; failures throw `BuError` with an `OnChainErrorType` taxonomy value (one value per legacy class, `domain: 'onchain'`), built via same-signature `OnChainErrors.*` factories. Message text and `details` shapes are preserved — update `catch` clauses and `on` filters to `BuError`.
- **Many chain RPC request/response types regenerated from OpenAPI / OpenRPC and tested live.** Request and model types across chains were regenerated from their canonical OpenAPI / OpenRPC specs and validated against live nodes (see `test/*/test_vectors/live`). Field names, required/optional markers, enums, and defaults may differ from the previous hand-written models — review call sites when upgrading.
- **Tron transactions now use pregenerated protobuf models.** Transaction and contract types are generated from the canonical Tron protocol definitions (`lib/tron/src/proto_messages/`, wire-compatible enums and contract descriptors). Hand-written transaction models are gone — constructors, field names, and serialization follow the generated models.
- **Sui: JSON-RPC removed, gRPC only.** The Sui provider now dispatches
  exclusively to the gRPC v2 API (`SuiGrpcRequest` → `doGrpcRequest`, proto
  messages in `lib/sui/src/proto_messages/`). The old JSON-RPC method surface
  is gone — endpoints, request/response models, and streaming now follow the
  gRPC definitions. Update providers and custom method calls accordingly.

## Networks

### Ethereum / EVM

- Sign transactions and personal messages; Legacy, EIP-1559, EIP-2930 (access lists), EIP-4844, EIP-7702.
- Contract interaction via Solidity ABI; EIP-712 structured signing (legacy, v3, v4, ZKSync); EIP-4361 (SIWE); EIP-4626 vault helpers.
- TSS-ready: transactions accept DKLs23 threshold-ECDSA (secp256k1) signatures from `blockchain_utils` — verifiable as standard Ethereum ECDSA, no single key reconstructed.
- JSON-RPC provider; HD wallet (mnemonic → seed → addresses).
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/ethereum) · [EIP-712](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/eip_712) · [ABI](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/abi)

### Tron

- Transaction + personal signing; multi-signature; full native contract set (account, assets, votes, witnesses, resources, markets, shielded).
- Shielded TRC-20 (mint/transfer/burn, verified on Nile testnet): note scanning/parsing in Dart, Sapling proving (`SaplingApi`, Groth16) in the Rust backend of `blockchain_utils` — select it via `blockchainUtils.setRustApi()` before shielded operations.
- TVM contract calls; HTTP-node + gRPC full-node providers; visible-JSON mode; HD wallet.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/tron)

### Solana

- Versioned transaction build/serialize/deserialize/sign (legacy, v0, and v1 messages); 15+ prebuilt instructions (system, SPL token, Token-2022, stake, stake-pool, vote, memo, compute budget, ALTs, name service, secp256k1/ed25519 precompiles, lending, swaps) plus Metaplex suites (auction house, candy machine, bubblegum, hydra, …).
- Token-2022 extensions, DAS compressed-asset APIs, MPL Core, transfer-hook helpers, quick client with fee/history passthroughs.
- Token-2022 confidential transfers: balance read/decrypt stays in Dart (`SolanaConfidentialZkUtils`); Bulletproofs + Sigma proving lives in the Rust `solana_zk` backend of `blockchain_utils` — proof generation throws without `blockchainUtils.setRustApi()`.
- TSS-ready: transactions accept FROST threshold-Ed25519 signatures from `blockchain_utils` — verifiable as standard Solana Ed25519, no single key reconstructed.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/solana)

### Cardano

- Byron + Shelley + Conway transaction build/serialize/deserialize/sign (incl. async builder); base/reward/pointer/enterprise and Byron/legacy addresses.
- Mint, Plutus, native scripts, stake/pool/MIR certificates, metadata, withdrawals; Icarus/Legacy seeds + Shelley/Byron HD.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/cardano)

### Aptos

- Script / EntryFunction / multisig / encrypted transactions; ed25519, single-key, multikey, MultiED25519, and keyless (OIDC zk-proof) addresses; MultiAgent + FeePayer + keyless authenticators.
- RPC + GraphQL providers; Move codecs; HD wallet.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/aptos)

### Sui

- Programmable transactions; ed25519 / secp256k1 / secp256r1 / multisig / zkLogin (OIDC) addresses and authenticators; coin management; gRPC (v2) provider; HD wallet.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/sui)

### NEAR (new)

- Build, sign, and execute transactions with full action support; implicit + named accounts; Ed25519 / secp256k1 / ML-DSA-65; RPC client with convenience mixins.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/near)

### Tezos (new)

- Operation building/signing; tz1/tz2/tz3; Michelson + token helpers; RPC.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/tezos)

### Algorand (new)

- Transaction build/sign; ABI codecs; multisig; RPC.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/algorand)

### Hedera (new)

- Protobuf-native transactions; HTS tokens; staking; threshold keys; contract calls; gRPC client.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/hedera)

### ICP (new)

- Query/update calls; principals, accounts, ICRC token family (1/2/7/…), ledger + cycles ledgers, NNS governance; Candid/DID bindings generated from `did/files`.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/icp)

### Filecoin (new)

- secp256k1 / BLS / delegated addresses; message build/sign; RPC.
- [Examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/fil)

### Solidity / Move

- Solidity ABI encode/decode + contract interaction helpers; Move type encode/decode for Aptos/Sui.
- [Contract examples](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/contract)

## Examples

Explore all examples [here](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example) (mirrored per network under `example/lib/example/` in this repo).

## Testing

```sh
dart test            # VM, default backend
dart test test/one_shot_test.dart
```

Backend-parity suites (`one_shot_suite.dart`, `test_backend.dart`) exercise both
the pure-Dart and Rust/WASM backends; browser WASM tests need the built
`test/wasm_assets`.

## Contributing

Contributions are welcome! Please follow these guidelines:

- Fork the repository and create a new branch.
- Make your changes and ensure tests pass.
- Submit a pull request with a detailed description of your changes.

## Feature requests and bugs

Please file feature requests and bugs in the issue tracker.
