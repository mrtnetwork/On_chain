final tronContract = {
  "entrys": [
    {
      "inputs": [
        {"name": "b", "type": "bool"}
      ],
      "name": "checkBooliEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "b", "type": "bool[]"}
      ],
      "name": "checkBoolisEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "c", "type": "bytes32"}
      ],
      "name": "checkByte32Event",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "list1", "type": "int8[]"},
        {"name": "list2", "type": "int128[]"},
        {"name": "list3", "type": "int256[]"}
      ],
      "name": "checkIntListEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "list1", "type": "string[]"},
        {"name": "item2", "type": "string"}
      ],
      "name": "checkIntListEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "addresses", "type": "address[]"}
      ],
      "name": "checkListAddressesEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "byt", "type": "bytes[]"}
      ],
      "name": "checkListBytesEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "b", "type": "bool[]"},
        {"name": "byt", "type": "bytes[]"},
        {"name": "addresses", "type": "address[]"},
        {"name": "test", "type": "uint8"}
      ],
      "name": "checkListEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "list1", "type": "uint8[]"},
        {"name": "list2", "type": "uint128[]"},
        {"name": "list3", "type": "uint256[]"}
      ],
      "name": "checkUintListEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "is64", "type": "int64"},
        {"name": "is128", "type": "int128"},
        {"name": "is256", "type": "int256"},
        {"name": "is8", "type": "int8"}
      ],
      "name": "checkintEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "c", "type": "bytes"}
      ],
      "name": "checkuByteEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "is64", "type": "uint64"},
        {"name": "is128", "type": "uint128"},
        {"name": "is256", "type": "uint256"},
        {"name": "is8", "type": "uint8"}
      ],
      "name": "checkuIntEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "list1", "type": "address[5]"},
        {"name": "list2", "type": "bytes16[5]"},
        {"name": "list3", "type": "bytes32[5]"},
        {"name": "list4", "type": "bytes[8]"},
        {"name": "list5", "type": "string[2]"},
        {"name": "list6", "type": "uint256[2]"},
        {"name": "list7", "type": "uint256[2]"},
        {"name": "list8", "type": "int256[5]"}
      ],
      "name": "fixedListEvent",
      "type": "Event"
    },
    {
      "inputs": [
        {"name": "list1", "type": "bytes8[]"},
        {"name": "list2", "type": "bytes16[]"},
        {"name": "list3", "type": "bytes32[]"}
      ],
      "name": "checBytesSizeList",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "address[5]"},
        {"type": "bytes16[5]"},
        {"type": "bytes32[5]"},
        {"type": "bytes[8]"},
        {"type": "string[2]"},
        {"type": "uint256[2]"},
        {"type": "uint256[2]"},
        {"type": "int256[5]"}
      ],
      "inputs": [
        {"name": "list1", "type": "address[5]"},
        {"name": "list2", "type": "bytes16[5]"},
        {"name": "list3", "type": "bytes32[5]"},
        {"name": "list4", "type": "bytes[8]"},
        {"name": "list5", "type": "string[2]"},
        {"name": "list6", "type": "uint256[2]"},
        {"name": "list7", "type": "uint256[2]"},
        {"name": "list8", "type": "int256[5]"}
      ],
      "name": "checBytesSizeList",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "int64"},
        {"type": "int128"},
        {"type": "int256"},
        {"type": "int8"}
      ],
      "inputs": [
        {"name": "is64", "type": "int64"},
        {"name": "is128", "type": "int128"},
        {"name": "is256", "type": "int256"},
        {"name": "is8", "type": "int8"}
      ],
      "name": "checkInt",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "list1", "type": "int8[]"},
        {"name": "list2", "type": "int128[]"},
        {"name": "list3", "type": "int256[]"}
      ],
      "name": "checkIntList",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "is64", "type": "int64"},
        {"name": "is128", "type": "int128"},
        {"name": "is256", "type": "int256"},
        {"name": "is8", "type": "int8"}
      ],
      "name": "checkIntPayable",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "uint8[]"},
        {"type": "uint128[]"},
        {"type": "uint256[]"}
      ],
      "inputs": [
        {"name": "list1", "type": "uint8[]"},
        {"name": "list2", "type": "uint128[]"},
        {"name": "list3", "type": "uint256[]"}
      ],
      "name": "checkUintList",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "bool"}
      ],
      "inputs": [
        {"name": "signature", "type": "bool"}
      ],
      "name": "checkbooli",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bool"}
      ],
      "name": "checkbooliPayable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "bool[]"}
      ],
      "inputs": [
        {"name": "signature", "type": "bool[]"}
      ],
      "name": "checkboolis",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bool[]"}
      ],
      "name": "checkboolisPayable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "bytes"}
      ],
      "inputs": [
        {"name": "signature", "type": "bytes"}
      ],
      "name": "checkbyte",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "bytes32"}
      ],
      "inputs": [
        {"name": "signature", "type": "bytes32"}
      ],
      "name": "checkbyte32",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bytes32"}
      ],
      "name": "checkbyte32Payable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bytes"}
      ],
      "name": "checkbytePayable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "bytes[]"}
      ],
      "inputs": [
        {"name": "signature", "type": "bytes[]"}
      ],
      "name": "checkbytest",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bytes[]"}
      ],
      "name": "checkbytestPayable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "uint64"},
        {"type": "uint128"},
        {"type": "uint256"},
        {"type": "uint8"}
      ],
      "inputs": [
        {"name": "is64", "type": "uint64"},
        {"name": "is128", "type": "uint128"},
        {"name": "is256", "type": "uint256"},
        {"name": "is8", "type": "uint8"}
      ],
      "name": "checkuInt",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "is64", "type": "uint64"},
        {"name": "is128", "type": "uint128"},
        {"name": "is256", "type": "uint256"},
        {"name": "is8", "type": "uint8"}
      ],
      "name": "checkuIntPayable",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "name": "emptyFieldPayable",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "list1", "type": "string[]"},
        {"name": "test", "type": "string"}
      ],
      "name": "fixedLiengthArray",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "list1", "type": "string[]"},
        {"name": "test", "type": "string"}
      ],
      "name": "fixedLiengthArrayPayable",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "address[]"}
      ],
      "inputs": [
        {"name": "addresses", "type": "address[]"}
      ],
      "name": "listAddress",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "addresses", "type": "address[]"}
      ],
      "name": "listAddressPayable",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "address[]"},
        {"type": "bytes[]"}
      ],
      "inputs": [
        {"name": "addresses", "type": "address[]"},
        {"name": "signature", "type": "bytes[]"}
      ],
      "name": "multiListWithReturn",
      "stateMutability": "Pure",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "addresses", "type": "address[]"}
      ],
      "name": "multiListWithReturnAndPayable",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "list1", "type": "string[]"},
        {"name": "test", "type": "string"}
      ],
      "name": "stringListx",
      "stateMutability": "Nonpayable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "signature", "type": "bool[]"},
        {"name": "bytesss", "type": "bytes[]"},
        {"name": "addresss", "type": "address[]"},
        {"name": "test8", "type": "uint8"}
      ],
      "name": "testManyLust",
      "stateMutability": "Nonpayable",
      "type": "Function"
    }
  ]
};
