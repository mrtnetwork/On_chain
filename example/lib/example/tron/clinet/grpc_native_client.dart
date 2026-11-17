import 'package:grpc/grpc.dart';
import 'package:on_chain/tron/tron.dart';
import 'grpc_client_example.dart';

DefaultTronQuickClient tronClient({
  String? fullnodeUrl,
  String? grpcUrl,
  int grpcPort = 443,
  String? proxy,
  bool? tls,
}) {
  tls ??= grpcPort == 443;
  final channel = switch (grpcUrl) {
    String() => TronGrpcClient(
        ClientChannel(
          grpcUrl,
          port: grpcPort,
          options: ChannelOptions(
            credentials: tls
                ? const ChannelCredentials.secure()
                : const ChannelCredentials.insecure(),
            userAgent: "hiero-sdk-js/DEV",
            proxy: proxy == null
                ? null
                : Proxy(
                    host: proxy.split(":").first,
                    port: int.parse(proxy.split(":").last),
                  ),
          ),
        ),
      ),
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
