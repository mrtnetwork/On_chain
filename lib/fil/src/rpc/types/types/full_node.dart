import 'package:blockchain_utils/helper/extensions/extensions.dart';

import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';
import 'package:on_chain/fil/src/types/types.dart';

// Auto-generated from Go struct definitions.

enum MessageReceiptVersion {
  /// MessageReceiptV0 refers to pre FIP-0049 receipts.
  messageReceiptV0(0),

  /// MessageReceiptV1 refers to post FIP-0049 receipts.
  messageReceiptV1(1);

  final int value;
  const MessageReceiptVersion(this.value);

  static MessageReceiptVersion fromValue(int value) {
    return MessageReceiptVersion.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.filPlugin(
                "MessageReceiptVersion.fromValue",
                reason: "Invalid message receipt version.",
                details: {"value": "$value"},
              ),
    );
  }
}

/// LotusResponseActiveSync
class LotusResponseActiveSync {
  final BigInt workerID;
  final LotusResponseTipSet? base;
  final LotusResponseTipSet? target;
  final int stage;
  final BigInt height;
  final DateTime start;
  final DateTime end;
  final String message;

  const LotusResponseActiveSync({
    required this.workerID,
    this.base,
    this.target,
    required this.stage,
    required this.height,
    required this.start,
    required this.end,
    required this.message,
  });

  factory LotusResponseActiveSync.fromJson(Map<String, dynamic> json) {
    return LotusResponseActiveSync(
      workerID: json.valueAsBigInt("WorkerID", onMissing: () => BigInt.zero),
      base: json.valueTo<LotusResponseTipSet?, Map>(
        key: "Base",
        parse:
            (e) => LotusResponseTipSet.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      target: json.valueTo<LotusResponseTipSet?, Map>(
        key: "Target",
        parse:
            (e) => LotusResponseTipSet.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      stage: json.valueAsInt("Stage", onMissing: () => 0),
      height: json.valueAsBigInt("Height", onMissing: () => BigInt.zero),
      start: json.valueTo<DateTime, dynamic>(
        key: "Start",
        parse:
            (e) =>
                DateTime.tryParse(e.toString()) ??
                DateTime.fromMillisecondsSinceEpoch(0),
      ),
      end: json.valueTo<DateTime, dynamic>(
        key: "End",
        parse:
            (e) =>
                DateTime.tryParse(e.toString()) ??
                DateTime.fromMillisecondsSinceEpoch(0),
      ),
      message: json.valueAsString("Message"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "WorkerID": config.encodeBigint(workerID),
      "Base": base?.toJson(config: config),
      "Target": target?.toJson(config: config),
      "Stage": stage,
      "Height": config.encodeBigint(height),
      "Start": start.toIso8601String(),
      "End": end.toIso8601String(),
      "Message": message,
    });
  }
}

/// LotusResponseActorState
class LotusResponseActorState {
  final BigInt balance;
  final Cid code;
  final dynamic state;

  const LotusResponseActorState({
    required this.balance,
    required this.code,
    required this.state,
  });

  factory LotusResponseActorState.fromJson(Map<String, dynamic> json) {
    return LotusResponseActorState(
      balance: json.valueTo<BigInt, Object>(
        key: "Balance",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      code: json.valueTo<Cid, Object>(
        key: "Code",
        parse: (e) => Cid.fromJson(e),
      ),
      state: json["State"],
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Balance": config.encodeBigint(balance),
      "Code": code.toJson(),
      "State": state,
    });
  }
}

/// LotusResponseActorTrace
class LotusResponseActorTrace {
  final BigInt id;
  final LotusResponseActor state;

  const LotusResponseActorTrace({required this.id, required this.state});

  factory LotusResponseActorTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseActorTrace(
      id: json.valueAsBigInt("Id", onMissing: () => BigInt.zero),
      state: json.valueTo<LotusResponseActor, Map>(
        key: "State",
        parse:
            (e) => LotusResponseActor.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Id": config.encodeBigint(id),
      "State": state.toJson(config: config),
    });
  }
}

/// LotusResponseBeaconEntry
class LotusResponseBeaconEntry {
  final BigInt round;
  final List<int> data;

  const LotusResponseBeaconEntry({required this.round, required this.data});

  factory LotusResponseBeaconEntry.fromJson(Map<String, dynamic> json) {
    return LotusResponseBeaconEntry(
      round: json.valueAsBigInt("Round", onMissing: () => BigInt.zero),
      data: json.valueAsBytes(
        "Data",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Round": config.encodeBigint(round),
      "Data": data,
    });
  }
}

/// LotusResponseBeneficiaryTerm
class LotusResponseBeneficiaryTerm {
  final BigInt quota;
  final BigInt usedQuota;
  final BigInt expiration;

  const LotusResponseBeneficiaryTerm({
    required this.quota,
    required this.usedQuota,
    required this.expiration,
  });

  factory LotusResponseBeneficiaryTerm.fromJson(Map<String, dynamic> json) {
    return LotusResponseBeneficiaryTerm(
      quota: JsonParser.valueAsBigInt(json["Quota"] ?? "0"),
      usedQuota: JsonParser.valueAsBigInt(json["UsedQuota"] ?? "0"),
      expiration: json.valueAsBigInt(
        "Expiration",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Quota": config.encodeBigint(quota),
      "UsedQuota": config.encodeBigint(usedQuota),
      "Expiration": config.encodeBigint(expiration),
    });
  }
}

/// LotusResponseBlockHeader
class LotusResponseBlockHeader {
  final String miner;
  final LotusResponseTicket? ticket;
  final LotusResponseElectionProof? electionProof;
  final List<LotusResponseBeaconEntry> beaconEntries;
  final List<LotusResponsePoStProof> winPoStProof;
  final List<Cid> parents;
  final BigInt parentWeight;
  final BigInt height;
  final Cid parentStateRoot;
  final Cid parentMessageReceipts;
  final Cid messages;
  final FilSignature? bLSAggregate;
  final BigInt timestamp;
  final FilSignature? blockSig;
  final BigInt forkSignaling;
  final BigInt parentBaseFee;
  final bool validated;

  const LotusResponseBlockHeader({
    required this.miner,
    this.ticket,
    this.electionProof,
    required this.beaconEntries,
    required this.winPoStProof,
    required this.parents,
    required this.parentWeight,
    required this.height,
    required this.parentStateRoot,
    required this.parentMessageReceipts,
    required this.messages,
    this.bLSAggregate,
    required this.timestamp,
    this.blockSig,
    required this.forkSignaling,
    required this.parentBaseFee,
    required this.validated,
  });

