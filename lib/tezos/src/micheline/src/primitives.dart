import 'package:on_chain/exception/onchain_error.dart';

class MichelsonPrimitives {
  MichelsonPrimitives._();

  static const List<String> names = [
    'parameter', // 0
    'storage', // 1
    'code', // 2
    'False', // 3
    'Elt', // 4
    'Left', // 5
    'None', // 6
    'Pair', // 7
    'Right', // 8
    'Some', // 9
    'True', // 10
    'Unit', // 11
    'PACK', // 12
    'UNPACK', // 13
    'BLAKE2B', // 14
    'SHA256', // 15
    'SHA512', // 16
    'ABS', // 17
    'ADD', // 18
    'AMOUNT', // 19
    'AND', // 20
    'BALANCE', // 21
    'CAR', // 22
    'CDR', // 23
    'CHECK_SIGNATURE', // 24
    'COMPARE', // 25
    'CONCAT', // 26
    'CONS', // 27
    'CREATE_ACCOUNT', // 28
    'CREATE_CONTRACT', // 29
    'IMPLICIT_ACCOUNT', // 30
    'DIP', // 31
    'DROP', // 32
    'DUP', // 33
    'EDIV', // 34
    'EMPTY_MAP', // 35
    'EMPTY_SET', // 36
    'EQ', // 37
    'EXEC', // 38
    'FAILWITH', // 39
    'GE', // 40
    'GET', // 41
    'GT', // 42
    'HASH_KEY', // 43
    'IF', // 44
    'IF_CONS', // 45
    'IF_LEFT', // 46
    'IF_NONE', // 47
    'INT', // 48
    'LAMBDA', // 49
    'LE', // 50
    'LEFT', // 51
    'LOOP', // 52
    'LSL', // 53
    'LSR', // 54
    'LT', // 55
    'MAP', // 56
    'MEM', // 57
    'MUL', // 58
    'NEG', // 59
    'NEQ', // 60
    'NIL', // 61
    'NONE', // 62
    'NOT', // 63
    'NOW', // 64
    'OR', // 65
    'PAIR', // 66
    'PUSH', // 67
    'RIGHT', // 68
    'SIZE', // 69
    'SOME', // 70
    'SOURCE', // 71
    'SENDER', // 72
    'SELF', // 73
    'STEPS_TO_QUOTA', // 74
    'SUB', // 75
    'SWAP', // 76
    'TRANSFER_TOKENS', // 77
    'SET_DELEGATE', // 78
    'UNIT', // 79
    'UPDATE', // 80
    'XOR', // 81
    'ITER', // 82
    'LOOP_LEFT', // 83
    'ADDRESS', // 84
    'CONTRACT', // 85
    'ISNAT', // 86
    'CAST', // 87
    'RENAME', // 88
    'bool', // 89
    'contract', // 90
    'int', // 91
    'key', // 92
    'key_hash', // 93
    'lambda', // 94
    'list', // 95
    'map', // 96
    'big_map', // 97
    'nat', // 98
    'option', // 99
    'or', // 100
    'pair', // 101
    'set', // 102
    'signature', // 103
    'string', // 104
    'bytes', // 105
    'mutez', // 106
    'timestamp', // 107
    'unit', // 108
    'operation', // 109
    'address', // 110
    'SLICE', // 111
    'DIG', // 112
    'DUG', // 113
    'EMPTY_BIG_MAP', // 114
    'APPLY', // 115
    'chain_id', // 116
    'CHAIN_ID', // 117
    'LEVEL', // 118
    'SELF_ADDRESS', // 119
    'never', // 120
    'NEVER', // 121
    'UNPAIR', // 122
    'VOTING_POWER', // 123
    'TOTAL_VOTING_POWER', // 124
    'KECCAK', // 125
    'SHA3', // 126
    'PAIRING_CHECK', // 127
    'bls12_381_g1', // 128
    'bls12_381_g2', // 129
    'bls12_381_fr', // 130
    'sapling_state', // 131
    'sapling_transaction_deprecated', // 132
    'SAPLING_EMPTY_STATE', // 133
    'SAPLING_VERIFY_UPDATE', // 134
    'ticket', // 135
    'TICKET_DEPRECATED', // 136
    'READ_TICKET', // 137
    'SPLIT_TICKET', // 138
    'JOIN_TICKETS', // 139
    'GET_AND_UPDATE', // 140
    'chest', // 141
    'chest_key', // 142
    'OPEN_CHEST', // 143
    'VIEW', // 144
    'view', // 145
    'constant', // 146
    'SUB_MUTEZ', // 147
    'tx_rollup_l2_address', // 148
    'MIN_BLOCK_TIME', // 149
    'sapling_transaction', // 150
    'EMIT', // 151
    'Lambda_rec', // 152
    'LAMBDA_REC', // 153
    'TICKET', // 154
    'BYTES', // 155
    'NAT', // 156
    'Ticket', // 157
    'IS_IMPLICIT_ACCOUNT', // 158
    'INDEX_ADDRESS', // 159
    'GET_ADDRESS_INDEX', // 160
  ];

  static const int minTag = 0;
  static const int maxTag = 160;

  static String nameOf(int tag) {
    if (tag < minTag || tag > maxTag) {
      throw OnChainErrors.tezosMicheline(
        "MichelsonPrimitives.nameOf",
        reason: "Invalid Michelson primitive tag.",
        details: {"tag": tag.toString()},
      );
    }
    return names[tag];
  }

  static String from(Object? tag) {
    if (tag is int) return nameOf(tag);
    if (tag is String) return ensureIsValidPrimitives(tag);
    throw OnChainErrors.tezosMicheline(
      "MichelsonPrimitives.from",
      reason: "Invalid Michelson primitive tag.",
      details: {"tag": tag.toString()},
    );
  }

  static int tagOf(String name) {
    final index = names.indexOf(name);
    if (index.isNegative) {
      throw OnChainErrors.tezosMicheline(
        "MichelsonPrimitives.tagOf",
        reason: "Invalid Michelson primitive name.",
        details: {"name": name},
      );
    }
    return index;
  }

  static String ensureIsValidPrimitives(String name) {
    tagOf(name);
    return name;
  }
}
