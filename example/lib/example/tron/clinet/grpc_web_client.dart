import 'package:grpc/grpc_web.dart';
import 'package:on_chain/tron/tron.dart';
import 'grpc_client_example.dart';

DefaultTronQuickClient tronClient({
  String? fullnodeUrl,
  String? grpcUrl,
  int grpcPort = 443,
  String? proxy,
  bool? tls,
}) {
  final channel = switch (grpcUrl) {
    String() => TronGrpcClient(GrpcWebClientChannel.xhr(Uri.parse(grpcUrl))),
    _ => null,
  };
  return DefaultTronQuickClient(
      provider:
          TronProvider(TronExampleProvider(grpc: channel, rpcUrl: fullnodeUrl)),
      availableProviders: [
        if (grpcUrl != null) TronProviderApi.grpc,
        if (fullnodeUrl != null) TronProviderApi.fullnode
      ]);
}