  factory LotusResponseBlockHeader.fromJson(Map<String, dynamic> json) {
    return LotusResponseBlockHeader(
      miner: json.valueAsString("Miner"),
      ticket: json.valueTo<LotusResponseTicket?, Map>(
        key: "Ticket",
        parse:
            (e) => LotusResponseTicket.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      electionProof: json.valueTo<LotusResponseElectionProof?, Map>(
        key: "ElectionProof",
        parse:
            (e) => LotusResponseElectionProof.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      beaconEntries: json.valueTo<List<LotusResponseBeaconEntry>, List>(
        key: "BeaconEntries",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseBeaconEntry.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      winPoStProof: json.valueTo<List<LotusResponsePoStProof>, List>(
        key: "WinPoStProof",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponsePoStProof.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      parents: json.valueTo<List<Cid>, List>(
        key: "Parents",
        onMissing: () => [],
        parse: (e) => e.map((x) => Cid.fromJson(x)).toList(),
      ),
      parentWeight: json.valueTo<BigInt, Object>(
        key: "ParentWeight",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      height: json.valueAsBigInt("Height", onMissing: () => BigInt.zero),
      parentStateRoot: json.valueTo<Cid, Object>(
        key: "ParentStateRoot",
        parse: (e) => Cid.fromJson(e),
      ),
      parentMessageReceipts: json.valueTo<Cid, Object>(
        key: "ParentMessageReceipts",
        parse: (e) => Cid.fromJson(e),
      ),
      messages: json.valueTo<Cid, Object>(
        key: "Messages",
        parse: (e) => Cid.fromJson(e),
      ),
      bLSAggregate: json.valueTo<FilSignature?, Map>(
        key: "BLSAggregate",
        parse: (e) => FilSignature.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      timestamp: json.valueAsBigInt("Timestamp", onMissing: () => BigInt.zero),
      blockSig: json.valueTo<FilSignature?, Map>(
        key: "BlockSig",
        parse: (e) => FilSignature.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      forkSignaling: json.valueAsBigInt(
        "ForkSignaling",
        onMissing: () => BigInt.zero,
      ),
      parentBaseFee: JsonParser.valueAsBigInt(json["ParentBaseFee"] ?? "0"),
      validated: json.valueAsBool("validated", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Miner": miner,
      "Ticket": ticket?.toJson(config: config),
      "ElectionProof": electionProof?.toJson(config: config),
      "BeaconEntries":
          beaconEntries.map((e) => e.toJson(config: config)).toList(),
      "WinPoStProof":
          winPoStProof.map((e) => e.toJson(config: config)).toList(),
      "Parents": parents.map((e) => e.toJson()).toList(),
      "ParentWeight": config.encodeBigint(parentWeight),
      "Height": config.encodeBigint(height),
      "ParentStateRoot": parentStateRoot.toJson(),
      "ParentMessageReceipts": parentMessageReceipts.toJson(),
      "Messages": messages.toJson(),
      "BLSAggregate": bLSAggregate?.toJson(),
      "Timestamp": config.encodeBigint(timestamp),
      "BlockSig": blockSig?.toJson(),
      "ForkSignaling": config.encodeBigint(forkSignaling),
      "ParentBaseFee": config.encodeBigint(parentBaseFee),
      "validated": validated,
    });
  }
}

/// LotusResponseBlockMessages
class LotusResponseBlockMessages {
  final List<FilMessage> blsMessages;
  final List<FilSignedMessage> secpkMessages;
  final List<Cid> cids;

  const LotusResponseBlockMessages({
    required this.blsMessages,
    required this.secpkMessages,
    required this.cids,
  });

  factory LotusResponseBlockMessages.fromJson(Map<String, dynamic> json) {
    return LotusResponseBlockMessages(
      blsMessages: json.valueTo<List<FilMessage>, List>(
        key: "BlsMessages",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) =>
                          FilMessage.fromJson(JsonParser.valueEnsureAsMap(x)),
                    )
                    .toList(),
      ),
      secpkMessages: json.valueTo<List<FilSignedMessage>, List>(
        key: "SecpkMessages",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => FilSignedMessage.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      cids: json.valueTo<List<Cid>, List>(
        key: "Cids",
        onMissing: () => [],
        parse: (e) => e.map((x) => Cid.fromJson(x)).toList(),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "BlsMessages": blsMessages.map((e) => e.toJson()).toList(),
      "SecpkMessages": secpkMessages.map((e) => e.toJson()).toList(),
      "Cids": cids.map((e) => e.toJson()).toList(),
    });
  }
}

/// LotusResponseBlockMsg
class LotusResponseBlockMsg {
  final LotusResponseBlockHeader? header;
  final List<Cid> blsMessages;
  final List<Cid> secpkMessages;

  const LotusResponseBlockMsg({
    this.header,
    required this.blsMessages,
    required this.secpkMessages,
  });

  factory LotusResponseBlockMsg.fromJson(Map<String, dynamic> json) {
    return LotusResponseBlockMsg(
      header: json.valueTo<LotusResponseBlockHeader?, Map>(
        key: "Header",
        parse:
            (e) => LotusResponseBlockHeader.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      blsMessages: json.valueTo<List<Cid>, List>(
        key: "BlsMessages",
        onMissing: () => [],
        parse: (e) => e.map((x) => Cid.fromJson(x)).toList(),
      ),
      secpkMessages: json.valueTo<List<Cid>, List>(
        key: "SecpkMessages",
        onMissing: () => [],
        parse: (e) => e.map((x) => Cid.fromJson(x)).toList(),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Header": header?.toJson(config: config),
      "BlsMessages": blsMessages.map((e) => e.toJson()).toList(),
      "SecpkMessages": secpkMessages.map((e) => e.toJson()).toList(),
    });
  }
}

/// LotusResponseBlockTemplate
class LotusResponseBlockTemplate {
  final String miner;
  final LotusTipSetKey parents;
  final LotusResponseTicket? ticket;
  final LotusResponseElectionProof? eproof;
  final List<LotusResponseBeaconEntry> beaconValues;
  final List<FilSignedMessage> messages;
  final BigInt epoch;
  final BigInt timestamp;
  final List<LotusResponsePoStProof> winningPoStProof;

  const LotusResponseBlockTemplate({
    required this.miner,
    required this.parents,
    this.ticket,
    this.eproof,
    required this.beaconValues,
    required this.messages,
    required this.epoch,
    required this.timestamp,
    required this.winningPoStProof,
  });

  factory LotusResponseBlockTemplate.fromJson(Map<String, dynamic> json) {
    return LotusResponseBlockTemplate(
      miner: json.valueAsString("Miner"),
      parents: json.valueTo<LotusTipSetKey, Object>(
        key: "Parents",
        parse: (e) => LotusTipSetKey.fromJson(e),
      ),
      ticket: json.valueTo<LotusResponseTicket?, Map>(
        key: "Ticket",
        parse:
            (e) => LotusResponseTicket.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      eproof: json.valueTo<LotusResponseElectionProof?, Map>(
        key: "Eproof",
        parse:
            (e) => LotusResponseElectionProof.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      beaconValues: json.valueTo<List<LotusResponseBeaconEntry>, List>(
        key: "BeaconValues",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseBeaconEntry.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      messages: json.valueTo<List<FilSignedMessage>, List>(
        key: "Messages",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => FilSignedMessage.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      epoch: json.valueAsBigInt("Epoch", onMissing: () => BigInt.zero),
      timestamp: json.valueAsBigInt("Timestamp", onMissing: () => BigInt.zero),
      winningPoStProof: json.valueTo<List<LotusResponsePoStProof>, List>(
        key: "WinningPoStProof",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponsePoStProof.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Miner": miner,
      "Parents": parents.toJson(),
      "Ticket": ticket?.toJson(config: config),
      "Eproof": eproof?.toJson(config: config),
      "BeaconValues":
          beaconValues.map((e) => e.toJson(config: config)).toList(),
      "Messages": messages.map((e) => e.toJson()).toList(),
      "Epoch": config.encodeBigint(epoch),
      "Timestamp": config.encodeBigint(timestamp),
      "WinningPoStProof":
          winningPoStProof.map((e) => e.toJson(config: config)).toList(),
    });
  }
}

/// LotusResponseChannelAvailableFunds
class LotusResponseChannelAvailableFunds {
  /// Channel is the address of the channel
  final String? channel;

  /// From is the from address of the channel (channel creator)
  final String from;

  /// To is the to address of the channel
  final String to;

  /// ConfirmedAmt is the total amount of funds that have been confirmed on-chain for the channel
  final BigInt confirmedAmt;

  /// PendingAmt is the amount of funds that are pending confirmation on-chain
  final BigInt pendingAmt;

  /// NonReservedAmt is part of ConfirmedAmt that is available for use (e.g. when the payment channel was pre-funded)
  final BigInt nonReservedAmt;

  /// PendingAvailableAmt is the amount of funds that are pending confirmation on-chain that will become available once confirmed
  final BigInt pendingAvailableAmt;

  /// PendingWaitSentinel can be used with PaychGetWaitReady to wait for confirmation of pending funds
  final Cid? pendingWaitSentinel;

  /// QueuedAmt is the amount that is queued up behind a pending request
  final BigInt queuedAmt;

  /// VoucherReedeemedAmt is the amount that is redeemed by vouchers on-chain and in the local datastore
  final BigInt voucherReedeemedAmt;

  const LotusResponseChannelAvailableFunds({
    this.channel,
    required this.from,
    required this.to,
    required this.confirmedAmt,
    required this.pendingAmt,
    required this.nonReservedAmt,
    required this.pendingAvailableAmt,
    this.pendingWaitSentinel,
    required this.queuedAmt,
    required this.voucherReedeemedAmt,
  });

  factory LotusResponseChannelAvailableFunds.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseChannelAvailableFunds(
      channel: json["Channel"]?.toString(),
      from: json.valueAsString("From"),
      to: json.valueAsString("To"),
      confirmedAmt: json.valueTo<BigInt, Object>(
        key: "ConfirmedAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      pendingAmt: json.valueTo<BigInt, Object>(
        key: "PendingAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      nonReservedAmt: json.valueTo<BigInt, Object>(
        key: "NonReservedAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      pendingAvailableAmt: json.valueTo<BigInt, Object>(
        key: "PendingAvailableAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      pendingWaitSentinel: json.valueTo<Cid?, Object>(
        key: "PendingWaitSentinel",
        parse: (e) => Cid.fromJson(e),
      ),
      queuedAmt: json.valueTo<BigInt, Object>(
        key: "QueuedAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      voucherReedeemedAmt: json.valueTo<BigInt, Object>(
        key: "VoucherReedeemedAmt",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Channel": channel,
      "From": from,
      "To": to,
      "ConfirmedAmt": config.encodeBigint(confirmedAmt),
      "PendingAmt": config.encodeBigint(pendingAmt),
      "NonReservedAmt": config.encodeBigint(nonReservedAmt),
      "PendingAvailableAmt": config.encodeBigint(pendingAvailableAmt),
      "PendingWaitSentinel": pendingWaitSentinel?.toJson(),
      "QueuedAmt": config.encodeBigint(queuedAmt),
      "VoucherReedeemedAmt": config.encodeBigint(voucherReedeemedAmt),
    });
  }
}

/// LotusResponseChannelInfo
class LotusResponseChannelInfo {
  final String channel;
  final Cid waitSentinel;

  const LotusResponseChannelInfo({
    required this.channel,
    required this.waitSentinel,
  });

  factory LotusResponseChannelInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseChannelInfo(
      channel: json.valueAsString("Channel"),
      waitSentinel: json.valueTo<Cid, Object>(
        key: "WaitSentinel",
        parse: (e) => Cid.fromJson(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Channel": channel,
      "WaitSentinel": waitSentinel.toJson(),
    });
  }
}

/// LotusResponseCirculatingSupply
class LotusResponseCirculatingSupply {
  final BigInt filVested;
  final BigInt filMined;
  final BigInt filBurnt;
  final BigInt filLocked;
  final BigInt filCirculating;
  final BigInt filReserveDisbursed;

  const LotusResponseCirculatingSupply({
    required this.filVested,
    required this.filMined,
    required this.filBurnt,
    required this.filLocked,
    required this.filCirculating,
    required this.filReserveDisbursed,
  });

  factory LotusResponseCirculatingSupply.fromJson(Map<String, dynamic> json) {
    return LotusResponseCirculatingSupply(
      filVested: JsonParser.valueAsBigInt(json["FilVested"] ?? "0"),
      filMined: JsonParser.valueAsBigInt(json["FilMined"] ?? "0"),
      filBurnt: JsonParser.valueAsBigInt(json["FilBurnt"] ?? "0"),
      filLocked: JsonParser.valueAsBigInt(json["FilLocked"] ?? "0"),
      filCirculating: JsonParser.valueAsBigInt(json["FilCirculating"] ?? "0"),
      filReserveDisbursed: JsonParser.valueAsBigInt(
        json["FilReserveDisbursed"] ?? "0",
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "FilVested": config.encodeBigint(filVested),
      "FilMined": config.encodeBigint(filMined),
      "FilBurnt": config.encodeBigint(filBurnt),
      "FilLocked": config.encodeBigint(filLocked),
      "FilCirculating": config.encodeBigint(filCirculating),
      "FilReserveDisbursed": config.encodeBigint(filReserveDisbursed),
    });
  }
}

class LotusResponseStateGetAllocation {
  final BigInt? client;
  final Cid? data;
  final BigInt? expiration;
  final BigInt? provider;
  final BigInt? size;
  final BigInt? termMax;
  final BigInt? termMin;

  const LotusResponseStateGetAllocation({
    this.client,
    this.data,
    this.expiration,
    this.provider,
    this.size,
    this.termMax,
    this.termMin,
  });

  factory LotusResponseStateGetAllocation.fromJson(Map<String, dynamic> json) {
    return LotusResponseStateGetAllocation(
      client: json.valueAsBigInt('Client'),
      data: json.valueTo<Cid?, Object>(
        key: "Data",
        parse: (v) => Cid.fromJson(v),
      ),
      expiration: json.valueAsBigInt('Expiration'),
      provider: json.valueAsBigInt('Provider'),
      size: json.valueAsBigInt('Size'),
      termMax: json.valueAsBigInt('TermMax'),
      termMin: json.valueAsBigInt('TermMin'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Client': config.encodeBigint(client),
    'Data': data?.toJson(),
    'Expiration': config.encodeBigint(expiration),
    'Provider': config.encodeBigint(provider),
    'Size': config.encodeBigint(size),
    'TermMax': config.encodeBigint(termMax),
    'TermMin': config.encodeBigint(termMin),
  });
}

class LotusResponseClaim {
  final BigInt? client;
  final Cid? data;
  final BigInt? provider;
  final BigInt? size;
  final BigInt? termMax;
  final BigInt? termMin;
  final BigInt? termStart;
  final BigInt? sector;
  const LotusResponseClaim({
    this.client,
    this.data,
    this.provider,
    this.size,
    this.termMax,
    this.termMin,
    this.sector,
    this.termStart,
  });

  factory LotusResponseClaim.fromJson(Map<String, dynamic> json) {
    return LotusResponseClaim(
      client: json.valueAsBigInt('Client'),
      data: json.valueTo<Cid?, Object>(
        key: "Data",
        parse: (v) => Cid.fromJson(v),
      ),
      sector: json.valueAsBigInt('Sector'),
      provider: json.valueAsBigInt('Provider'),
      size: json.valueAsBigInt('Size'),
      termMax: json.valueAsBigInt('TermMax'),
      termMin: json.valueAsBigInt('TermMin'),
      termStart: json.valueAsBigInt('TermStart'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Client': config.encodeBigint(client),
    'Data': data?.toJson(),
    'TermStart': config.encodeBigint(termStart),
    'Provider': config.encodeBigint(provider),
    'Size': config.encodeBigint(size),
    'TermMax': config.encodeBigint(termMax),
    'TermMin': config.encodeBigint(termMin),
    "Sector": config.encodeBigint(sector),
  });
}

/// LotusResponseComputeStateOutput
class LotusResponseComputeStateOutput {
  final Cid root;
  final List<dynamic> trace;

  const LotusResponseComputeStateOutput({
    required this.root,
    required this.trace,
  });

  factory LotusResponseComputeStateOutput.fromJson(Map<String, dynamic> json) {
    return LotusResponseComputeStateOutput(
      root: json.valueTo<Cid, Object>(
        key: "Root",
        parse: (e) => Cid.fromJson(e),
      ),
      trace: json.valueEnsureAsList<dynamic>("Trace", onMissing: () => []),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Root": root.toJson(),
      "Trace": trace,
    });
  }
}

class LotusResponsePowerClaim {
  final BigInt? qualityAdjPower;
  final BigInt? rawBytePower;

  const LotusResponsePowerClaim({this.qualityAdjPower, this.rawBytePower});

  factory LotusResponsePowerClaim.fromJson(Map<String, dynamic> json) {
    return LotusResponsePowerClaim(
      qualityAdjPower: json.valueAsBigInt("QualityAdjPower"),
      rawBytePower: json.valueAsBigInt("RawBytePower"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'QualityAdjPower': config.encodeBigint(qualityAdjPower),
    'RawBytePower': config.encodeBigint(rawBytePower),
  });
}

class LotusResponseDeadline {
  final BigInt disputableProofCount;

  final BigInt dailyFee;

  final List<int> postSubmissions;

  const LotusResponseDeadline({
    required this.disputableProofCount,
    required this.dailyFee,
    required this.postSubmissions,
  });

  factory LotusResponseDeadline.fromJson(Map<String, dynamic> json) {
    return LotusResponseDeadline(
      disputableProofCount: json.valueAsBigInt(
        "DisputableProofCount",
        onMissing: () => BigInt.zero,
      ),
      dailyFee: json.valueAsBigInt("DailyFee", onMissing: () => BigInt.zero),
      postSubmissions: json.valueAsList<List<int>>("PostSubmissions"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "DisputableProofCount": config.encodeBigint(disputableProofCount),
      "DailyFee": config.encodeBigint(dailyFee),
      "PostSubmissions": postSubmissions,
    });
  }
}

/// LotusResponseDealCollateralBounds
class LotusResponseDealCollateralBounds {
  final BigInt min;
  final BigInt max;

  const LotusResponseDealCollateralBounds({
    required this.min,
    required this.max,
  });

  factory LotusResponseDealCollateralBounds.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseDealCollateralBounds(
      min: JsonParser.valueAsBigInt(json["Min"] ?? "0"),
      max: JsonParser.valueAsBigInt(json["Max"] ?? "0"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Min": config.encodeBigint(min),
      "Max": config.encodeBigint(max),
    });
  }
}

/// Note: Deal Collateral is only released and returned to clients and miners when the storage deal stops counting towards power. In the current iteration, it will be released when the sector containing the storage deals expires, even though some storage deals can expire earlier than the sector does. Collaterals are denominated in PerEpoch to incur a cost for self dealing or minimal deals that last for a long time. Note: ClientCollateralPerEpoch may not be needed and removed pending future confirmation. There will be a Minimum value for both client and provider deal collateral.
class LotusResponseDealProposal {
  final Cid pieceCID;
  final BigInt pieceSize;
  final bool verifiedDeal;
  final String client;
  final String provider;

  /// Label is an arbitrary client chosen label to apply to the deal
  final String label;

  /// Nominal start epoch. Deal payment is linear between StartEpoch and EndEpoch, with total amount StoragePricePerEpoch * (EndEpoch - StartEpoch). Storage deal must appear in a sealed (proven) sector no later than StartEpoch, otherwise it is invalid.
  final BigInt startEpoch;
  final BigInt endEpoch;
  final BigInt storagePricePerEpoch;
  final BigInt providerCollateral;
  final BigInt clientCollateral;

  const LotusResponseDealProposal({
    required this.pieceCID,
    required this.pieceSize,
    required this.verifiedDeal,
    required this.client,
    required this.provider,
    required this.label,
    required this.startEpoch,
    required this.endEpoch,
    required this.storagePricePerEpoch,
    required this.providerCollateral,
    required this.clientCollateral,
  });

  factory LotusResponseDealProposal.fromJson(Map<String, dynamic> json) {
    return LotusResponseDealProposal(
      pieceCID: json.valueTo<Cid, Object>(
        key: "PieceCID",
        parse: (e) => Cid.fromJson(e),
      ),
      pieceSize: json.valueAsBigInt("PieceSize", onMissing: () => BigInt.zero),
      verifiedDeal: json.valueAsBool("VerifiedDeal", onMissing: () => false),
      client: json.valueAsString("Client"),
      provider: json.valueAsString("Provider"),
      label: json.valueAsString("Label"),
      startEpoch: json.valueAsBigInt(
        "StartEpoch",
        onMissing: () => BigInt.zero,
      ),
      endEpoch: json.valueAsBigInt("EndEpoch", onMissing: () => BigInt.zero),
      storagePricePerEpoch: JsonParser.valueAsBigInt(
        json["StoragePricePerEpoch"] ?? "0",
      ),
      providerCollateral: JsonParser.valueAsBigInt(
        json["ProviderCollateral"] ?? "0",
      ),
      clientCollateral: JsonParser.valueAsBigInt(
        json["ClientCollateral"] ?? "0",
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "PieceCID": pieceCID.toJson(),
      "PieceSize": config.encodeBigint(pieceSize),
      "VerifiedDeal": verifiedDeal,
      "Client": client,
      "Provider": provider,
      "Label": label,
      "StartEpoch": config.encodeBigint(startEpoch),
      "EndEpoch": config.encodeBigint(endEpoch),
      "StoragePricePerEpoch": config.encodeBigint(storagePricePerEpoch),
      "ProviderCollateral": config.encodeBigint(providerCollateral),
      "ClientCollateral": config.encodeBigint(clientCollateral),
    });
  }
}

/// LotusResponseElectionProof
class LotusResponseElectionProof {
  final BigInt winCount;
  final List<int> vRFProof;

  const LotusResponseElectionProof({
    required this.winCount,
    required this.vRFProof,
  });

  factory LotusResponseElectionProof.fromJson(Map<String, dynamic> json) {
    return LotusResponseElectionProof(
      winCount: json.valueAsBigInt("WinCount", onMissing: () => BigInt.zero),
      vRFProof: json.valueAsBytes(
        "VRFProof",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "WinCount": config.encodeBigint(winCount),
      "VRFProof": vRFProof,
    });
  }
}

/// LotusResponseExecutionTrace
class LotusResponseExecutionTrace {
  final LotusResponseMessageTrace msg;
  final LotusResponseReturnTrace msgRct;
  final LotusResponseActorTrace? invokedActor;
  final List<dynamic> gasCharges;
  final List<LotusResponseExecutionTrace> subcalls;
  final List<String>? logs;
  final List<LotusResponseTraceIpld>? ipldOps;

  const LotusResponseExecutionTrace({
    required this.msg,
    required this.msgRct,
    this.invokedActor,
    required this.gasCharges,
    required this.subcalls,
    this.logs,
    this.ipldOps,
  });

  factory LotusResponseExecutionTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseExecutionTrace(
      msg: json.valueTo<LotusResponseMessageTrace, Map>(
        key: "Msg",
        parse:
            (e) => LotusResponseMessageTrace.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      msgRct: json.valueTo<LotusResponseReturnTrace, Map>(
        key: "MsgRct",
        parse:
            (e) => LotusResponseReturnTrace.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      invokedActor: json.valueTo<LotusResponseActorTrace?, Map>(
        key: "InvokedActor",
        parse:
            (e) => LotusResponseActorTrace.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      gasCharges: json.valueEnsureAsList<dynamic>(
        "GasCharges",
        onMissing: () => [],
      ),
      subcalls: json.valueTo<List<LotusResponseExecutionTrace>, List>(
        key: "Subcalls",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseExecutionTrace.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      logs: json.valueAsList<List<String>?>("Logs"),
      ipldOps: json.valueTo<List<LotusResponseTraceIpld>?, List>(
        key: "IpldOps",
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseTraceIpld.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Msg": msg.toJson(config: config),
      "MsgRct": msgRct.toJson(config: config),
      "InvokedActor": invokedActor?.toJson(config: config),
      "GasCharges": gasCharges,
      "Subcalls": subcalls.map((e) => e.toJson(config: config)).toList(),
      "Logs": logs,
      "IpldOps": ipldOps?.map((e) => e.toJson()).toList(),
    });
  }
}

/// LotusResponseExtendedSectorInfo
class LotusResponseExtendedSectorInfo {
  final BigInt sealProof;
  final BigInt sectorNumber;
  final Cid? sectorKey;
  final Cid sealedCID;

  const LotusResponseExtendedSectorInfo({
    required this.sealProof,
    required this.sectorNumber,
    this.sectorKey,
    required this.sealedCID,
  });

  factory LotusResponseExtendedSectorInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseExtendedSectorInfo(
      sealProof: json.valueAsBigInt("SealProof", onMissing: () => BigInt.zero),
      sectorNumber: json.valueAsBigInt(
        "SectorNumber",
        onMissing: () => BigInt.zero,
      ),
      sectorKey: json.valueTo<Cid?, Object>(
        key: "SectorKey",
        parse: (e) => Cid.fromJson(e),
      ),
      sealedCID: json.valueTo<Cid, Object>(
        key: "SealedCID",
        parse: (e) => Cid.fromJson(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "SealProof": config.encodeBigint(sealProof),
      "SectorNumber": config.encodeBigint(sectorNumber),
      "SectorKey": sectorKey?.toJson(),
      "SealedCID": sealedCID.toJson(),
    });
  }
}

/// LotusResponseFault
class LotusResponseFault {
  final String miner;
  final BigInt epoch;

  const LotusResponseFault({required this.miner, required this.epoch});

  factory LotusResponseFault.fromJson(Map<String, dynamic> json) {
    return LotusResponseFault(
      miner: json.valueAsString("Miner"),
      epoch: json.valueAsBigInt("Epoch", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Miner": miner,
      "Epoch": config.encodeBigint(epoch),
    });
  }
}

/// LotusResponseForkUpgradeParams
class LotusResponseForkUpgradeParams {
  final BigInt upgradeSmokeHeight;
  final BigInt upgradeBreezeHeight;
  final BigInt upgradeIgnitionHeight;
  final BigInt upgradeLiftoffHeight;
  final BigInt upgradeAssemblyHeight;
  final BigInt upgradeRefuelHeight;
  final BigInt upgradeTapeHeight;
  final BigInt upgradeKumquatHeight;
  final BigInt breezeGasTampingDuration;
  final BigInt upgradeCalicoHeight;
  final BigInt upgradePersianHeight;
  final BigInt upgradeOrangeHeight;
  final BigInt upgradeClausHeight;
  final BigInt upgradeTrustHeight;
  final BigInt upgradeNorwegianHeight;
  final BigInt upgradeTurboHeight;
  final BigInt upgradeHyperdriveHeight;
  final BigInt upgradeChocolateHeight;
  final BigInt upgradeOhSnapHeight;
  final BigInt upgradeSkyrHeight;
  final BigInt upgradeSharkHeight;
  final BigInt upgradeHyggeHeight;
  final BigInt upgradeLightningHeight;
  final BigInt upgradeThunderHeight;
  final BigInt upgradeWatermelonHeight;
  final BigInt upgradeDragonHeight;
  final BigInt upgradePhoenixHeight;
  final BigInt upgradeWaffleHeight;
  final BigInt upgradeTuktukHeight;
  final BigInt upgradeTeepHeight;
  final BigInt upgradeTockHeight;
  final BigInt upgradeGoldenWeekHeight;
  final BigInt upgradeFireHorseHeight;
  final BigInt upgradeXxHeight;

  const LotusResponseForkUpgradeParams({
    required this.upgradeSmokeHeight,
    required this.upgradeBreezeHeight,
    required this.upgradeIgnitionHeight,
    required this.upgradeLiftoffHeight,
    required this.upgradeAssemblyHeight,
    required this.upgradeRefuelHeight,
    required this.upgradeTapeHeight,
    required this.upgradeKumquatHeight,
    required this.breezeGasTampingDuration,
    required this.upgradeCalicoHeight,
    required this.upgradePersianHeight,
    required this.upgradeOrangeHeight,
    required this.upgradeClausHeight,
    required this.upgradeTrustHeight,
    required this.upgradeNorwegianHeight,
    required this.upgradeTurboHeight,
    required this.upgradeHyperdriveHeight,
    required this.upgradeChocolateHeight,
    required this.upgradeOhSnapHeight,
    required this.upgradeSkyrHeight,
    required this.upgradeSharkHeight,
    required this.upgradeHyggeHeight,
    required this.upgradeLightningHeight,
    required this.upgradeThunderHeight,
    required this.upgradeWatermelonHeight,
    required this.upgradeDragonHeight,
    required this.upgradePhoenixHeight,
    required this.upgradeWaffleHeight,
    required this.upgradeTuktukHeight,
    required this.upgradeTeepHeight,
    required this.upgradeTockHeight,
    required this.upgradeGoldenWeekHeight,
    required this.upgradeFireHorseHeight,
    required this.upgradeXxHeight,
  });

  factory LotusResponseForkUpgradeParams.fromJson(Map<String, dynamic> json) {
    return LotusResponseForkUpgradeParams(
      upgradeSmokeHeight: json.valueAsBigInt(
        "UpgradeSmokeHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeBreezeHeight: json.valueAsBigInt(
        "UpgradeBreezeHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeIgnitionHeight: json.valueAsBigInt(
        "UpgradeIgnitionHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeLiftoffHeight: json.valueAsBigInt(
        "UpgradeLiftoffHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeAssemblyHeight: json.valueAsBigInt(
        "UpgradeAssemblyHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeRefuelHeight: json.valueAsBigInt(
        "UpgradeRefuelHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTapeHeight: json.valueAsBigInt(
        "UpgradeTapeHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeKumquatHeight: json.valueAsBigInt(
        "UpgradeKumquatHeight",
        onMissing: () => BigInt.zero,
      ),
      breezeGasTampingDuration: json.valueAsBigInt(
        "BreezeGasTampingDuration",
        onMissing: () => BigInt.zero,
      ),
      upgradeCalicoHeight: json.valueAsBigInt(
        "UpgradeCalicoHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradePersianHeight: json.valueAsBigInt(
        "UpgradePersianHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeOrangeHeight: json.valueAsBigInt(
        "UpgradeOrangeHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeClausHeight: json.valueAsBigInt(
        "UpgradeClausHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTrustHeight: json.valueAsBigInt(
        "UpgradeTrustHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeNorwegianHeight: json.valueAsBigInt(
        "UpgradeNorwegianHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTurboHeight: json.valueAsBigInt(
        "UpgradeTurboHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeHyperdriveHeight: json.valueAsBigInt(
        "UpgradeHyperdriveHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeChocolateHeight: json.valueAsBigInt(
        "UpgradeChocolateHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeOhSnapHeight: json.valueAsBigInt(
        "UpgradeOhSnapHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeSkyrHeight: json.valueAsBigInt(
        "UpgradeSkyrHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeSharkHeight: json.valueAsBigInt(
        "UpgradeSharkHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeHyggeHeight: json.valueAsBigInt(
        "UpgradeHyggeHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeLightningHeight: json.valueAsBigInt(
        "UpgradeLightningHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeThunderHeight: json.valueAsBigInt(
        "UpgradeThunderHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeWatermelonHeight: json.valueAsBigInt(
        "UpgradeWatermelonHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeDragonHeight: json.valueAsBigInt(
        "UpgradeDragonHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradePhoenixHeight: json.valueAsBigInt(
        "UpgradePhoenixHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeWaffleHeight: json.valueAsBigInt(
        "UpgradeWaffleHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTuktukHeight: json.valueAsBigInt(
        "UpgradeTuktukHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTeepHeight: json.valueAsBigInt(
        "UpgradeTeepHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeTockHeight: json.valueAsBigInt(
        "UpgradeTockHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeGoldenWeekHeight: json.valueAsBigInt(
        "UpgradeGoldenWeekHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeFireHorseHeight: json.valueAsBigInt(
        "UpgradeFireHorseHeight",
        onMissing: () => BigInt.zero,
      ),
      upgradeXxHeight: json.valueAsBigInt(
        "UpgradeXxHeight",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "UpgradeSmokeHeight": config.encodeBigint(upgradeSmokeHeight),
      "UpgradeBreezeHeight": config.encodeBigint(upgradeBreezeHeight),
      "UpgradeIgnitionHeight": config.encodeBigint(upgradeIgnitionHeight),
      "UpgradeLiftoffHeight": config.encodeBigint(upgradeLiftoffHeight),
      "UpgradeAssemblyHeight": config.encodeBigint(upgradeAssemblyHeight),
      "UpgradeRefuelHeight": config.encodeBigint(upgradeRefuelHeight),
      "UpgradeTapeHeight": config.encodeBigint(upgradeTapeHeight),
      "UpgradeKumquatHeight": config.encodeBigint(upgradeKumquatHeight),
      "BreezeGasTampingDuration": config.encodeBigint(breezeGasTampingDuration),
      "UpgradeCalicoHeight": config.encodeBigint(upgradeCalicoHeight),
      "UpgradePersianHeight": config.encodeBigint(upgradePersianHeight),
      "UpgradeOrangeHeight": config.encodeBigint(upgradeOrangeHeight),
      "UpgradeClausHeight": config.encodeBigint(upgradeClausHeight),
      "UpgradeTrustHeight": config.encodeBigint(upgradeTrustHeight),
      "UpgradeNorwegianHeight": config.encodeBigint(upgradeNorwegianHeight),
      "UpgradeTurboHeight": config.encodeBigint(upgradeTurboHeight),
      "UpgradeHyperdriveHeight": config.encodeBigint(upgradeHyperdriveHeight),
      "UpgradeChocolateHeight": config.encodeBigint(upgradeChocolateHeight),
      "UpgradeOhSnapHeight": config.encodeBigint(upgradeOhSnapHeight),
      "UpgradeSkyrHeight": config.encodeBigint(upgradeSkyrHeight),
      "UpgradeSharkHeight": config.encodeBigint(upgradeSharkHeight),
      "UpgradeHyggeHeight": config.encodeBigint(upgradeHyggeHeight),
      "UpgradeLightningHeight": config.encodeBigint(upgradeLightningHeight),
      "UpgradeThunderHeight": config.encodeBigint(upgradeThunderHeight),
      "UpgradeWatermelonHeight": config.encodeBigint(upgradeWatermelonHeight),
      "UpgradeDragonHeight": config.encodeBigint(upgradeDragonHeight),
      "UpgradePhoenixHeight": config.encodeBigint(upgradePhoenixHeight),
      "UpgradeWaffleHeight": config.encodeBigint(upgradeWaffleHeight),
      "UpgradeTuktukHeight": config.encodeBigint(upgradeTuktukHeight),
      "UpgradeTeepHeight": config.encodeBigint(upgradeTeepHeight),
      "UpgradeTockHeight": config.encodeBigint(upgradeTockHeight),
      "UpgradeGoldenWeekHeight": config.encodeBigint(upgradeGoldenWeekHeight),
      "UpgradeFireHorseHeight": config.encodeBigint(upgradeFireHorseHeight),
      "UpgradeXxHeight": config.encodeBigint(upgradeXxHeight),
    });
  }
}

/// LotusResponseGasTrace
class LotusResponseGasTrace {
  final String name;
  final BigInt totalGas;
  final BigInt computeGas;
  final BigInt storageGas;
  final int timeTaken;

  const LotusResponseGasTrace({
    required this.name,
    required this.totalGas,
    required this.computeGas,
    required this.storageGas,
    required this.timeTaken,
  });

  factory LotusResponseGasTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseGasTrace(
      name: json.valueAsString("Name"),
      totalGas: json.valueAsBigInt("tg", onMissing: () => BigInt.zero),
      computeGas: json.valueAsBigInt("cg", onMissing: () => BigInt.zero),
      storageGas: json.valueAsBigInt("sg", onMissing: () => BigInt.zero),
      timeTaken: json.valueAsInt("tt", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Name": name,
      "tg": config.encodeBigint(totalGas),
      "cg": config.encodeBigint(computeGas),
      "sg": config.encodeBigint(storageGas),
      "tt": timeTaken,
    });
  }
}

/// LotusResponseHeadChange
class LotusResponseHeadChange {
  final String type;
  final LotusResponseTipSet? val;

  const LotusResponseHeadChange({required this.type, this.val});

  factory LotusResponseHeadChange.fromJson(Map<String, dynamic> json) {
    return LotusResponseHeadChange(
      type: json.valueAsString("Type"),
      val: json.valueTo<LotusResponseTipSet?, Map>(
        key: "Val",
        parse:
            (e) => LotusResponseTipSet.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Type": type,
      "Val": val?.toJson(config: config),
    });
  }
}

/// LotusResponseInvocResult
class LotusResponseInvocResult {
  final Cid msgCid;
  final FilMessage? msg;
  final LotusResponseMessageReceipt? msgRct;
  final LotusResponseMsgGasCost gasCost;
  final LotusResponseExecutionTrace executionTrace;
  final String error;
  final int duration;

  const LotusResponseInvocResult({
    required this.msgCid,
    this.msg,
    this.msgRct,
    required this.gasCost,
    required this.executionTrace,
    required this.error,
    required this.duration,
  });

  factory LotusResponseInvocResult.fromJson(Map<String, dynamic> json) {
    return LotusResponseInvocResult(
      msgCid: json.valueTo<Cid, Object>(
        key: "MsgCid",
        parse: (e) => Cid.fromJson(e),
      ),
      msg: json.valueTo<FilMessage?, Map>(
        key: "Msg",
        parse: (e) => FilMessage.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      msgRct: json.valueTo<LotusResponseMessageReceipt?, Map>(
        key: "MsgRct",
        parse:
            (e) => LotusResponseMessageReceipt.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      gasCost: json.valueTo<LotusResponseMsgGasCost, Map>(
        key: "GasCost",
        parse:
            (e) => LotusResponseMsgGasCost.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      executionTrace: json.valueTo<LotusResponseExecutionTrace, Map>(
        key: "ExecutionTrace",
        parse:
            (e) => LotusResponseExecutionTrace.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      error: json.valueAsString("Error"),
      duration: json.valueAsInt("Duration", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "MsgCid": msgCid.toJson(),
      "Msg": msg?.toJson(),
      "MsgRct": msgRct?.toJson(config: config),
      "GasCost": gasCost.toJson(config: config),
      "ExecutionTrace": executionTrace.toJson(config: config),
      "Error": error,
      "Duration": duration,
    });
  }
}

/// LotusResponseIpldObject
class LotusResponseIpldObject {
  final Cid cid;
  final dynamic obj;

  const LotusResponseIpldObject({required this.cid, required this.obj});

  factory LotusResponseIpldObject.fromJson(Map<String, dynamic> json) {
    return LotusResponseIpldObject(
      cid: json.valueTo<Cid, Object>(key: "Cid", parse: (e) => Cid.fromJson(e)),
      obj: json["Obj"],
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{"Cid": cid.toJson(), "Obj": obj});
  }
}

/// LotusResponseKeyInfo is used for storing keys in KeyStore
class LotusResponseKeyInfo {
  final String type;
  final List<int> privateKey;

  const LotusResponseKeyInfo({required this.type, required this.privateKey});

  factory LotusResponseKeyInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseKeyInfo(
      type: json.valueAsString("Type"),
      privateKey: json.valueAsBytes(
        "PrivateKey",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Type": type,
      "PrivateKey": privateKey,
    });
  }
}

/// LotusResponseMarketBalance
class LotusResponseMarketBalance {
  final BigInt escrow;
  final BigInt locked;

  const LotusResponseMarketBalance({
    required this.escrow,
    required this.locked,
  });

  factory LotusResponseMarketBalance.fromJson(Map<String, dynamic> json) {
    return LotusResponseMarketBalance(
      escrow: json.valueAsBigInt("Escrow", onMissing: () => BigInt.zero),
      locked: json.valueAsBigInt("Locked", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Escrow": config.encodeBigint(escrow),
      "Locked": config.encodeBigint(locked),
    });
  }
}

/// LotusResponseMarketDeal
class LotusResponseMarketDeal {
  final LotusResponseDealProposal proposal;
  final LotusResponseMarketDealState state;

  const LotusResponseMarketDeal({required this.proposal, required this.state});

  factory LotusResponseMarketDeal.fromJson(Map<String, dynamic> json) {
    return LotusResponseMarketDeal(
      proposal: json.valueTo<LotusResponseDealProposal, Map>(
        key: "Proposal",
        parse:
            (e) => LotusResponseDealProposal.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      state: json.valueTo<LotusResponseMarketDealState, Map>(
        key: "State",
        parse:
            (e) => LotusResponseMarketDealState.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Proposal": proposal.toJson(config: config),
      "State": state.toJson(config: config),
    });
  }
}

/// LotusResponseMarketDealState
class LotusResponseMarketDealState {
  final BigInt sectorNumber;
  final BigInt sectorStartEpoch;
  final BigInt lastUpdatedEpoch;
  final BigInt slashEpoch;

  const LotusResponseMarketDealState({
    required this.sectorNumber,
    required this.sectorStartEpoch,
    required this.lastUpdatedEpoch,
    required this.slashEpoch,
  });

  factory LotusResponseMarketDealState.fromJson(Map<String, dynamic> json) {
    return LotusResponseMarketDealState(
      sectorNumber: json.valueAsBigInt(
        "SectorNumber",
        onMissing: () => BigInt.zero,
      ),
      sectorStartEpoch: json.valueAsBigInt(
        "SectorStartEpoch",
        onMissing: () => BigInt.zero,
      ),
      lastUpdatedEpoch: json.valueAsBigInt(
        "LastUpdatedEpoch",
        onMissing: () => BigInt.zero,
      ),
      slashEpoch: json.valueAsBigInt(
        "SlashEpoch",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "SectorNumber": config.encodeBigint(sectorNumber),
      "SectorStartEpoch": config.encodeBigint(sectorStartEpoch),
      "LastUpdatedEpoch": config.encodeBigint(lastUpdatedEpoch),
      "SlashEpoch": config.encodeBigint(slashEpoch),
    });
  }
}

/// Specifies which `Lane`s to be merged with what `Nonce` on channelUpdate
class LotusResponseMerge {
  final BigInt lane;
  final BigInt nonce;

  const LotusResponseMerge({required this.lane, required this.nonce});

  factory LotusResponseMerge.fromJson(Map<String, dynamic> json) {
    return LotusResponseMerge(
      lane: json.valueAsBigInt("Lane", onMissing: () => BigInt.zero),
      nonce: json.valueAsBigInt("Nonce", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Lane": config.encodeBigint(lane),
      "Nonce": config.encodeBigint(nonce),
    });
  }
}

/// LotusResponseMessageMatch
class LotusResponseMessageMatch {
  final String to;
  final String from;

  const LotusResponseMessageMatch({required this.to, required this.from});

  factory LotusResponseMessageMatch.fromJson(Map<String, dynamic> json) {
    return LotusResponseMessageMatch(
      to: json.valueAsString("To"),
      from: json.valueAsString("From"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{"To": to, "From": from});
  }
}

/// LotusResponseMessageReceipt
class LotusResponseMessageReceipt {
  final MessageReceiptVersion? version;
  final BigInt exitCode;
  final List<int>? returnValue;
  final BigInt gasUsed;
  final Cid? eventsRoot;

  const LotusResponseMessageReceipt({
    required this.version,
    required this.exitCode,
    required this.returnValue,
    required this.gasUsed,
    this.eventsRoot,
  });

  factory LotusResponseMessageReceipt.fromJson(Map<String, dynamic> json) {
    return LotusResponseMessageReceipt(
      version: json.valueTo<MessageReceiptVersion?, int>(
        key: "version",
        parse: (e) => MessageReceiptVersion.fromValue(e),
      ),
      exitCode: json.valueAsBigInt("ExitCode", onMissing: () => BigInt.zero),
      returnValue: json.valueAsBytes("Return", encoding: StringEncoding.base64),
      gasUsed: json.valueAsBigInt("GasUsed", onMissing: () => BigInt.zero),
      eventsRoot: json.valueTo<Cid?, Object>(
        key: "EventsRoot",
        parse: (e) => Cid.fromJson(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "version": version?.value,
      "ExitCode": config.encodeBigint(exitCode),
      "Return":
          returnValue == null
              ? null
              : StringUtils.decode(
                returnValue!,
                encoding: StringEncoding.base64,
              ),
      "GasUsed": config.encodeBigint(gasUsed),
      "EventsRoot": eventsRoot?.toJson(),
    });
  }
}

/// LotusParamsMessageSendSpec contains optional fields which modify message sending behavior
class LotusParamsMessageSendSpec {
  /// MaxFee specifies a cap on network fees related to this message
  final BigInt maxFee;

  /// MsgUuid specifies a unique message identifier which can be used on node (or node cluster) level to prevent double-sends of messages even when nonce generation is not handled by sender
  final List<int> msgUuid;

  /// MaximizeFeeCap makes message FeeCap be based entirely on MaxFee
  final bool maximizeFeeCap;

  const LotusParamsMessageSendSpec({
    required this.maxFee,
    required this.msgUuid,
    required this.maximizeFeeCap,
  });

  factory LotusParamsMessageSendSpec.fromJson(Map<String, dynamic> json) {
    return LotusParamsMessageSendSpec(
      maxFee: JsonParser.valueAsBigInt(json["MaxFee"] ?? "0"),
      msgUuid: json.valueAsBytes("MsgUuid", encoding: StringEncoding.base64),
      maximizeFeeCap: json.valueAsBool(
        "MaximizeFeeCap",
        onMissing: () => false,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "MaxFee": config.encodeBigint(maxFee),
      "MsgUuid": StringUtils.decode(msgUuid, encoding: StringEncoding.base64),
      "MaximizeFeeCap": maximizeFeeCap,
    });
  }
}

/// LotusResponseMessageTrace
class LotusResponseMessageTrace {
  final String from;
  final String to;
  final BigInt value;
  final BigInt method;
  final List<int> params;
  final BigInt paramsCodec;
  final BigInt gasLimit;
  final bool readOnly;

  const LotusResponseMessageTrace({
    required this.from,
    required this.to,
    required this.value,
    required this.method,
    required this.params,
    required this.paramsCodec,
    required this.gasLimit,
    required this.readOnly,
  });

  factory LotusResponseMessageTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseMessageTrace(
      from: json.valueAsString("From"),
      to: json.valueAsString("To"),
      value: JsonParser.valueAsBigInt(json["Value"] ?? "0"),
      method: json.valueAsBigInt("Method", onMissing: () => BigInt.zero),
      params: json.valueAsBytes(
        "Params",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      paramsCodec: json.valueAsBigInt(
        "ParamsCodec",
        onMissing: () => BigInt.zero,
      ),
      gasLimit: json.valueAsBigInt("GasLimit", onMissing: () => BigInt.zero),
      readOnly: json.valueAsBool("ReadOnly", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "From": from,
      "To": to,
      "Value": config.encodeBigint(value),
      "Method": config.encodeBigint(method),
      "Params": StringUtils.decode(params, encoding: StringEncoding.base64),
      "ParamsCodec": config.encodeBigint(paramsCodec),
      "GasLimit": config.encodeBigint(gasLimit),
      "ReadOnly": readOnly,
    });
  }
}

/// LotusResponseMinerInfo
class LotusResponseMinerInfo {
  /// Account that owns this miner. - Income and returned collateral are paid to this address. - This address is also allowed to change the worker address for the miner.
  final String owner;

  /// Worker account for this miner. The associated pubkey-type address is used to sign blocks and messages on behalf of this miner.
  final String worker;

  /// Additional addresses that are permitted to submit messages controlling this actor (optional).
  final List<String> controlAddresses;
  final LotusResponseWorkerKeyChange? pendingWorkerKey;

  /// Byte array representing a Libp2p identity that should be used when connecting to this miner.
  final String peerId;

  /// Slice of byte arrays representing Libp2p multi-addresses used for establishing a connection with this miner.
  final List<String> multiaddrs;

  /// The proof type used for Window PoSt for this miner. A miner may commit sectors with different seal proof types (but compatible sector size and corresponding PoSt proof types).
  final BigInt windowPoStProofType;

  /// Amount of space in each sector committed by this miner. This is computed from the proof type and represented here redundantly.
  final BigInt sectorSize;

  /// The number of sectors in each Window PoSt partition (proof). This is computed from the proof type and represented here redundantly.
  final BigInt windowPoStPartitionSectors;

  /// The next epoch this miner is eligible for certain permissioned actor methods and winning block elections as a result of being reported for a consensus fault.
  final BigInt consensusFaultElapsed;

  /// A proposed new owner account for this miner. Must be confirmed by a message from the pending address itself.
  final String? pendingOwnerAddress;

  /// Beneficiary address for this miner. This is the address that tokens will be withdrawn to
  final String beneficiary;

  /// Beneficiary's withdrawal quota, how much of the quota has been withdrawn, and when the Beneficiary expires.
  final LotusResponseBeneficiaryTerm beneficiaryTerm;

  /// A proposed change to `BenificiaryTerm`
  final LotusResponsePendingBeneficiaryChange? pendingBeneficiaryTerm;

  const LotusResponseMinerInfo({
    required this.owner,
    required this.worker,
    required this.controlAddresses,
    this.pendingWorkerKey,
    required this.peerId,
    required this.multiaddrs,
    required this.windowPoStProofType,
    required this.sectorSize,
    required this.windowPoStPartitionSectors,
    required this.consensusFaultElapsed,
    this.pendingOwnerAddress,
    required this.beneficiary,
    required this.beneficiaryTerm,
    this.pendingBeneficiaryTerm,
  });

  factory LotusResponseMinerInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseMinerInfo(
      owner: json.valueAsString("Owner"),
      worker: json.valueAsString("Worker"),
      controlAddresses: json.valueTo<List<String>, List>(
        key: "ControlAddresses",
        onMissing: () => [],
        parse: (e) => e.map((x) => x.toString()).toList(),
      ),
      pendingWorkerKey: json.valueTo<LotusResponseWorkerKeyChange?, Map>(
        key: "PendingWorkerKey",
        parse:
            (e) => LotusResponseWorkerKeyChange.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      peerId: json.valueTo<String, dynamic>(
        key: "PeerId",
        parse: (e) => e.toString(),
      ),
      multiaddrs: json.valueTo<List<String>, List>(
        key: "Multiaddrs",
        onMissing: () => [],
        parse: (e) => e.map((x) => x.toString()).toList(),
      ),
      windowPoStProofType: json.valueAsBigInt(
        "WindowPoStProofType",
        onMissing: () => BigInt.zero,
      ),
      sectorSize: json.valueAsBigInt(
        "SectorSize",
        onMissing: () => BigInt.zero,
      ),
      windowPoStPartitionSectors: json.valueAsBigInt(
        "WindowPoStPartitionSectors",
        onMissing: () => BigInt.zero,
      ),
      consensusFaultElapsed: json.valueAsBigInt(
        "ConsensusFaultElapsed",
        onMissing: () => BigInt.zero,
      ),
      pendingOwnerAddress: json["PendingOwnerAddress"]?.toString(),
      beneficiary: json.valueAsString("Beneficiary"),
      beneficiaryTerm: json.valueTo<LotusResponseBeneficiaryTerm, Map>(
        key: "BeneficiaryTerm",
        parse:
            (e) => LotusResponseBeneficiaryTerm.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      pendingBeneficiaryTerm: json
          .valueTo<LotusResponsePendingBeneficiaryChange?, Map>(
            key: "PendingBeneficiaryTerm",
            parse:
                (e) => LotusResponsePendingBeneficiaryChange.fromJson(
                  JsonParser.valueEnsureAsMap(e),
                ),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Owner": owner,
      "Worker": worker,
      "ControlAddresses": controlAddresses,
      "PendingWorkerKey": pendingWorkerKey?.toJson(config: config),
      "PeerId": peerId,
      "Multiaddrs": multiaddrs,
      "WindowPoStProofType": config.encodeBigint(windowPoStProofType),
      "SectorSize": config.encodeBigint(sectorSize),
      "WindowPoStPartitionSectors": config.encodeBigint(
        windowPoStPartitionSectors,
      ),
      "ConsensusFaultElapsed": config.encodeBigint(consensusFaultElapsed),
      "PendingOwnerAddress": pendingOwnerAddress,
      "Beneficiary": beneficiary,
      "BeneficiaryTerm": beneficiaryTerm.toJson(config: config),
      "PendingBeneficiaryTerm": pendingBeneficiaryTerm?.toJson(config: config),
    });
  }
}

/// LotusResponseMinerPower
class LotusResponseMinerPower {
  final LotusResponsePowerClaim minerPower;
  final LotusResponsePowerClaim totalPower;
  final bool hasMinPower;

  const LotusResponseMinerPower({
    required this.minerPower,
    required this.totalPower,
    required this.hasMinPower,
  });

  factory LotusResponseMinerPower.fromJson(Map<String, dynamic> json) {
    return LotusResponseMinerPower(
      minerPower: json.valueTo<LotusResponsePowerClaim, Map>(
        key: "MinerPower",
        parse:
            (e) => LotusResponsePowerClaim.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      totalPower: json.valueTo<LotusResponsePowerClaim, Map>(
        key: "TotalPower",
        parse:
            (e) => LotusResponsePowerClaim.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      hasMinPower: json.valueAsBool("HasMinPower", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "MinerPower": minerPower.toJson(config: config),
      "TotalPower": totalPower.toJson(config: config),
      "HasMinPower": hasMinPower,
    });
  }
}

class LotusResponseDeadlineInfo {
  final BigInt? challenge;
  final BigInt? close;
  final BigInt? currentEpoch;
  final BigInt? faultCutoff;
  final BigInt? faultDeclarationCutoff;
  final BigInt? index;
  final BigInt? open;
  final BigInt? periodStart;
  final BigInt? wPoStChallengeLookback;
  final BigInt? wPoStChallengeWindow;
  final BigInt? wPoStPeriodDeadlines;
  final BigInt? wPoStProvingPeriod;

  const LotusResponseDeadlineInfo({
    this.challenge,
    this.close,
    this.currentEpoch,
    this.faultCutoff,
    this.faultDeclarationCutoff,
    this.index,
    this.open,
    this.periodStart,
    this.wPoStChallengeLookback,
    this.wPoStChallengeWindow,
    this.wPoStPeriodDeadlines,
    this.wPoStProvingPeriod,
  });

  factory LotusResponseDeadlineInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseDeadlineInfo(
      challenge: json.valueAsBigInt('Challenge'),
      close: json.valueAsBigInt('Close'),
      currentEpoch: json.valueAsBigInt('CurrentEpoch'),
      faultCutoff: json.valueAsBigInt('FaultCutoff'),
      faultDeclarationCutoff: json.valueAsBigInt('FaultDeclarationCutoff'),
      index: json.valueAsBigInt('Index'),
      open: json.valueAsBigInt('Open'),
      periodStart: json.valueAsBigInt('PeriodStart'),
      wPoStChallengeLookback: json.valueAsBigInt('WPoStChallengeLookback'),
      wPoStChallengeWindow: json.valueAsBigInt('WPoStChallengeWindow'),
      wPoStPeriodDeadlines: json.valueAsBigInt('WPoStPeriodDeadlines'),
      wPoStProvingPeriod: json.valueAsBigInt('WPoStProvingPeriod'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Challenge': config.encodeBigint(challenge),
    'Close': config.encodeBigint(close),
    'CurrentEpoch': config.encodeBigint(currentEpoch),
    'FaultCutoff': config.encodeBigint(faultCutoff),
    'FaultDeclarationCutoff': config.encodeBigint(faultDeclarationCutoff),
    'Index': config.encodeBigint(index),
    'Open': config.encodeBigint(open),
    'PeriodStart': config.encodeBigint(periodStart),
    'WPoStChallengeLookback': config.encodeBigint(wPoStChallengeLookback),
    'WPoStChallengeWindow': config.encodeBigint(wPoStChallengeWindow),
    'WPoStPeriodDeadlines': config.encodeBigint(wPoStPeriodDeadlines),
    'WPoStProvingPeriod': config.encodeBigint(wPoStProvingPeriod),
  });
}

/// LotusResponseMinerSectors
class LotusResponseMinerSectors {
  /// Live sectors that should be proven.
  final BigInt live;

  /// Sectors actively contributing to power.
  final BigInt active;

  /// Sectors with failed proofs.
  final BigInt faulty;

  const LotusResponseMinerSectors({
    required this.live,
    required this.active,
    required this.faulty,
  });

  factory LotusResponseMinerSectors.fromJson(Map<String, dynamic> json) {
    return LotusResponseMinerSectors(
      live: json.valueAsBigInt("Live", onMissing: () => BigInt.zero),
      active: json.valueAsBigInt("Active", onMissing: () => BigInt.zero),
      faulty: json.valueAsBigInt("Faulty", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Live": config.encodeBigint(live),
      "Active": config.encodeBigint(active),
      "Faulty": config.encodeBigint(faulty),
    });
  }
}

/// LotusResponseMiningBaseInfo
class LotusResponseMiningBaseInfo {
  final BigInt minerPower;
  final BigInt networkPower;
  final List<LotusResponseExtendedSectorInfo> sectors;
  final String workerKey;
  final BigInt sectorSize;
  final LotusResponseBeaconEntry prevBeaconEntry;
  final List<LotusResponseBeaconEntry> beaconEntries;
  final bool eligibleForMining;

  const LotusResponseMiningBaseInfo({
    required this.minerPower,
    required this.networkPower,
    required this.sectors,
    required this.workerKey,
    required this.sectorSize,
    required this.prevBeaconEntry,
    required this.beaconEntries,
    required this.eligibleForMining,
  });

  factory LotusResponseMiningBaseInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseMiningBaseInfo(
      minerPower: json.valueTo<BigInt, Object>(
        key: "MinerPower",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      networkPower: json.valueTo<BigInt, Object>(
        key: "NetworkPower",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      sectors: json.valueTo<List<LotusResponseExtendedSectorInfo>, List>(
        key: "Sectors",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseExtendedSectorInfo.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      workerKey: json.valueAsString("WorkerKey"),
      sectorSize: json.valueAsBigInt(
        "SectorSize",
        onMissing: () => BigInt.zero,
      ),
      prevBeaconEntry: json.valueTo<LotusResponseBeaconEntry, Map>(
        key: "PrevBeaconEntry",
        parse:
            (e) => LotusResponseBeaconEntry.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      beaconEntries: json.valueTo<List<LotusResponseBeaconEntry>, List>(
        key: "BeaconEntries",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseBeaconEntry.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      eligibleForMining: json.valueAsBool(
        "EligibleForMining",
        onMissing: () => false,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "MinerPower": config.encodeBigint(minerPower),
      "NetworkPower": config.encodeBigint(networkPower),
      "Sectors": sectors.map((e) => e.toJson(config: config)).toList(),
      "WorkerKey": workerKey,
      "SectorSize": config.encodeBigint(sectorSize),
      "PrevBeaconEntry": prevBeaconEntry.toJson(config: config),
      "BeaconEntries":
          beaconEntries.map((e) => e.toJson(config: config)).toList(),
      "EligibleForMining": eligibleForMining,
    });
  }
}

/// Modular Verification method
class LotusResponseModVerifyParams {
  /// LotusResponseActor on which to invoke the method.
  final String actor;

  /// Method to invoke.
  final BigInt method;

  /// Pre-serialized method parameters.
  final List<int> data;

  const LotusResponseModVerifyParams({
    required this.actor,
    required this.method,
    required this.data,
  });

  factory LotusResponseModVerifyParams.fromJson(Map<String, dynamic> json) {
    return LotusResponseModVerifyParams(
      actor: json.valueAsString("Actor"),
      method: json.valueAsBigInt("Method", onMissing: () => BigInt.zero),
      data: json.valueAsBytes(
        "Data",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Actor": actor,
      "Method": config.encodeBigint(method),
      "Data": StringUtils.decode(data, encoding: StringEncoding.base64),
    });
  }
}

/// LotusResponseMpoolConfig
class LotusResponseMpoolConfig {
  final List<String> priorityAddrs;
  final int sizeLimitHigh;
  final int sizeLimitLow;
  final BigInt replaceByFeeRatio;
  final int pruneCooldown;
  final double gasLimitOverestimation;

  const LotusResponseMpoolConfig({
    required this.priorityAddrs,
    required this.sizeLimitHigh,
    required this.sizeLimitLow,
    required this.replaceByFeeRatio,
    required this.pruneCooldown,
    required this.gasLimitOverestimation,
  });

  factory LotusResponseMpoolConfig.fromJson(Map<String, dynamic> json) {
    return LotusResponseMpoolConfig(
      priorityAddrs: json.valueTo<List<String>, List>(
        key: "PriorityAddrs",
        onMissing: () => [],
        parse: (e) => e.map((x) => x.toString()).toList(),
      ),
      sizeLimitHigh: json.valueAsInt("SizeLimitHigh", onMissing: () => 0),
      sizeLimitLow: json.valueAsInt("SizeLimitLow", onMissing: () => 0),
      replaceByFeeRatio: json.valueAsBigInt(
        "ReplaceByFeeRatio",
        onMissing: () => BigInt.zero,
      ),
      pruneCooldown: json.valueAsInt("PruneCooldown", onMissing: () => 0),
      gasLimitOverestimation: json.valueAsDouble(
        "GasLimitOverestimation",
        onMissing: () => 0.0,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "PriorityAddrs": priorityAddrs,
      "SizeLimitHigh": sizeLimitHigh,
      "SizeLimitLow": sizeLimitLow,
      "ReplaceByFeeRatio": config.encodeBigint(replaceByFeeRatio),
      "PruneCooldown": pruneCooldown,
      "GasLimitOverestimation": gasLimitOverestimation,
    });
  }
}

/// LotusResponseMpoolUpdate
class LotusResponseMpoolUpdate {
  final int type;
  final FilSignedMessage? message;

  const LotusResponseMpoolUpdate({required this.type, this.message});

  factory LotusResponseMpoolUpdate.fromJson(Map<String, dynamic> json) {
    return LotusResponseMpoolUpdate(
      type: json.valueAsInt("Type", onMissing: () => 0),
      message: json.valueTo<FilSignedMessage?, Map>(
        key: "Message",
        parse: (e) => FilSignedMessage.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Type": type,
      "Message": message?.toJson(),
    });
  }
}

/// LotusResponseMsgGasCost
class LotusResponseMsgGasCost {
  final Cid? message;
  final BigInt gasUsed;
  final BigInt baseFeeBurn;
  final BigInt overEstimationBurn;
  final BigInt minerPenalty;
  final BigInt minerTip;
  final BigInt refund;
  final BigInt totalCost;

  const LotusResponseMsgGasCost({
    required this.message,
    required this.gasUsed,
    required this.baseFeeBurn,
    required this.overEstimationBurn,
    required this.minerPenalty,
    required this.minerTip,
    required this.refund,
    required this.totalCost,
  });

  factory LotusResponseMsgGasCost.fromJson(Map<String, dynamic> json) {
    return LotusResponseMsgGasCost(
      message: json.valueTo<Cid?, Object>(
        key: "Message",
        parse: (e) => Cid.fromJson(e),
      ),
      gasUsed: JsonParser.valueAsBigInt(json["GasUsed"] ?? "0"),
      baseFeeBurn: JsonParser.valueAsBigInt(json["BaseFeeBurn"] ?? "0"),
      overEstimationBurn: JsonParser.valueAsBigInt(
        json["OverEstimationBurn"] ?? "0",
      ),
      minerPenalty: JsonParser.valueAsBigInt(json["MinerPenalty"] ?? "0"),
      minerTip: JsonParser.valueAsBigInt(json["MinerTip"] ?? "0"),
      refund: JsonParser.valueAsBigInt(json["Refund"] ?? "0"),
      totalCost: JsonParser.valueAsBigInt(json["TotalCost"] ?? "0"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Message": message?.toJson(),
      "GasUsed": config.encodeBigint(gasUsed),
      "BaseFeeBurn": config.encodeBigint(baseFeeBurn),
      "OverEstimationBurn": config.encodeBigint(overEstimationBurn),
      "MinerPenalty": config.encodeBigint(minerPenalty),
      "MinerTip": config.encodeBigint(minerTip),
      "Refund": config.encodeBigint(refund),
      "TotalCost": config.encodeBigint(totalCost),
    });
  }
}

/// LotusResponseMsgLookup
class LotusResponseMsgLookup {
  final Cid message;
  final LotusResponseMessageReceipt receipt;
  final dynamic returnDec;
  final LotusTipSetKey? tipSet;
  final BigInt height;

  const LotusResponseMsgLookup({
    required this.message,
    required this.receipt,
    required this.returnDec,
    required this.tipSet,
    required this.height,
  });

  factory LotusResponseMsgLookup.fromJson(Map<String, dynamic> json) {
    return LotusResponseMsgLookup(
      message: json.valueTo<Cid, Object>(
        key: "Message",
        parse: (e) => Cid.fromJson(e),
      ),
      receipt: json.valueTo<LotusResponseMessageReceipt, Map>(
        key: "Receipt",
        parse:
            (e) => LotusResponseMessageReceipt.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      returnDec: json["ReturnDec"],
      tipSet: json.valueTo<LotusTipSetKey?, Object>(
        key: "TipSet",
        parse: (e) => LotusTipSetKey.fromJson(e),
      ),
      height: json.valueAsBigInt("Height", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Message": message.toJson(),
      "Receipt": receipt.toJson(config: config),
      "ReturnDec": returnDec,
      "TipSet": tipSet?.toJson(),
      "Height": config.encodeBigint(height),
    });
  }
}

/// LotusResponseMsigTransaction
class LotusResponseMsigTransaction {
  final BigInt iD;
  final String to;
  final BigInt value;
  final BigInt method;
  final List<int> params;
  final List<FilAddress> approved;

  const LotusResponseMsigTransaction({
    required this.iD,
    required this.to,
    required this.value,
    required this.method,
    required this.params,
    required this.approved,
  });

  factory LotusResponseMsigTransaction.fromJson(Map<String, dynamic> json) {
    return LotusResponseMsigTransaction(
      iD: json.valueAsBigInt("ID", onMissing: () => BigInt.zero),
      to: json.valueAsString("To"),
      value: JsonParser.valueAsBigInt(json["Value"] ?? "0"),
      method: json.valueAsBigInt("Method", onMissing: () => BigInt.zero),
      params: json.valueAsBytes(
        "Params",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      approved:
          json
              .valueAsList<List<String>>("Approved", onMissing: () => [])
              .map((e) => FilAddress(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "ID": config.encodeBigint(iD),
      "To": to,
      "Value": config.encodeBigint(value),
      "Method": config.encodeBigint(method),
      "Params": StringUtils.decode(params, encoding: StringEncoding.base64),
      "Approved": approved.map((e) => e.address).toList(),
    });
  }
}

/// LotusResponseMsigVesting
class LotusResponseMsigVesting {
  final BigInt initialBalance;
  final BigInt startEpoch;
  final BigInt unlockDuration;

  const LotusResponseMsigVesting({
    required this.initialBalance,
    required this.startEpoch,
    required this.unlockDuration,
  });

  factory LotusResponseMsigVesting.fromJson(Map<String, dynamic> json) {
    return LotusResponseMsigVesting(
      initialBalance: JsonParser.valueAsBigInt(json["InitialBalance"] ?? "0"),
      startEpoch: json.valueAsBigInt(
        "StartEpoch",
        onMissing: () => BigInt.zero,
      ),
      unlockDuration: json.valueAsBigInt(
        "UnlockDuration",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "InitialBalance": config.encodeBigint(initialBalance),
      "StartEpoch": config.encodeBigint(startEpoch),
      "UnlockDuration": config.encodeBigint(unlockDuration),
    });
  }
}

/// LotusResponseNetworkParams
class LotusResponseNetworkParams {
  final String networkName;
  final BigInt blockDelaySecs;
  final BigInt consensusMinerMinPower;
  final BigInt preCommitChallengeDelay;
  final LotusResponseForkUpgradeParams forkUpgradeParams;
  final int eip155ChainID;
  final BigInt genesisTimestamp;

  const LotusResponseNetworkParams({
    required this.networkName,
    required this.blockDelaySecs,
    required this.consensusMinerMinPower,
    required this.preCommitChallengeDelay,
    required this.forkUpgradeParams,
    required this.eip155ChainID,
    required this.genesisTimestamp,
  });

  factory LotusResponseNetworkParams.fromJson(Map<String, dynamic> json) {
    return LotusResponseNetworkParams(
      networkName: json.valueAsString("NetworkName"),
      blockDelaySecs: json.valueAsBigInt(
        "BlockDelaySecs",
        onMissing: () => BigInt.zero,
      ),
      consensusMinerMinPower: json.valueAsBigInt(
        "ConsensusMinerMinPower",
        onMissing: () => BigInt.zero,
      ),
      preCommitChallengeDelay: json.valueAsBigInt(
        "PreCommitChallengeDelay",
        onMissing: () => BigInt.zero,
      ),
      forkUpgradeParams: json.valueTo<LotusResponseForkUpgradeParams, Map>(
        key: "ForkUpgradeParams",
        parse:
            (e) => LotusResponseForkUpgradeParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      eip155ChainID: json.valueAsInt("Eip155ChainID", onMissing: () => 0),
      genesisTimestamp: json.valueAsBigInt(
        "GenesisTimestamp",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "NetworkName": networkName,
      "BlockDelaySecs": config.encodeBigint(blockDelaySecs),
      "ConsensusMinerMinPower": config.encodeBigint(consensusMinerMinPower),
      "PreCommitChallengeDelay": config.encodeBigint(preCommitChallengeDelay),
      "ForkUpgradeParams": forkUpgradeParams.toJson(config: config),
      "Eip155ChainID": eip155ChainID,
      "GenesisTimestamp": config.encodeBigint(genesisTimestamp),
    });
  }
}

/// LotusResponseObjStat
class LotusResponseObjStat {
  final BigInt size;
  final BigInt links;

  const LotusResponseObjStat({required this.size, required this.links});

  factory LotusResponseObjStat.fromJson(Map<String, dynamic> json) {
    return LotusResponseObjStat(
      size: json.valueAsBigInt("Size", onMissing: () => BigInt.zero),
      links: json.valueAsBigInt("Links", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Size": config.encodeBigint(size),
      "Links": config.encodeBigint(links),
    });
  }
}

/// LotusResponsePartition
class LotusResponsePartition {
  /// Sector numbers in this partition, including faulty, unproven, and terminated sectors.
  final LotusResponseBitField sectors;

  /// Unproven sectors in this partition. This bitfield will be cleared on a successful window post (or at the end of the partition's next deadline). At that time, any still unproven sectors will be added to the faulty sector bitfield.
  final LotusResponseBitField unproven;

  /// Subset of sectors detected/declared faulty and not yet recovered (excl. from PoSt). Faults ∩ Terminated = ∅
  final LotusResponseBitField faults;

  /// Subset of faulty sectors expected to recover on next PoSt Recoveries ∩ Terminated = ∅
  final LotusResponseBitField recoveries;

  /// Subset of sectors terminated but not yet removed from partition (excl. from PoSt)
  final LotusResponseBitField terminated;

  /// Maps epochs sectors that expire in or before that epoch. An expiration may be an "on-time" scheduled expiration, or early "faulty" expiration. Keys are quantized to last-in-deadline epochs.
  final Cid expirationsEpochs;

  /// Subset of terminated that were before their committed expiration epoch, by termination epoch. Termination fees have not yet been calculated or paid and associated deals have not yet been canceled but effective power has already been adjusted. Not quantized.
  final Cid earlyTerminated;

  /// Power of not-yet-terminated sectors (incl faulty & unproven).
  final LotusResponsePowerPair livePower;

  /// Power of yet-to-be-proved sectors (never faulty).
  final LotusResponsePowerPair unprovenPower;

  /// Power of currently-faulty sectors. FaultyPower <= LivePower.
  final LotusResponsePowerPair faultyPower;

  /// Power of expected-to-recover sectors. RecoveringPower <= FaultyPower.
  final LotusResponsePowerPair recoveringPower;

  const LotusResponsePartition({
    required this.sectors,
    required this.unproven,
    required this.faults,
    required this.recoveries,
    required this.terminated,
    required this.expirationsEpochs,
    required this.earlyTerminated,
    required this.livePower,
    required this.unprovenPower,
    required this.faultyPower,
    required this.recoveringPower,
  });

  factory LotusResponsePartition.fromJson(Map<String, dynamic> json) {
    return LotusResponsePartition(
      sectors: json.valueTo<LotusResponseBitField, Map>(
        key: "Sectors",
        parse:
            (e) =>
                LotusResponseBitField.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      unproven: json.valueTo<LotusResponseBitField, Map>(
        key: "Unproven",
        parse:
            (e) =>
                LotusResponseBitField.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      faults: json.valueTo<LotusResponseBitField, Map>(
        key: "Faults",
        parse:
            (e) =>
                LotusResponseBitField.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      recoveries: json.valueTo<LotusResponseBitField, Map>(
        key: "Recoveries",
        parse:
            (e) =>
                LotusResponseBitField.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      terminated: json.valueTo<LotusResponseBitField, Map>(
        key: "Terminated",
        parse:
            (e) =>
                LotusResponseBitField.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      expirationsEpochs: json.valueTo<Cid, Object>(
        key: "ExpirationsEpochs",
        parse: (e) => Cid.fromJson(e),
      ),
      earlyTerminated: json.valueTo<Cid, Object>(
        key: "EarlyTerminated",
        parse: (e) => Cid.fromJson(e),
      ),
      livePower: json.valueTo<LotusResponsePowerPair, Map>(
        key: "LivePower",
        parse:
            (e) =>
                LotusResponsePowerPair.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      unprovenPower: json.valueTo<LotusResponsePowerPair, Map>(
        key: "UnprovenPower",
        parse:
            (e) =>
                LotusResponsePowerPair.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      faultyPower: json.valueTo<LotusResponsePowerPair, Map>(
        key: "FaultyPower",
        parse:
            (e) =>
                LotusResponsePowerPair.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      recoveringPower: json.valueTo<LotusResponsePowerPair, Map>(
        key: "RecoveringPower",
        parse:
            (e) =>
                LotusResponsePowerPair.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Sectors": sectors.toJson(),
      "Unproven": unproven.toJson(),
      "Faults": faults.toJson(),
      "Recoveries": recoveries.toJson(),
      "Terminated": terminated.toJson(),
      "ExpirationsEpochs": expirationsEpochs.toJson(),
      "EarlyTerminated": earlyTerminated.toJson(),
      "LivePower": livePower.toJson(config: config),
      "UnprovenPower": unprovenPower.toJson(config: config),
      "FaultyPower": faultyPower.toJson(config: config),
      "RecoveringPower": recoveringPower.toJson(config: config),
    });
  }
}

/// LotusResponsePaychStatus
class LotusResponsePaychStatus {
  final String controlAddr;
  final int direction;

  const LotusResponsePaychStatus({
    required this.controlAddr,
    required this.direction,
  });

  factory LotusResponsePaychStatus.fromJson(Map<String, dynamic> json) {
    return LotusResponsePaychStatus(
      controlAddr: json.valueAsString("ControlAddr"),
      direction: json.valueAsInt("Direction", onMissing: () => 0),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "ControlAddr": controlAddr,
      "Direction": direction,
    });
  }
}

/// LotusResponsePaymentInfo
class LotusResponsePaymentInfo {
  final String channel;
  final Cid waitSentinel;
  final List<LotusResponseSignedVoucher> vouchers;

  const LotusResponsePaymentInfo({
    required this.channel,
    required this.waitSentinel,
    required this.vouchers,
  });

  factory LotusResponsePaymentInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponsePaymentInfo(
      channel: json.valueAsString("Channel"),
      waitSentinel: json.valueTo<Cid, Object>(
        key: "WaitSentinel",
        parse: (e) => Cid.fromJson(e),
      ),
      vouchers: json.valueTo<List<LotusResponseSignedVoucher>, List>(
        key: "Vouchers",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseSignedVoucher.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Channel": channel,
      "WaitSentinel": waitSentinel.toJson(),
      "Vouchers": vouchers.map((e) => e.toJson(config: config)).toList(),
    });
  }
}

/// LotusResponsePendingBeneficiaryChange
class LotusResponsePendingBeneficiaryChange {
  final String newBeneficiary;
  final BigInt newQuota;
  final BigInt newExpiration;
  final bool approvedByBeneficiary;
  final bool approvedByNominee;

  const LotusResponsePendingBeneficiaryChange({
    required this.newBeneficiary,
    required this.newQuota,
    required this.newExpiration,
    required this.approvedByBeneficiary,
    required this.approvedByNominee,
  });

  factory LotusResponsePendingBeneficiaryChange.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponsePendingBeneficiaryChange(
      newBeneficiary: json.valueAsString("NewBeneficiary"),
      newQuota: JsonParser.valueAsBigInt(json["NewQuota"] ?? "0"),
      newExpiration: json.valueAsBigInt(
        "NewExpiration",
        onMissing: () => BigInt.zero,
      ),
      approvedByBeneficiary: json.valueAsBool(
        "ApprovedByBeneficiary",
        onMissing: () => false,
      ),
      approvedByNominee: json.valueAsBool(
        "ApprovedByNominee",
        onMissing: () => false,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "NewBeneficiary": newBeneficiary,
      "NewQuota": config.encodeBigint(newQuota),
      "NewExpiration": config.encodeBigint(newExpiration),
      "ApprovedByBeneficiary": approvedByBeneficiary,
      "ApprovedByNominee": approvedByNominee,
    });
  }
}

/// LotusResponsePoStProof
class LotusResponsePoStProof {
  final BigInt poStProof;
  final List<int> proofBytes;

  const LotusResponsePoStProof({
    required this.poStProof,
    required this.proofBytes,
  });

  factory LotusResponsePoStProof.fromJson(Map<String, dynamic> json) {
    return LotusResponsePoStProof(
      poStProof: json.valueAsBigInt("PoStProof", onMissing: () => BigInt.zero),
      proofBytes: json.valueAsBytes(
        "ProofBytes",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "PoStProof": config.encodeBigint(poStProof),
      "ProofBytes": StringUtils.decode(
        proofBytes,
        encoding: StringEncoding.base64,
      ),
    });
  }
}

/// Value type for a pair of raw and QA power.
class LotusResponsePowerPair {
  final BigInt raw;
  final BigInt qA;

  const LotusResponsePowerPair({required this.raw, required this.qA});

  factory LotusResponsePowerPair.fromJson(Map<String, dynamic> json) {
    return LotusResponsePowerPair(
      raw: json.valueAsBigInt("Raw", onMissing: () => BigInt.zero),
      qA: json.valueAsBigInt("QA", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Raw": config.encodeBigint(raw),
      "QA": config.encodeBigint(qA),
    });
  }
}

/// LotusResponseReturnTrace
class LotusResponseReturnTrace {
  final BigInt exitCode;
  final List<int> returnValue;
  final BigInt returnCodec;

  const LotusResponseReturnTrace({
    required this.exitCode,
    required this.returnValue,
    required this.returnCodec,
  });

  factory LotusResponseReturnTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseReturnTrace(
      exitCode: json.valueAsBigInt("ExitCode", onMissing: () => BigInt.zero),
      returnValue: json.valueAsBytes(
        "Return",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      returnCodec: json.valueAsBigInt(
        "ReturnCodec",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "ExitCode": config.encodeBigint(exitCode),
      "Return": StringUtils.decode(
        returnValue,
        encoding: StringEncoding.base64,
      ),
      "ReturnCodec": config.encodeBigint(returnCodec),
    });
  }
}

/// Information stored on-chain for a proven sector.
class LotusResponseSectorOnChainInfo {
  final BigInt sectorNumber;
  final BigInt sealProof;
  final Cid sealedCID;
  final List<BigInt> dealIDs;
  final BigInt activation;
  final BigInt expiration;
  final BigInt? dealWeight;
  final BigInt? verifiedDealWeight;
  final BigInt? initialPledge;
  final BigInt? expectedDayReward;
  final BigInt? expectedStoragePledge;
  final BigInt? powerBaseEpoch;
  final BigInt? replacedDayReward;
  final Cid? sectorKeyCID;
  final bool simpleQAPower;

  const LotusResponseSectorOnChainInfo({
    required this.sectorNumber,
    required this.sealProof,
    required this.sealedCID,
    required this.dealIDs,
    required this.activation,
    required this.expiration,
    required this.dealWeight,
    required this.verifiedDealWeight,
    required this.initialPledge,
    required this.expectedDayReward,
    required this.expectedStoragePledge,
    required this.powerBaseEpoch,
    required this.replacedDayReward,
    this.sectorKeyCID,
    required this.simpleQAPower,
  });

  factory LotusResponseSectorOnChainInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseSectorOnChainInfo(
      sectorNumber: json.valueAsBigInt(
        "SectorNumber",
        onMissing: () => BigInt.zero,
      ),
      sealProof: json.valueAsBigInt("SealProof", onMissing: () => BigInt.zero),
      sealedCID: json.valueTo<Cid, Object>(
        key: "SealedCID",
        parse: (e) => Cid.fromJson(e),
      ),
      dealIDs: json.valueEnsureAsList<BigInt>(
        "DeprecatedDealIDs",
        onMissing: () => [],
      ),
      activation: json.valueAsBigInt(
        "Activation",
        onMissing: () => BigInt.zero,
      ),
      expiration: json.valueAsBigInt(
        "Expiration",
        onMissing: () => BigInt.zero,
      ),
      dealWeight: json.valueAsBigInt("DealWeight"),
      verifiedDealWeight: json.valueAsBigInt("VerifiedDealWeight"),
      initialPledge: json.valueAsBigInt("InitialPledge"),
      expectedDayReward: json.valueAsBigInt("ExpectedDayReward"),
      expectedStoragePledge: json.valueAsBigInt("ExpectedStoragePledge"),
      powerBaseEpoch: json.valueAsBigInt(
        "PowerBaseEpoch",
        onMissing: () => BigInt.zero,
      ),
      replacedDayReward: json.valueAsBigInt("ReplacedDayReward"),
      sectorKeyCID: json.valueTo<Cid?, Object>(
        key: "SectorKeyCID",
        parse: (e) => Cid.fromJson(e),
      ),
      simpleQAPower: json.valueAsBool("SimpleQAPower", onMissing: () => false),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "SectorNumber": config.encodeBigint(sectorNumber),
      "SealProof": config.encodeBigint(sealProof),
      "SealedCID": sealedCID.toJson(),
      "DealIDs": dealIDs.map((e) => config.encodeBigint(e)).toList(),
      "Activation": config.encodeBigint(activation),
      "Expiration": config.encodeBigint(expiration),
      "DealWeight": config.encodeBigint(dealWeight),
      "VerifiedDealWeight": config.encodeBigint(verifiedDealWeight),
      "InitialPledge": config.encodeBigint(initialPledge),
      "ExpectedDayReward": config.encodeBigint(expectedDayReward),
      "ExpectedStoragePledge": config.encodeBigint(expectedStoragePledge),
      "PowerBaseEpoch": config.encodeBigint(powerBaseEpoch),
      "ReplacedDayReward": config.encodeBigint(replacedDayReward),
      "SectorKeyCID": sectorKeyCID?.toJson(),
      "SimpleQAPower": simpleQAPower,
    });
  }
}

/// Information provided by a miner when pre-committing a sector.
class LotusResponseSectorPreCommitInfo {
  final BigInt sealProof;
  final BigInt sectorNumber;
  final Cid sealedCID;
  final BigInt sealRandEpoch;
  final List<BigInt> dealIDs;
  final BigInt expiration;
  final Cid? unsealedCid;

  const LotusResponseSectorPreCommitInfo({
    required this.sealProof,
    required this.sectorNumber,
    required this.sealedCID,
    required this.sealRandEpoch,
    required this.dealIDs,
    required this.expiration,
    this.unsealedCid,
  });

  factory LotusResponseSectorPreCommitInfo.fromJson(Map<String, dynamic> json) {
    return LotusResponseSectorPreCommitInfo(
      sealProof: json.valueAsBigInt("SealProof", onMissing: () => BigInt.zero),
      sectorNumber: json.valueAsBigInt(
        "SectorNumber",
        onMissing: () => BigInt.zero,
      ),
      sealedCID: json.valueTo<Cid, Object>(
        key: "SealedCID",
        parse: (e) => Cid.fromJson(e),
      ),
      sealRandEpoch: json.valueAsBigInt(
        "SealRandEpoch",
        onMissing: () => BigInt.zero,
      ),
      dealIDs: json.valueEnsureAsList<BigInt>("DealIDs", onMissing: () => []),
      expiration: json.valueAsBigInt(
        "Expiration",
        onMissing: () => BigInt.zero,
      ),
      unsealedCid: json.valueTo<Cid?, Object>(
        key: "UnsealedCid",
        parse: (e) => Cid.fromJson(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "SealProof": config.encodeBigint(sealProof),
      "SectorNumber": config.encodeBigint(sectorNumber),
      "SealedCID": sealedCID.toJson(),
      "SealRandEpoch": config.encodeBigint(sealRandEpoch),
      "DealIDs": dealIDs.map((e) => config.encodeBigint(e)).toList(),
      "Expiration": config.encodeBigint(expiration),
      "UnsealedCid": unsealedCid?.toJson(),
    });
  }
}

/// Information stored on-chain for a pre-committed sector.
class LotusResponseSectorPreCommitOnChainInfo {
  final LotusResponseSectorPreCommitInfo info;
  final BigInt preCommitDeposit;
  final BigInt preCommitEpoch;

  const LotusResponseSectorPreCommitOnChainInfo({
    required this.info,
    required this.preCommitDeposit,
    required this.preCommitEpoch,
  });

  factory LotusResponseSectorPreCommitOnChainInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseSectorPreCommitOnChainInfo(
      info: json.valueTo<LotusResponseSectorPreCommitInfo, Map>(
        key: "Info",
        parse:
            (e) => LotusResponseSectorPreCommitInfo.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      preCommitDeposit: JsonParser.valueAsBigInt(
        json["PreCommitDeposit"] ?? "0",
      ),
      preCommitEpoch: json.valueAsBigInt(
        "PreCommitEpoch",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Info": info.toJson(config: config),
      "PreCommitDeposit": config.encodeBigint(preCommitDeposit),
      "PreCommitEpoch": config.encodeBigint(preCommitEpoch),
    });
  }
}

/// FilSignature
// class FilSignature {
//   final int type;
//   final List<int> data;

//   const FilSignature({required this.type, required this.data});

//   factory FilSignature.fromJson(Map<String, dynamic> json) {
//     return FilSignature(
//       type: json.valueAsInt("Type"),
//       data: json.valueAsBytes(
//         "Data",
//         encoding: StringEncoding.base64,
//         onMissing: () => [],
//       ),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"Type": type, "Data": data}.notNullValue;
//   }
// }

class LotusResponseMessageWithCid {
  final FilMessage message;
  final Cid cid;

  const LotusResponseMessageWithCid({required this.message, required this.cid});

  factory LotusResponseMessageWithCid.fromJson(Map<String, dynamic> json) {
    return LotusResponseMessageWithCid(
      message: json.valueTo<FilMessage, Map>(
        key: "Message",
        parse: (e) => FilMessage.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
      cid: json.valueTo<Cid, Object>(key: "Cid", parse: (e) => Cid.fromJson(e)),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Message": message.toJson(),
      "Cid": cid.toJson(),
    });
  }
}

// /// FilSignedMessage
// class FilSignedMessage {
//   final FilMessage message;
//   final FilSignature signature;

//   const FilSignedMessage({required this.message, required this.signature});

//   factory FilSignedMessage.fromJson(Map<String, dynamic> json) {
//     return FilSignedMessage(
//       message: json.valueTo<FilMessage, Map>(
//         key: "Message",
//         parse: (e) => FilMessage.fromJson(JsonParser.valueEnsureAsMap(e)),
//       ),
//       signature: json.valueTo<FilSignature, Map>(
//         key: "Signature",
//         parse:
//             (e) =>
//                 FilSignature.fromJson(JsonParser.valueEnsureAsMap(e)),
//       ),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "Message": message.toJson(),
//       "Signature": signature.toJson(),
//     }.notNullValue;
//   }
// }

/// A voucher is sent by `From` to `To` off-chain in order to enable `To` to redeem payments on-chain in the future
class LotusResponseSignedVoucher {
  /// ChannelAddr is the address of the payment channel this signed voucher is valid for
  final String channelAddr;

  /// TimeLockMin sets a min epoch before which the voucher cannot be redeemed
  final BigInt timeLockMin;

  /// TimeLockMax sets a max epoch beyond which the voucher cannot be redeemed TimeLockMax set to 0 means no timeout
  final BigInt timeLockMax;

  /// (optional) The SecretHash is used by `To` to validate
  final List<int> secretHash;

  /// (optional) Extra can be specified by `From` to add a verification method to the voucher.
  final LotusResponseModVerifyParams? extra;

  /// Specifies which lane the Voucher merges into (will be created if does not exist)
  final BigInt lane;

  /// Nonce is set by `From` to prevent redemption of stale vouchers on a lane
  final BigInt nonce;

  /// Amount voucher can be redeemed for
  final BigInt amount;

  /// (optional) MinSettleHeight can extend channel MinSettleHeight if needed
  final BigInt minSettleHeight;

  /// (optional) Set of lanes to be merged into `Lane`
  final List<LotusResponseMerge> merges;

  /// Sender's signature over the voucher
  final FilSignature? signature;

  const LotusResponseSignedVoucher({
    required this.channelAddr,
    required this.timeLockMin,
    required this.timeLockMax,
    required this.secretHash,
    this.extra,
    required this.lane,
    required this.nonce,
    required this.amount,
    required this.minSettleHeight,
    required this.merges,
    this.signature,
  });

  factory LotusResponseSignedVoucher.fromJson(Map<String, dynamic> json) {
    return LotusResponseSignedVoucher(
      channelAddr: json.valueAsString("ChannelAddr"),
      timeLockMin: json.valueAsBigInt(
        "TimeLockMin",
        onMissing: () => BigInt.zero,
      ),
      timeLockMax: json.valueAsBigInt(
        "TimeLockMax",
        onMissing: () => BigInt.zero,
      ),
      secretHash: json.valueAsBytes(
        "SecretHash",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
      extra: json.valueTo<LotusResponseModVerifyParams?, Map>(
        key: "Extra",
        parse:
            (e) => LotusResponseModVerifyParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      lane: json.valueAsBigInt("Lane", onMissing: () => BigInt.zero),
      nonce: json.valueAsBigInt("Nonce", onMissing: () => BigInt.zero),
      amount: json.valueAsBigInt("Amount", onMissing: () => BigInt.zero),
      minSettleHeight: json.valueAsBigInt(
        "MinSettleHeight",
        onMissing: () => BigInt.zero,
      ),
      merges: json.valueTo<List<LotusResponseMerge>, List>(
        key: "Merges",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseMerge.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      signature: json.valueTo<FilSignature?, Map>(
        key: "Signature",
        parse: (e) => FilSignature.fromJson(JsonParser.valueEnsureAsMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "ChannelAddr": channelAddr,
      "TimeLockMin": config.encodeBigint(timeLockMin),
      "TimeLockMax": config.encodeBigint(timeLockMax),
      "SecretHash": StringUtils.decode(
        secretHash,
        encoding: StringEncoding.base64,
      ),
      "Extra": extra?.toJson(config: config),
      "Lane": config.encodeBigint(lane),
      "Nonce": config.encodeBigint(nonce),
      "Amount": config.encodeBigint(amount),
      "MinSettleHeight": config.encodeBigint(minSettleHeight),
      "Merges": merges.map((e) => e.toJson(config: config)).toList(),
      "Signature": signature?.toJson(),
    });
  }
}

/// LotusResponseSyncState
class LotusResponseSyncState {
  final List<LotusResponseActiveSync> activeSyncs;
  final BigInt vMApplied;

  const LotusResponseSyncState({
    required this.activeSyncs,
    required this.vMApplied,
  });

  factory LotusResponseSyncState.fromJson(Map<String, dynamic> json) {
    return LotusResponseSyncState(
      activeSyncs: json.valueTo<List<LotusResponseActiveSync>, List>(
        key: "ActiveSyncs",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseActiveSync.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      vMApplied: json.valueAsBigInt("VMApplied", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "ActiveSyncs": activeSyncs.map((e) => e.toJson(config: config)).toList(),
      "VMApplied": config.encodeBigint(vMApplied),
    });
  }
}

/// LotusResponseTicket
class LotusResponseTicket {
  final List<int> vRFProof;

  const LotusResponseTicket({required this.vRFProof});

  factory LotusResponseTicket.fromJson(Map<String, dynamic> json) {
    return LotusResponseTicket(
      vRFProof: json.valueAsBytes(
        "VRFProof",
        encoding: StringEncoding.base64,
        onMissing: () => [],
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{"VRFProof": vRFProof});
  }
}

/// LotusResponseTipSet
class LotusResponseTipSet {
  final List<Cid> cids;
  final List<LotusResponseBlockHeader> blks;
  final BigInt height;

  const LotusResponseTipSet({
    required this.cids,
    required this.blks,
    required this.height,
  });

  factory LotusResponseTipSet.fromJson(Map<String, dynamic> json) {
    return LotusResponseTipSet(
      cids: json.valueTo<List<Cid>, List>(
        key: "Cids",
        onMissing: () => [],
        parse: (e) => e.map((x) => Cid.fromJson(x)).toList(),
      ),
      blks: json.valueTo<List<LotusResponseBlockHeader>, List>(
        key: "Blocks",
        onMissing: () => [],
        parse:
            (e) =>
                e
                    .map(
                      (x) => LotusResponseBlockHeader.fromJson(
                        JsonParser.valueEnsureAsMap(x),
                      ),
                    )
                    .toList(),
      ),
      height: json.valueAsBigInt("Height", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "cids": cids.map((e) => e.toJson()).toList(),
      "blks": blks.map((e) => e.toJson(config: config)).toList(),
      "Height": config.encodeBigint(height),
    });
  }
}

/// LotusResponseTraceIpld
class LotusResponseTraceIpld {
  final String op;
  final Cid cid;
  final BigInt size;

  const LotusResponseTraceIpld({
    required this.op,
    required this.cid,
    required this.size,
  });

  factory LotusResponseTraceIpld.fromJson(Map<String, dynamic> json) {
    return LotusResponseTraceIpld(
      op: json.valueAsString("Op"),
      cid: json.valueTo<Cid, Object>(key: "Cid", parse: (e) => Cid.fromJson(e)),
      size: json.valueAsBigInt("Size", onMissing: () => BigInt.zero),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Op": op,
      "Cid": cid.toJson(),
      "Size": config.encodeBigint(size),
    });
  }
}

/// LotusResponseVoucherCreateResult is the response to calling PaychVoucherCreate
class LotusResponseVoucherCreateResult {
  /// Voucher that was created, or nil if there was an error or if there were insufficient funds in the channel
  final LotusResponseSignedVoucher? voucher;

  /// Shortfall is the additional amount that would be needed in the channel in order to be able to create the voucher
  final BigInt shortfall;

  const LotusResponseVoucherCreateResult({
    this.voucher,
    required this.shortfall,
  });

  factory LotusResponseVoucherCreateResult.fromJson(Map<String, dynamic> json) {
    return LotusResponseVoucherCreateResult(
      voucher: json.valueTo<LotusResponseSignedVoucher?, Map>(
        key: "Voucher",
        parse:
            (e) => LotusResponseSignedVoucher.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
      shortfall: json.valueTo<BigInt, Object>(
        key: "Shortfall",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Voucher": voucher?.toJson(config: config),
      "Shortfall": config.encodeBigint(shortfall),
    });
  }
}

/// LotusResponseVoucherSpec
class LotusResponseVoucherSpec {
  final BigInt amount;
  final BigInt timeLockMin;
  final BigInt timeLockMax;
  final BigInt minSettle;
  final LotusResponseModVerifyParams? extra;

  const LotusResponseVoucherSpec({
    required this.amount,
    required this.timeLockMin,
    required this.timeLockMax,
    required this.minSettle,
    this.extra,
  });

  factory LotusResponseVoucherSpec.fromJson(Map<String, dynamic> json) {
    return LotusResponseVoucherSpec(
      amount: json.valueTo<BigInt, Object>(
        key: "Amount",
        parse: (e) => JsonParser.valueAsBigInt(e),
      ),
      timeLockMin: json.valueAsBigInt(
        "TimeLockMin",
        onMissing: () => BigInt.zero,
      ),
      timeLockMax: json.valueAsBigInt(
        "TimeLockMax",
        onMissing: () => BigInt.zero,
      ),
      minSettle: json.valueAsBigInt("MinSettle", onMissing: () => BigInt.zero),
      extra: json.valueTo<LotusResponseModVerifyParams?, Map>(
        key: "Extra",
        parse:
            (e) => LotusResponseModVerifyParams.fromJson(
              JsonParser.valueEnsureAsMap(e),
            ),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Amount": config.encodeBigint(amount),
      "TimeLockMin": config.encodeBigint(timeLockMin),
      "TimeLockMax": config.encodeBigint(timeLockMax),
      "MinSettle": config.encodeBigint(minSettle),
      "Extra": extra?.toJson(config: config),
    });
  }
}

/// LotusResponseWorkerKeyChange
class LotusResponseWorkerKeyChange {
  final String newWorker;
  final BigInt effectiveAt;

  const LotusResponseWorkerKeyChange({
    required this.newWorker,
    required this.effectiveAt,
  });

  factory LotusResponseWorkerKeyChange.fromJson(Map<String, dynamic> json) {
    return LotusResponseWorkerKeyChange(
      newWorker: json.valueAsString("NewWorker"),
      effectiveAt: json.valueAsBigInt(
        "EffectiveAt",
        onMissing: () => BigInt.zero,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "NewWorker": newWorker,
      "EffectiveAt": config.encodeBigint(effectiveAt),
    });
  }
}

class LotusResponseActor {
  final Cid code;
  final Cid head;
  final BigInt nonce;
  final BigInt balance;
  final String? delegatedAddress;

  const LotusResponseActor({
    required this.code,
    required this.head,
    required this.nonce,
    required this.balance,
    this.delegatedAddress,
  });

  factory LotusResponseActor.fromJson(Map<String, dynamic> json) {
    return LotusResponseActor(
      code: json.valueTo<Cid, Object>(
        key: "Code",
        parse: (v) => Cid.fromJson(v),
      ),
      head: json.valueTo<Cid, Object>(
        key: "Head",
        parse: (v) => Cid.fromJson(v),
      ),
      nonce: json.valueAsBigInt("Nonce"),
      balance: json.valueAsBigInt("Balance"),
      delegatedAddress:
          json.valueAsString<String?>("DelegatedAddress") ??
          json.valueAsString<String?>("Address"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Code': code.toJson(),
    'Head': head.toJson(),
    'Nonce': config.encodeBigint(nonce),
    'Balance': config.encodeBigint(balance),
    if (delegatedAddress != null) 'DelegatedAddress': delegatedAddress!,
  });
}

class LotusResponseActorEventBlock {
  final BigInt codec;
  final List<int> value;

  const LotusResponseActorEventBlock({
    required this.codec,
    required this.value,
  });

  factory LotusResponseActorEventBlock.fromJson(Map<String, dynamic> json) {
    return LotusResponseActorEventBlock(
      codec: json.valueAsBigInt("codec"),
      value: json.valueAsBytes("value", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'codec': config.encodeBigint(codec),
    'value': StringUtils.decode(value, encoding: StringEncoding.base64),
  });
}

class LotusParamsActorEventFilter {
  final List<String> addresses;
  final List<LotusResponseActorEventBlock> fields;
  final BigInt? fromHeight;
  final BigInt? toHeight;
  final LotusTipSetKey? tipSetKey;

  const LotusParamsActorEventFilter({
    this.addresses = const [],
    this.fields = const [],
    this.fromHeight,
    this.toHeight,
    this.tipSetKey,
  });

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'addresses': addresses.emptyAsNull,
    "fields": fields.emptyAsNull,
    "fromHeight": config.encodeBigint(fromHeight),
    "toHeight": config.encodeBigint(toHeight),
    "tipsetKey": tipSetKey?.toJson(),
  });
}

class LotusResponseAPIVersion {
  final String version;
  final int apiVersion;
  final BigInt blockDelay;
  final String agent;
  const LotusResponseAPIVersion({
    required this.version,
    required this.apiVersion,
    required this.blockDelay,
    required this.agent,
  });
  factory LotusResponseAPIVersion.fromJson(Map<String, dynamic> json) =>
      LotusResponseAPIVersion(
        version: (json['Version'] ?? '').toString(),
        apiVersion:
            IntUtils.tryParse(json['LotusResponseAPIVersion'] ?? 0) ?? 0,
        blockDelay: BigintUtils.parse(json['BlockDelay'] ?? 0),
        agent: (json['Agent'] ?? '').toString(),
      );
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Version': version,
    'LotusResponseAPIVersion': apiVersion,
    'BlockDelay': config.encodeBigint(blockDelay),
    'Agent': agent,
  });
}

class LotusResponseBitField {
  final dynamic raw;
  const LotusResponseBitField([this.raw]);
  factory LotusResponseBitField.fromJson(dynamic json) =>
      LotusResponseBitField(json);
  dynamic toJson() => raw;
}

class LotusParamsEthCall {
  final String from;
  final String to;
  final BigInt gas;
  final BigInt gasPrice;
  final BigInt value;
  final String? data;
  const LotusParamsEthCall({
    required this.from,
    required this.to,
    required this.gas,
    required this.gasPrice,
    required this.value,
    this.data,
  });
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "from": from,
      "to": to,
      "gas": config.encodeBigint(gas),
      "gasPrice": config.encodeBigint(gasPrice),
      "value": config.encodeBigint(value),
      "data": data,
    });
  }
}

class LotusParamsEthFilterSpec {
  /// Epoch hex string or "latest", "earliest", "pending"
  final String? fromBlock;

  /// Epoch hex string or "latest", "earliest", "pending"
  final String? toBlock;

  /// LotusResponseActor address or list of addresses
  final List<String> address;

  /// Topics to match
  final List<List<String>> topics;

  /// EIP-234 block hash filter
  final String? blockHash;

  const LotusParamsEthFilterSpec({
    this.fromBlock,
    this.toBlock,
    required this.address,
    required this.topics,
    this.blockHash,
  });

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      if (fromBlock != null) 'fromBlock': fromBlock,
      if (toBlock != null) 'toBlock': toBlock,
      'address': address,
      'topics': topics,
      if (blockHash != null) 'blockHash': blockHash,
    });
  }
}

class LotusResponseEthFilterResult {
  final Map<String, dynamic> raw;
  const LotusResponseEthFilterResult(this.raw);
  factory LotusResponseEthFilterResult.fromJson(dynamic json) =>
      LotusResponseEthFilterResult(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseEthSyncingResult {
  final BigInt? startingBlock;
  final BigInt? currentBlock;
  final BigInt? highestBlock;

  const LotusResponseEthSyncingResult({
    required this.startingBlock,
    required this.currentBlock,
    required this.highestBlock,
  });

  factory LotusResponseEthSyncingResult.fromJson(Map<String, dynamic> json) {
    return LotusResponseEthSyncingResult(
      startingBlock: json.valueAsBigInt("startingBlock"),
      currentBlock: json.valueAsBigInt("currentBlock"),
      highestBlock: json.valueAsBigInt("highestBlock"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      'startingBlock': config.encodeBigint(startingBlock),
      'currentBlock': config.encodeBigint(currentBlock),
      'highestBlock': config.encodeBigint(highestBlock),
    });
  }
}

class LotusResponseEthTrace {
  final String type;
  final String? error;
  final int subtraces;
  final List<int> traceAddress;
  final dynamic action;
  final dynamic result;

  const LotusResponseEthTrace({
    required this.type,
    this.error,
    required this.subtraces,
    required this.traceAddress,
    required this.action,
    required this.result,
  });

  factory LotusResponseEthTrace.fromJson(Map<String, dynamic> json) {
    return LotusResponseEthTrace(
      type: json['type'] as String,
      error: json['error'] as String?,
      subtraces: json['subtraces'] as int,
      traceAddress:
          (json['traceAddress'] as List<dynamic>).map((e) => e as int).toList(),
      action: json['action'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      'type': type,
      if (error != null) 'error': error,
      'subtraces': subtraces,
      'traceAddress': traceAddress,
      'action': action,
      'result': result,
    });
  }
}

class LotusResponseEthTraceBlock extends LotusResponseEthTrace {
  final String blockHash;
  final BigInt blockNumber;
  final String transactionHash;
  final int transactionPosition;

  const LotusResponseEthTraceBlock({
    required super.type,
    super.error,
    required super.subtraces,
    required super.traceAddress,
    required super.action,
    required super.result,
    required this.blockHash,
    required this.blockNumber,
    required this.transactionHash,
    required this.transactionPosition,
  });

  factory LotusResponseEthTraceBlock.fromJson(Map<String, dynamic> json) {
    return LotusResponseEthTraceBlock(
      type: json.valueAsString("type"),
      error: json.valueAsString("error"),
      subtraces: json.valueAsInt("subtraces"),
      traceAddress: json.valueAsList("traceAddress"),
      action: json.valueAs("action"),
      result: json.valueAs("result"),

      blockHash: json.valueAsString("blockHash"),
      blockNumber: json.valueAsBigInt('blockNumber', allowHex: true),
      transactionHash: json.valueAsString("transactionHash"),
      transactionPosition: json.valueAsInt("transactionPosition"),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      ...super.toJson(),
      'blockHash': blockHash,
      'blockNumber': blockNumber.toHexaDecimal,
      'transactionHash': transactionHash,
      'transactionPosition': transactionPosition,
    });
  }
}

class LotusParamsEthTraceFilterCriteria {
  /// Epoch hex string or "latest"/"pending"
  final String? fromBlock;

  /// Epoch hex string or "latest"/"pending"
  final String? toBlock;

  /// Sender addresses
  final List<String>? fromAddress;

  /// Receiver addresses
  final List<String>? toAddress;

  /// Pagination offset
  final BigInt? after;

  /// Maximum number of traces
  final BigInt? count;

  const LotusParamsEthTraceFilterCriteria({
    this.fromBlock,
    this.toBlock,
    this.fromAddress,
    this.toAddress,
    this.after,
    this.count,
  });

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      'fromBlock': fromBlock,
      'toBlock': toBlock,
      'fromAddress': fromAddress,
      'toAddress': toAddress,
      'after': after?.toHexaDecimal,
      'count': count?.toHexaDecimal,
    });
  }
}

class LotusResponseEthTraceFilterResult extends LotusResponseEthTrace {
  final String blockHash;
  final BigInt blockNumber;
  final String transactionHash;
  final int transactionPosition;

  const LotusResponseEthTraceFilterResult({
    required super.type,
    super.error,
    required super.subtraces,
    required super.traceAddress,
    required super.action,
    required super.result,
    required this.blockHash,
    required this.blockNumber,
    required this.transactionHash,
    required this.transactionPosition,
  });

  factory LotusResponseEthTraceFilterResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseEthTraceFilterResult(
      type: json.valueAsString("type"),
      error: json.valueAsString("error"),
      subtraces: json.valueAsInt("subtraces"),
      traceAddress: json.valueAsList("traceAddress"),
      action: json.valueAs("action"),
      result: json.valueAs("result"),
      blockHash: json.valueAsString("blockHash"),
      blockNumber: json.valueAsBigInt('blockNumber', allowHex: true),
      transactionHash: json.valueAsString("transactionHash"),
      transactionPosition: json.valueAsInt("transactionPosition"),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      ...super.toJson(),
      'blockHash': blockHash,
      'blockNumber': blockNumber.toHexaDecimal,
      'transactionHash': transactionHash,
      'transactionPosition': transactionPosition,
    });
  }
}

class LotusResponseEthTraceReplayBlockTransaction {
  final String output;
  final String? stateDiff;
  final List<LotusResponseEthTrace?> trace;
  final String transactionHash;
  final String? vmTrace;

  const LotusResponseEthTraceReplayBlockTransaction({
    required this.output,
    this.stateDiff,
    required this.trace,
    required this.transactionHash,
    this.vmTrace,
  });

  factory LotusResponseEthTraceReplayBlockTransaction.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseEthTraceReplayBlockTransaction(
      output: json.valueAsString("output"),
      stateDiff: json.valueAsString("stateDiff"),
      trace:
          json
              .valueAsList("trace")
              ?.map((e) => e == null ? null : LotusResponseEthTrace.fromJson(e))
              .toList() ??
          [],
      transactionHash: json.valueAsString("transactionHash"),
      vmTrace: json.valueAsString("vmTrace"),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "output": output,
      "stateDiff": stateDiff,
      "trace": trace.map((e) => e?.toJson(config: config)).toList(),
      "transactionHash": transactionHash,
      "vmTrace": vmTrace,
    });
  }
}

class LotusResponseEthTraceTransaction extends LotusResponseEthTrace {
  final String blockHash;
  final BigInt blockNumber;
  final String transactionHash;
  final int transactionPosition;

  const LotusResponseEthTraceTransaction({
    required super.type,
    super.error,
    required super.subtraces,
    required super.traceAddress,
    required super.action,
    required super.result,
    required this.blockHash,
    required this.blockNumber,
    required this.transactionHash,
    required this.transactionPosition,
  });

  factory LotusResponseEthTraceTransaction.fromJson(Map<String, dynamic> json) {
    return LotusResponseEthTraceTransaction(
      type: json.valueAsString("type"),
      error: json.valueAsString("error"),
      subtraces: json.valueAsInt("subtraces"),
      traceAddress: json.valueAsList("traceAddress"),
      action: json.valueAs("action"),
      result: json.valueAs("result"),
      blockHash: json.valueAsString("blockHash"),
      blockNumber: json.valueAsBigInt("blockNumber"),
      transactionHash: json.valueAsString("transactionHash"),
      transactionPosition: json.valueAsInt("transactionPosition"),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      ...super.toJson(),
      "blockHash": blockHash,
      "blockNumber": blockNumber.toHexaDecimal,
      "transactionHash": transactionHash,
      "transactionPosition": transactionPosition,
    });
  }
}

class LotusResponseF3Participant {
  final Map<String, dynamic> raw;
  const LotusResponseF3Participant(this.raw);
  factory LotusResponseF3Participant.fromJson(dynamic json) =>
      LotusResponseF3Participant(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseF3ParticipationLease {
  final Map<String, dynamic> raw;
  const LotusResponseF3ParticipationLease(this.raw);
  factory LotusResponseF3ParticipationLease.fromJson(dynamic json) =>
      LotusResponseF3ParticipationLease(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseF3ParticipationTicket {
  final Map<String, dynamic> raw;
  const LotusResponseF3ParticipationTicket(this.raw);
  factory LotusResponseF3ParticipationTicket.fromJson(dynamic json) =>
      LotusResponseF3ParticipationTicket(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseFinalityCertificateECChainItem {
  final List<int>? commitments;
  final BigInt? epoch;
  final LotusTipSetKey? key;
  final Cid? powerTable;

  const LotusResponseFinalityCertificateECChainItem({
    this.commitments,
    this.epoch,
    this.key,
    this.powerTable,
  });

  factory LotusResponseFinalityCertificateECChainItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseFinalityCertificateECChainItem(
      commitments: json.valueAsBytes(
        "Commitments",
        encoding: StringEncoding.base64,
      ),
      epoch: json.valueAsBigInt('Epoch'),
      key: json.valueTo<LotusTipSetKey?, Object>(
        key: "Key",
        parse: (e) => LotusTipSetKey.fromJson(e),
      ),
      powerTable: json.valueTo<Cid?, Object>(
        key: "PowerTable",
        parse: (e) => Cid.fromJson(e),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Commitments':
        commitments == null
            ? null
            : StringUtils.decode(commitments!, encoding: StringEncoding.base64),
    'Epoch': config.encodeBigint(epoch),
    'Key': key?.toJson(),
    'PowerTable': powerTable?.toJson(),
  });
}

class LotusResponseFinalityCertificatePowerTableDeltaItem {
  final BigInt? participantID;
  final BigInt? powerDelta;
  final List<int>? signingKey;

  const LotusResponseFinalityCertificatePowerTableDeltaItem({
    this.participantID,
    this.powerDelta,
    this.signingKey,
  });

  factory LotusResponseFinalityCertificatePowerTableDeltaItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseFinalityCertificatePowerTableDeltaItem(
      participantID: json.valueAsBigInt('ParticipantID'),
      powerDelta: json.valueAsBigInt('PowerDelta'),
      signingKey: json.valueAsBytes(
        'SigningKey',
        encoding: StringEncoding.base64,
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ParticipantID': config.encodeBigint(participantID),
    'PowerDelta': config.encodeBigint(powerDelta),
    'SigningKey':
        signingKey == null
            ? null
            : StringUtils.decode(signingKey!, encoding: StringEncoding.base64),
  });
}

class LotusResponseFinalityCertificateSupplementalData {
  final List<int>? commitments;
  final Cid? powerTable;

  const LotusResponseFinalityCertificateSupplementalData({
    this.commitments,
    this.powerTable,
  });

  factory LotusResponseFinalityCertificateSupplementalData.fromJson(
    Map<String, dynamic> json,
  ) {
    return LotusResponseFinalityCertificateSupplementalData(
      commitments: json.valueAsBytes(
        "Commitments",
        encoding: StringEncoding.base64,
      ),
      powerTable: json.valueTo<Cid?, Object>(
        key: 'PowerTable',
        parse: (v) => Cid.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'Commitments':
        commitments == null
            ? null
            : StringUtils.decode(commitments!, encoding: StringEncoding.base64),
    'PowerTable': powerTable?.toJson(),
  });
}

class LotusResponseFinalityCertificate {
  final List<LotusResponseFinalityCertificateECChainItem>? eCChain;
  final BigInt? gPBFTInstance;
  final List<LotusResponseFinalityCertificatePowerTableDeltaItem>?
  powerTableDelta;
  final List<int>? signature;
  final List<int>? signers;
  final LotusResponseFinalityCertificateSupplementalData? supplementalData;

  const LotusResponseFinalityCertificate({
    this.eCChain,
    this.gPBFTInstance,
    this.powerTableDelta,
    this.signature,
    this.signers,
    this.supplementalData,
  });

  factory LotusResponseFinalityCertificate.fromJson(Map<String, dynamic> json) {
    return LotusResponseFinalityCertificate(
      eCChain:
          json.hasValue('ECChain')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('ECChain')
                  .map(
                    (e) =>
                        LotusResponseFinalityCertificateECChainItem.fromJson(e),
                  )
                  .toList()
              : null,
      gPBFTInstance: json.valueAsBigInt('GPBFTInstance'),
      powerTableDelta:
          json.hasValue('PowerTableDelta')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('PowerTableDelta')
                  .map(
                    (e) =>
                        LotusResponseFinalityCertificatePowerTableDeltaItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      signature: json.valueAsBytes(
        'FilSignature',
        encoding: StringEncoding.base64,
      ),
      signers: json.valueAsList<List<int>?>('Signers'),
      supplementalData: json.valueTo<
        LotusResponseFinalityCertificateSupplementalData?,
        Map<String, dynamic>
      >(
        key: 'SupplementalData',
        parse:
            (v) => LotusResponseFinalityCertificateSupplementalData.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ECChain': eCChain?.map((e) => e.toJson()).toList(),
    'GPBFTInstance': config.encodeBigint(gPBFTInstance),
    'PowerTableDelta': powerTableDelta?.map((e) => e.toJson()).toList(),
    'FilSignature':
        signature == null
            ? null
            : StringUtils.decode(signature!, encoding: StringEncoding.base64),
    'Signers': signers,
    'SupplementalData': supplementalData?.toJson(config: config),
  });
}

class LotusResponseInstanceProgress {
  final Map<String, dynamic> raw;
  const LotusResponseInstanceProgress(this.raw);
  factory LotusResponseInstanceProgress.fromJson(dynamic json) =>
      LotusResponseInstanceProgress(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseManifest {
  final Map<String, dynamic> raw;
  const LotusResponseManifest(this.raw);
  factory LotusResponseManifest.fromJson(dynamic json) => LotusResponseManifest(
    json is Map ? Map<String, dynamic>.from(json) : {'value': json},
  );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponsePowerEntry {
  final BigInt id;
  final BigInt power;
  final List<int> pubKey;

  const LotusResponsePowerEntry({
    required this.power,
    required this.id,
    required this.pubKey,
  });

  factory LotusResponsePowerEntry.fromJson(Map<String, dynamic> json) {
    return LotusResponsePowerEntry(
      id: json.valueAsBigInt('ID'),
      power: json.valueAsBigInt("Power"),
      pubKey: json.valueAsBytes('PubKey', encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ID': config.encodeBigint(id),
    'Power': config.encodeBigint(power),
    'PubKey': pubKey,
  });
}

class LotusResponsePaychGetOpts {
  final Map<String, dynamic> raw;
  const LotusResponsePaychGetOpts(this.raw);
  factory LotusResponsePaychGetOpts.fromJson(dynamic json) =>
      LotusResponsePaychGetOpts(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseRegisteredSealProof {
  final Map<String, dynamic> raw;
  const LotusResponseRegisteredSealProof(this.raw);
  factory LotusResponseRegisteredSealProof.fromJson(dynamic json) =>
      LotusResponseRegisteredSealProof(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseSectorExpiration {
  final Map<String, dynamic> raw;
  const LotusResponseSectorExpiration(this.raw);
  factory LotusResponseSectorExpiration.fromJson(dynamic json) =>
      LotusResponseSectorExpiration(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseSectorLocation {
  final Map<String, dynamic> raw;
  const LotusResponseSectorLocation(this.raw);
  factory LotusResponseSectorLocation.fromJson(dynamic json) =>
      LotusResponseSectorLocation(
        json is Map ? Map<String, dynamic>.from(json) : {'value': json},
      );
  Map<String, dynamic> toJson() => raw;
}

class LotusResponseEventEntry {
  final int flags;
  final String key;
  final BigInt codec;
  final List<int> value;
  const LotusResponseEventEntry({
    required this.flags,
    required this.key,
    required this.codec,
    required this.value,
  });
  factory LotusResponseEventEntry.fromJson(Map<String, dynamic> json) {
    return LotusResponseEventEntry(
      flags: json.valueAsInt("Flags"),
      key: json.valueAsString("Key"),
      codec: json.valueAsBigInt("Codec"),
      value: json.valueAsBytes("Value", encoding: StringEncoding.base64),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "Flags": flags,
      "Key": key,
      "Codec": config.encodeBigint(codec),
      "value": StringUtils.decode(value, encoding: StringEncoding.base64),
    });
  }
}

class LotusResponseEvent {
  final BigInt emitter;
  final List<LotusResponseEventEntry> entries;
  const LotusResponseEvent({required this.emitter, required this.entries});
  factory LotusResponseEvent.fromJson(Map<String, dynamic> json) {
    return LotusResponseEvent(
      emitter: json.valueAsBigInt("Emitter"),
      entries:
          json
              .valueAsList("Entries")
              ?.map((e) => LotusResponseEventEntry.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class LotusResponseActorEvent {
  final String emitter;
  final bool reverted;
  final BigInt height;
  final LotusTipSetKey tipSetKey;
  final Cid msgCid;
  final List<LotusResponseEventEntry> entries;
  const LotusResponseActorEvent({
    required this.emitter,
    required this.entries,
    required this.reverted,
    required this.height,
    required this.tipSetKey,
    required this.msgCid,
  });
  factory LotusResponseActorEvent.fromJson(Map<String, dynamic> json) {
    return LotusResponseActorEvent(
      emitter: json.valueAsString("emitter"),
      entries:
          json
              .valueAsList("entries")
              ?.map((e) => LotusResponseEventEntry.fromJson(e))
              .toList() ??
          [],
      height: json.valueAsBigInt("height"),
      reverted: json.valueAsBool("reverted"),
      msgCid: Cid.fromJson(json.valueAs("msgCid")),
      tipSetKey: LotusTipSetKey.fromJson(json.valueAs("tipsetKey")),
    );
  }
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) {
    return config.encodeMap(<String, dynamic>{
      "emitter": emitter,
      "entries": entries.map((e) => e.toJson(config: config)).toList(),
      "height": config.encodeBigint(height),
      "reverted": reverted,
      "msgCid": msgCid.toJson(),
      "tipsetKey": tipSetKey.toJson(),
    });
  }
}

/// Filecoin address — JSON string (`f1...`, `f3...`).
/// LotusResponseTipSet key — list of CID links, or null/[] when empty.
class LotusTipSetKey {
  final List<Cid> cids;
  const LotusTipSetKey(this.cids);
  static const LotusTipSetKey empty = LotusTipSetKey([]);

  factory LotusTipSetKey.fromJson(dynamic json) {
    if (json == null) return LotusTipSetKey.empty;
    if (json is String) {
      if (json.isEmpty) return LotusTipSetKey.empty;
      return LotusTipSetKey([Cid(json)]);
    }
    if (json is List) {
      return LotusTipSetKey(json.map(Cid.fromJson).toList());
    }
    if (json is Map) {
      if (json.containsKey('/')) {
        return LotusTipSetKey([Cid.fromJson(json)]);
      }
      final v = json['value'] ?? json['Cids'] ?? json['cids'];
      if (v is List) return LotusTipSetKey(v.map(Cid.fromJson).toList());
    }
    throw OnChainErrors.filPlugin(
      "LotusTipSetKey.fromJson",
      reason: "Failed to parse LotusTipSetKey.",
      details: {"input": "$json"},
    );
  }

  dynamic toJson() =>
      cids.isEmpty ? null : cids.map((c) => c.toJson()).toList();
  @override
  String toString() => cids.map((c) => c.cid).join(',');
}
