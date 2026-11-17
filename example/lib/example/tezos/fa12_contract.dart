const List<Map<String, dynamic>> smartpyF12ExampleCode = [
  {
    "prim": "storage",
    "args": [
      {
        "prim": "pair",
        "args": [
          {
            "prim": "address",
            "annots": ["%administrator"],
          },
          {
            "prim": "pair",
            "args": [
              {
                "prim": "big_map",
                "args": [
                  {"prim": "address"},
                  {
                    "prim": "pair",
                    "args": [
                      {
                        "prim": "map",
                        "args": [
                          {"prim": "address"},
                          {"prim": "nat"},
                        ],
                        "annots": ["%approvals"],
                      },
                      {
                        "prim": "nat",
                        "annots": ["%balance"],
                      },
                    ],
                  },
                ],
                "annots": ["%ledger"],
              },
              {
                "prim": "pair",
                "args": [
                  {
                    "prim": "big_map",
                    "args": [
                      {"prim": "string"},
                      {"prim": "bytes"},
                    ],
                    "annots": ["%metadata"],
                  },
                  {
                    "prim": "pair",
                    "args": [
                      {
                        "prim": "bool",
                        "annots": ["%paused"],
                      },
                      {
                        "prim": "pair",
                        "args": [
                          {
                            "prim": "big_map",
                            "args": [
                              {"prim": "nat"},
                              {
                                "prim": "pair",
                                "args": [
                                  {
                                    "prim": "nat",
                                    "annots": ["%token_id"],
                                  },
                                  {
                                    "prim": "map",
                                    "args": [
                                      {"prim": "string"},
                                      {"prim": "bytes"},
                                    ],
                                    "annots": ["%token_info"],
                                  },
                                ],
                              },
                            ],
                            "annots": ["%token_metadata"],
                          },
                          {
                            "prim": "nat",
                            "annots": ["%total_supply"],
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
  {
    "prim": "parameter",
    "args": [
      {
        "prim": "or",
        "args": [
          {
            "prim": "or",
            "args": [
              {
                "prim": "or",
                "args": [
                  {
                    "prim": "pair",
                    "args": [
                      {
                        "prim": "address",
                        "annots": ["%spender"],
                      },
                      {
                        "prim": "nat",
                        "annots": ["%value"],
                      },
                    ],
                    "annots": ["%approve"],
                  },
                  {
                    "prim": "pair",
                    "args": [
                      {
                        "prim": "address",
                        "annots": ["%address"],
                      },
                      {
                        "prim": "nat",
                        "annots": ["%value"],
                      },
                    ],
                    "annots": ["%burn"],
                  },
                ],
              },
              {
                "prim": "or",
                "args": [
                  {
                    "prim": "pair",
                    "args": [
                      {"prim": "unit"},
                      {
                        "prim": "contract",
                        "args": [
                          {"prim": "address"},
                        ],
                      },
                    ],
                    "annots": ["%getAdministrator"],
                  },
                  {
                    "prim": "or",
                    "args": [
                      {
                        "prim": "pair",
                        "args": [
                          {
                            "prim": "pair",
                            "args": [
                              {
                                "prim": "address",
                                "annots": ["%owner"],
                              },
                              {
                                "prim": "address",
                                "annots": ["%spender"],
                              },
                            ],
                          },
                          {
                            "prim": "contract",
                            "args": [
                              {"prim": "nat"},
                            ],
                          },
                        ],
                        "annots": ["%getAllowance"],
                      },
                      {
                        "prim": "pair",
                        "args": [
                          {"prim": "address"},
                          {
                            "prim": "contract",
                            "args": [
                              {"prim": "nat"},
                            ],
                          },
                        ],
                        "annots": ["%getBalance"],
                      },
                    ],
                  },
                ],
              },
            ],
          },
          {
            "prim": "or",
            "args": [
              {
                "prim": "or",
                "args": [
                  {
                    "prim": "pair",
                    "args": [
                      {"prim": "unit"},
                      {
                        "prim": "contract",
                        "args": [
                          {"prim": "nat"},
                        ],
                      },
                    ],
                    "annots": ["%getTotalSupply"],
                  },
                  {
                    "prim": "or",
                    "args": [
                      {
                        "prim": "pair",
                        "args": [
                          {
                            "prim": "address",
                            "annots": ["%address"],
                          },
                          {
                            "prim": "nat",
                            "annots": ["%value"],
                          },
                        ],
                        "annots": ["%mint"],
                      },
                      {
                        "prim": "address",
                        "annots": ["%setAdministrator"],
                      },
                    ],
                  },
                ],
              },
              {
                "prim": "or",
                "args": [
                  {
                    "prim": "bool",
                    "annots": ["%setPause"],
                  },
                  {
                    "prim": "or",
                    "args": [
                      {
                        "prim": "pair",
                        "args": [
                          {
                            "prim": "address",
                            "annots": ["%from"],
                          },
                          {
                            "prim": "pair",
                            "args": [
                              {
                                "prim": "address",
                                "annots": ["%to"],
                              },
                              {
                                "prim": "nat",
                                "annots": ["%value"],
                              },
                            ],
                          },
                        ],
                        "annots": ["%transfer"],
                      },
                      {
                        "prim": "pair",
                        "args": [
                          {
                            "prim": "string",
                            "annots": ["%key"],
                          },
                          {
                            "prim": "bytes",
                            "annots": ["%value"],
                          },
                        ],
                        "annots": ["%update_metadata"],
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
  {
    "prim": "code",
    "args": [
      [
        {
          "prim": "LAMBDA",
          "args": [
            {
              "prim": "pair",
              "args": [
                {"prim": "address"},
                {
                  "prim": "pair",
                  "args": [
                    {"prim": "address"},
                    {
                      "prim": "pair",
                      "args": [
                        {
                          "prim": "big_map",
                          "args": [
                            {"prim": "address"},
                            {
                              "prim": "pair",
                              "args": [
                                {
                                  "prim": "map",
                                  "args": [
                                    {"prim": "address"},
                                    {"prim": "nat"},
                                  ],
                                },
                                {"prim": "nat"},
                              ],
                            },
                          ],
                        },
                        {
                          "prim": "pair",
                          "args": [
                            {
                              "prim": "big_map",
                              "args": [
                                {"prim": "string"},
                                {"prim": "bytes"},
                              ],
                            },
                            {
                              "prim": "pair",
                              "args": [
                                {"prim": "bool"},
                                {
                                  "prim": "pair",
                                  "args": [
                                    {
                                      "prim": "big_map",
                                      "args": [
                                        {"prim": "nat"},
                                        {
                                          "prim": "pair",
                                          "args": [
                                            {"prim": "nat"},
                                            {
                                              "prim": "map",
                                              "args": [
                                                {"prim": "string"},
                                                {"prim": "bytes"},
                                              ],
                                            },
                                          ],
                                        },
                                      ],
                                    },
                                    {"prim": "nat"},
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
            {
              "prim": "pair",
              "args": [
                {"prim": "bool"},
                {
                  "prim": "pair",
                  "args": [
                    {"prim": "address"},
                    {
                      "prim": "pair",
                      "args": [
                        {
                          "prim": "big_map",
                          "args": [
                            {"prim": "address"},
                            {
                              "prim": "pair",
                              "args": [
                                {
                                  "prim": "map",
                                  "args": [
                                    {"prim": "address"},
                                    {"prim": "nat"},
                                  ],
                                },
                                {"prim": "nat"},
                              ],
                            },
                          ],
                        },
                        {
                          "prim": "pair",
                          "args": [
                            {
                              "prim": "big_map",
                              "args": [
                                {"prim": "string"},
                                {"prim": "bytes"},
                              ],
                            },
                            {
                              "prim": "pair",
                              "args": [
                                {"prim": "bool"},
                                {
                                  "prim": "pair",
                                  "args": [
                                    {
                                      "prim": "big_map",
                                      "args": [
                                        {"prim": "nat"},
                                        {
                                          "prim": "pair",
                                          "args": [
                                            {"prim": "nat"},
                                            {
                                              "prim": "map",
                                              "args": [
                                                {"prim": "string"},
                                                {"prim": "bytes"},
                                              ],
                                            },
                                          ],
                                        },
                                      ],
                                    },
                                    {"prim": "nat"},
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
            [
              {"prim": "UNPAIR"},
              {
                "prim": "DUP",
                "args": [
                  {"int": "2"},
                ],
              },
              {"prim": "CAR"},
              {"prim": "COMPARE"},
              {"prim": "EQ"},
              {"prim": "PAIR"},
            ],
          ],
        },
        {"prim": "SWAP"},
        {
          "prim": "LAMBDA",
          "args": [
            {
              "prim": "pair",
              "args": [
                {"prim": "unit"},
                {
                  "prim": "pair",
                  "args": [
                    {"prim": "address"},
                    {
                      "prim": "pair",
                      "args": [
                        {
                          "prim": "big_map",
                          "args": [
                            {"prim": "address"},
                            {
                              "prim": "pair",
                              "args": [
                                {
                                  "prim": "map",
                                  "args": [
                                    {"prim": "address"},
                                    {"prim": "nat"},
                                  ],
                                },
                                {"prim": "nat"},
                              ],
                            },
                          ],
                        },
                        {
                          "prim": "pair",
                          "args": [
                            {
                              "prim": "big_map",
                              "args": [
                                {"prim": "string"},
                                {"prim": "bytes"},
                              ],
                            },
                            {
                              "prim": "pair",
                              "args": [
                                {"prim": "bool"},
                                {
                                  "prim": "pair",
                                  "args": [
                                    {
                                      "prim": "big_map",
                                      "args": [
                                        {"prim": "nat"},
                                        {
                                          "prim": "pair",
                                          "args": [
                                            {"prim": "nat"},
                                            {
                                              "prim": "map",
                                              "args": [
                                                {"prim": "string"},
                                                {"prim": "bytes"},
                                              ],
                                            },
                                          ],
                                        },
                                      ],
                                    },
                                    {"prim": "nat"},
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
            {
              "prim": "pair",
              "args": [
                {"prim": "bool"},
                {
                  "prim": "pair",
                  "args": [
                    {"prim": "address"},
                    {
                      "prim": "pair",
                      "args": [
                        {
                          "prim": "big_map",
                          "args": [
                            {"prim": "address"},
                            {
                              "prim": "pair",
                              "args": [
                                {
                                  "prim": "map",
                                  "args": [
                                    {"prim": "address"},
                                    {"prim": "nat"},
                                  ],
                                },
                                {"prim": "nat"},
                              ],
                            },
                          ],
                        },
                        {
                          "prim": "pair",
                          "args": [
                            {
                              "prim": "big_map",
                              "args": [
                                {"prim": "string"},
                                {"prim": "bytes"},
                              ],
                            },
                            {
                              "prim": "pair",
                              "args": [
                                {"prim": "bool"},
                                {
                                  "prim": "pair",
                                  "args": [
                                    {
                                      "prim": "big_map",
                                      "args": [
                                        {"prim": "nat"},
                                        {
                                          "prim": "pair",
                                          "args": [
                                            {"prim": "nat"},
                                            {
                                              "prim": "map",
                                              "args": [
                                                {"prim": "string"},
                                                {"prim": "bytes"},
                                              ],
                                            },
                                          ],
                                        },
                                      ],
                                    },
                                    {"prim": "nat"},
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
            [
              {"prim": "CDR"},
              {"prim": "DUP"},
              {
                "prim": "GET",
                "args": [
                  {"int": "7"},
                ],
              },
              {"prim": "PAIR"},
            ],
          ],
        },
        {"prim": "SWAP"},
        {"prim": "UNPAIR"},
        {
          "prim": "IF_LEFT",
          "args": [
            [
              {
                "prim": "IF_LEFT",
                "args": [
                  [
                    {
                      "prim": "IF_LEFT",
                      "args": [
                        [
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "DROP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "UNIT"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "PAIR"},
                          {"prim": "EXEC"},
                          {"prim": "UNPAIR"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DUG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "IF",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "string"},
                                    {"string": "FA1.2_Paused"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                              [],
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "SENDER"},
                          {"prim": "GET"},
                          {
                            "prim": "IF_NONE",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {
                                      "prim": "pair",
                                      "args": [
                                        {
                                          "prim": "map",
                                          "args": [
                                            {"prim": "address"},
                                            {"prim": "nat"},
                                          ],
                                        },
                                        {"prim": "nat"},
                                      ],
                                    },
                                    {
                                      "prim": "Pair",
                                      "args": [
                                        [],
                                        {"int": "0"},
                                      ],
                                    },
                                  ],
                                },
                              ],
                              [],
                            ],
                          },
                          {"prim": "DUP"},
                          {"prim": "CAR"},
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "CAR"},
                          {"prim": "GET"},
                          {
                            "prim": "IF_NONE",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "nat"},
                                    {"int": "0"},
                                  ],
                                },
                              ],
                              [],
                            ],
                          },
                          {
                            "prim": "PUSH",
                            "args": [
                              {"prim": "nat"},
                              {"int": "0"},
                            ],
                          },
                          {"prim": "COMPARE"},
                          {"prim": "EQ"},
                          {
                            "prim": "IF",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "bool"},
                                    {"prim": "True"},
                                  ],
                                },
                              ],
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "nat"},
                                    {"int": "0"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "CDR"},
                                {"prim": "COMPARE"},
                                {"prim": "EQ"},
                              ],
                            ],
                          },
                          {
                            "prim": "IF",
                            "args": [
                              [],
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "string"},
                                    {"string": "FA1.2_UnsafeAllowanceChange"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                            ],
                          },
                          {"prim": "DUP"},
                          {"prim": "CAR"},
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "CDR"},
                          {"prim": "SOME"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "CAR"},
                          {"prim": "UPDATE"},
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "1"},
                            ],
                          },
                          {"prim": "SWAP"},
                          {"prim": "DUP"},
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "SOME"},
                          {"prim": "SENDER"},
                          {"prim": "UPDATE"},
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                        ],
                        [
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DROP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "SENDER"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "PAIR"},
                          {"prim": "EXEC"},
                          {"prim": "UNPAIR"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DUG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "IF",
                            "args": [
                              [],
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "string"},
                                    {"string": "Fa1.2_NotAdmin"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "CAR"},
                          {"prim": "GET"},
                          {
                            "prim": "IF_NONE",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {
                                      "prim": "pair",
                                      "args": [
                                        {
                                          "prim": "map",
                                          "args": [
                                            {"prim": "address"},
                                            {"prim": "nat"},
                                          ],
                                        },
                                        {"prim": "nat"},
                                      ],
                                    },
                                    {
                                      "prim": "Pair",
                                      "args": [
                                        [],
                                        {"int": "0"},
                                      ],
                                    },
                                  ],
                                },
                              ],
                              [],
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "CDR"},
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "CDR"},
                          {"prim": "SUB"},
                          {"prim": "ISNAT"},
                          {
                            "prim": "IF_NONE",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "string"},
                                    {"string": "FA1.2_InsufficientBalance"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                              [],
                            ],
                          },
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DUP"},
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "SOME"},
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "4"},
                            ],
                          },
                          {"prim": "CAR"},
                          {"prim": "UPDATE"},
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {"prim": "SWAP"},
                          {"prim": "CDR"},
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "10"},
                            ],
                          },
                          {"prim": "SUB"},
                          {"prim": "ISNAT"},
                          {
                            "prim": "IF_NONE",
                            "args": [
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "int"},
                                    {"int": "233"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                              [],
                            ],
                          },
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "10"},
                            ],
                          },
                        ],
                      ],
                    },
                    {
                      "prim": "NIL",
                      "args": [
                        {"prim": "operation"},
                      ],
                    },
                  ],
                  [
                    {
                      "prim": "DIG",
                      "args": [
                        {"int": "3"},
                      ],
                    },
                    {"prim": "DROP"},
                    {
                      "prim": "IF_LEFT",
                      "args": [
                        [
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DROP"},
                          {"prim": "CDR"},
                          {
                            "prim": "NIL",
                            "args": [
                              {"prim": "operation"},
                            ],
                          },
                          {"prim": "SWAP"},
                          {
                            "prim": "PUSH",
                            "args": [
                              {"prim": "mutez"},
                              {"int": "0"},
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "4"},
                            ],
                          },
                          {"prim": "CAR"},
                          {"prim": "TRANSFER_TOKENS"},
                          {"prim": "CONS"},
                        ],
                        [
                          {
                            "prim": "IF_LEFT",
                            "args": [
                              [
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DROP"},
                                {"prim": "UNPAIR"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {
                                            "prim": "pair",
                                            "args": [
                                              {
                                                "prim": "map",
                                                "args": [
                                                  {"prim": "address"},
                                                  {"prim": "nat"},
                                                ],
                                              },
                                              {"prim": "nat"},
                                            ],
                                          },
                                          {
                                            "prim": "Pair",
                                            "args": [
                                              [],
                                              {"int": "0"},
                                            ],
                                          },
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "SWAP"},
                                {"prim": "CDR"},
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {"prim": "nat"},
                                          {"int": "0"},
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {
                                  "prim": "NIL",
                                  "args": [
                                    {"prim": "operation"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "mutez"},
                                    {"int": "0"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "TRANSFER_TOKENS"},
                                {"prim": "CONS"},
                              ],
                              [
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DROP"},
                                {"prim": "UNPAIR"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "SWAP"},
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {
                                            "prim": "pair",
                                            "args": [
                                              {
                                                "prim": "map",
                                                "args": [
                                                  {"prim": "address"},
                                                  {"prim": "nat"},
                                                ],
                                              },
                                              {"prim": "nat"},
                                            ],
                                          },
                                          {
                                            "prim": "Pair",
                                            "args": [
                                              [],
                                              {"int": "0"},
                                            ],
                                          },
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {"prim": "CDR"},
                                {
                                  "prim": "NIL",
                                  "args": [
                                    {"prim": "operation"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "mutez"},
                                    {"int": "0"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "TRANSFER_TOKENS"},
                                {"prim": "CONS"},
                              ],
                            ],
                          },
                        ],
                      ],
                    },
                  ],
                ],
              },
            ],
            [
              {
                "prim": "IF_LEFT",
                "args": [
                  [
                    {
                      "prim": "IF_LEFT",
                      "args": [
                        [
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DROP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DROP"},
                          {"prim": "CDR"},
                          {
                            "prim": "NIL",
                            "args": [
                              {"prim": "operation"},
                            ],
                          },
                          {"prim": "SWAP"},
                          {
                            "prim": "PUSH",
                            "args": [
                              {"prim": "mutez"},
                              {"int": "0"},
                            ],
                          },
                          {
                            "prim": "DUP",
                            "args": [
                              {"int": "4"},
                            ],
                          },
                          {
                            "prim": "GET",
                            "args": [
                              {"int": "10"},
                            ],
                          },
                          {"prim": "TRANSFER_TOKENS"},
                          {"prim": "CONS"},
                        ],
                        [
                          {
                            "prim": "IF_LEFT",
                            "args": [
                              [
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DROP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SENDER"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "PAIR"},
                                {"prim": "EXEC"},
                                {"prim": "UNPAIR"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "IF",
                                  "args": [
                                    [],
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {"prim": "string"},
                                          {"string": "Fa1.2_NotAdmin"},
                                        ],
                                      },
                                      {"prim": "FAILWITH"},
                                    ],
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {
                                            "prim": "pair",
                                            "args": [
                                              {
                                                "prim": "map",
                                                "args": [
                                                  {"prim": "address"},
                                                  {"prim": "nat"},
                                                ],
                                              },
                                              {"prim": "nat"},
                                            ],
                                          },
                                          {
                                            "prim": "Pair",
                                            "args": [
                                              [],
                                              {"int": "0"},
                                            ],
                                          },
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {"prim": "DUP"},
                                {"prim": "CDR"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "CDR"},
                                {"prim": "ADD"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DUP"},
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SOME"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "4"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "UPDATE"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "DUP"},
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "10"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "CDR"},
                                {"prim": "ADD"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "10"},
                                  ],
                                },
                              ],
                              [
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DROP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SENDER"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "PAIR"},
                                {"prim": "EXEC"},
                                {"prim": "UNPAIR"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "IF",
                                  "args": [
                                    [],
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {"prim": "string"},
                                          {"string": "Fa1.2_NotAdmin"},
                                        ],
                                      },
                                      {"prim": "FAILWITH"},
                                    ],
                                  ],
                                },
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "1"},
                                  ],
                                },
                              ],
                            ],
                          },
                          {
                            "prim": "NIL",
                            "args": [
                              {"prim": "operation"},
                            ],
                          },
                        ],
                      ],
                    },
                  ],
                  [
                    {
                      "prim": "IF_LEFT",
                      "args": [
                        [
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "DROP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "SENDER"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "3"},
                            ],
                          },
                          {
                            "prim": "DIG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {"prim": "PAIR"},
                          {"prim": "EXEC"},
                          {"prim": "UNPAIR"},
                          {"prim": "SWAP"},
                          {
                            "prim": "DUG",
                            "args": [
                              {"int": "2"},
                            ],
                          },
                          {
                            "prim": "IF",
                            "args": [
                              [],
                              [
                                {
                                  "prim": "PUSH",
                                  "args": [
                                    {"prim": "string"},
                                    {"string": "Fa1.2_NotAdmin"},
                                  ],
                                },
                                {"prim": "FAILWITH"},
                              ],
                            ],
                          },
                          {
                            "prim": "UPDATE",
                            "args": [
                              {"int": "7"},
                            ],
                          },
                        ],
                        [
                          {
                            "prim": "IF_LEFT",
                            "args": [
                              [
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {
                                            "prim": "pair",
                                            "args": [
                                              {
                                                "prim": "map",
                                                "args": [
                                                  {"prim": "address"},
                                                  {"prim": "nat"},
                                                ],
                                              },
                                              {"prim": "nat"},
                                            ],
                                          },
                                          {
                                            "prim": "Pair",
                                            "args": [
                                              [],
                                              {"int": "0"},
                                            ],
                                          },
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "GET"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {
                                            "prim": "pair",
                                            "args": [
                                              {
                                                "prim": "map",
                                                "args": [
                                                  {"prim": "address"},
                                                  {"prim": "nat"},
                                                ],
                                              },
                                              {"prim": "nat"},
                                            ],
                                          },
                                          {
                                            "prim": "Pair",
                                            "args": [
                                              [],
                                              {"int": "0"},
                                            ],
                                          },
                                        ],
                                      },
                                    ],
                                    [],
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "4"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "CDR"},
                                {"prim": "SUB"},
                                {"prim": "ISNAT"},
                                {
                                  "prim": "IF_NONE",
                                  "args": [
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {"prim": "string"},
                                          {
                                            "string":
                                                "FA1.2_InsufficientBalance",
                                          },
                                        ],
                                      },
                                      {"prim": "FAILWITH"},
                                    ],
                                    [],
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SWAP"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SWAP"},
                                {"prim": "DUP"},
                                {"prim": "CDR"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "4"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "4"},
                                  ],
                                },
                                {"prim": "ADD"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {"prim": "SENDER"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "5"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "PAIR"},
                                {"prim": "EXEC"},
                                {"prim": "UNPAIR"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "6"},
                                  ],
                                },
                                {
                                  "prim": "IF",
                                  "args": [
                                    [
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "4"},
                                        ],
                                      },
                                      {"prim": "DROP"},
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "4"},
                                        ],
                                      },
                                      {"prim": "DROP"},
                                    ],
                                    [
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "5"},
                                        ],
                                      },
                                      {"prim": "DROP"},
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "4"},
                                        ],
                                      },
                                      {"prim": "UNIT"},
                                      {"prim": "SWAP"},
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "5"},
                                        ],
                                      },
                                      {
                                        "prim": "DIG",
                                        "args": [
                                          {"int": "2"},
                                        ],
                                      },
                                      {"prim": "PAIR"},
                                      {"prim": "EXEC"},
                                      {"prim": "UNPAIR"},
                                      {"prim": "SWAP"},
                                      {
                                        "prim": "DUG",
                                        "args": [
                                          {"int": "4"},
                                        ],
                                      },
                                      {
                                        "prim": "IF",
                                        "args": [
                                          [
                                            {
                                              "prim": "PUSH",
                                              "args": [
                                                {"prim": "string"},
                                                {"string": "FA1.2_Paused"},
                                              ],
                                            },
                                            {"prim": "FAILWITH"},
                                          ],
                                          [],
                                        ],
                                      },
                                      {"prim": "SENDER"},
                                      {
                                        "prim": "DUP",
                                        "args": [
                                          {"int": "4"},
                                        ],
                                      },
                                      {"prim": "CAR"},
                                      {"prim": "COMPARE"},
                                      {"prim": "NEQ"},
                                      {
                                        "prim": "IF",
                                        "args": [
                                          [
                                            {
                                              "prim": "DUP",
                                              "args": [
                                                {"int": "2"},
                                              ],
                                            },
                                            {"prim": "DUP"},
                                            {"prim": "CAR"},
                                            {
                                              "prim": "DUP",
                                              "args": [
                                                {"int": "5"},
                                              ],
                                            },
                                            {
                                              "prim": "GET",
                                              "args": [
                                                {"int": "4"},
                                              ],
                                            },
                                            {
                                              "prim": "DIG",
                                              "args": [
                                                {"int": "4"},
                                              ],
                                            },
                                            {"prim": "CAR"},
                                            {"prim": "SENDER"},
                                            {"prim": "GET"},
                                            {
                                              "prim": "IF_NONE",
                                              "args": [
                                                [
                                                  {
                                                    "prim": "PUSH",
                                                    "args": [
                                                      {"prim": "int"},
                                                      {"int": "113"},
                                                    ],
                                                  },
                                                  {"prim": "FAILWITH"},
                                                ],
                                                [],
                                              ],
                                            },
                                            {"prim": "SUB"},
                                            {"prim": "ISNAT"},
                                            {
                                              "prim": "IF_NONE",
                                              "args": [
                                                [
                                                  {
                                                    "prim": "PUSH",
                                                    "args": [
                                                      {"prim": "string"},
                                                      {
                                                        "string":
                                                            "FA1.2_NotAllowed",
                                                      },
                                                    ],
                                                  },
                                                  {"prim": "FAILWITH"},
                                                ],
                                                [],
                                              ],
                                            },
                                            {"prim": "SOME"},
                                            {"prim": "SENDER"},
                                            {"prim": "UPDATE"},
                                            {
                                              "prim": "UPDATE",
                                              "args": [
                                                {"int": "1"},
                                              ],
                                            },
                                            {"prim": "SWAP"},
                                          ],
                                          [],
                                        ],
                                      },
                                    ],
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "DUP"},
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "SOME"},
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "5"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "UPDATE"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "DUP"},
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SOME"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "UPDATE"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                              ],
                              [
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "DROP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "SENDER"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {"prim": "PAIR"},
                                {"prim": "EXEC"},
                                {"prim": "UNPAIR"},
                                {"prim": "SWAP"},
                                {
                                  "prim": "DUG",
                                  "args": [
                                    {"int": "2"},
                                  ],
                                },
                                {
                                  "prim": "IF",
                                  "args": [
                                    [],
                                    [
                                      {
                                        "prim": "PUSH",
                                        "args": [
                                          {"prim": "string"},
                                          {"string": "Fa1.2_NotAdmin"},
                                        ],
                                      },
                                      {"prim": "FAILWITH"},
                                    ],
                                  ],
                                },
                                {"prim": "SWAP"},
                                {"prim": "DUP"},
                                {
                                  "prim": "GET",
                                  "args": [
                                    {"int": "5"},
                                  ],
                                },
                                {
                                  "prim": "DUP",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "CDR"},
                                {"prim": "SOME"},
                                {
                                  "prim": "DIG",
                                  "args": [
                                    {"int": "3"},
                                  ],
                                },
                                {"prim": "CAR"},
                                {"prim": "UPDATE"},
                                {
                                  "prim": "UPDATE",
                                  "args": [
                                    {"int": "5"},
                                  ],
                                },
                              ],
                            ],
                          },
                        ],
                      ],
                    },
                    {
                      "prim": "NIL",
                      "args": [
                        {"prim": "operation"},
                      ],
                    },
                  ],
                ],
              },
            ],
          ],
        },
        {"prim": "PAIR"},
      ],
    ],
  },
  {
    "prim": "view",
    "args": [
      {"string": "get_administrator"},
      {"prim": "unit"},
      {"prim": "address"},
      [
        {"prim": "CDR"},
        {"prim": "CAR"},
      ],
    ],
  },
];
