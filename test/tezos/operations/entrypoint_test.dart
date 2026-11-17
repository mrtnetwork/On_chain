import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/tezos.dart';
import 'package:test/test.dart';

import '../../utils.dart';

void entrypointTest() {
  group('Tezos/Entrypoint', () {
    test("entrypoint", () {
      for (final i in testVector) {
        final decode = TezosContractParameters.deserializeJson(
          i.valueAs("json_parameters"),
        );
        expect(decode.toJson(), i.valueAs("json_parameters"));
        expect(decode.serializeHex(), i.valueAs("parameters_wire_hex"));
      }
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(entrypointTest, "Entrypoint");
}

const List<Map<String, dynamic>> testVector = [
  {
    "name": "entrypoint_default",
    "entrypoint": "default",
    "entrypoint_tag": 0,
    "json_parameters": {
      "entrypoint": "default",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63c00",
  },
  {
    "name": "entrypoint_root",
    "entrypoint": "root",
    "entrypoint_tag": 1,
    "json_parameters": {
      "entrypoint": "root",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0100000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0100000002030b",
  },
  {
    "name": "entrypoint_do",
    "entrypoint": "do",
    "entrypoint_tag": 2,
    "json_parameters": {
      "entrypoint": "do",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0200000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0200000002030b",
  },
  {
    "name": "entrypoint_set_delegate",
    "entrypoint": "set_delegate",
    "entrypoint_tag": 3,
    "json_parameters": {
      "entrypoint": "set_delegate",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0300000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0300000002030b",
  },
  {
    "name": "entrypoint_remove_delegate",
    "entrypoint": "remove_delegate",
    "entrypoint_tag": 4,
    "json_parameters": {
      "entrypoint": "remove_delegate",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0400000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0400000002030b",
  },
  {
    "name": "entrypoint_deposit",
    "entrypoint": "deposit",
    "entrypoint_tag": 5,
    "json_parameters": {
      "entrypoint": "deposit",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0500000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0500000002030b",
  },
  {
    "name": "entrypoint_stake",
    "entrypoint": "stake",
    "entrypoint_tag": 6,
    "json_parameters": {
      "entrypoint": "stake",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0600000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0600000002030b",
  },
  {
    "name": "entrypoint_unstake",
    "entrypoint": "unstake",
    "entrypoint_tag": 7,
    "json_parameters": {
      "entrypoint": "unstake",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0700000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0700000002030b",
  },
  {
    "name": "entrypoint_finalize_unstake",
    "entrypoint": "finalize_unstake",
    "entrypoint_tag": 8,
    "json_parameters": {
      "entrypoint": "finalize_unstake",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0800000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0800000002030b",
  },
  {
    "name": "entrypoint_set_delegate_parameters",
    "entrypoint": "set_delegate_parameters",
    "entrypoint_tag": 9,
    "json_parameters": {
      "entrypoint": "set_delegate_parameters",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "0900000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cff0900000002030b",
  },
  {
    "name": "entrypoint_foo",
    "entrypoint": "foo",
    "entrypoint_tag": 255,
    "json_parameters": {
      "entrypoint": "foo",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "ff03666f6f00000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cffff03666f6f00000002030b",
  },
  {
    "name": "entrypoint_my_entry",
    "entrypoint": "my_entry",
    "entrypoint_tag": 255,
    "json_parameters": {
      "entrypoint": "my_entry",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "ff086d795f656e74727900000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cffff086d795f656e74727900000002030b",
  },
  {
    "name": "entrypoint_default_entry",
    "entrypoint": "default_entry",
    "entrypoint_tag": 255,
    "json_parameters": {
      "entrypoint": "default_entry",
      "value": {"prim": "Unit"},
    },
    "parameters_wire_hex": "ff0d64656661756c745f656e74727900000002030b",
    "full_transaction_hex":
        "6c0002298c03ed7d454a101eb7022bc95f7e5f41ac78f40301f00b00000000e7670f32038107a59a2b9cfefae36ea21f5aa63cffff0d64656661756c745f656e74727900000002030b",
  },
];
