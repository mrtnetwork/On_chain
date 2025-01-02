import 'package:blockchain_utils/service/service.dart';

class TronHTTPMethods {
  final String uri;
  final RequestServiceType requestType;
  bool get isPost => requestType == RequestServiceType.post;
  const TronHTTPMethods._(this.uri, this.requestType);

  static const TronHTTPMethods validateaddress =
      TronHTTPMethods._('wallet/validateaddress', RequestServiceType.post);
  static const TronHTTPMethods broadcasttransaction =
      TronHTTPMethods._('wallet/broadcasttransaction', RequestServiceType.post);
  static const TronHTTPMethods broadcasthex =
      TronHTTPMethods._('wallet/broadcasthex', RequestServiceType.post);
  static const TronHTTPMethods createtransaction =
      TronHTTPMethods._('wallet/createtransaction', RequestServiceType.post);

  static const TronHTTPMethods createaccount =
      TronHTTPMethods._('wallet/createaccount', RequestServiceType.post);
  static const TronHTTPMethods getaccount =
      TronHTTPMethods._('wallet/getaccount', RequestServiceType.post);
  static const TronHTTPMethods updateaccount =
      TronHTTPMethods._('wallet/updateaccount', RequestServiceType.post);

  static const TronHTTPMethods accountpermissionupdate = TronHTTPMethods._(
      'wallet/accountpermissionupdate', RequestServiceType.post);

  static const TronHTTPMethods getaccountbalance =
      TronHTTPMethods._('wallet/getaccountbalance', RequestServiceType.post);
  static const TronHTTPMethods getaccountresource =
      TronHTTPMethods._('wallet/getaccountresource', RequestServiceType.post);
  static const TronHTTPMethods getaccountnet =
      TronHTTPMethods._('wallet/getaccountnet', RequestServiceType.post);
  static const TronHTTPMethods freezebalance =
      TronHTTPMethods._('wallet/freezebalance', RequestServiceType.post);
  static const TronHTTPMethods unfreezebalance =
      TronHTTPMethods._('wallet/unfreezebalance', RequestServiceType.post);
  static const TronHTTPMethods getdelegatedresource =
      TronHTTPMethods._('wallet/getdelegatedresource', RequestServiceType.post);

  static const TronHTTPMethods getdelegatedresourceaccountindex =
      TronHTTPMethods._(
          'wallet/getdelegatedresourceaccountindex', RequestServiceType.post);
  static const TronHTTPMethods freezebalancev2 =
      TronHTTPMethods._('wallet/freezebalancev2', RequestServiceType.post);

  static const TronHTTPMethods unfreezebalancev2 =
      TronHTTPMethods._('wallet/unfreezebalancev2', RequestServiceType.post);
  static const TronHTTPMethods cancelallunfreezev2 =
      TronHTTPMethods._('wallet/cancelallunfreezev2', RequestServiceType.post);
  static const TronHTTPMethods delegateresource =
      TronHTTPMethods._('wallet/delegateresource', RequestServiceType.post);
  static const TronHTTPMethods undelegateresource =
      TronHTTPMethods._('wallet/undelegateresource', RequestServiceType.post);

  static const TronHTTPMethods withdrawexpireunfreeze = TronHTTPMethods._(
      'wallet/withdrawexpireunfreeze', RequestServiceType.post);
  static const TronHTTPMethods getavailableunfreezecount = TronHTTPMethods._(
      'wallet/getavailableunfreezecount', RequestServiceType.post);
  static const TronHTTPMethods getcanwithdrawunfreezeamount = TronHTTPMethods._(
      'wallet/getcanwithdrawunfreezeamount', RequestServiceType.post);
  static const TronHTTPMethods getcandelegatedmaxsize = TronHTTPMethods._(
      'wallet/getcandelegatedmaxsize', RequestServiceType.post);
  static const TronHTTPMethods getdelegatedresourcev2 = TronHTTPMethods._(
      'wallet/getdelegatedresourcev2', RequestServiceType.post);
  static const TronHTTPMethods getdelegatedresourceaccountindexv2 =
      TronHTTPMethods._(
          'wallet/getdelegatedresourceaccountindexv2', RequestServiceType.post);
  static const TronHTTPMethods getblock =
      TronHTTPMethods._('wallet/getblock', RequestServiceType.post);
  static const TronHTTPMethods getblockbynum =
      TronHTTPMethods._('wallet/getblockbynum', RequestServiceType.post);

