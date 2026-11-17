final abiTest = [
  {
    "inputs": [
      {"internalType": "int128[]", "name": "is128", "type": "int128[]"},
      {"internalType": "int64", "name": "is64", "type": "int64"}
    ],
    "name": "InsufficientBalance",
    "type": "error"
  },
  {
    "inputs": [
      {"internalType": "int64", "name": "is64", "type": "int64"},
      {"internalType": "int8", "name": "is8", "type": "int8"}
    ],
    "name": "InsufficientBalanceX",
    "type": "error"
  },
  {"inputs": [], "name": "Unauthorized", "type": "error"},
  {
    "anonymous": false,
    "inputs": [
      {"indexed": false, "internalType": "bool", "name": "b", "type": "bool"}
    ],
    "name": "checkBooliEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "bool[]",
        "name": "b",
        "type": "bool[]"
      }
    ],
    "name": "checkBoolisEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "bytes32",
        "name": "c",
        "type": "bytes32"
      }
    ],
    "name": "checkByte32Event",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address[]",
        "name": "addresses",
        "type": "address[]"
      }
    ],
    "name": "checkListAddressesEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "bytes[]",
        "name": "byt",
        "type": "bytes[]"
      }
    ],
    "name": "checkListBytesEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "bool[]",
        "name": "b",
        "type": "bool[]"
      },
      {
        "indexed": false,
        "internalType": "bytes[]",
        "name": "byt",
        "type": "bytes[]"
      },
      {
        "indexed": false,
        "internalType": "address[]",
        "name": "addresses",
        "type": "address[]"
      },
      {
        "indexed": false,
        "internalType": "uint8",
        "name": "test",
        "type": "uint8"
      }
    ],
    "name": "checkListEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "int64",
        "name": "is64",
        "type": "int64"
      },
      {
        "indexed": true,
        "internalType": "int128[]",
        "name": "is128",
        "type": "int128[]"
      },
      {
        "indexed": true,
        "internalType": "int256[]",
        "name": "is256",
        "type": "int256[]"
      },
      {"indexed": false, "internalType": "int8", "name": "is8", "type": "int8"}
    ],
    "name": "checkintEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {"indexed": false, "internalType": "bytes", "name": "c", "type": "bytes"}
    ],
    "name": "checkuByteEvent",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint64",
        "name": "is64",
        "type": "uint64"
      },
      {
        "indexed": false,
        "internalType": "uint128",
        "name": "is128",
        "type": "uint128"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "is256",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "uint8",
        "name": "is8",
        "type": "uint8"
      }
    ],
    "name": "checkuIntEvent",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "checkError",
    "outputs": [],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "int64", "name": "is64", "type": "int64"},
      {"internalType": "int128[]", "name": "is128", "type": "int128[]"}
    ],
    "name": "checkErrorValue1",
    "outputs": [],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "int64", "name": "is64", "type": "int64"}
    ],
    "name": "checkErrorValue2",
    "outputs": [],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "int64", "name": "is64", "type": "int64"},
      {"internalType": "int128", "name": "is128", "type": "int128"},
      {"internalType": "int256", "name": "is256", "type": "int256"},
      {"internalType": "int8", "name": "is8", "type": "int8"}
    ],
    "name": "checkInt",
    "outputs": [
      {"internalType": "int64", "name": "", "type": "int64"},
      {"internalType": "int128", "name": "", "type": "int128"},
      {"internalType": "int256", "name": "", "type": "int256"},
      {"internalType": "int8", "name": "", "type": "int8"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bool", "name": "signature", "type": "bool"}
    ],
    "name": "checkbooli",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bool", "name": "signature", "type": "bool"}
    ],
    "name": "checkbooliPayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bool[]", "name": "signature", "type": "bool[]"}
    ],
    "name": "checkboolis",
    "outputs": [
      {"internalType": "bool[]", "name": "", "type": "bool[]"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bool[]", "name": "signature", "type": "bool[]"}
    ],
    "name": "checkboolisPayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes", "name": "signature", "type": "bytes"}
    ],
    "name": "checkbyte",
    "outputs": [
      {"internalType": "bytes", "name": "", "type": "bytes"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes32", "name": "signature", "type": "bytes32"}
    ],
    "name": "checkbyte32",
    "outputs": [
      {"internalType": "bytes32", "name": "", "type": "bytes32"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes32", "name": "signature", "type": "bytes32"}
    ],
    "name": "checkbyte32Payable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes", "name": "signature", "type": "bytes"}
    ],
    "name": "checkbytePayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes[]", "name": "signature", "type": "bytes[]"}
    ],
    "name": "checkbytest",
    "outputs": [
      {"internalType": "bytes[]", "name": "", "type": "bytes[]"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bytes[]", "name": "signature", "type": "bytes[]"}
    ],
    "name": "checkbytestPayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint64", "name": "is64", "type": "uint64"},
      {"internalType": "uint128", "name": "is128", "type": "uint128"},
      {"internalType": "uint256", "name": "is256", "type": "uint256"},
      {"internalType": "uint8", "name": "is8", "type": "uint8"}
    ],
    "name": "checkuInt",
    "outputs": [
      {"internalType": "uint64", "name": "", "type": "uint64"},
      {"internalType": "uint128", "name": "", "type": "uint128"},
      {"internalType": "uint256", "name": "", "type": "uint256"},
      {"internalType": "uint8", "name": "", "type": "uint8"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint64", "name": "is64", "type": "uint64"},
      {"internalType": "uint128", "name": "is128", "type": "uint128"},
      {"internalType": "uint256", "name": "is256", "type": "uint256"},
      {"internalType": "uint8", "name": "is8", "type": "uint8"}
    ],
    "name": "checkuIntPayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "address[]", "name": "addresses", "type": "address[]"}
    ],
    "name": "listAddress",
    "outputs": [
      {"internalType": "address[]", "name": "", "type": "address[]"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "address[]", "name": "addresses", "type": "address[]"}
    ],
    "name": "listAddressPayable",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "int32", "name": "i", "type": "int32"},
      {
        "internalType": "function (bool) pure external returns (bool)",
        "name": "f",
        "type": "function"
      }
    ],
    "name": "map",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"},
      {"internalType": "int32", "name": "", "type": "int32"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "string[]", "name": "a", "type": "string[]"}
    ],
    "name": "returnString",
    "outputs": [
      {"internalType": "string[]", "name": "", "type": "string[]"}
    ],
    "stateMutability": "pure",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "bool[]", "name": "signature", "type": "bool[]"},
      {"internalType": "bytes[]", "name": "bytesss", "type": "bytes[]"},
      {"internalType": "address[]", "name": "addresss", "type": "address[]"},
      {"internalType": "uint8", "name": "test8", "type": "uint8"}
    ],
    "name": "testManyLust",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];
