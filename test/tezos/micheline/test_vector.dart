const List<Map<String, dynamic>> michelineNestedTestVector = [
  {
    "name": "deep_pair_8",
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {
          "prim": "Pair",
          "args": [
            {"int": "2"},
            {
              "prim": "Pair",
              "args": [
                {"int": "3"},
                {
                  "prim": "Pair",
                  "args": [
                    {"int": "4"},
                    {
                      "prim": "Pair",
                      "args": [
                        {"int": "5"},
                        {
                          "prim": "Pair",
                          "args": [
                            {"int": "6"},
                            {
                              "prim": "Pair",
                              "args": [
                                {"int": "7"},
                                {"int": "8"},
                              ],
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    },
    "hex": "070700010707000207070003070700040707000507070006070700070008",
    "bytes": 30,
  },
  {
    "name": "deep_pair_16",
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {
          "prim": "Pair",
          "args": [
            {"int": "2"},
            {
              "prim": "Pair",
              "args": [
                {"int": "3"},
                {
                  "prim": "Pair",
                  "args": [
                    {"int": "4"},
                    {
                      "prim": "Pair",
                      "args": [
                        {"int": "5"},
                        {
                          "prim": "Pair",
                          "args": [
                            {"int": "6"},
                            {
                              "prim": "Pair",
                              "args": [
                                {"int": "7"},
                                {
                                  "prim": "Pair",
                                  "args": [
                                    {"int": "8"},
                                    {
                                      "prim": "Pair",
                                      "args": [
                                        {"int": "9"},
                                        {
                                          "prim": "Pair",
                                          "args": [
                                            {"int": "10"},
                                            {
                                              "prim": "Pair",
                                              "args": [
                                                {"int": "11"},
                                                {
                                                  "prim": "Pair",
                                                  "args": [
                                                    {"int": "12"},
                                                    {
                                                      "prim": "Pair",
                                                      "args": [
                                                        {"int": "13"},
                                                        {
                                                          "prim": "Pair",
                                                          "args": [
                                                            {"int": "14"},
                                                            {
                                                              "prim": "Pair",
                                                              "args": [
                                                                {"int": "15"},
                                                                {"int": "16"},
                                                              ],
                                                            },
                                                          ],
                                                        },
                                                      ],
                                                    },
                                                  ],
                                                },
                                              ],
                                            },
                                          ],
                                        },
                                      ],
                                    },
                                  ],
                                },
                              ],
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    },
    "hex":
        "0707000107070002070700030707000407070005070700060707000707070008070700090707000a0707000b0707000c0707000d0707000e0707000f0010",
    "bytes": 62,
  },
  {
    "name": "deep_some_10",
    "json": {
      "prim": "Some",
      "args": [
        {
          "prim": "Some",
          "args": [
            {
              "prim": "Some",
              "args": [
                {
                  "prim": "Some",
                  "args": [
                    {
                      "prim": "Some",
                      "args": [
                        {
                          "prim": "Some",
                          "args": [
                            {
                              "prim": "Some",
                              "args": [
                                {
                                  "prim": "Some",
                                  "args": [
                                    {
                                      "prim": "Some",
                                      "args": [
                                        {
                                          "prim": "Some",
                                          "args": [
                                            {"prim": "Unit"},
                                          ],
                                        },
                                      ],
                                    },
                                  ],
                                },
                              ],
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    },
    "hex": "0509050905090509050905090509050905090509030b",
    "bytes": 22,
  },
  {
    "name": "mixed_sequence",
    "json": [
      {"int": "0"},
      {"string": "hello"},
      {"bytes": "deadbeef"},
      {"prim": "Unit"},
      {"prim": "True"},
      {"prim": "False"},
      {"prim": "None"},
      {
        "prim": "Pair",
        "args": [
          {"int": "1"},
          {"int": "2"},
        ],
      },
      {
        "prim": "Some",
        "args": [
          {"string": "x"},
        ],
      },
      {
        "prim": "Left",
        "args": [
          {"prim": "Unit"},
        ],
      },
      {
        "prim": "Right",
        "args": [
          {"int": "99"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"string": "k"},
          {"int": "1"},
        ],
      },
    ],
    "hex":
        "020000003e0000010000000568656c6c6f0a00000004deadbeef030b030a0303030607070001000205090100000001780505030b050800a301070401000000016b0001",
    "bytes": 67,
  },
  {
    "name": "nested_sequences",
    "json": [
      [
        {"int": "1"},
        {"int": "2"},
      ],
      [
        {"string": "a"},
        {"string": "b"},
        {"string": "c"},
      ],
      [
        {"prim": "Unit"},
        [
          {"int": "0"},
        ],
      ],
    ],
    "hex":
        "020000002e02000000040001000202000000120100000001610100000001620100000001630200000009030b02000000020000",
    "bytes": 51,
  },
  {
    "name": "script_skeleton",
    "json": [
      {
        "prim": "parameter",
        "args": [
          {"prim": "unit"},
        ],
      },
      {
        "prim": "storage",
        "args": [
          {"prim": "nat"},
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
    "hex": "02000000170500036c05010362050202000000080317053d036d0342",
    "bytes": 28,
  },
  {
    "name": "map_20_elts",
    "json": [
      {
        "prim": "Elt",
        "args": [
          {"int": "0"},
          {"string": "val_0"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "1"},
          {"string": "val_1"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "2"},
          {"string": "val_2"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "3"},
          {"string": "val_3"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "4"},
          {"string": "val_4"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "5"},
          {"string": "val_5"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "6"},
          {"string": "val_6"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "7"},
          {"string": "val_7"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "8"},
          {"string": "val_8"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "9"},
          {"string": "val_9"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "10"},
          {"string": "val_10"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "11"},
          {"string": "val_11"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "12"},
          {"string": "val_12"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "13"},
          {"string": "val_13"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "14"},
          {"string": "val_14"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "15"},
          {"string": "val_15"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "16"},
          {"string": "val_16"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "17"},
          {"string": "val_17"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "18"},
          {"string": "val_18"},
        ],
      },
      {
        "prim": "Elt",
        "args": [
          {"int": "19"},
          {"string": "val_19"},
        ],
      },
    ],
    "hex":
        "020000012207040000010000000576616c5f3007040001010000000576616c5f3107040002010000000576616c5f3207040003010000000576616c5f3307040004010000000576616c5f3407040005010000000576616c5f3507040006010000000576616c5f3607040007010000000576616c5f3707040008010000000576616c5f3807040009010000000576616c5f390704000a010000000676616c5f31300704000b010000000676616c5f31310704000c010000000676616c5f31320704000d010000000676616c5f31330704000e010000000676616c5f31340704000f010000000676616c5f313507040010010000000676616c5f313607040011010000000676616c5f313707040012010000000676616c5f313807040013010000000676616c5f3139",
    "bytes": 295,
  },
  {
    "name": "nested_with_annots",
    "json": {
      "prim": "Pair",
      "args": [
        {
          "prim": "Some",
          "args": [
            {"int": "1"},
          ],
          "annots": ["%left"],
        },
        {
          "prim": "None",
          "annots": ["%right", "@x"],
        },
      ],
      "annots": ["%root", ":pair"],
    },
    "hex":
        "08070609000100000005256c6566740406000000092572696768742040780000000b25726f6f74203a70616972",
    "bytes": 45,
  },
  {
    "name": "prim_generic_4args",
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {"int": "2"},
        {"int": "3"},
        {"int": "4"},
      ],
      "annots": ["%g"],
    },
    "hex": "0907000000080001000200030004000000022567",
    "bytes": 20,
  },
  {
    "name": "string_256",
    "json": {
      "string":
          "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    },
    "hex":
        "010000010041414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141",
    "bytes": 261,
  },
  {
    "name": "bytes_128",
    "json": {
      "bytes":
          "abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababab",
    },
    "hex":
        "0a00000080abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababab",
    "bytes": 133,
  },
  {
    "name": "int_big",
    "json": {
      "int":
          "115792089237316195423570985008687907853269984665640564039457584007913129639936",
    },
    "hex":
        "0080808080808080808080808080808080808080808080808080808080808080808080808020",
    "bytes": 38,
  },
  {
    "name": "int_neg_big",
    "json": {"int": "-340282366920938463463374607431768211456"},
    "hex": "00c0808080808080808080808080808080808008",
    "bytes": 20,
  },
  {
    "name": "lambda_add",
    "json": {
      "prim": "LAMBDA",
      "args": [
        {
          "prim": "pair",
          "args": [
            {"prim": "nat"},
            {"prim": "nat"},
          ],
        },
        {"prim": "nat"},
        [
          {"prim": "UNPAIR"},
          {"prim": "ADD"},
        ],
      ],
    },
    "hex": "09310000001107650362036203620200000004037a031200000000",
    "bytes": 27,
  },
  {
    "name": "complex_state_tree",
    "json": {
      "prim": "Pair",
      "args": [
        {
          "prim": "Left",
          "args": [
            {
              "prim": "Pair",
              "args": [
                {"string": "alice"},
                {
                  "prim": "Some",
                  "args": [
                    {"int": "1000000"},
                  ],
                },
              ],
              "annots": ["%account"],
            },
          ],
        },
        {
          "prim": "Right",
          "args": [
            [
              {
                "prim": "Elt",
                "args": [
                  {
                    "bytes":
                        "0000000000000000000000000000000000000000000000000000000000000000",
                  },
                  {
                    "prim": "Pair",
                    "args": [
                      {"int": "1"},
                      {"prim": "True"},
                    ],
                  },
                ],
              },
              {
                "prim": "Elt",
                "args": [
                  {
                    "bytes":
                        "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
                  },
                  {
                    "prim": "Pair",
                    "args": [
                      {"int": "2"},
                      {"prim": "False"},
                    ],
                  },
                ],
              },
            ],
          ],
        },
      ],
      "annots": ["%state"],
    },
    "hex":
        "0807050508070100000005616c69636505090080897a00000008256163636f756e740508020000005a07040a00000020000000000000000000000000000000000000000000000000000000000000000007070001030a07040a00000020ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff07070002030300000006257374617465",
    "bytes": 141,
  },
  {
    "name": "seq_50_ints",
    "json": [
      {"int": "0"},
      {"int": "1"},
      {"int": "2"},
      {"int": "3"},
      {"int": "4"},
      {"int": "5"},
      {"int": "6"},
      {"int": "7"},
      {"int": "8"},
      {"int": "9"},
      {"int": "10"},
      {"int": "11"},
      {"int": "12"},
      {"int": "13"},
      {"int": "14"},
      {"int": "15"},
      {"int": "16"},
      {"int": "17"},
      {"int": "18"},
      {"int": "19"},
      {"int": "20"},
      {"int": "21"},
      {"int": "22"},
      {"int": "23"},
      {"int": "24"},
      {"int": "25"},
      {"int": "26"},
      {"int": "27"},
      {"int": "28"},
      {"int": "29"},
      {"int": "30"},
      {"int": "31"},
      {"int": "32"},
      {"int": "33"},
      {"int": "34"},
      {"int": "35"},
      {"int": "36"},
      {"int": "37"},
      {"int": "38"},
      {"int": "39"},
      {"int": "40"},
      {"int": "41"},
      {"int": "42"},
      {"int": "43"},
      {"int": "44"},
      {"int": "45"},
      {"int": "46"},
      {"int": "47"},
      {"int": "48"},
      {"int": "49"},
    ],
    "hex":
        "02000000640000000100020003000400050006000700080009000a000b000c000d000e000f0010001100120013001400150016001700180019001a001b001c001d001e001f0020002100220023002400250026002700280029002a002b002c002d002e002f00300031",
    "bytes": 105,
  },
  {
    "name": "push_nat_42",
    "json": {
      "prim": "PUSH",
      "args": [
        {"prim": "nat"},
        {"int": "42"},
      ],
    },
    "hex": "07430362002a",
    "bytes": 6,
  },

  {
    "name": "MichelineInt",
    "tag": 0,
    "json": {"int": "42"},
    "hex": "002a",
  },
  {
    "name": "MichelineInt_zero",
    "tag": 0,
    "json": {"int": "0"},
    "hex": "0000",
  },
  {
    "name": "MichelineInt_neg",
    "tag": 0,
    "json": {"int": "-1"},
    "hex": "0041",
  },
  {
    "name": "MichelineString",
    "tag": 1,
    "json": {"string": "hello"},
    "hex": "010000000568656c6c6f",
  },
  {
    "name": "MichelineString_empty",
    "tag": 1,
    "json": {"string": ""},
    "hex": "0100000000",
  },
  {
    "name": "MichelineSequence",
    "tag": 2,
    "json": [
      {"int": "1"},
      {"string": "a"},
    ],
    "hex": "02000000080001010000000161",
  },
  {
    "name": "MichelineSequence_empty",
    "tag": 2,
    "json": [],
    "hex": "0200000000",
  },
  {
    "name": "MichelinePrimNoArgsNoAnnots",
    "tag": 3,
    "json": {"prim": "Unit"},
    "hex": "030b",
  },
  {
    "name": "MichelinePrimNoArgsSomeAnnots",
    "tag": 4,
    "json": {
      "prim": "Unit",
      "annots": ["%x"],
    },
    "hex": "040b000000022578",
  },
  {
    "name": "MichelinePrim1ArgNoAnnots",
    "tag": 5,
    "json": {
      "prim": "Some",
      "args": [
        {"int": "1"},
      ],
    },
    "hex": "05090001",
  },
  {
    "name": "MichelinePrim1ArgSomeAnnots",
    "tag": 6,
    "json": {
      "prim": "Some",
      "args": [
        {"int": "1"},
      ],
      "annots": ["%x"],
    },
    "hex": "06090001000000022578",
  },
  {
    "name": "MichelinePrim2ArgsNoAnnots",
    "tag": 7,
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {"int": "2"},
      ],
    },
    "hex": "070700010002",
  },
  {
    "name": "MichelinePrim2ArgsSomeAnnots",
    "tag": 8,
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {"int": "2"},
      ],
      "annots": ["%p"],
    },
    "hex": "080700010002000000022570",
  },
  {
    "name": "MichelinePrimGeneric",
    "tag": 9,
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {"int": "2"},
        {"int": "3"},
      ],
    },
    "hex": "09070000000600010002000300000000",
  },
  {
    "name": "MichelinePrimGeneric_annots",
    "tag": 9,
    "json": {
      "prim": "Pair",
      "args": [
        {"int": "1"},
        {"int": "2"},
        {"int": "3"},
      ],
      "annots": ["%g"],
    },
    "hex": "090700000006000100020003000000022567",
  },
  {
    "name": "MichelineBytes",
    "tag": 10,
    "json": {"bytes": "deadbeef"},
    "hex": "0a00000004deadbeef",
  },
  {
    "name": "MichelineBytes_empty",
    "tag": 10,
    "json": {"bytes": ""},
    "hex": "0a00000000",
  },
];