  static const TronHTTPMethods getblockbyid =
      TronHTTPMethods._('wallet/getblockbyid', RequestServiceType.post);
  static const TronHTTPMethods getblockbylatestnum =
      TronHTTPMethods._('wallet/getblockbylatestnum', RequestServiceType.post);
  static const TronHTTPMethods getblockbylimitnext =
      TronHTTPMethods._('wallet/getblockbylimitnext', RequestServiceType.post);
  static const TronHTTPMethods getnowblock =
      TronHTTPMethods._('wallet/getnowblock', RequestServiceType.post);
  static const TronHTTPMethods gettransactionbyid =
      TronHTTPMethods._('wallet/gettransactionbyid', RequestServiceType.post);

  static const TronHTTPMethods gettransactioninfobyid = TronHTTPMethods._(
      'wallet/gettransactioninfobyid', RequestServiceType.post);
  static const TronHTTPMethods gettransactioninfobyblocknum = TronHTTPMethods._(
      'wallet/gettransactioninfobyblocknum', RequestServiceType.post);
  static const TronHTTPMethods listnodes =
      TronHTTPMethods._('wallet/listnodes', RequestServiceType.get);
  static const TronHTTPMethods getnodeinfo =
      TronHTTPMethods._('wallet/getnodeinfo', RequestServiceType.get);
  static const TronHTTPMethods getchainparameters =
      TronHTTPMethods._('wallet/getchainparameters', RequestServiceType.get);
  static const TronHTTPMethods getblockbalance =
      TronHTTPMethods._('wallet/getblockbalance', RequestServiceType.post);
  static const TronHTTPMethods getenergyprices =
      TronHTTPMethods._('wallet/getenergyprices', RequestServiceType.get);
  static const TronHTTPMethods getbandwidthprices =
      TronHTTPMethods._('wallet/getbandwidthprices', RequestServiceType.get);
  static const TronHTTPMethods getburntrx =
      TronHTTPMethods._('wallet/getburntrx', RequestServiceType.get);
  static const TronHTTPMethods getapprovedlist =
      TronHTTPMethods._('wallet/getapprovedlist', RequestServiceType.post);

  static const TronHTTPMethods getassetissuebyaccount = TronHTTPMethods._(
      'wallet/getassetissuebyaccount', RequestServiceType.post);
  static const TronHTTPMethods getassetissuebyid =
      TronHTTPMethods._('wallet/getassetissuebyid', RequestServiceType.post);
  static const TronHTTPMethods getassetissuebyname =
      TronHTTPMethods._('wallet/getassetissuebyname', RequestServiceType.post);
  static const TronHTTPMethods getassetissuelist =
      TronHTTPMethods._('wallet/getassetissuelist', RequestServiceType.get);

  static const TronHTTPMethods getassetissuelistbyname = TronHTTPMethods._(
      'wallet/getassetissuelistbyname', RequestServiceType.post);
  static const TronHTTPMethods getpaginatedassetissuelist = TronHTTPMethods._(
      'wallet/getpaginatedassetissuelist', RequestServiceType.post);
  static const TronHTTPMethods transferasset =
      TronHTTPMethods._('wallet/transferasset', RequestServiceType.post);
  static const TronHTTPMethods createassetissue =
      TronHTTPMethods._('wallet/createassetissue', RequestServiceType.post);
  static const TronHTTPMethods participateassetissue = TronHTTPMethods._(
      'wallet/participateassetissue', RequestServiceType.post);
  static const TronHTTPMethods unfreezeasset =
      TronHTTPMethods._('wallet/unfreezeasset', RequestServiceType.post);
  static const TronHTTPMethods updateasset =
      TronHTTPMethods._('wallet/updateasset', RequestServiceType.post);

  static const TronHTTPMethods getcontract =
      TronHTTPMethods._('wallet/getcontract', RequestServiceType.post);
  static const TronHTTPMethods getcontractinfo =
      TronHTTPMethods._('wallet/getcontractinfo', RequestServiceType.post);

