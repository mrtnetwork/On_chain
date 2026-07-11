import 'package:blockchain_utils/service/models/params.dart';

class AptosApiMethod {
  final String name;
  final String url;
  final RequestMethod requestType;
  const AptosApiMethod._({
    required this.name,
    required this.url,
    required this.requestType,
  });
  static const AptosApiMethod getAccount = AptosApiMethod._(
    url: '/accounts/{address}',
    name: 'Get account',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountResources = AptosApiMethod._(
    url: '/accounts/{address}/resources',
    name: 'Get account resources',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountResources2 = AptosApiMethod._(
    url: '/accounts/{address}/balance/{asset_type}',
    name: 'Get account resources',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountModules = AptosApiMethod._(
    url: '/accounts/{address}/modules',
    name: 'Get account modules',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod showOpenAPIExplorer = AptosApiMethod._(
    url: '/spec',
    name: 'Show OpenAPI explorer',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod showSomeBasicInfoOfTheNode = AptosApiMethod._(
    url: '/info',
    name: 'Show some basic info of the node.',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod checkBasicNodeHealth = AptosApiMethod._(
    url: '/-/healthy',
    name: 'Check basic node health',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getBlocksByHeight = AptosApiMethod._(
    url: '/blocks/by_height/{block_height}',
    name: 'Get blocks by height',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getBlocksByVersion = AptosApiMethod._(
    url: '/blocks/by_version/{version}',
    name: 'Get blocks by version',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getEventsByCreationNumber = AptosApiMethod._(
    url: '/accounts/{address}/events/{creation_number}',
    name: 'Get events by creation number',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getEventsByEventHandle = AptosApiMethod._(
    url: '/accounts/{address}/events/{event_handle}/{field_name}',
    name: 'Get events by event handle',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getLedgerInfo = AptosApiMethod._(
    url: '/',
    name: 'Get ledger info',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountResource = AptosApiMethod._(
    url: '/accounts/{address}/resource/{resource_type}',
    name: 'Get account resource',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountModule = AptosApiMethod._(
    url: '/accounts/{address}/module/{module_name}',
    name: 'Get account module',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getTableItem = AptosApiMethod._(
    url: '/tables/{table_handle}/item',
    name: 'Get table item',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod getRawTableItem = AptosApiMethod._(
    url: '/tables/{table_handle}/raw_item',
    name: 'Get raw table item',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod submitTransaction = AptosApiMethod._(
    url: '/transactions',
    name: 'Submit transaction',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod getTransactions = AptosApiMethod._(
    url: '/transactions',
    name: 'Get transactions ',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getTransactionByHash = AptosApiMethod._(
    url: '/transactions/by_hash/{txn_hash}',
    name: 'Get transaction by hash',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod waitForTransactionByHash = AptosApiMethod._(
    url: '/transactions/wait_by_hash/{txn_hash}',
    name: 'Wait for transaction by hash',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getTransactionByVersion = AptosApiMethod._(
    url: '/transactions/by_version/{txn_version}',
    name: 'Get transaction by version',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod getAccountTransactions = AptosApiMethod._(
    url: '/accounts/{address}/transactions',
    name: 'Get account transactions',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod submitBatchTransactions = AptosApiMethod._(
    url: '/transactions/batch',
    name: 'Submit batch transactions',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod simulateTransaction = AptosApiMethod._(
    url: '/transactions/simulate',
    name: 'Simulate transaction',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod encodeSubmission = AptosApiMethod._(
    url: '/transactions/encode_submission',
    name: 'Encode submission',
    requestType: RequestMethod.post,
  );
  static const AptosApiMethod estimateGasPrice = AptosApiMethod._(
    url: '/estimate_gas_price',
    name: 'Estimate gas price',
    requestType: RequestMethod.get,
  );
  static const AptosApiMethod executeViewFunctionOfAModule = AptosApiMethod._(
    url: '/view',
    name: 'Execute view function of a module',
    requestType: RequestMethod.post,
  );
}
