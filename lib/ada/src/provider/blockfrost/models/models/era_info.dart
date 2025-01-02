class ADABlockchainEraResponse {
  /// Start of the blockchain era, relative to the start of the network
  final ADAEra start;

  /// End of the blockchain era, relative to the start of the network
  final ADAEra end;

  /// Era parameters
  final EraParameters parameters;

  ADABlockchainEraResponse({
    required this.start,
    required this.end,
    required this.parameters,
  });

  factory ADABlockchainEraResponse.fromJson(Map<String, dynamic> json) {
    return ADABlockchainEraResponse(
      start: ADAEra.fromJson(json['start']),
      end: ADAEra.fromJson(json['end']),
      parameters: EraParameters.fromJson(json['parameters']),
    );
  }

  Map<String, dynamic> toJson() => {
        'start': start.toJson(),
        'end': end.toJson(),
        'parameters': parameters.toJson(),
      };
  @override
  String toString() {
    return 'ADABlockchainEraResponse${toJson()}';
  }
}

class ADAEra {
  /// Time in seconds relative to the start time of the network
  final int time;

  /// Absolute slot number
  final int slot;

  /// Epoch number
  final int epoch;

  ADAEra({
    required this.time,
    required this.slot,
    required this.epoch,
  });

  factory ADAEra.fromJson(Map<String, dynamic> json) {
    return ADAEra(
      time: json['time'],
      slot: json['slot'],
      epoch: json['epoch'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'slot': slot,
        'epoch': epoch,
      };
}

class EraParameters {
  /// Epoch length in number of slots
  final int epochLength;

  /// Slot length in seconds
  final int slotLength;

  /// Zone in which it is guaranteed that no hard fork can take place
  final int safeZone;

  EraParameters({
    required this.epochLength,
    required this.slotLength,
    required this.safeZone,
  });

  factory EraParameters.fromJson(Map<String, dynamic> json) {
    return EraParameters(
      epochLength: json['epoch_length'],
      slotLength: json['slot_length'],
      safeZone: json['safe_zone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'epoch_length': epochLength,
        'slot_length': slotLength,
        'safe_zone': safeZone,
      };
}
