import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solidity/solidity.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/models.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/api.dart'
    as protocol_api;
import 'package:on_chain/tron/src/proto_messages/protocol/src/balance_contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/smart_contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart';
import 'package:on_chain/tron/src/provider/core/request.dart';
import 'package:on_chain/tron/src/provider/models/types.dart';
import 'package:on_chain/tron/src/provider/utils/utils.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

/// Maps a sealed wallet response value to [T]. Throws [RPCError]
/// when the node returned [JavaTronError].
T _mapResult<T>(Object mapped) {
  if (mapped is TronHttpJavaTronError) {
    throw RPCError(
      message: mapped.error,
      relatedNetwork: BlockchainNetwork.tron,
    );
  }
  return mapped as T;
}

/// POST /wallet/getaccount
class TronFullNodeRequestWalletGetaccountPost
    extends TronFullNodeRequest<TronAccount, Map<String, dynamic>> {
  final TronHttpAccountRequest requestBody;

  const TronFullNodeRequestWalletGetaccountPost({required this.requestBody});

  @override
  String? get path => '/wallet/getaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronAccount onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) {
      return TronAccount();
    }
    final r = TronHttpResponseWalletGetaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetaccountPostAccount(:final value) =>
        value.toAccount(),
      TronHttpResponseWalletGetaccountPostJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getaccountbalance
class TronFullNodeRequestWalletGetaccountbalancePost
    extends
        TronFullNodeRequest<TronAccountBalanceResponse, Map<String, dynamic>> {
  final TronHttpAccountBalanceRequestRequest requestBody;

  const TronFullNodeRequestWalletGetaccountbalancePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getaccountbalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronAccountBalanceResponse onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) {
      return TronAccountBalanceResponse();
    }
    final r = TronHttpResponseWalletGetaccountbalancePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetaccountbalancePostAccountBalanceResponse(
        :final value,
      ) =>
        value.toAccountBalanceResponse(),
      TronHttpResponseWalletGetaccountbalancePostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getaccountnet
class TronFullNodeRequestWalletGetaccountnetPost
    extends
        TronFullNodeRequest<
          protocol_api.TronAccountNetMessage,
          Map<String, dynamic>
        > {
  final TronHttpAccountRequest requestBody;

  const TronFullNodeRequestWalletGetaccountnetPost({required this.requestBody});

  @override
  String? get path => '/wallet/getaccountnet';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronAccountNetMessage onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) {
      return protocol_api.TronAccountNetMessage();
    }
    final r = TronHttpResponseWalletGetaccountnetPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetaccountnetPostAccountNetMessage(:final value) =>
        value.toAccountNetMessage(),
      TronHttpResponseWalletGetaccountnetPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getaccountresource
class TronFullNodeRequestWalletGetaccountresourcePost
    extends
        TronFullNodeRequest<TronAccountResourceMessage, Map<String, dynamic>> {
  final TronHttpWalletGetaccountresourcePostBody requestBody;

  const TronFullNodeRequestWalletGetaccountresourcePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getaccountresource';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronAccountResourceMessage onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) {
      return TronAccountResourceMessage.noResources();
    }
    final r = TronHttpResponseWalletGetaccountresourcePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetaccountresourcePostAccountResourceMessage(
        :final value,
      ) =>
        value.toAccountResourceMessage(),
      TronHttpResponseWalletGetaccountresourcePostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/createaccount
class TronFullNodeRequestWalletCreateaccountPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpAccountCreateContractRequest requestBody;
  const TronFullNodeRequestWalletCreateaccountPost({required this.requestBody});

  @override
  String? get path => '/wallet/createaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/updateaccount
class TronFullNodeRequestWalletUpdateaccountPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpAccountUpdateContractRequest requestBody;

  const TronFullNodeRequestWalletUpdateaccountPost({required this.requestBody});

  @override
  String? get path => '/wallet/updateaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/accountpermissionupdate
class TronFullNodeRequestWalletAccountpermissionupdatePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpAccountPermissionUpdateContractRequest requestBody;

  const TronFullNodeRequestWalletAccountpermissionupdatePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/accountpermissionupdate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/validateaddress
