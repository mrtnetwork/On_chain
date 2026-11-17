import 'package:on_chain/exception/onchain_error.dart';

enum HederaNetwork {
  mainnet(0, 295, "mainnet"),
  testnet(1, 296, "testnet"),
  previewnet(2, 297, "previewnet"),
  localNode(3, 298, "local-node");

  final int ledgerId;
  final int chainId;
  final String name;

  const HederaNetwork(this.ledgerId, this.chainId, this.name);
  static HederaNetwork fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "HederaNetwork.fromName",
                reason: "Invalid Hedera network name.",
                details: {"name": "$name"},
              ),
    );
  }

  static HederaNetwork fromId(int? id) {
    return values.firstWhere(
      (e) => e.ledgerId == id,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "HederaNetwork.fromId",
                reason: "Invalid Hedera network ledger ID.",
                details: {"id": "$id"},
              ),
    );
  }

  bool get isMainnet => this == HederaNetwork.mainnet;

  bool get isTestnet => this == HederaNetwork.testnet;

  bool get isPreviewnet => this == HederaNetwork.previewnet;

  bool get isLocalNode => this == HederaNetwork.localNode;
}
