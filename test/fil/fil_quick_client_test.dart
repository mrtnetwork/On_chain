// Offline tests for the Filecoin quick client additions
// (Tier A in quick_api.dart, Tier B in quick_evm_api.dart).
// Stub-service tests only — no network.
import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/fil.dart';
import 'package:on_chain/solidity/helper/helper.dart';
import 'package:test/test.dart';

import '../utils.dart';

const String _ownerEth = '0x1111111111111111111111111111111111111111';
const String _txCid = 'bafytesttxcid';

class _StubLotusService with LotusServiceProvider {
  final BaseServiceResponse Function(LotusFullNodeRequestDetails params)
  respond;
  _StubLotusService(this.respond);

  @override
  Future<BaseServiceResponse> doRequest(
    LotusFullNodeRequestDetails params, {
    Duration? timeout,
  }) async => respond(params);
}

BaseServiceResponse _ok(LotusFullNodeRequestDetails params, Object? result) {
  return params.toResponse({
    'jsonrpc': '2.0',
    'id': params.requestID,
    'result': result,
  });
}

BaseServiceResponse _rpcError(
  LotusFullNodeRequestDetails params, {
  required int code,
  required String message,
}) {
  return params.toResponse(
    StringUtils.encodeJson({
      'jsonrpc': '2.0',
      'id': params.requestID,
      'error': {'code': code, 'message': message},
    }),
  );
}

DefaultFilClient _quick(
  BaseServiceResponse Function(LotusFullNodeRequestDetails params) respond,
) {
  return DefaultFilClient(
    LotusProvider(_StubLotusService(respond)),
    network: FilNetworkConfig.mainnet,
  );
}

/// StateCall result envelope for [exitCode] with optional ABI [returnData].
Map<String, dynamic> _invocResult({
  required int exitCode,
  List<int>? returnData,
}) {
  String b64(List<int> bytes) =>
      StringUtils.decode(bytes, encoding: StringEncoding.base64);
  return {
    'MsgCid': 'bafytest',
    'MsgRct': {
      'ExitCode': exitCode,
      if (returnData != null)
        'Return': b64(CborBytesValue(returnData).encode()),
      'GasUsed': 0,
    },
    'GasCost': {},
    'ExecutionTrace': {
      'Msg': {
        'From': 'f00',
        'To': '0x01',
        'Value': '0',
        'Method': 0,
        'Params': '',
        'ParamsCodec': 0,
        'GasLimit': 0,
        'ReadOnly': false,
      },
      'MsgRct': {'ExitCode': exitCode, 'Return': '', 'ReturnCodec': 0},
      'GasCharges': [],
      'Subcalls': [],
    },
    'Error': '',
  };
}

/// ABI-encode a uint256 output word, then wrap as EVM returndata.
List<int> _uintReturn(BigInt v) {
  final words = <int>[];
  final raw = v.toRadixString(16).padLeft(64, '0');
  for (var i = 0; i < raw.length; i += 2) {
    words.add(int.parse(raw.substring(i, i + 2), radix: 16));
  }
  return words;
}

void filQuickClientAdditionsTest() {
  group('Filecoin/QuickClient additions (offline)', () {
    test('getActorNonce reads nonce, zero when missing', () async {
      final quick = _quick(
        (p) => _ok(p, {
          'Code': {'/': 'bafytest'},
          'Head': {'/': 'bafytest'},
          'Nonce': 7,
          'Balance': '1000',
        }),
      );
      expect(await quick.getActorNonce(FilAddress('f01011')), BigInt.from(7));

      final missing = _quick(
        (p) => _rpcError(p, code: -32603, message: 'actor not found'),
      );
      expect(await missing.getActorNonce(FilAddress('f01011')), BigInt.zero);

      final broken = _quick(
        (p) => _rpcError(p, code: -32603, message: 'internal error'),
      );
      expect(
        () => broken.getActorNonce(FilAddress('f01011')),
        throwsA(isA<RPCError>()),
      );
    });

    test('getTransactionStatus maps lookup states', () async {
      Map<String, dynamic> lookup({required int exitCode}) => {
        'Message': {'/': 'bafytest'},
        'Height': 100,
        'TipSet': [],
        'Receipt': {'ExitCode': exitCode, 'Return': '', 'GasUsed': 0},
      };
      final block = _quick((p) => _ok(p, lookup(exitCode: 0)));
      expect(await block.getTransactionStatus(Cid(_txCid)), FilTxStatus.block);

      final failed = _quick((p) => _ok(p, lookup(exitCode: 33)));
      expect(
        await failed.getTransactionStatus(Cid(_txCid)),
        FilTxStatus.failed,
      );

      final missing = _quick((p) => _ok(p, null));
      expect(
        await missing.getTransactionStatus(Cid(_txCid)),
        FilTxStatus.unknown,
      );

      final broken = _quick(
        (p) => _rpcError(p, code: -32603, message: 'internal error'),
      );
      expect(
        () => broken.getTransactionStatus(Cid(_txCid)),
        throwsA(isA<RPCError>()),
      );
    });

    test('fetchErc20Balance decodes uint256 returndata', () async {
      final contract = FilAddress('f01022');
      final quick = _quick(
        (p) => _ok(
          p,
          _invocResult(exitCode: 0, returnData: _uintReturn(BigInt.from(42))),
        ),
      );
      expect(
        await quick.fetchErc20Balance(contract: contract, ownerEth: _ownerEth),
        BigInt.from(42),
      );
    });

    test('revert maps to negative values, other errors throw', () async {
      final contract = FilAddress('f01022');
      final revert = _quick((p) => _ok(p, _invocResult(exitCode: 33)));
      expect(
        await revert.fetchErc20Allowance(
          contract: contract,
          ownerEth: _ownerEth,
          spenderEth: _ownerEth,
        ),
        BigInt.zero,
      );
      expect(
        await revert.filSupportsInterface(
          contract: contract,
          interfaceId: '0x80ac58cd',
        ),
        isFalse,
      );
      expect(
        await revert.fetchErc721Owner(contract: contract, tokenId: BigInt.one),
        isNull,
      );

      final broken = _quick(
        (p) => _rpcError(p, code: -32603, message: 'internal error'),
      );
      expect(
        () => broken.fetchErc20Balance(contract: contract, ownerEth: _ownerEth),
        throwsA(isA<RPCError>()),
      );
      expect(
        () => broken.filSupportsInterface(
          contract: contract,
          interfaceId: '0x80ac58cd',
        ),
        throwsA(isA<RPCError>()),
      );
    });

    test('filErc20TransferCalldata encodes transfer', () async {
      final data = FilQuickEvmApiUtils.filErc20TransferCalldata(
        toEth: _ownerEth,
        amount: BigInt.from(9),
      );
      final decoded = const ERC20TransferEncoder().decodeInput(data);
      expect(decoded.to.address.toLowerCase(), _ownerEth);
      expect(decoded.value, BigInt.from(9));
    });

    test('filInvokeMessage builds invoke skeleton', () async {
      final quick = _quick((p) => _ok(p, null));
      final contract = FilAddress('f01022');
      final msg = quick.filInvokeMessage(
        contract: contract,
        from: contract,
        calldata: [1, 2, 3],
      );
      expect(msg.method, FilEvmMethods.invokeContract);
      expect(msg.to, contract);
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(filQuickClientAdditionsTest, 'Fil Quick Client');
}
