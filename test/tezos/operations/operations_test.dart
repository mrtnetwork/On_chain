import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void operationsTest() {
  group('Tezos/Operations', () {
    test("test vector", () {
      for (final i in _testVector) {
        final List<int> bytes = i.valueAsBytes("hex");
        final decodeJson = TezosOperationContent.fromJson(i.valueAs("json"));
        expect(
          decodeJson.toVariantJson(),
          i.valueEnsureAsMap("json"),
          reason: "json: ${i.valueAs("name")}",
        );
        expect(
          decodeJson.serializeVariantBytes(),
          bytes,
          reason: "forge: ${i.valueAs("name")}",
        );
        final decodeBytes = TezosOperationContent.deserialize(bytes);
        if (decodeJson.type != TezosOperationKind.transaction) {
          expect(
            decodeBytes.toVariantJson(),
            i.valueEnsureAsMap("json"),
            reason: "json: ${i.valueAs("name")}",
          );
          expect(decodeJson, decodeBytes);
        }
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(operationsTest, "Operations");
}

const List<Map<String, dynamic>> _testVector = [
  {
    "name": "activate_account",
    "json": {
      "kind": "activate_account",
      "pkh": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "secret": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    },
    "hex":
        "0402298c03ed7d454a101eb7022bc95f7e5f41ac78aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
  },
  {
    "name": "attestation",
    "json": {
      "kind": "attestation",
      "slot": 0,
      "level": 14651635,
      "round": 0,
      "block_payload_hash":
          "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
    },
    "hex":
        "15000000df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86",
  },
  {
    "name": "attestation_with_dal",
    "json": {
      "kind": "attestation_with_dal",
      "slot": 0,
      "level": 14651635,
      "round": 0,
      "block_payload_hash":
          "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
      "dal_attestation": "1",
    },
    "hex":
        "17000000df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c8601",
  },
  {
    "name": "attestations_aggregate",
    "json": {
      "kind": "attestations_aggregate",
      "consensus_content": {
        "level": 14651635,
        "round": 0,
        "block_payload_hash":
            "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
      },
      "committee": [
        {"slot": 0},
        {"slot": 1, "dal_attestation": "0"},
      ],
    },
    "hex":
        "1f00df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000070000000001ff00",
  },
  {
    "name": "attestations_aggregate_mixed_dal",
    "json": {
      "kind": "attestations_aggregate",
      "consensus_content": {
        "level": 14651635,
        "round": 0,
        "block_payload_hash":
            "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
      },
      "committee": [
        {"slot": 0, "dal_attestation": "3"},
        {"slot": 1},
      ],
    },
    "hex":
        "1f00df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000070000ff03000100",
  },
  {
    "name": "ballot",
    "json": {
      "kind": "ballot",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "period": 10,
      "proposal": "PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY",
      "ballot": "yay",
    },
    "hex":
        "060002298c03ed7d454a101eb7022bc95f7e5f41ac780000000a645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b5100",
  },
  {
    "name": "ballot_nay",
    "json": {
      "kind": "ballot",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "period": 10,
      "proposal": "PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY",
      "ballot": "nay",
    },
    "hex":
        "060002298c03ed7d454a101eb7022bc95f7e5f41ac780000000a645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b5101",
  },
  {
    "name": "ballot_pass",
    "json": {
      "kind": "ballot",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "period": 10,
      "proposal": "PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY",
      "ballot": "pass",
    },
    "hex":
        "060002298c03ed7d454a101eb7022bc95f7e5f41ac780000000a645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b5102",
  },
  {
    "name": "delegation_null",
    "json": {
      "kind": "delegation",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "5",
      "gas_limit": "1000",
      "storage_limit": "0",
    },
    "hex": "6e0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80705e8070000",
  },
  {
    "name": "delegation_with",
    "json": {
      "kind": "delegation",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "4",
      "gas_limit": "1000",
      "storage_limit": "0",
      "delegate": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
    },
    "hex":
        "6e0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80704e80700ff00e7670f32038107a59a2b9cfefae36ea21f5aa63c",
  },
  {
    "name": "drain_delegate",
    "json": {
      "kind": "drain_delegate",
      "consensus_key": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "delegate": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "destination": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
    },
    "hex":
        "090002298c03ed7d454a101eb7022bc95f7e5f41ac7800e7670f32038107a59a2b9cfefae36ea21f5aa63c0002298c03ed7d454a101eb7022bc95f7e5f41ac78",
  },
  {
    "name": "failing_noop",
    "json": {"kind": "failing_noop", "arbitrary": "0123456789abcdef"},
    "hex": "11000000080123456789abcdef",
  },
  {
    "name": "increase_paid_storage",
    "json": {
      "kind": "increase_paid_storage",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "8",
      "gas_limit": "1000",
      "storage_limit": "0",
      "amount": "100",
      "destination": "KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG",
    },
    "hex":
        "710002298c03ed7d454a101eb7022bc95f7e5f41ac78e80708e80700a40101b31ba9bfde1dd3598b5a10b17fe8162a3de554e100",
  },
  {
    "name": "origination_no_delegate",
    "json": {
      "kind": "origination",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "10",
      "gas_limit": "10000",
      "storage_limit": "10000",
      "balance": "1000000",
      "script": {
        "code": [
          {
            "prim": "parameter",
            "args": [
              {"prim": "unit"},
            ],
          },
          {
            "prim": "storage",
            "args": [
              {"prim": "unit"},
            ],
          },
          {
            "prim": "code",
            "args": [
              [
                {"prim": "CDR"},
                {
                  "prim": "NIL",
                  "args": [
                    {"prim": "operation"},
                  ],
                },
                {"prim": "PAIR"},
              ],
            ],
          },
        ],
        "storage": {"prim": "Unit"},
      },
    },
    "hex":
        "6d0002298c03ed7d454a101eb7022bc95f7e5f41ac78904e0a904e904ec0843d000000001c02000000170500036c0501036c050202000000080317053d036d034200000002030b",
  },
  {
    "name": "origination_with_delegate",
    "json": {
      "kind": "origination",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "11",
      "gas_limit": "10000",
      "storage_limit": "10000",
      "balance": "1000000",
      "delegate": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "script": {
        "code": [
          {
            "prim": "parameter",
            "args": [
              {"prim": "unit"},
            ],
          },
          {
            "prim": "storage",
            "args": [
              {"prim": "unit"},
            ],
          },
          {
            "prim": "code",
            "args": [
              [
                {"prim": "CDR"},
                {
                  "prim": "NIL",
                  "args": [
                    {"prim": "operation"},
                  ],
                },
                {"prim": "PAIR"},
              ],
            ],
          },
        ],
        "storage": {"prim": "Unit"},
      },
    },
    "hex":
        "6d0002298c03ed7d454a101eb7022bc95f7e5f41ac78904e0b904e904ec0843dff00e7670f32038107a59a2b9cfefae36ea21f5aa63c0000001c02000000170500036c0501036c050202000000080317053d036d034200000002030b",
  },
  {
    "name": "preattestation",
    "json": {
      "kind": "preattestation",
      "slot": 0,
      "level": 14651635,
      "round": 0,
      "block_payload_hash":
          "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
    },
    "hex":
        "14000000df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86",
  },
  {
    "name": "preattestations_aggregate",
    "json": {
      "kind": "preattestations_aggregate",
      "consensus_content": {
        "level": 14651635,
        "round": 0,
        "block_payload_hash":
            "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
      },
      "committee": [0, 1, 2],
    },
    "hex":
        "1e00df90f3000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c8600000006000000010002",
  },
  {
    "name": "proposals",
    "json": {
      "kind": "proposals",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "period": 10,
      "proposals": ["PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY"],
    },
    "hex":
        "050002298c03ed7d454a101eb7022bc95f7e5f41ac780000000a00000020645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b51",
  },
  {
    "name": "proposals_multiple",
    "json": {
      "kind": "proposals",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "period": 10,
      "proposals": [
        "PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY",
        "PsUshuai9QapM5TGj1JpuVGkdxz5GykdnEvS6Rh8SUVrARvZLCY",
      ],
    },
    "hex":
        "050002298c03ed7d454a101eb7022bc95f7e5f41ac780000000a00000040645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b51645071cc229bc362ac95960030c4cfedad42548e32ad7adaefd7009981779b51",
  },
  {
    "name": "register_global_constant",
    "json": {
      "kind": "register_global_constant",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "9",
      "gas_limit": "10000",
      "storage_limit": "1000",
      "value": {"prim": "Unit"},
    },
    "hex":
        "6f0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80709904ee80700000002030b",
  },
  {
    "name": "reveal",
    "json": {
      "kind": "reveal",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1257",
      "counter": "1",
      "gas_limit": "10000",
      "storage_limit": "0",
      "public_key": "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav",
    },
    "hex":
        "6b0002298c03ed7d454a101eb7022bc95f7e5f41ac78e90901904e00004798d2cc98473d7e250c898885718afd2e4efbcb1a1595ab9730761ed830de0f00",
  },
  {
    "name": "reveal_bls_pk_no_proof",
    "json": {
      "kind": "reveal",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1257",
      "counter": "50",
      "gas_limit": "10000",
      "storage_limit": "0",
      "public_key":
          "BLpk1mta4am8YmHp6mCQRAz2WWScLRgRRXD38KMPNiURqByycERm2Ggid5PCKj5oUYyCkN6NmLHN",
    },
    "hex":
        "6b0002298c03ed7d454a101eb7022bc95f7e5f41ac78e90932904e00038530c1bdc4cd6b1408be0933c4a41ac3513350eef36850b804708e1f338932ce01b655a163344a4500b281c8750c461f00",
  },
  {
    "name": "reveal_bls_pk_with_proof",
    "json": {
      "kind": "reveal",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1257",
      "counter": "51",
      "gas_limit": "10000",
      "storage_limit": "0",
      "public_key":
          "BLpk1mta4am8YmHp6mCQRAz2WWScLRgRRXD38KMPNiURqByycERm2Ggid5PCKj5oUYyCkN6NmLHN",
      "proof":
          "BLsigBhdyFSDUAP5fpw1Pv1YmP6HA1E5fcQTWZvrB3ctzzouV3EyvK8wLRACSy5dKDQacUNFNmf4nQDr4vUu6JxF1KoApiFTYxKmqMYXWtG1A8LqEqggNJYpGkmU8bcLY29gu4Pd91SjeU",
    },
    "hex":
        "6b0002298c03ed7d454a101eb7022bc95f7e5f41ac78e90933904e00038530c1bdc4cd6b1408be0933c4a41ac3513350eef36850b804708e1f338932ce01b655a163344a4500b281c8750c461fff00000060b87c8522e2f71bf84194d4de2ab785e68cdc59134006d8bf685b3e2f5a0926214c7edaeadfb486978c8988d46a33f484167dcc84d0bd9ed21eee54d5977823b790ce63ca01704fdcf20a96f44f1c5044baee358f192ebe50f1ad45c60b05b6b1",
  },
  {
    "name": "reveal_with_proof",
    "json": {
      "kind": "reveal",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1257",
      "counter": "1",
      "gas_limit": "10000",
      "storage_limit": "0",
      "public_key": "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav",
      "proof":
          "BLsigBhdyFSDUAP5fpw1Pv1YmP6HA1E5fcQTWZvrB3ctzzouV3EyvK8wLRACSy5dKDQacUNFNmf4nQDr4vUu6JxF1KoApiFTYxKmqMYXWtG1A8LqEqggNJYpGkmU8bcLY29gu4Pd91SjeU",
    },
    "hex":
        "6b0002298c03ed7d454a101eb7022bc95f7e5f41ac78e90901904e00004798d2cc98473d7e250c898885718afd2e4efbcb1a1595ab9730761ed830de0fff00000060b87c8522e2f71bf84194d4de2ab785e68cdc59134006d8bf685b3e2f5a0926214c7edaeadfb486978c8988d46a33f484167dcc84d0bd9ed21eee54d5977823b790ce63ca01704fdcf20a96f44f1c5044baee358f192ebe50f1ad45c60b05b6b1",
  },
  {
    "name": "seed_nonce_revelation",
    "json": {
      "kind": "seed_nonce_revelation",
      "level": 1000,
      "nonce":
          "0000000000000000000000000000000000000000000000000000000000000000",
    },
    "hex":
        "01000003e80000000000000000000000000000000000000000000000000000000000000000",
  },
  {
    "name": "set_deposits_limit_null",
    "json": {
      "kind": "set_deposits_limit",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "7",
      "gas_limit": "1000",
      "storage_limit": "0",
    },
    "hex": "700002298c03ed7d454a101eb7022bc95f7e5f41ac78e80707e8070000",
  },
  {
    "name": "set_deposits_limit_with",
    "json": {
      "kind": "set_deposits_limit",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "6",
      "gas_limit": "1000",
      "storage_limit": "0",
      "limit": "1000000",
    },
    "hex": "700002298c03ed7d454a101eb7022bc95f7e5f41ac78e80706e80700ffc0843d",
  },
  {
    "name": "smart_rollup_add_messages",
    "json": {
      "kind": "smart_rollup_add_messages",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "20",
      "gas_limit": "10000",
      "storage_limit": "0",
      "message": ["00", "ff"],
    },
    "hex":
        "c90002298c03ed7d454a101eb7022bc95f7e5f41ac78e80714904e000000000a000000010000000001ff",
  },
  {
    "name": "smart_rollup_add_messages_empty",
    "json": {
      "kind": "smart_rollup_add_messages",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "58",
      "gas_limit": "10000",
      "storage_limit": "0",
      "message": [],
    },
    "hex": "c90002298c03ed7d454a101eb7022bc95f7e5f41ac78e8073a904e0000000000",
  },
  {
    "name": "smart_rollup_cement",
    "json": {
      "kind": "smart_rollup_cement",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "21",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
    },
    "hex":
        "ca0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80715904e007017010cbce8df86a42e8f8515baf6aa19848fdd",
  },
  {
    "name": "smart_rollup_execute_outbox_message",
    "json": {
      "kind": "smart_rollup_execute_outbox_message",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "40",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "cemented_commitment":
          "src12yJRjtGGwZGtXF1wiPTj45prMxRJwBuGJcx8rMvYZ376SGDxDK",
      "output_proof": "00",
    },
    "hex":
        "ce0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80728904e007017010cbce8df86a42e8f8515baf6aa19848fdd41d37edd4c78c1063a57ad5c15a28d5f34c59b54c00044f6d7f93e29d5cb54570000000100",
  },
  {
    "name": "smart_rollup_originate_arith",
    "json": {
      "kind": "smart_rollup_originate",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "33",
      "gas_limit": "100000",
      "storage_limit": "10000",
      "pvm_kind": "arith",
      "kernel": "00",
      "parameters_ty": {"prim": "unit"},
    },
    "hex":
        "c80002298c03ed7d454a101eb7022bc95f7e5f41ac78904e21a08d06904e00000000010000000002036c00",
  },
  {
    "name": "smart_rollup_originate_no_whitelist",
    "json": {
      "kind": "smart_rollup_originate",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "31",
      "gas_limit": "100000",
      "storage_limit": "10000",
      "pvm_kind": "wasm_2_0_0",
      "kernel": "00",
      "parameters_ty": {"prim": "unit"},
    },
    "hex":
        "c80002298c03ed7d454a101eb7022bc95f7e5f41ac78904e1fa08d06904e01000000010000000002036c00",
  },
  {
    "name": "smart_rollup_originate_riscv",
    "json": {
      "kind": "smart_rollup_originate",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "57",
      "gas_limit": "100000",
      "storage_limit": "10000",
      "pvm_kind": "riscv",
      "kernel": "00",
      "parameters_ty": {"prim": "unit"},
    },
    "hex":
        "c80002298c03ed7d454a101eb7022bc95f7e5f41ac78904e39a08d06904e02000000010000000002036c00",
  },
  {
    "name": "smart_rollup_originate_with_whitelist",
    "json": {
      "kind": "smart_rollup_originate",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "10000",
      "counter": "32",
      "gas_limit": "100000",
      "storage_limit": "10000",
      "pvm_kind": "wasm_2_0_0",
      "kernel": "00",
      "parameters_ty": {"prim": "unit"},
      "whitelist": [
        "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
        "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      ],
    },
    "hex":
        "c80002298c03ed7d454a101eb7022bc95f7e5f41ac78904e20a08d06904e01000000010000000002036cff0000002a0002298c03ed7d454a101eb7022bc95f7e5f41ac7800e7670f32038107a59a2b9cfefae36ea21f5aa63c",
  },
  {
    "name": "smart_rollup_publish",
    "json": {
      "kind": "smart_rollup_publish",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "23",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "commitment": {
        "compressed_state":
            "srs11RzHDmi83qz7oNC7i7bz51RtBSXsSy3p4H4Pw9ZS5nQ3y5vUVD",
        "inbox_level": 100,
        "predecessor": "src12yJRjtGGwZGtXF1wiPTj45prMxRJwBuGJcx8rMvYZ376SGDxDK",
        "number_of_ticks": "1000",
      },
    },
    "hex":
        "cb0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80717904e007017010cbce8df86a42e8f8515baf6aa19848fdd00000000000000000000000000000000000000000000000000000000000000000000006441d37edd4c78c1063a57ad5c15a28d5f34c59b54c00044f6d7f93e29d5cb545700000000000003e8",
  },
  {
    "name": "smart_rollup_recover_bond",
    "json": {
      "kind": "smart_rollup_recover_bond",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "22",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "staker": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
    },
    "hex":
        "cf0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80716904e007017010cbce8df86a42e8f8515baf6aa19848fdd0002298c03ed7d454a101eb7022bc95f7e5f41ac78",
  },
  {
    "name": "smart_rollup_refute_move_dissection",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "counter": "35",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": [
          {
            "state": "srs11RzHDmi83qz7oNC7i7bz51RtBSXsSy3p4H4Pw9ZS5nQ3y5vUVD",
            "tick": "0",
          },
          {
            "state": "srs11RzHDmi83qz7oNC7i7bz51RtBSXsSy3p4H4Pw9ZS5nQ3y5vUVD",
            "tick": "500",
          },
          {"tick": "1000"},
        ],
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80723904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c01000000000048ff000000000000000000000000000000000000000000000000000000000000000000ff0000000000000000000000000000000000000000000000000000000000000000f40300e807",
    "note":
        "Sc_rollup_game_repr.step = Dissection. JSON: step is a list of chunks {state?, tick}.",
  },
  {
    "name": "smart_rollup_refute_move_proof",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "counter": "36",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {"pvm_step": "00"},
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80724904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c010001000000010000",
    "note":
        "Sc_rollup_game_repr.step = Proof. JSON: step is {pvm_step, input_proof?}.",
  },
  {
    "name": "smart_rollup_refute_move_proof_inbox",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "37",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {
            "input_proof_kind": "inbox_proof",
            "level": 100,
            "message_counter": "0",
            "serialized_proof": "00",
          },
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80725904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff0000000064000000000100",
  },
  {
    "name": "smart_rollup_refute_move_proof_metadata",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "38",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {
            "input_proof_kind": "reveal_proof",
            "reveal_proof": {"reveal_proof_kind": "metadata_proof"},
          },
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80726904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff0101",
  },
  {
    "name": "smart_rollup_refute_move_proof_raw_data",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "56",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {
            "input_proof_kind": "reveal_proof",
            "reveal_proof": {
              "reveal_proof_kind": "raw_data_proof",
              "raw_data": "deadbeef",
            },
          },
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80738904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff01000004deadbeef",
  },
  {
    "name": "smart_rollup_refute_start",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "34",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "start",
        "player_commitment_hash":
            "src12yJRjtGGwZGtXF1wiPTj45prMxRJwBuGJcx8rMvYZ376SGDxDK",
        "opponent_commitment_hash":
            "src12yJRjtGGwZGtXF1wiPTj45prMxRJwBuGJcx8rMvYZ376SGDxDK",
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80722904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0041d37edd4c78c1063a57ad5c15a28d5f34c59b54c00044f6d7f93e29d5cb545741d37edd4c78c1063a57ad5c15a28d5f34c59b54c00044f6d7f93e29d5cb5457",
  },
  {
    "name": "smart_rollup_timeout",
    "json": {
      "kind": "smart_rollup_timeout",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "39",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "stakers": {
        "alice": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
        "bob": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      },
    },
    "hex":
        "cd0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80727904e007017010cbce8df86a42e8f8515baf6aa19848fdd0002298c03ed7d454a101eb7022bc95f7e5f41ac7800e7670f32038107a59a2b9cfefae36ea21f5aa63c",
  },
  {
    "name": "transaction_entrypoint_stake",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "50000",
      "counter": "55",
      "gas_limit": "20000",
      "storage_limit": "0",
      "amount": "1000000",
      "destination": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "parameters": {
        "entrypoint": "stake",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78d0860337a09c0100c0843d000002298c03ed7d454a101eb7022bc95f7e5f41ac78ff0600000002030b",
  },
  {
    "name": "transaction_named_entrypoint",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "50000",
      "counter": "54",
      "gas_limit": "20000",
      "storage_limit": "0",
      "amount": "0",
      "destination": "KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG",
      "parameters": {
        "entrypoint": "foo",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78d0860336a09c01000001b31ba9bfde1dd3598b5a10b17fe8162a3de554e100ffff03666f6f00000002030b",
  },
  {
    "name": "transaction_no_params",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "50000",
      "counter": "2",
      "gas_limit": "200",
      "storage_limit": "0",
      "amount": "100000000",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78d0860302c8010080c2d72f0000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "transaction_with_params",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "50000",
      "counter": "3",
      "gas_limit": "20000",
      "storage_limit": "0",
      "amount": "0",
      "destination": "KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG",
      "parameters": {
        "entrypoint": "default",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78d0860303a09c01000001b31ba9bfde1dd3598b5a10b17fe8162a3de554e10000",
  },
  {
    "name": "transfer_ticket",
    "json": {
      "kind": "transfer_ticket",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "30",
      "gas_limit": "10000",
      "storage_limit": "100",
      "ticket_contents": {"string": "hello"},
      "ticket_ty": {"prim": "string"},
      "ticket_ticketer": "KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG",
      "ticket_amount": "1",
      "destination": "KT1QuofAgnsWffHzLA7D78rxytJruGHDe7XG",
      "entrypoint": "default",
    },
    "hex":
        "9e0002298c03ed7d454a101eb7022bc95f7e5f41ac78e8071e904e640000000a010000000568656c6c6f00000002036801b31ba9bfde1dd3598b5a10b17fe8162a3de554e1000101b31ba9bfde1dd3598b5a10b17fe8162a3de554e1000000000764656661756c74",
  },
  {
    "name": "update_companion_key",
    "json": {
      "kind": "update_companion_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "13",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk": "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav",
    },
    "hex":
        "730002298c03ed7d454a101eb7022bc95f7e5f41ac78e8070d904e00004798d2cc98473d7e250c898885718afd2e4efbcb1a1595ab9730761ed830de0f00",
  },
  {
    "name": "update_companion_key_bls_no_proof",
    "json": {
      "kind": "update_companion_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "55",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk":
          "BLpk1mta4am8YmHp6mCQRAz2WWScLRgRRXD38KMPNiURqByycERm2Ggid5PCKj5oUYyCkN6NmLHN",
    },
    "hex":
        "730002298c03ed7d454a101eb7022bc95f7e5f41ac78e80737904e00038530c1bdc4cd6b1408be0933c4a41ac3513350eef36850b804708e1f338932ce01b655a163344a4500b281c8750c461f00",
  },
  {
    "name": "update_companion_key_with_proof",
    "json": {
      "kind": "update_companion_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "54",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk":
          "BLpk1mta4am8YmHp6mCQRAz2WWScLRgRRXD38KMPNiURqByycERm2Ggid5PCKj5oUYyCkN6NmLHN",
      "proof":
          "BLsigBhdyFSDUAP5fpw1Pv1YmP6HA1E5fcQTWZvrB3ctzzouV3EyvK8wLRACSy5dKDQacUNFNmf4nQDr4vUu6JxF1KoApiFTYxKmqMYXWtG1A8LqEqggNJYpGkmU8bcLY29gu4Pd91SjeU",
    },
    "hex":
        "730002298c03ed7d454a101eb7022bc95f7e5f41ac78e80736904e00038530c1bdc4cd6b1408be0933c4a41ac3513350eef36850b804708e1f338932ce01b655a163344a4500b281c8750c461fff00000060b87c8522e2f71bf84194d4de2ab785e68cdc59134006d8bf685b3e2f5a0926214c7edaeadfb486978c8988d46a33f484167dcc84d0bd9ed21eee54d5977823b790ce63ca01704fdcf20a96f44f1c5044baee358f192ebe50f1ad45c60b05b6b1",
  },
  {
    "name": "update_consensus_key",
    "json": {
      "kind": "update_consensus_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "12",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk": "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav",
    },
    "hex":
        "720002298c03ed7d454a101eb7022bc95f7e5f41ac78e8070c904e00004798d2cc98473d7e250c898885718afd2e4efbcb1a1595ab9730761ed830de0f00",
  },
  {
    "name": "update_consensus_key_bls_with_proof",
    "json": {
      "kind": "update_consensus_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "53",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk":
          "BLpk1mta4am8YmHp6mCQRAz2WWScLRgRRXD38KMPNiURqByycERm2Ggid5PCKj5oUYyCkN6NmLHN",
      "proof":
          "BLsigBhdyFSDUAP5fpw1Pv1YmP6HA1E5fcQTWZvrB3ctzzouV3EyvK8wLRACSy5dKDQacUNFNmf4nQDr4vUu6JxF1KoApiFTYxKmqMYXWtG1A8LqEqggNJYpGkmU8bcLY29gu4Pd91SjeU",
    },
    "hex":
        "720002298c03ed7d454a101eb7022bc95f7e5f41ac78e80735904e00038530c1bdc4cd6b1408be0933c4a41ac3513350eef36850b804708e1f338932ce01b655a163344a4500b281c8750c461fff00000060b87c8522e2f71bf84194d4de2ab785e68cdc59134006d8bf685b3e2f5a0926214c7edaeadfb486978c8988d46a33f484167dcc84d0bd9ed21eee54d5977823b790ce63ca01704fdcf20a96f44f1c5044baee358f192ebe50f1ad45c60b05b6b1",
  },
  {
    "name": "update_consensus_key_with_proof",
    "json": {
      "kind": "update_consensus_key",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "52",
      "gas_limit": "10000",
      "storage_limit": "0",
      "pk": "edpkuBknW28nW72KG6RoHtYW7p12T6GKc7nAbwYX5m8Wd9sDVC9yav",
      "proof":
          "BLsigBhdyFSDUAP5fpw1Pv1YmP6HA1E5fcQTWZvrB3ctzzouV3EyvK8wLRACSy5dKDQacUNFNmf4nQDr4vUu6JxF1KoApiFTYxKmqMYXWtG1A8LqEqggNJYpGkmU8bcLY29gu4Pd91SjeU",
    },
    "hex":
        "720002298c03ed7d454a101eb7022bc95f7e5f41ac78e80734904e00004798d2cc98473d7e250c898885718afd2e4efbcb1a1595ab9730761ed830de0fff00000060b87c8522e2f71bf84194d4de2ab785e68cdc59134006d8bf685b3e2f5a0926214c7edaeadfb486978c8988d46a33f484167dcc84d0bd9ed21eee54d5977823b790ce63ca01704fdcf20a96f44f1c5044baee358f192ebe50f1ad45c60b05b6b1",
  },
  {
    "name": "smart_rollup_refute_move_dal_page_proof",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "34",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {
            "input_proof_kind": "reveal_proof",
            "reveal_proof": {
              "reveal_proof_kind": "dal_page_proof",
              "dal_page_id": {
                "published_level": 10,
                "slot_index": 0,
                "page_index": 0,
              },
              "dal_proof": "00",
            },
          },
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80722904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff01020000000a0000000000000100",
  },
  {
    "name": "smart_rollup_refute_move_dal_parameters_proof",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "34",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {
            "input_proof_kind": "reveal_proof",
            "reveal_proof": {"reveal_proof_kind": "dal_parameters_proof"},
          },
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80722904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff0103",
  },
  {
    "name": "smart_rollup_refute_move_first_input",
    "json": {
      "kind": "smart_rollup_refute",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "34",
      "gas_limit": "10000",
      "storage_limit": "0",
      "rollup": "sr1GG29rd2XtsHkYvHEmJrWBzCAYBwkXXi6j",
      "opponent": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "refutation": {
        "refutation_kind": "move",
        "choice": "0",
        "step": {
          "pvm_step": "00",
          "input_proof": {"input_proof_kind": "first_input"},
        },
      },
    },
    "hex":
        "cc0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80722904e007017010cbce8df86a42e8f8515baf6aa19848fdd00e7670f32038107a59a2b9cfefae36ea21f5aa63c0100010000000100ff02",
  },
  {
    "name": "attestation_with_dal_zero",
    "json": {
      "kind": "attestation_with_dal",
      "slot": 5,
      "level": 100,
      "round": 1,
      "block_payload_hash":
          "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
      "dal_attestation": "0",
    },
    "hex":
        "17000500000064000000018128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c8600",
  },
  {
    "name": "vdf_revelation",
    "json": {
      "kind": "vdf_revelation",
      "solution": [
        "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
        "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
      ],
    },
    "hex":
        "080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  },
  {
    "name": "zk_rollup_publish_empty",
    "json": {
      "kind": "zk_rollup_publish",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "1",
      "gas_limit": "10000",
      "storage_limit": "0",
      "zk_rollup": "epx16D48wS8mtjMzS6vWCXzQi7SJcXuRA378z",
      "op": [],
    },
    "hex":
        "fb0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80701904e00010101010101010101010101010101010101010100000000",
  },
  {
    "name": "zk_rollup_publish_one_op",
    "json": {
      "kind": "zk_rollup_publish",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "2",
      "gas_limit": "10000",
      "storage_limit": "0",
      "zk_rollup": "epx16D48wS8mtjMzS6vWCXzQi7SJcXuRA378z",
      "op": [
        [
          {
            "op_code": 0,
            "price": {
              "id": "expruJpGVgueH6vjZDZQRjgXUuHBi4Y6UQ3cbz6swP2FMVybvnDjm5",
              "amount": "0",
            },
            "l1_dst": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
            "rollup_id": "epx16D48wS8mtjMzS6vWCXzQi7SJcXuRA378z",
            "payload": [],
          },
          null,
        ],
      ],
    },
    "hex":
        "fb0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80702904e0001010101010101010101010101010101010101010000005300000000684e749ec79dbc86da95a51917741e565164cf2cd44970f0313e820810e9868b000002298c03ed7d454a101eb7022bc95f7e5f41ac7801010101010101010101010101010101010101010000000000",
  },
  {
    "name": "zk_rollup_publish_op_payload",
    "json": {
      "kind": "zk_rollup_publish",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1000",
      "counter": "3",
      "gas_limit": "10000",
      "storage_limit": "0",
      "zk_rollup": "epx16D48wS8mtjMzS6vWCXzQi7SJcXuRA378z",
      "op": [
        [
          {
            "op_code": 0,
            "price": {
              "id": "expruJpGVgueH6vjZDZQRjgXUuHBi4Y6UQ3cbz6swP2FMVybvnDjm5",
              "amount": "0",
            },
            "l1_dst": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
            "rollup_id": "epx16D48wS8mtjMzS6vWCXzQi7SJcXuRA378z",
            "payload": [
              "0000000000000000000000000000000000000000000000000000000000000000",
            ],
          },
          null,
        ],
      ],
    },
    "hex":
        "fb0002298c03ed7d454a101eb7022bc95f7e5f41ac78e80703904e0001010101010101010101010101010101010101010000007300000000684e749ec79dbc86da95a51917741e565164cf2cd44970f0313e820810e9868b000002298c03ed7d454a101eb7022bc95f7e5f41ac78010101010101010101010101010101010101010100000020000000000000000000000000000000000000000000000000000000000000000000",
  },
  {
    "name": "transaction_mutez_no_params",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "1000000",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00c0843d0000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "transaction_zero_amount",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "transaction_default_unit",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "default",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "transaction_default_int",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "default",
        "value": {"int": "42"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0000000002002a",
  },
  {
    "name": "transaction_root_unit",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "root",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0100000002030b",
  },
  {
    "name": "transaction_do_unit",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "do",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0200000002030b",
  },
  {
    "name": "transaction_set_delegate",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "set_delegate",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0300000002030b",
  },
  {
    "name": "transaction_remove_delegate",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "remove_delegate",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0400000002030b",
  },
  {
    "name": "transaction_deposit",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "deposit",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0500000002030b",
  },
  {
    "name": "transaction_stake",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "stake",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0600000002030b",
  },
  {
    "name": "transaction_unstake",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "unstake",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0700000002030b",
  },
  {
    "name": "transaction_finalize_unstake",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "finalize_unstake",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0800000002030b",
  },
  {
    "name": "transaction_set_delegate_parameters",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "set_delegate_parameters",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0900000002030b",
  },
  {
    "name": "transaction_named_foo",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "foo",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cffff03666f6f00000002030b",
  },
  {
    "name": "transaction_named_transfer",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "transfer",
        "value": {
          "prim": "Pair",
          "args": [
            {"string": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN"},
            {"int": "100"},
          ],
        },
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cffff087472616e736665720000002e07070100000024747a31676a614638315a525276647a6a6f627966564e7341655343365053636a6651774e00a401",
  },
  {
    "name": "transaction_default_pair",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "default",
        "value": {
          "prim": "Pair",
          "args": [
            {"int": "1"},
            {"int": "2"},
          ],
        },
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0000000006070700010002",
  },
  {
    "name": "transaction_large_amount",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "1500",
      "counter": "1",
      "gas_limit": "5000",
      "storage_limit": "0",
      "amount": "1000000000000",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78dc0b0188270080a094a58d1d0000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "transaction_to_self",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "1",
      "destination": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b0001000002298c03ed7d454a101eb7022bc95f7e5f41ac7800",
  },
  {
    "name": "transaction_storage_limit",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "10000",
      "storage_limit": "1000",
      "amount": "0",
      "destination": "tz1gjaF81ZRRvdzjobyfVNsAeSC6PScjfQwN",
      "parameters": {
        "entrypoint": "default",
        "value": {"string": "hello"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301904ee807000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff000000000a010000000568656c6c6f",
  },
  {
    "name": "transaction_to_kt1_KT1EY9XA",
    "json": {
      "kind": "transaction",
      "source": "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx",
      "fee": "500",
      "counter": "1",
      "gas_limit": "1520",
      "storage_limit": "0",
      "amount": "0",
      "destination": "KT1EY9XA4Z5tybQN5zmVUL5cntku1zTCBLTv",
      "parameters": {
        "entrypoint": "default",
        "value": {"prim": "Unit"},
      },
    },
    "hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b0000014151d57ddff98da8cd49f0f2cbf89465bcf267a40000",
  },
  {
    "name": "double_consensus_attestation",
    "json": {
      "kind": "double_consensus_operation_evidence",
      "slot": 0,
      "op1": {
        "branch": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "operations": {
          "kind": "attestation",
          "slot": 0,
          "level": 100,
          "round": 0,
          "block_payload_hash":
              "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        },
      },
      "op2": {
        "branch": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "operations": {
          "kind": "attestation",
          "slot": 0,
          "level": 100,
          "round": 1,
          "block_payload_hash":
              "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        },
      },
    },
    "hex":
        "0200000000004b8fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab815000000000064000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c860000004b8fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab815000000000064000000018128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86",
  },
  {
    "name": "double_consensus_preattestation",
    "json": {
      "kind": "double_consensus_operation_evidence",
      "slot": 5,
      "op1": {
        "branch": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "operations": {
          "kind": "preattestation",
          "slot": 5,
          "level": 200,
          "round": 0,
          "block_payload_hash":
              "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        },
      },
      "op2": {
        "branch": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "operations": {
          "kind": "preattestation",
          "slot": 5,
          "level": 200,
          "round": 2,
          "block_payload_hash":
              "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        },
      },
    },
    "hex":
        "0200050000004b8fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8140005000000c8000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c860000004b8fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8140005000000c8000000028128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86",
  },
  {
    "name": "double_baking_evidence",
    "json": {
      "kind": "double_baking_evidence",
      "bh1": {
        "level": 10,
        "proto": 1,
        "predecessor": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "timestamp": "2020-01-01T00:00:00Z",
        "validation_pass": 4,
        "operations_hash":
            "LLoZKi1iMzbeJrfrGWPFYmkLebcsha6vGskQ4rAXt2uMwQtBfRcjL",
        "fitness": [],
        "context": "CoUeJrcPBj3T3iJL3PY4jZHnmZa5rRZ87VQPdSBNBcwZRMWJGh9j",
        "payload_hash": "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        "payload_round": 0,
        "proof_of_work_nonce": "0000000000000000",
        "liquidity_baking_toggle_vote": "on",
        "signature":
            "sigMzJ4GVAvXEd2RjsKGfG2H9QvqTSKCZsuB2KiHbZRGFz72XgF6KaKADznh674fQgBatxw3xdHqTtMHUZAGRprxy64wg1aq",
      },
      "bh2": {
        "level": 10,
        "proto": 1,
        "predecessor": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "timestamp": "2020-01-01T00:00:00Z",
        "validation_pass": 4,
        "operations_hash":
            "LLoZKi1iMzbeJrfrGWPFYmkLebcsha6vGskQ4rAXt2uMwQtBfRcjL",
        "fitness": [],
        "context": "CoUeJrcPBj3T3iJL3PY4jZHnmZa5rRZ87VQPdSBNBcwZRMWJGh9j",
        "payload_hash": "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        "payload_round": 1,
        "proof_of_work_nonce": "0000000000000000",
        "liquidity_baking_toggle_vote": "on",
        "signature":
            "sigMzJ4GVAvXEd2RjsKGfG2H9QvqTSKCZsuB2KiHbZRGFz72XgF6KaKADznh674fQgBatxw3xdHqTtMHUZAGRprxy64wg1aq",
      },
    },
    "hex":
        "03000000e00000000a018fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8000000005e0be1000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00000000a018fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8000000005e0be1000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  },
  {
    "name": "double_baking_identical_headers",
    "json": {
      "kind": "double_baking_evidence",
      "bh1": {
        "level": 10,
        "proto": 1,
        "predecessor": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "timestamp": "2020-01-01T00:00:00Z",
        "validation_pass": 4,
        "operations_hash":
            "LLoZKi1iMzbeJrfrGWPFYmkLebcsha6vGskQ4rAXt2uMwQtBfRcjL",
        "fitness": [],
        "context": "CoUeJrcPBj3T3iJL3PY4jZHnmZa5rRZ87VQPdSBNBcwZRMWJGh9j",
        "payload_hash": "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        "payload_round": 0,
        "proof_of_work_nonce": "0000000000000000",
        "liquidity_baking_toggle_vote": "on",
        "signature":
            "sigMzJ4GVAvXEd2RjsKGfG2H9QvqTSKCZsuB2KiHbZRGFz72XgF6KaKADznh674fQgBatxw3xdHqTtMHUZAGRprxy64wg1aq",
      },
      "bh2": {
        "level": 10,
        "proto": 1,
        "predecessor": "BLockGenesisGenesisGenesisGenesisGenesisCCCCCeZiLHU",
        "timestamp": "2020-01-01T00:00:00Z",
        "validation_pass": 4,
        "operations_hash":
            "LLoZKi1iMzbeJrfrGWPFYmkLebcsha6vGskQ4rAXt2uMwQtBfRcjL",
        "fitness": [],
        "context": "CoUeJrcPBj3T3iJL3PY4jZHnmZa5rRZ87VQPdSBNBcwZRMWJGh9j",
        "payload_hash": "vh2f1KHNSndPnVtfzF5Gdg8EGfufMeHH6nJyqV2V7rhhHU9fdb7C",
        "payload_round": 0,
        "proof_of_work_nonce": "0000000000000000",
        "liquidity_baking_toggle_vote": "on",
        "signature":
            "sigMzJ4GVAvXEd2RjsKGfG2H9QvqTSKCZsuB2KiHbZRGFz72XgF6KaKADznh674fQgBatxw3xdHqTtMHUZAGRprxy64wg1aq",
      },
    },
    "hex":
        "03000000e00000000a018fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8000000005e0be1000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00000000a018fcf233671b6a04fcf679d2a381c2544ea6c1ea29ba6157776ed842426e5cab8000000005e0be1000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008128caf996acf84dd02e0e093565abbfb55153c2f7fbfb8949f63997bd694c86000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  },
];
