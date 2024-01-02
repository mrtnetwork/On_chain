final payableContractTest = {
  "entrys": [
    {
      "outputs": [
        {"type": "uint256"},
        {"type": "uint256"}
      ],
      "name": "PayWithTRX",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "uint256"},
        {"type": "uint256"}
      ],
      "name": "PayWithTrc10",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "inputs": [
        {"name": "toAddress", "type": "address"},
        {"name": "id", "type": "trcToken"},
        {"name": "amount", "type": "uint256"}
      ],
      "name": "TransferTokenTo",
      "stateMutability": "Payable",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "uint256"}
      ],
      "inputs": [
        {"type": "address"}
      ],
      "name": "orderTokenValues",
      "stateMutability": "View",
      "type": "Function"
    },
    {
      "outputs": [
        {"type": "uint256"}
      ],
      "inputs": [
        {"type": "address"}
      ],
      "name": "orderValue",
      "stateMutability": "View",
      "type": "Function"
    }
  ]
};