class TronFullNodeRequestWalletValidateaddressGet
    extends
        TronFullNodeRequest<
          TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1,
          Map<String, dynamic>
        > {
  final String address;
  final bool? int64AsString;

  const TronFullNodeRequestWalletValidateaddressGet({
    required this.address,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/validateaddress';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1
  onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletValidateaddressGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1() =>
        r,
      TronHttpResponseWalletValidateaddressGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/validateaddress
class TronFullNodeRequestWalletValidateaddressPost
    extends
        TronFullNodeRequest<
          TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1,
          Map<String, dynamic>
        > {
  final TronHttpWalletValidateaddressPostBody requestBody;

  const TronFullNodeRequestWalletValidateaddressPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/validateaddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1
  onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletValidateaddressGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletValidateaddressGetValidateaddressGetResultObject1() =>
        r,
      TronHttpResponseWalletValidateaddressGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getnowblock
class TronFullNodeRequestWalletGetnowblockGet
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetnowblockGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getnowblock';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnowblockGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnowblockGetBlockInt64StringCompatible(
        :final value,
      ) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetnowblockGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getnowblock
class TronFullNodeRequestWalletGetnowblockPost
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletGetnowblockPost({this.visible});

  @override
  String? get path => '/wallet/getnowblock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnowblockPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnowblockPostBlock(:final value) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetnowblockPostJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/getblock
class TronFullNodeRequestWalletGetblockGet
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  final String? idOrNum;
  final bool? detail;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetblockGet({
    this.idOrNum,
    this.detail,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getblock';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'id_or_num': idOrNum,
    'detail': detail?.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockGetBlockInt64StringCompatible(
        :final value,
      ) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetblockGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getblock
class TronFullNodeRequestWalletGetblockPost
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  final TronHttpBlockReqRequest requestBody;

  const TronFullNodeRequestWalletGetblockPost({required this.requestBody});

  @override
  String? get path => '/wallet/getblock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockPostBlock(:final value) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetblockPostJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getblockbynum
class TronFullNodeRequestWalletGetblockbynumPost
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  final TronHttpBlockHeightNumberMessageRequest requestBody;

  const TronFullNodeRequestWalletGetblockbynumPost({required this.requestBody});

  @override
  String? get path => '/wallet/getblockbynum';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnowblockPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnowblockPostBlock(:final value) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetnowblockPostJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/getblockbyid
class TronFullNodeRequestWalletGetblockbyidGet
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  final String? value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetblockbyidGet({
    this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getblockbyid';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnowblockGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnowblockGetBlockInt64StringCompatible(
        :final value,
      ) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetnowblockGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getblockbyid
class TronFullNodeRequestWalletGetblockbyidPost
    extends TronFullNodeRequest<TronBlock, Map<String, dynamic>> {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGetblockbyidPost({required this.requestBody});

  @override
  String? get path => '/wallet/getblockbyid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronBlock onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnowblockPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnowblockPostBlock(:final value) =>
        value.toBlockLenient(),
      TronHttpResponseWalletGetnowblockPostJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/getblockbylimitnext
class TronFullNodeRequestWalletGetblockbylimitnextGet
    extends
        TronFullNodeRequest<protocol_api.TronBlockList, Map<String, dynamic>> {
  final BigInt startNum;
  final BigInt endNum;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetblockbylimitnextGet({
    required this.startNum,
    required this.endNum,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getblockbylimitnext';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'startNum': startNum.toString(),
    'endNum': endNum.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronBlockList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockbylimitnextGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockbylimitnextGetBlockListInt64StringCompatible(
        :final value,
      ) =>
        value.toBlockList(),
      TronHttpResponseWalletGetblockbylimitnextGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getblockbylimitnext
class TronFullNodeRequestWalletGetblockbylimitnextPost
    extends
        TronFullNodeRequest<protocol_api.TronBlockList, Map<String, dynamic>> {
  final TronHttpBlockLimitRequest requestBody;

  const TronFullNodeRequestWalletGetblockbylimitnextPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getblockbylimitnext';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronBlockList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockbylimitnextPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockbylimitnextPostBlockList(:final value) =>
        value.toBlockList(),
      TronHttpResponseWalletGetblockbylimitnextPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getblockbylatestnum
class TronFullNodeRequestWalletGetblockbylatestnumGet
    extends
        TronFullNodeRequest<protocol_api.TronBlockList, Map<String, dynamic>> {
  final BigInt num_;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetblockbylatestnumGet({
    required this.num_,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getblockbylatestnum';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'num': num_.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronBlockList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockbylimitnextGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockbylimitnextGetBlockListInt64StringCompatible(
        :final value,
      ) =>
        value.toBlockList(),
      TronHttpResponseWalletGetblockbylimitnextGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getblockbylatestnum
class TronFullNodeRequestWalletGetblockbylatestnumPost
    extends
        TronFullNodeRequest<protocol_api.TronBlockList, Map<String, dynamic>> {
  final TronHttpNumberMessageRequest requestBody;

  const TronFullNodeRequestWalletGetblockbylatestnumPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getblockbylatestnum';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronBlockList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockbylimitnextPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockbylimitnextPostBlockList(:final value) =>
        value.toBlockList(),
      TronHttpResponseWalletGetblockbylimitnextPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getblockbalance
class TronFullNodeRequestWalletGetblockbalancePost
    extends TronFullNodeRequest<TronBlockBalanceTrace, Map<String, dynamic>> {
  final TronHttpBlockIdentifierRequest requestBody;

  const TronFullNodeRequestWalletGetblockbalancePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getblockbalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronBlockBalanceTrace onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetblockbalancePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetblockbalancePostBlockBalanceTrace(
        :final value,
      ) =>
        value.toBlockBalanceTrace(),
      TronHttpResponseWalletGetblockbalancePostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/gettransactioncountbyblocknum
class TronFullNodeRequestWalletGettransactioncountbyblocknumGet
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  final BigInt num_;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGettransactioncountbyblocknumGet({
    required this.num_,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/gettransactioncountbyblocknum';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'num': num_.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGettransactioncountbyblocknumGet.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGettransactioncountbyblocknumGetGettransactioncountbyblocknumGetResultObject1(
        :final count,
      ) =>
        count ?? BigInt.zero,
      TronHttpResponseWalletGettransactioncountbyblocknumGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/gettransactionbyid
class TronFullNodeRequestWalletGettransactionbyidPost
    extends TronFullNodeRequest<TronTransaction?, Map<String, dynamic>> {
  const TronFullNodeRequestWalletGettransactionbyidPost({
    required this.txId,
    this.visible = false,
  });
  final String txId;
  @override
  final bool visible;

  @override
  String? get path => '/wallet/gettransactionbyid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => {"value": txId, "visible": visible};

  @override
  TronTransaction? onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) return null;
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/gettransactioninfobyid
class TronFullNodeRequestWalletGettransactioninfobyidPost
    extends TronFullNodeRequest<TronTransactionInfo?, Map<String, dynamic>> {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGettransactioninfobyidPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/gettransactioninfobyid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransactionInfo? onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) return null;
    final r = TronHttpResponseWalletGettransactioninfobyidPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGettransactioninfobyidPostTransactionInfo(
        :final value,
      ) =>
        value.toTransactionInfo(),
      TronHttpResponseWalletGettransactioninfobyidPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/gettransactioninfobyblocknum
class TronFullNodeRequestWalletGettransactioninfobyblocknumPost
    extends
        TronFullNodeRequest<List<TronTransactionInfo>, Map<String, dynamic>> {
  final TronHttpBlockHeightNumberMessageRequest requestBody;

  const TronFullNodeRequestWalletGettransactioninfobyblocknumPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/gettransactioninfobyblocknum';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  List<TronTransactionInfo> onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGettransactioninfobyblocknumPost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultArray1(
        :final value,
      ) =>
        (value)
            .map(
              (e) => TronTransactionInfo.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList(),
      TronHttpResponseWalletGettransactioninfobyblocknumPostGettransactioninfobyblocknumPostResultEmpty2() =>
        <TronTransactionInfo>[],
      TronHttpResponseWalletGettransactioninfobyblocknumPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getpendingsize
class TronFullNodeRequestWalletGetpendingsizePost
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  const TronFullNodeRequestWalletGetpendingsizePost();

  @override
  String? get path => '/wallet/getpendingsize';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetpendingsizePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetpendingsizePostGetpendingsizePostResultObject1(
        :final pendingSize,
      ) =>
        pendingSize ?? BigInt.zero,
      TronHttpResponseWalletGetpendingsizePostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/gettransactionfrompending
class TronFullNodeRequestWalletGettransactionfrompendingGet
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final String value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGettransactionfrompendingGet({
    required this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/gettransactionfrompending';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGettransactionbyidGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGettransactionbyidGetTransactionInt64StringCompatible(
        :final value,
      ) =>
        value.toTransaction(),
      TronHttpResponseWalletGettransactionbyidGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/gettransactionlistfrompending
class TronFullNodeRequestWalletGettransactionlistfrompendingPost
    extends
        TronFullNodeRequest<
          protocol_api.TronTransactionIdList,
          Map<String, dynamic>
        > {
  final TronHttpWalletGettransactionlistfrompendingPostBody requestBody;

  const TronFullNodeRequestWalletGettransactionlistfrompendingPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/gettransactionlistfrompending';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronTransactionIdList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGettransactionlistfrompendingGet.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGettransactionlistfrompendingGetTransactionIdList(
        :final value,
      ) =>
        value.toTransactionIdList(),
      TronHttpResponseWalletGettransactionlistfrompendingGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/createtransaction
class TronFullNodeRequestWalletCreatetransactionPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpTransferContractRequest requestBody;

  const TronFullNodeRequestWalletCreatetransactionPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/createtransaction';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getsignweight
class TronFullNodeRequestWalletGetsignweightPost
    extends
        TronFullNodeRequest<
          protocol_api.TronTransactionSignWeight,
          Map<String, dynamic>
        > {
  final TronHttpTransactionRequest requestBody;

  const TronFullNodeRequestWalletGetsignweightPost({required this.requestBody});

  @override
  String? get path => '/wallet/getsignweight';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronTransactionSignWeight onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetsignweightPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetsignweightPostTransactionSignWeight(
        :final value,
      ) =>
        value.toTransactionSignWeight(),
      TronHttpResponseWalletGetsignweightPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getapprovedlist
class TronFullNodeRequestWalletGetapprovedlistPost
    extends
        TronFullNodeRequest<
          protocol_api.TronTransactionApprovedList,
          Map<String, dynamic>
        > {
  final TronHttpTransactionRequest requestBody;

  const TronFullNodeRequestWalletGetapprovedlistPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getapprovedlist';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronTransactionApprovedList onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetapprovedlistPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetapprovedlistPostTransactionApprovedList(
        :final value,
      ) =>
        value.toTransactionApprovedList(),
      TronHttpResponseWalletGetapprovedlistPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/broadcasttransaction
class TronFullNodeRequestWalletBroadcasttransactionPost
    extends
        TronFullNodeRequest<
          TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1,
          Map<String, dynamic>
        > {
  final TronHttpWalletBroadcasttransactionPostBody requestBody;

  const TronFullNodeRequestWalletBroadcasttransactionPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/broadcasttransaction';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1
  onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletBroadcasttransactionPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletBroadcasttransactionPostBroadcasttransactionPostResultObject1() =>
        r,
      TronHttpResponseWalletBroadcasttransactionPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/broadcasthex
class TronFullNodeRequestWalletBroadcasthexPost
    extends
        TronFullNodeRequest<
          TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1,
          Map<String, dynamic>
        > {
  final TronHttpWalletBroadcasthexPostBody requestBody;

  const TronFullNodeRequestWalletBroadcasthexPost({required this.requestBody});

  @override
  String? get path => '/wallet/broadcasthex';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1
  onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletBroadcasthexPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletBroadcasthexPostBroadcasthexPostResultObject1() =>
        r,
      TronHttpResponseWalletBroadcasthexPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/createassetissue
class TronFullNodeRequestWalletCreateassetissuePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpAssetIssueContractRequest requestBody;

  const TronFullNodeRequestWalletCreateassetissuePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/createassetissue';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/updateasset
class TronFullNodeRequestWalletUpdateassetPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUpdateAssetContractRequest requestBody;

  const TronFullNodeRequestWalletUpdateassetPost({required this.requestBody});

  @override
  String? get path => '/wallet/updateasset';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/transferasset
class TronFullNodeRequestWalletTransferassetPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpTransferAssetContractRequest requestBody;

  const TronFullNodeRequestWalletTransferassetPost({required this.requestBody});

  @override
  String? get path => '/wallet/transferasset';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/participateassetissue
class TronFullNodeRequestWalletParticipateassetissuePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpParticipateAssetIssueContractRequest requestBody;

  const TronFullNodeRequestWalletParticipateassetissuePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/participateassetissue';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/unfreezeasset
class TronFullNodeRequestWalletUnfreezeassetPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUnfreezeAssetContractRequest requestBody;

  const TronFullNodeRequestWalletUnfreezeassetPost({required this.requestBody});

  @override
  String? get path => '/wallet/unfreezeasset';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getassetissuebyid
class TronFullNodeRequestWalletGetassetissuebyidPost
    extends TronFullNodeRequest<TronAssetIssueContract?, Map<String, dynamic>> {
  final TronHttpWalletGetassetissuebyidPostBody requestBody;

  const TronFullNodeRequestWalletGetassetissuebyidPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getassetissuebyid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronAssetIssueContract? onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) return null;
    final r = TronHttpResponseWalletGetassetissuebyidPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuebyidPostAssetIssueContract(
        :final value,
      ) =>
        value.toAssetIssueContract(),
      TronHttpResponseWalletGetassetissuebyidPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getassetissuebyname
class TronFullNodeRequestWalletGetassetissuebynameGet
    extends TronFullNodeRequest<TronAssetIssueContract?, Map<String, dynamic>> {
  final String value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetassetissuebynameGet({
    required this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getassetissuebyname';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronAssetIssueContract? onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) return null;
    final r = TronHttpResponseWalletGetassetissuebyidGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuebyidGetAssetIssueContractInt64StringCompatible(
        :final value,
      ) =>
        value.toAssetIssueContract(),
      TronHttpResponseWalletGetassetissuebyidGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getassetissuebyname
class TronFullNodeRequestWalletGetassetissuebynamePost
    extends TronFullNodeRequest<TronAssetIssueContract?, Map<String, dynamic>> {
  final TronHttpWalletGetassetissuebyidPostBody requestBody;

  const TronFullNodeRequestWalletGetassetissuebynamePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getassetissuebyname';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronAssetIssueContract? onResponse(Map<String, dynamic> result) {
    if (result.isEmpty) return null;
    final r = TronHttpResponseWalletGetassetissuebyidPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuebyidPostAssetIssueContract(
        :final value,
      ) =>
        value.toAssetIssueContract(),
      TronHttpResponseWalletGetassetissuebyidPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getassetissuelistbyname
class TronFullNodeRequestWalletGetassetissuelistbynameGet
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final String value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetassetissuelistbynameGet({
    required this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getassetissuelistbyname';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynameGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getassetissuelistbyname
class TronFullNodeRequestWalletGetassetissuelistbynamePost
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final TronHttpWalletGetassetissuebyidPostBody requestBody;

  const TronFullNodeRequestWalletGetassetissuelistbynamePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getassetissuelistbyname';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynamePost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getassetissuebyaccount
class TronFullNodeRequestWalletGetassetissuebyaccountGet
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final String address;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetassetissuebyaccountGet({
    required this.address,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getassetissuebyaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynameGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getassetissuebyaccount
class TronFullNodeRequestWalletGetassetissuebyaccountPost
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final TronHttpAccountRequest requestBody;

  const TronFullNodeRequestWalletGetassetissuebyaccountPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getassetissuebyaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynamePost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getassetissuelist
class TronFullNodeRequestWalletGetassetissuelistPost
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletGetassetissuelistPost({this.visible});

  @override
  String? get path => '/wallet/getassetissuelist';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynamePost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getpaginatedassetissuelist
class TronFullNodeRequestWalletGetpaginatedassetissuelistGet
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final BigInt offset;
  final BigInt limit;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetpaginatedassetissuelistGet({
    required this.offset,
    required this.limit,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getpaginatedassetissuelist';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset': offset.toString(),
    'limit': limit.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynameGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynameGetAssetIssueListInt64StringCompatible(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynameGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getpaginatedassetissuelist
class TronFullNodeRequestWalletGetpaginatedassetissuelistPost
    extends
        TronFullNodeRequest<
          protocol_api.TronAssetIssueList,
          Map<String, dynamic>
        > {
  final TronHttpPaginatedMessageRequest requestBody;

  const TronFullNodeRequestWalletGetpaginatedassetissuelistPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getpaginatedassetissuelist';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronAssetIssueList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetassetissuelistbynamePost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetassetissuelistbynamePostAssetIssueList(
        :final value,
      ) =>
        value.toAssetIssueList(),
      TronHttpResponseWalletGetassetissuelistbynamePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/deploycontract
class TronFullNodeRequestWalletDeploycontractPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronCreateSmartContract contract;

  /// When true, addresses are encoded in base58check; when false or omitted, addresses are hex-encoded.
  @override
  final bool visible;

  /// Permission id used to sign the transaction with a non-owner account permission.
  final int? permissionId;

  const TronFullNodeRequestWalletDeploycontractPost(
    this.contract, {
    this.visible = false,
    this.permissionId,
  });

  @override
  String? get path => '/wallet/deploycontract';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() =>
      {
        ...contract.toJson(
          config: TronProtoJsonConfig.config.copyWith(visible: visible),
        ),
        "visible": visible,
        "Permission_id": permissionId,
      }.notNullValue;

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/triggersmartcontract
class TronFullNodeRequestWalletTriggersmartcontractPost
    extends
        TronFullNodeRequest<
          protocol_api.TronTransactionExtention,
          Map<String, dynamic>
        > {
  final TronHttpTriggerSmartContractRequest requestBody;

  const TronFullNodeRequestWalletTriggersmartcontractPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/triggersmartcontract';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronTransactionExtention onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletTriggersmartcontractPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletTriggersmartcontractPostTransactionExtention(
        :final value,
      ) =>
        value.toTransactionExtention(),
      TronHttpResponseWalletTriggersmartcontractPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/triggerconstantcontract
class TronFullNodeRequestWalletTriggerconstantcontractPost
    extends
        TronFullNodeRequest<
          protocol_api.TronTransactionExtention,
          Map<String, dynamic>
        > {
  factory TronFullNodeRequestWalletTriggerconstantcontractPost.fromMethod({
    required TronAddress ownerAddress,
    required TronAddress contractAddress,
    required AbiFunctionFragment function,
    required List<dynamic> params,
    String? parameter,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    bool visible = true,
  }) {
    final rawBytes = function.encode(params, true);

    return TronFullNodeRequestWalletTriggerconstantcontractPost._(
      ownerAddress: ownerAddress,
      contractAddress: contractAddress,
      callTokenValue: callTokenValue,
      callValue: callValue,
      data: rawBytes.isEmpty ? null : BytesUtils.toHexString(rawBytes),
      fragment: function,
      tokenId: tokenId,
      visible: visible,
    );
  }
  factory TronFullNodeRequestWalletTriggerconstantcontractPost({
    required TronAddress ownerAddress,
    TronAddress? contractAddress,
    String? functionSelector,
    String? parameter,
    String? data,
    BigInt? callValue,
    BigInt? callTokenValue,
    BigInt? tokenId,
    AbiFunctionFragment? fragment,
    bool visible = true,
  }) {
    return TronFullNodeRequestWalletTriggerconstantcontractPost._(
      ownerAddress: ownerAddress,
      contractAddress: contractAddress,
      functionSelector: functionSelector,
      parameter: parameter,
      callTokenValue: callTokenValue,
      callValue: callValue,
      data: data,
      fragment: fragment,
      tokenId: tokenId,
      visible: visible,
    );
  }
  TronFullNodeRequestWalletTriggerconstantcontractPost._({
    required this.ownerAddress,
    this.contractAddress,
    this.functionSelector,
    this.parameter,
    this.fragment,
    this.data,
    this.callValue,
    this.callTokenValue,
    this.tokenId,
    this.visible = true,
  });

  /// Owner address that triggers the contract.
  final TronAddress ownerAddress;

  /// Smart contract address
  final TronAddress? contractAddress;

  /// Function call, must not be left blank.
  final String? functionSelector;

  /// Parameter encoding needs to be in accordance with the ABI rules,
  /// the rules are more complicated, users can use the ethers library
  /// to encode,For details, please refer to the document-Guide-Smart
  /// Contract-Best Practice-Parameter Encoding and Decoding.
  final String? parameter;

  /// The bytecode of the contract or the data for interacting with smart contracts,
  /// including the contract function and parameters. You can choose to use this field,
  /// or you can choose to use function_selector and parameter for contract interaction.
  ///  When both of data and function_selector exist, function_selector is preferred
  final String? data;

  /// Amount of TRX transferred to the contract with this transaction, the unit is sun. This field may be used when estimating energy consumption.
  final BigInt? callValue;

  /// Amount of TRC10 token transferred with this transaction
  final BigInt? callTokenValue;

  /// TRC10 token id
  final BigInt? tokenId;
  @override
  final bool visible;
  final AbiFunctionFragment? fragment;

  @override
  String? get path => '/wallet/triggerconstantcontract';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => {
    'owner_address': ownerAddress.toAddress(visible),
    'contract_address': contractAddress?.toAddress(visible),
    'function_selector': functionSelector,
    'parameter': parameter,
    'data': data,
    'call_value': callValue,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
    'visible': visible,
  };

  @override
  protocol_api.TronTransactionExtention onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletTriggersmartcontractPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletTriggersmartcontractPostTransactionExtention(
        :final value,
      ) =>
        value.toTransactionExtention(),
      TronHttpResponseWalletTriggersmartcontractPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/estimateenergy
class TronFullNodeRequestWalletEstimateenergyPost
    extends
        TronFullNodeRequest<
          protocol_api.TronEstimateEnergyMessage,
          Map<String, dynamic>
        > {
  TronFullNodeRequestWalletEstimateenergyPost({
    required this.ownerAddress,
    required this.contractAddress,
    required this.functionSelector,
    required this.parameter,
    this.data,
    this.callValue,
    this.callTokenValue,
    this.tokenId,
    this.visible = false,
  });

  /// Owner address that triggers the contract
  final TronAddress ownerAddress;

  /// Smart contract address
  final TronAddress contractAddress;

  /// Function call, must not be left blank.
  final String functionSelector;

  /// Parameter encoding needs to be in accordance with the ABI rules, the rules are more complicated, users can use the ethers library to encode,For details,
  /// please refer to the document-Guide-Smart Contract-Best Practice-Parameter Encoding and Decoding.
  final String parameter;

  /// The bytecode of the contract or the data for interacting with smart contracts,
  /// including the contract function and parameters. You can choose to use this field, or you can choose to use function_selector and parameter for contract interaction. When both of data and function_selector exist, function_selector is preferred
  final String? data;

  /// Amount of TRX transferred with this transaction, measured in SUN (1 TRX = 1,000,000 SUN).
  final BigInt? callValue;

  /// Amount of TRC10 token transferred with this transaction
  final BigInt? callTokenValue;

  /// TRC10 token id
  final BigInt? tokenId;

  @override
  final bool visible;

  @override
  String? get path => '/wallet/estimateenergy';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => {
    'owner_address': ownerAddress.toAddress(visible),
    'contract_address': contractAddress.toAddress(visible),
    'function_selector': functionSelector,
    'parameter': parameter,
    'data': data,
    'call_value': callValue,
    'call_token_value': callTokenValue,
    'token_id': tokenId,
    'visible': visible,
  };

  @override
  protocol_api.TronEstimateEnergyMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletEstimateenergyPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletEstimateenergyPostEstimateenergyPostResultObject1(
        :final result,
        :final energyRequired,
      ) =>
        protocol_api.TronEstimateEnergyMessage(
          result: protocol_api.TronReturn(
            code: protocol_api.TronReturnresponseCode.from(result?.code),
            message: StringUtils.tryEncode(result?.message),
            result: result?.result,
          ),
          energyRequired: energyRequired,
        ),
      TronHttpResponseWalletEstimateenergyPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getcontract
class TronFullNodeRequestWalletGetcontractGet
    extends TronFullNodeRequest<TronSmartContract, Map<String, dynamic>> {
  final String? value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetcontractGet({
    this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getcontract';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronSmartContract onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetcontractGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcontractGetSmartContractInt64StringCompatible(
        :final value,
      ) =>
        value.toSmartContract(),
      TronHttpResponseWalletGetcontractGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getcontract
class TronFullNodeRequestWalletGetcontractPost
    extends TronFullNodeRequest<TronSmartContract, Map<String, dynamic>> {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGetcontractPost({required this.requestBody});

  @override
  String? get path => '/wallet/getcontract';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronSmartContract onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetcontractPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcontractPostSmartContract(:final value) =>
        value.toSmartContract(),
      TronHttpResponseWalletGetcontractPostJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/getcontractinfo
class TronFullNodeRequestWalletGetcontractinfoGet
    extends
        TronFullNodeRequest<
          TronSmartContractDataWrapper,
          Map<String, dynamic>
        > {
  final String? value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetcontractinfoGet({
    this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getcontractinfo';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronSmartContractDataWrapper onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetcontractinfoGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcontractinfoGetSmartContractDataWrapperInt64StringCompatible(
        :final value,
      ) =>
        value.toSmartContractDataWrapper(),
      TronHttpResponseWalletGetcontractinfoGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getcontractinfo
class TronFullNodeRequestWalletGetcontractinfoPost
    extends
        TronFullNodeRequest<
          TronSmartContractDataWrapper,
          Map<String, dynamic>
        > {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGetcontractinfoPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getcontractinfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronSmartContractDataWrapper onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetcontractinfoPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcontractinfoPostSmartContractDataWrapper(
        :final value,
      ) =>
        value.toSmartContractDataWrapper(),
      TronHttpResponseWalletGetcontractinfoPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/clearabi
class TronFullNodeRequestWalletClearabiPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpClearABIContractRequest requestBody;

  const TronFullNodeRequestWalletClearabiPost({required this.requestBody});

  @override
  String? get path => '/wallet/clearabi';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/updatesetting
class TronFullNodeRequestWalletUpdatesettingPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUpdateSettingContractRequest requestBody;

  const TronFullNodeRequestWalletUpdatesettingPost({required this.requestBody});

  @override
  String? get path => '/wallet/updatesetting';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/updateenergylimit
class TronFullNodeRequestWalletUpdateenergylimitPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUpdateEnergyLimitContractRequest requestBody;

  const TronFullNodeRequestWalletUpdateenergylimitPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/updateenergylimit';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/createwitness
class TronFullNodeRequestWalletCreatewitnessPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpWitnessCreateContractRequest requestBody;

  const TronFullNodeRequestWalletCreatewitnessPost({required this.requestBody});

  @override
  String? get path => '/wallet/createwitness';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/updatewitness
class TronFullNodeRequestWalletUpdatewitnessPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpWitnessUpdateContractRequest requestBody;

  const TronFullNodeRequestWalletUpdatewitnessPost({required this.requestBody});

  @override
  String? get path => '/wallet/updatewitness';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/listwitnesses
class TronFullNodeRequestWalletListwitnessesGet
    extends
        TronFullNodeRequest<
          protocol_api.TronWitnessList,
          Map<String, dynamic>
        > {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletListwitnessesGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/listwitnesses';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronWitnessList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListwitnessesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListwitnessesGetWitnessListInt64StringCompatible(
        :final value,
      ) =>
        value.toWitnessList(),
      TronHttpResponseWalletListwitnessesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/listwitnesses
class TronFullNodeRequestWalletListwitnessesPost
    extends
        TronFullNodeRequest<
          protocol_api.TronWitnessList,
          Map<String, dynamic>
        > {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletListwitnessesPost({this.visible});

  @override
  String? get path => '/wallet/listwitnesses';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  protocol_api.TronWitnessList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListwitnessesPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListwitnessesPostWitnessList(:final value) =>
        value.toWitnessList(),
      TronHttpResponseWalletListwitnessesPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getpaginatednowwitnesslist
class TronFullNodeRequestWalletGetpaginatednowwitnesslistGet
    extends
        TronFullNodeRequest<
          protocol_api.TronWitnessList,
          Map<String, dynamic>
        > {
  final BigInt offset;
  final BigInt limit;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetpaginatednowwitnesslistGet({
    required this.offset,
    required this.limit,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getpaginatednowwitnesslist';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset': offset.toString(),
    'limit': limit.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronWitnessList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListwitnessesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListwitnessesGetWitnessListInt64StringCompatible(
        :final value,
      ) =>
        value.toWitnessList(),
      TronHttpResponseWalletListwitnessesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getpaginatednowwitnesslist
class TronFullNodeRequestWalletGetpaginatednowwitnesslistPost
    extends
        TronFullNodeRequest<
          protocol_api.TronWitnessList,
          Map<String, dynamic>
        > {
  final TronHttpPaginatedMessageRequest requestBody;

  const TronFullNodeRequestWalletGetpaginatednowwitnesslistPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getpaginatednowwitnesslist';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronWitnessList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListwitnessesPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListwitnessesPostWitnessList(:final value) =>
        value.toWitnessList(),
      TronHttpResponseWalletListwitnessesPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/votewitnessaccount
class TronFullNodeRequestWalletVotewitnessaccountPost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpVoteWitnessContractRequest requestBody;

  const TronFullNodeRequestWalletVotewitnessaccountPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/votewitnessaccount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getBrokerage
class TronFullNodeRequestWalletGetBrokerageGet
    extends TronFullNodeRequest<int, Map<String, dynamic>> {
  final String? address;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetBrokerageGet({
    this.address,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getBrokerage';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  int onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetBrokerageGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1(
        :final brokerage,
        :final error,
      ) =>
        brokerage ??
            (throw BuError(
              OnChainErrorType.tronPlugin,
              error ?? "Brokerage error.",
            )),
      TronHttpResponseWalletGetBrokerageGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getBrokerage
class TronFullNodeRequestWalletGetBrokeragePost
    extends TronFullNodeRequest<int, Map<String, dynamic>> {
  final TronHttpWalletGetBrokeragePostBody requestBody;

  const TronFullNodeRequestWalletGetBrokeragePost({required this.requestBody});

  @override
  String? get path => '/wallet/getBrokerage';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  int onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetBrokerageGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetBrokerageGetGetBrokerageGetResultObject1(
        :final brokerage,
        :final error,
      ) =>
        brokerage ??
            (throw BuError(
              OnChainErrorType.tronPlugin,
              error ?? "Brokerage error.",
            )),
      TronHttpResponseWalletGetBrokerageGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/updateBrokerage
class TronFullNodeRequestWalletUpdateBrokeragePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUpdateBrokerageContractRequest requestBody;

  const TronFullNodeRequestWalletUpdateBrokeragePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/updateBrokerage';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getReward
class TronFullNodeRequestWalletGetRewardGet
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  final String? address;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetRewardGet({
    this.address,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getReward';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetRewardGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetRewardGetGetRewardGetResultRequiresReward1(
        :final reward,
      ) =>
        reward,
      TronHttpResponseWalletGetRewardGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getReward
class TronFullNodeRequestWalletGetRewardPost
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  final TronHttpWalletGetBrokeragePostBody requestBody;

  const TronFullNodeRequestWalletGetRewardPost({required this.requestBody});

  @override
  String? get path => '/wallet/getReward';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetRewardPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetRewardPostGetRewardPostResultRequiresReward1(
        :final reward,
      ) =>
        reward,
      TronHttpResponseWalletGetRewardPostJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/withdrawbalance
class TronFullNodeRequestWalletWithdrawbalancePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpWithdrawBalanceContractRequest requestBody;

  const TronFullNodeRequestWalletWithdrawbalancePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/withdrawbalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/proposalcreate
class TronFullNodeRequestWalletProposalcreatePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpProposalCreateContractRequest requestBody;

  const TronFullNodeRequestWalletProposalcreatePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/proposalcreate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/proposalapprove
class TronFullNodeRequestWalletProposalapprovePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpProposalApproveContractRequest requestBody;

  const TronFullNodeRequestWalletProposalapprovePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/proposalapprove';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/proposaldelete
class TronFullNodeRequestWalletProposaldeletePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpProposalDeleteContractRequest requestBody;

  const TronFullNodeRequestWalletProposaldeletePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/proposaldelete';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/listproposals
class TronFullNodeRequestWalletListproposalsGet
    extends
        TronFullNodeRequest<
          protocol_api.TronProposalList,
          Map<String, dynamic>
        > {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletListproposalsGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/listproposals';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronProposalList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListproposalsGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListproposalsGetProposalListInt64StringCompatible(
        :final value,
      ) =>
        value.toProposalList(),
      TronHttpResponseWalletListproposalsGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/listproposals
class TronFullNodeRequestWalletListproposalsPost
    extends
        TronFullNodeRequest<
          protocol_api.TronProposalList,
          Map<String, dynamic>
        > {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletListproposalsPost({this.visible});

  @override
  String? get path => '/wallet/listproposals';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  protocol_api.TronProposalList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListproposalsPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListproposalsPostProposalList(:final value) =>
        value.toProposalList(),
      TronHttpResponseWalletListproposalsPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getproposalbyid
class TronFullNodeRequestWalletGetproposalbyidGet
    extends TronFullNodeRequest<TronProposal, Map<String, dynamic>> {
  final BigInt id;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetproposalbyidGet({
    required this.id,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getproposalbyid';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'id': id.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronProposal onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetproposalbyidGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetproposalbyidGetProposalInt64StringCompatible(
        :final value,
      ) =>
        value.toProposal(),
      TronHttpResponseWalletGetproposalbyidGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getproposalbyid
class TronFullNodeRequestWalletGetproposalbyidPost
    extends TronFullNodeRequest<TronProposal, Map<String, dynamic>> {
  final TronHttpWalletGetproposalbyidPostBody requestBody;

  const TronFullNodeRequestWalletGetproposalbyidPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getproposalbyid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronProposal onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetproposalbyidPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetproposalbyidPostProposal(:final value) =>
        value.toProposal(),
      TronHttpResponseWalletGetproposalbyidPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getpaginatedproposallist
class TronFullNodeRequestWalletGetpaginatedproposallistGet
    extends
        TronFullNodeRequest<
          protocol_api.TronProposalList,
          Map<String, dynamic>
        > {
  final BigInt offset;
  final BigInt limit;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetpaginatedproposallistGet({
    required this.offset,
    required this.limit,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getpaginatedproposallist';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset': offset.toString(),
    'limit': limit.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronProposalList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListproposalsGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListproposalsGetProposalListInt64StringCompatible(
        :final value,
      ) =>
        value.toProposalList(),
      TronHttpResponseWalletListproposalsGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getpaginatedproposallist
class TronFullNodeRequestWalletGetpaginatedproposallistPost
    extends
        TronFullNodeRequest<
          protocol_api.TronProposalList,
          Map<String, dynamic>
        > {
  final TronHttpPaginatedMessageRequest requestBody;

  const TronFullNodeRequestWalletGetpaginatedproposallistPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getpaginatedproposallist';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronProposalList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListproposalsPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListproposalsPostProposalList(:final value) =>
        value.toProposalList(),
      TronHttpResponseWalletListproposalsPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getchainparameters
class TronFullNodeRequestWalletGetchainparametersGet
    extends TronFullNodeRequest<TronChainParameters, Map<String, dynamic>> {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetchainparametersGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getchainparameters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronChainParameters onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetchainparametersGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetchainparametersGetChainParametersInt64StringCompatible(
        :final value,
      ) =>
        value.toChainParameters(),
      TronHttpResponseWalletGetchainparametersGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getchainparameters
class TronFullNodeRequestWalletGetchainparametersPost
    extends TronFullNodeRequest<TronChainParameters, Map<String, dynamic>> {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletGetchainparametersPost({this.visible});

  @override
  String? get path => '/wallet/getchainparameters';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  TronChainParameters onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetchainparametersPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetchainparametersPostChainParameters(
        :final value,
      ) =>
        value.toChainParameters(),
      TronHttpResponseWalletGetchainparametersPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getnextmaintenancetime
class TronFullNodeRequestWalletGetnextmaintenancetimeGet
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetnextmaintenancetimeGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getnextmaintenancetime';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnextmaintenancetimeGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnextmaintenancetimeGetGetnextmaintenancetimeGetResultRequiresNum1(
        :final num_,
      ) =>
        num_,
      TronHttpResponseWalletGetnextmaintenancetimeGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getnextmaintenancetime
class TronFullNodeRequestWalletGetnextmaintenancetimePost
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletGetnextmaintenancetimePost({this.visible});

  @override
  String? get path => '/wallet/getnextmaintenancetime';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnextmaintenancetimePost.fromJson(result);
    return _mapResult(switch (r) {
      // TronHttpResponseWalletGetnextmaintenancetimePostNum(:final value) =>
      //   value,
      TronHttpResponseWalletGetnextmaintenancetimePostJavaTronError(
        :final value,
      ) =>
        value,
      TronHttpResponseWalletGetnextmaintenancetimePostGetnextmaintenancetimePostResultRequiresNum1(
        :final num_,
      ) =>
        num_,
    });
  }
}

/// POST /wallet/freezebalance
class TronFullNodeRequestWalletFreezebalancePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpFreezeBalanceContractRequest requestBody;

  const TronFullNodeRequestWalletFreezebalancePost({required this.requestBody});

  @override
  String? get path => '/wallet/freezebalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/unfreezebalance
class TronFullNodeRequestWalletUnfreezebalancePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUnfreezeBalanceContractRequest requestBody;

  const TronFullNodeRequestWalletUnfreezebalancePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/unfreezebalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getdelegatedresource
class TronFullNodeRequestWalletGetdelegatedresourceGet
    extends
        TronFullNodeRequest<
          protocol_api.TronDelegatedResourceList,
          Map<String, dynamic>
        > {
  final String fromAddress;
  final String toAddress;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetdelegatedresourceGet({
    required this.fromAddress,
    required this.toAddress,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getdelegatedresource';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'fromAddress': fromAddress,
    'toAddress': toAddress,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronDelegatedResourceList onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetdelegatedresourceGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourceGetDelegatedResourceListInt64StringCompatible(
        :final value,
      ) =>
        value.toDelegatedResourceList(),
      TronHttpResponseWalletGetdelegatedresourceGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getdelegatedresource
class TronFullNodeRequestWalletGetdelegatedresourcePost
    extends
        TronFullNodeRequest<
          protocol_api.TronDelegatedResourceList,
          Map<String, dynamic>
        > {
  final TronHttpDelegatedResourceMessageRequest requestBody;

  const TronFullNodeRequestWalletGetdelegatedresourcePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getdelegatedresource';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronDelegatedResourceList onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetdelegatedresourcePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourcePostDelegatedResourceList(
        :final value,
      ) =>
        value.toDelegatedResourceList(),
      TronHttpResponseWalletGetdelegatedresourcePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getdelegatedresourceaccountindex
class TronFullNodeRequestWalletGetdelegatedresourceaccountindexGet
    extends
        TronFullNodeRequest<
          TronDelegatedResourceAccountIndex,
          Map<String, dynamic>
        > {
  final String value;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetdelegatedresourceaccountindexGet({
    required this.value,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getdelegatedresourceaccountindex';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'value': value,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronDelegatedResourceAccountIndex onResponse(Map<String, dynamic> result) {
    final r =
        TronHttpResponseWalletGetdelegatedresourceaccountindexGet.fromJson(
          result,
        );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourceaccountindexGetDelegatedResourceAccountIndexInt64StringCompatible(
        :final value,
      ) =>
        value.toDelegatedResourceAccountIndex(),
      TronHttpResponseWalletGetdelegatedresourceaccountindexGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getdelegatedresourceaccountindex
class TronFullNodeRequestWalletGetdelegatedresourceaccountindexPost
    extends
        TronFullNodeRequest<
          TronDelegatedResourceAccountIndex,
          Map<String, dynamic>
        > {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGetdelegatedresourceaccountindexPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getdelegatedresourceaccountindex';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronDelegatedResourceAccountIndex onResponse(Map<String, dynamic> result) {
    final r =
        TronHttpResponseWalletGetdelegatedresourceaccountindexPost.fromJson(
          result,
        );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourceaccountindexPostDelegatedResourceAccountIndex(
        :final value,
      ) =>
        value.toDelegatedResourceAccountIndex(),
      TronHttpResponseWalletGetdelegatedresourceaccountindexPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/freezebalancev2
class TronFullNodeRequestWalletFreezebalancev2Post
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpFreezeBalanceV2ContractRequest requestBody;

  const TronFullNodeRequestWalletFreezebalancev2Post({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/freezebalancev2';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/unfreezebalancev2
class TronFullNodeRequestWalletUnfreezebalancev2Post
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUnfreezeBalanceV2ContractRequest requestBody;

  const TronFullNodeRequestWalletUnfreezebalancev2Post({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/unfreezebalancev2';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/withdrawexpireunfreeze
class TronFullNodeRequestWalletWithdrawexpireunfreezePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpWithdrawExpireUnfreezeContractRequest requestBody;

  const TronFullNodeRequestWalletWithdrawexpireunfreezePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/withdrawexpireunfreeze';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/cancelallunfreezev2
class TronFullNodeRequestWalletCancelallunfreezev2Post
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpCancelAllUnfreezeV2ContractRequest requestBody;

  const TronFullNodeRequestWalletCancelallunfreezev2Post({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/cancelallunfreezev2';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/delegateresource
class TronFullNodeRequestWalletDelegateresourcePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpDelegateResourceContractRequest requestBody;

  const TronFullNodeRequestWalletDelegateresourcePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/delegateresource';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/undelegateresource
class TronFullNodeRequestWalletUndelegateresourcePost
    extends TronFullNodeRequest<TronTransaction, Map<String, dynamic>> {
  final TronHttpUnDelegateResourceContractRequest requestBody;

  const TronFullNodeRequestWalletUndelegateresourcePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/undelegateresource';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronTransaction onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletCreateaccountPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletCreateaccountPostTransaction(:final value) =>
        value.toTransaction(),
      TronHttpResponseWalletCreateaccountPostJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getdelegatedresourcev2
class TronFullNodeRequestWalletGetdelegatedresourcev2Post
    extends
        TronFullNodeRequest<
          protocol_api.TronDelegatedResourceList,
          Map<String, dynamic>
        > {
  final TronHttpDelegatedResourceMessageRequest requestBody;

  const TronFullNodeRequestWalletGetdelegatedresourcev2Post({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getdelegatedresourcev2';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronDelegatedResourceList onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetdelegatedresourcePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourcePostDelegatedResourceList(
        :final value,
      ) =>
        value.toDelegatedResourceList(),
      TronHttpResponseWalletGetdelegatedresourcePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getdelegatedresourceaccountindexv2
class TronFullNodeRequestWalletGetdelegatedresourceaccountindexv2Post
    extends
        TronFullNodeRequest<
          TronDelegatedResourceAccountIndex,
          Map<String, dynamic>
        > {
  final TronHttpBytesMessageRequest requestBody;

  const TronFullNodeRequestWalletGetdelegatedresourceaccountindexv2Post({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getdelegatedresourceaccountindexv2';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  TronDelegatedResourceAccountIndex onResponse(Map<String, dynamic> result) {
    final r =
        TronHttpResponseWalletGetdelegatedresourceaccountindexPost.fromJson(
          result,
        );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetdelegatedresourceaccountindexPostDelegatedResourceAccountIndex(
        :final value,
      ) =>
        value.toDelegatedResourceAccountIndex(),
      TronHttpResponseWalletGetdelegatedresourceaccountindexPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getcandelegatedmaxsize
class TronFullNodeRequestWalletGetcandelegatedmaxsizePost
    extends
        TronFullNodeRequest<
          protocol_api.TronCanDelegatedMaxSizeResponseMessage,
          Map<String, dynamic>
        > {
  final TronHttpCanDelegatedMaxSizeRequestMessageRequest requestBody;

  const TronFullNodeRequestWalletGetcandelegatedmaxsizePost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getcandelegatedmaxsize';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronCanDelegatedMaxSizeResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetcandelegatedmaxsizePost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcandelegatedmaxsizePostCanDelegatedMaxSizeResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetcandelegatedmaxsizePostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getavailableunfreezecount
class TronFullNodeRequestWalletGetavailableunfreezecountGet
    extends
        TronFullNodeRequest<
          protocol_api.TronGetAvailableUnfreezeCountResponseMessage,
          Map<String, dynamic>
        > {
  final String? owner;
  final String? ownerAddress;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetavailableunfreezecountGet({
    this.owner,
    this.ownerAddress,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getavailableunfreezecount';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'ownerAddress': ownerAddress,
    'owner_address': ownerAddress,
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronGetAvailableUnfreezeCountResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetavailableunfreezecountGet.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetavailableunfreezecountGetGetAvailableUnfreezeCountResponseMessageInt64StringCompatible(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetavailableunfreezecountGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getavailableunfreezecount
class TronFullNodeRequestWalletGetavailableunfreezecountPost
    extends
        TronFullNodeRequest<
          protocol_api.TronGetAvailableUnfreezeCountResponseMessage,
          Map<String, dynamic>
        > {
  final TronHttpGetAvailableUnfreezeCountRequestMessageRequest requestBody;

  const TronFullNodeRequestWalletGetavailableunfreezecountPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getavailableunfreezecount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronGetAvailableUnfreezeCountResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetavailableunfreezecountPost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetavailableunfreezecountPostGetAvailableUnfreezeCountResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetavailableunfreezecountPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getcanwithdrawunfreezeamount
class TronFullNodeRequestWalletGetcanwithdrawunfreezeamountGet
    extends
        TronFullNodeRequest<
          protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage,
          Map<String, dynamic>
        > {
  final String ownerAddress;
  final BigInt? timestamp;
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetcanwithdrawunfreezeamountGet({
    required this.ownerAddress,
    this.timestamp,
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/getcanwithdrawunfreezeamount';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'owner_address': ownerAddress,
    'timestamp': timestamp?.toString(),
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetcanwithdrawunfreezeamountGet.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcanwithdrawunfreezeamountGetCanWithdrawUnfreezeAmountResponseMessageInt64StringCompatible(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetcanwithdrawunfreezeamountGetJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// POST /wallet/getcanwithdrawunfreezeamount
class TronFullNodeRequestWalletGetcanwithdrawunfreezeamountPost
    extends
        TronFullNodeRequest<
          protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage,
          Map<String, dynamic>
        > {
  final TronHttpCanWithdrawUnfreezeAmountRequestMessageRequest requestBody;

  const TronFullNodeRequestWalletGetcanwithdrawunfreezeamountPost({
    required this.requestBody,
  });

  @override
  String? get path => '/wallet/getcanwithdrawunfreezeamount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic>? body() => requestBody.toJson();

  @override
  protocol_api.TronCanWithdrawUnfreezeAmountResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetcanwithdrawunfreezeamountPost.fromJson(
      result,
    );
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetcanwithdrawunfreezeamountPostCanWithdrawUnfreezeAmountResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetcanwithdrawunfreezeamountPostJavaTronError(
        :final value,
      ) =>
        value,
    });
  }
}

/// GET /wallet/getnodeinfo
class TronFullNodeRequestWalletGetnodeinfoGet
    extends TronFullNodeRequest<TronNodeInfo, Map<String, dynamic>> {
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetnodeinfoGet({this.int64AsString});

  @override
  String? get path => '/wallet/getnodeinfo';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  TronNodeInfo onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnodeinfoGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnodeinfoGetNodeInfoInt64StringCompatible(
        :final value,
      ) =>
        value.toNodeInfo(),
      TronHttpResponseWalletGetnodeinfoGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getnodeinfo
class TronFullNodeRequestWalletGetnodeinfoPost
    extends TronFullNodeRequest<TronNodeInfo, Map<String, dynamic>> {
  const TronFullNodeRequestWalletGetnodeinfoPost();

  @override
  String? get path => '/wallet/getnodeinfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  TronNodeInfo onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetnodeinfoPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetnodeinfoPostNodeInfo(:final value) =>
        value.toNodeInfo(),
      TronHttpResponseWalletGetnodeinfoPostJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/listnodes
class TronFullNodeRequestWalletListnodesGet
    extends
        TronFullNodeRequest<protocol_api.TronNodeList, Map<String, dynamic>> {
  @override
  final bool? visible;
  final bool? int64AsString;

  const TronFullNodeRequestWalletListnodesGet({
    this.visible,
    this.int64AsString,
  });

  @override
  String? get path => '/wallet/listnodes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'visible': visible?.toString(),
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronNodeList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListnodesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListnodesGetNodeList(:final value) =>
        value.toNodeList(),
      TronHttpResponseWalletListnodesGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/listnodes
class TronFullNodeRequestWalletListnodesPost
    extends
        TronFullNodeRequest<protocol_api.TronNodeList, Map<String, dynamic>> {
  @override
  final bool? visible;

  const TronFullNodeRequestWalletListnodesPost({this.visible});

  @override
  String? get path => '/wallet/listnodes';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'visible': visible?.toString()};

  @override
  protocol_api.TronNodeList onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletListnodesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletListnodesGetNodeList(:final value) =>
        value.toNodeList(),
      TronHttpResponseWalletListnodesGetJavaTronError(:final value) => value,
    });
  }
}

/// GET /wallet/getenergyprices
class TronFullNodeRequestWalletGetenergypricesGet
    extends
        TronFullNodeRequest<
          protocol_api.TronPricesResponseMessage,
          Map<String, dynamic>
        > {
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetenergypricesGet({this.int64AsString});

  @override
  String? get path => '/wallet/getenergyprices';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronPricesResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetenergypricesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetenergypricesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getenergyprices
class TronFullNodeRequestWalletGetenergypricesPost
    extends
        TronFullNodeRequest<
          protocol_api.TronPricesResponseMessage,
          Map<String, dynamic>
        > {
  const TronFullNodeRequestWalletGetenergypricesPost();

  @override
  String? get path => '/wallet/getenergyprices';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  protocol_api.TronPricesResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetenergypricesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetenergypricesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getbandwidthprices
class TronFullNodeRequestWalletGetbandwidthpricesGet
    extends
        TronFullNodeRequest<
          protocol_api.TronPricesResponseMessage,
          Map<String, dynamic>
        > {
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetbandwidthpricesGet({this.int64AsString});

  @override
  String? get path => '/wallet/getbandwidthprices';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  protocol_api.TronPricesResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetenergypricesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetenergypricesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// POST /wallet/getbandwidthprices
class TronFullNodeRequestWalletGetbandwidthpricesPost
    extends
        TronFullNodeRequest<
          protocol_api.TronPricesResponseMessage,
          Map<String, dynamic>
        > {
  const TronFullNodeRequestWalletGetbandwidthpricesPost();

  @override
  String? get path => '/wallet/getbandwidthprices';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  protocol_api.TronPricesResponseMessage onResponse(
    Map<String, dynamic> result,
  ) {
    final r = TronHttpResponseWalletGetenergypricesGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetenergypricesGetPricesResponseMessage(
        :final value,
      ) =>
        value.toProtobuf(),
      TronHttpResponseWalletGetenergypricesGetJavaTronError(:final value) =>
        value,
    });
  }
}

/// GET /wallet/getburntrx
class TronFullNodeRequestWalletGetburntrxGet
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  final bool? int64AsString;

  const TronFullNodeRequestWalletGetburntrxGet({this.int64AsString});

  @override
  String? get path => '/wallet/getburntrx';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'int64_as_string': int64AsString?.toString(),
  };

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetburntrxGet.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetburntrxGetGetburntrxGetResultObject1(
        :final burnTrxAmount,
      ) =>
        burnTrxAmount ?? BigInt.zero,
      TronHttpResponseWalletGetburntrxGetJavaTronError(:final value) => value,
    });
  }
}

/// POST /wallet/getburntrx
class TronFullNodeRequestWalletGetburntrxPost
    extends TronFullNodeRequest<BigInt, Map<String, dynamic>> {
  const TronFullNodeRequestWalletGetburntrxPost();

  @override
  String? get path => '/wallet/getburntrx';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  BigInt onResponse(Map<String, dynamic> result) {
    final r = TronHttpResponseWalletGetburntrxPost.fromJson(result);
    return _mapResult(switch (r) {
      TronHttpResponseWalletGetburntrxPostGetburntrxPostResultObject1(
        :final burnTrxAmount,
      ) =>
        burnTrxAmount ?? BigInt.zero,
      TronHttpResponseWalletGetburntrxPostJavaTronError(:final value) => value,
    });
  }
}