  ///
  static const TronHTTPMethods triggersmartcontract =
      TronHTTPMethods._('wallet/triggersmartcontract', RequestServiceType.post);
  static const TronHTTPMethods triggerconstantcontract = TronHTTPMethods._(
      'wallet/triggerconstantcontract', RequestServiceType.post);
  static const TronHTTPMethods deploycontract =
      TronHTTPMethods._('wallet/deploycontract', RequestServiceType.post);
  static const TronHTTPMethods updatesetting =
      TronHTTPMethods._('wallet/updatesetting', RequestServiceType.post);
  static const TronHTTPMethods updateenergylimit =
      TronHTTPMethods._('wallet/updateenergylimit', RequestServiceType.post);
  static const TronHTTPMethods clearabi =
      TronHTTPMethods._('wallet/clearabi', RequestServiceType.post);
  static const TronHTTPMethods estimateenergy =
      TronHTTPMethods._('wallet/estimateenergy', RequestServiceType.post);
  static const TronHTTPMethods getexpandedspendingkey = TronHTTPMethods._(
      'wallet/getexpandedspendingkey', RequestServiceType.post);

  static const TronHTTPMethods getakfromask =
      TronHTTPMethods._('wallet/getakfromask', RequestServiceType.post);
  static const TronHTTPMethods getnkfromnsk =
      TronHTTPMethods._('wallet/getnkfromnsk', RequestServiceType.post);
  static const TronHTTPMethods getincomingviewingkey = TronHTTPMethods._(
      'wallet/getincomingviewingkey', RequestServiceType.post);
  static const TronHTTPMethods getzenpaymentaddress =
      TronHTTPMethods._('wallet/getzenpaymentaddress', RequestServiceType.post);
  static const TronHTTPMethods createshieldedcontractparameters =
      TronHTTPMethods._(
          'wallet/createshieldedcontractparameters', RequestServiceType.post);
  static const TronHTTPMethods createspendauthsig =
      TronHTTPMethods._('wallet/createspendauthsig', RequestServiceType.post);
  static const TronHTTPMethods gettriggerinputforshieldedtrc20contract =
      TronHTTPMethods._('wallet/gettriggerinputforshieldedtrc20contract',
          RequestServiceType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyivk = TronHTTPMethods._(
      'wallet/scanshieldedtrc20notesbyivk', RequestServiceType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyovk = TronHTTPMethods._(
      'wallet/scanshieldedtrc20notesbyovk', RequestServiceType.post);
  static const TronHTTPMethods isshieldedtrc20contractnotespent =
      TronHTTPMethods._(
          'wallet/isshieldedtrc20contractnotespent', RequestServiceType.post);

  static const TronHTTPMethods getspendingkey =
      TronHTTPMethods._('wallet/getspendingkey', RequestServiceType.get);

  static const TronHTTPMethods getdiversifier =
      TronHTTPMethods._('wallet/getdiversifier', RequestServiceType.get);
  static const TronHTTPMethods getnewshieldedaddress =
      TronHTTPMethods._('wallet/getnewshieldedaddress', RequestServiceType.get);

  static const TronHTTPMethods listwitnesses =
      TronHTTPMethods._('wallet/listwitnesses', RequestServiceType.get);
  static const TronHTTPMethods getnextmaintenancetime = TronHTTPMethods._(
      'wallet/getnextmaintenancetime', RequestServiceType.get);

  static const TronHTTPMethods updatewitness =
      TronHTTPMethods._('wallet/updatewitness', RequestServiceType.post);

  static const TronHTTPMethods getBrokerage =
      TronHTTPMethods._('wallet/getBrokerage', RequestServiceType.post);

  static const TronHTTPMethods updateBrokerage =
      TronHTTPMethods._('wallet/updateBrokerage', RequestServiceType.post);

  static const TronHTTPMethods votewitnessaccount =
      TronHTTPMethods._('wallet/votewitnessaccount', RequestServiceType.post);
  static const TronHTTPMethods getReward =
      TronHTTPMethods._('wallet/getReward', RequestServiceType.post);
  static const TronHTTPMethods withdrawbalance =
      TronHTTPMethods._('wallet/withdrawbalance', RequestServiceType.post);
  static const TronHTTPMethods proposaldelete =
      TronHTTPMethods._('wallet/proposaldelete', RequestServiceType.post);
  static const TronHTTPMethods proposalapprove =
      TronHTTPMethods._('wallet/proposalapprove', RequestServiceType.post);

  static const TronHTTPMethods proposalcreate =
      TronHTTPMethods._('wallet/proposalcreate', RequestServiceType.post);
  static const TronHTTPMethods getproposalbyid =
      TronHTTPMethods._('wallet/getproposalbyid', RequestServiceType.post);

  static const TronHTTPMethods listproposals =
      TronHTTPMethods._('wallet/listproposals', RequestServiceType.get);

  static const TronHTTPMethods listexchanges =
      TronHTTPMethods._('wallet/listexchanges', RequestServiceType.get);

  static const TronHTTPMethods getexchangebyid =
      TronHTTPMethods._('wallet/getexchangebyid', RequestServiceType.post);
  static const TronHTTPMethods exchangecreate =
      TronHTTPMethods._('wallet/exchangecreate', RequestServiceType.post);
  static const TronHTTPMethods exchangeinject =
      TronHTTPMethods._('wallet/exchangeinject', RequestServiceType.post);
  static const TronHTTPMethods exchangewithdraw =
      TronHTTPMethods._('wallet/exchangewithdraw', RequestServiceType.post);
  static const TronHTTPMethods exchangetransaction =
      TronHTTPMethods._('wallet/exchangetransaction', RequestServiceType.post);
  static const TronHTTPMethods gettransactionfrompending = TronHTTPMethods._(
      'wallet/gettransactionfrompending', RequestServiceType.post);

  static const TronHTTPMethods gettransactionlistfrompending =
      TronHTTPMethods._(
          'wallet/gettransactionlistfrompending', RequestServiceType.get);

  static const TronHTTPMethods getpendingsize =
      TronHTTPMethods._('wallet/getpendingsize', RequestServiceType.get);
  static const List<TronHTTPMethods> values = [
    validateaddress,
    broadcasttransaction,
    broadcasthex,
    createtransaction,
    createaccount,
    getaccount,
    updateaccount,
    accountpermissionupdate,
    getaccountbalance,
    getaccountresource,
    getaccountnet,
    freezebalance,
    unfreezebalance,
    getdelegatedresource,
    getdelegatedresourceaccountindex,
    freezebalancev2,
    unfreezebalancev2,
    cancelallunfreezev2,
    delegateresource,
    undelegateresource,
    withdrawexpireunfreeze,
    getavailableunfreezecount,
    getcanwithdrawunfreezeamount,
    getcandelegatedmaxsize,
    getdelegatedresourcev2,
    getdelegatedresourceaccountindexv2,
    getblock,
    getblockbynum,
    getblockbyid,
    getblockbylatestnum,
    getblockbylimitnext,
    getnowblock,
    gettransactionbyid,
    gettransactioninfobyid,
    gettransactioninfobyblocknum,
    listnodes,
    getnodeinfo,
    getchainparameters,
    getenergyprices,
    getbandwidthprices,
    getburntrx,
    getapprovedlist,
    getassetissuebyaccount,
    getassetissuebyid,
    getassetissuebyname,
    getassetissuelist,
    getassetissuelistbyname,
    getpaginatedassetissuelist,
    transferasset,
    createassetissue,
    participateassetissue,
    unfreezeasset,
    updateasset,
    getcontract,
    getcontractinfo,
    triggersmartcontract,
    triggerconstantcontract,
    deploycontract,
    updatesetting,
    updateenergylimit,
    clearabi,
    estimateenergy,
    getexpandedspendingkey,
    getakfromask,
    getnkfromnsk,
    getincomingviewingkey,
    getzenpaymentaddress,
    createshieldedcontractparameters,
    createspendauthsig,
    gettriggerinputforshieldedtrc20contract,
    scanshieldedtrc20notesbyivk,
    scanshieldedtrc20notesbyovk,
    isshieldedtrc20contractnotespent,
    getspendingkey,
    getdiversifier,
    getnewshieldedaddress,
    listwitnesses,
    getnextmaintenancetime,
    updatewitness,
    getBrokerage,
    updateBrokerage,
    votewitnessaccount,
    getReward,
    withdrawbalance,
    proposaldelete,
    proposalapprove,
    proposalcreate,
    getproposalbyid,
    listproposals,
    listexchanges,
    getexchangebyid,
    exchangecreate,
    exchangeinject,
    exchangewithdraw,
    exchangetransaction,
    gettransactionfrompending,
    gettransactionlistfrompending,
    getpendingsize,
    getblockbalance
  ];
}
