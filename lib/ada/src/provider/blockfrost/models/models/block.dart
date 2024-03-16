class ADABlockResponse {
  /// Block creation time in UNIX time
  final int time;

  /// Block number
  final int? height;

  /// Hash of the block
  final String hash;

  /// Slot number
  final int? slot;

  /// Epoch number
  final int? epoch;

  /// Slot within the epoch
  final int? epochSlot;

  /// Bech32 ID of the slot leader or specific block description
  final String slotLeader;

  /// Block size in Bytes
  final int size;

  /// Number of transactions in the block
  final int txCount;

  /// Total output within the block in Lovelaces
  final String? output;

  /// Total fees within the block in Lovelaces
  final String? fees;

  /// VRF key of the block
  final String? blockVrf;

  /// The hash of the operational certificate of the block
  final String? opCert;

  /// The value of the counter used to produce the operational certificate
  final String? opCertCounter;

  /// Hash of the previous block
  final String? previousBlock;

  /// Hash of the next block
  final String? nextBlock;

  /// Number of block confirmations
  final int confirmations;

  ADABlockResponse({
    required this.time,
    required this.hash,
    required this.slotLeader,
    required this.size,
    required this.txCount,
    required this.confirmations,
    this.height,
    this.slot,
    this.epoch,
    this.epochSlot,
    this.output,
    this.fees,
    this.blockVrf,
    this.opCert,
    this.opCertCounter,
    this.previousBlock,
    this.nextBlock,
  });

  factory ADABlockResponse.fromJson(Map<String, dynamic> json) {
    return ADABlockResponse(
      time: json['time'],
      height: json['height'],
      hash: json['hash'],
      slot: json['slot'],
      epoch: json['epoch'],
      epochSlot: json['epoch_slot'],
      slotLeader: json['slot_leader'],
      size: json['size'],
      txCount: json['tx_count'],
      output: json['output'],
      fees: json['fees'],
      blockVrf: json['block_vrf'],
      opCert: json['op_cert'],
      opCertCounter: json['op_cert_counter'],
      previousBlock: json['previous_block'],
      nextBlock: json['next_block'],
      confirmations: json['confirmations'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'height': height,
        'hash': hash,
        'slot': slot,
        'epoch': epoch,
        'epoch_slot': epochSlot,
        'slot_leader': slotLeader,
        'size': size,
        'tx_count': txCount,
        'output': output,
        'fees': fees,
        'block_vrf': blockVrf,
        'op_cert': opCert,
        'op_cert_counter': opCertCounter,
        'previous_block': previousBlock,
        'next_block': nextBlock,
        'confirmations': confirmations,
      };
  @override
  String toString() {
    return "ADABlockResponse${toJson()}";
  }
}
