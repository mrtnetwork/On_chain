enum RequestType { post, get }

class TronHTTPMethods {
  final String uri;
  final RequestType requestType;
  bool get isPost => requestType == RequestType.post;
  const TronHTTPMethods._(this.uri, this.requestType);

  static const TronHTTPMethods validateaddress =
      TronHTTPMethods._("wallet/validateaddress", RequestType.post);
  static const TronHTTPMethods broadcasttransaction =
      TronHTTPMethods._("wallet/broadcasttransaction", RequestType.post);
  static const TronHTTPMethods broadcasthex =
      TronHTTPMethods._("wallet/broadcasthex", RequestType.post);
  static const TronHTTPMethods createtransaction =
      TronHTTPMethods._("wallet/createtransaction", RequestType.post);

  static const TronHTTPMethods createaccount =
      TronHTTPMethods._("wallet/createaccount", RequestType.post);
  static const TronHTTPMethods getaccount =
      TronHTTPMethods._("wallet/getaccount", RequestType.post);
  static const TronHTTPMethods updateaccount =
      TronHTTPMethods._("wallet/updateaccount", RequestType.post);

  static const TronHTTPMethods accountpermissionupdate =
      TronHTTPMethods._("wallet/accountpermissionupdate", RequestType.post);

  static const TronHTTPMethods getaccountbalance =
      TronHTTPMethods._("wallet/getaccountbalance", RequestType.post);
  static const TronHTTPMethods getaccountresource =
      TronHTTPMethods._("wallet/getaccountresource", RequestType.post);
  static const TronHTTPMethods getaccountnet =
      TronHTTPMethods._("wallet/getaccountnet", RequestType.post);
  static const TronHTTPMethods freezebalance =
      TronHTTPMethods._("wallet/freezebalance", RequestType.post);
  static const TronHTTPMethods unfreezebalance =
      TronHTTPMethods._("wallet/unfreezebalance", RequestType.post);
  static const TronHTTPMethods getdelegatedresource =
      TronHTTPMethods._("wallet/getdelegatedresource", RequestType.post);

  static const TronHTTPMethods getdelegatedresourceaccountindex =
      TronHTTPMethods._(
          "wallet/getdelegatedresourceaccountindex", RequestType.post);
  static const TronHTTPMethods freezebalancev2 =
      TronHTTPMethods._("wallet/freezebalancev2", RequestType.post);

  static const TronHTTPMethods unfreezebalancev2 =
      TronHTTPMethods._("wallet/unfreezebalancev2", RequestType.post);
  static const TronHTTPMethods cancelallunfreezev2 =
      TronHTTPMethods._("wallet/cancelallunfreezev2", RequestType.post);
  static const TronHTTPMethods delegateresource =
      TronHTTPMethods._("wallet/delegateresource", RequestType.post);
  static const TronHTTPMethods undelegateresource =
      TronHTTPMethods._("wallet/undelegateresource", RequestType.post);

  static const TronHTTPMethods withdrawexpireunfreeze =
      TronHTTPMethods._("wallet/withdrawexpireunfreeze", RequestType.post);
  static const TronHTTPMethods getavailableunfreezecount =
      TronHTTPMethods._("wallet/getavailableunfreezecount", RequestType.post);
  static const TronHTTPMethods getcanwithdrawunfreezeamount = TronHTTPMethods._(
      "wallet/getcanwithdrawunfreezeamount", RequestType.post);
  static const TronHTTPMethods getcandelegatedmaxsize =
      TronHTTPMethods._("wallet/getcandelegatedmaxsize", RequestType.post);
  static const TronHTTPMethods getdelegatedresourcev2 =
      TronHTTPMethods._("wallet/getdelegatedresourcev2", RequestType.post);
  static const TronHTTPMethods getdelegatedresourceaccountindexv2 =
      TronHTTPMethods._(
          "wallet/getdelegatedresourceaccountindexv2", RequestType.post);
  static const TronHTTPMethods getblock =
      TronHTTPMethods._("wallet/getblock", RequestType.post);
  static const TronHTTPMethods getblockbynum =
      TronHTTPMethods._("wallet/getblockbynum", RequestType.post);

  static const TronHTTPMethods getblockbyid =
      TronHTTPMethods._("wallet/getblockbyid", RequestType.post);
  static const TronHTTPMethods getblockbylatestnum =
      TronHTTPMethods._("wallet/getblockbylatestnum", RequestType.post);
  static const TronHTTPMethods getblockbylimitnext =
      TronHTTPMethods._("wallet/getblockbylimitnext", RequestType.post);
  static const TronHTTPMethods getnowblock =
      TronHTTPMethods._("wallet/getnowblock", RequestType.post);
  static const TronHTTPMethods gettransactionbyid =
      TronHTTPMethods._("wallet/gettransactionbyid", RequestType.post);

  static const TronHTTPMethods gettransactioninfobyid =
      TronHTTPMethods._("wallet/gettransactioninfobyid", RequestType.post);
  static const TronHTTPMethods gettransactioninfobyblocknum = TronHTTPMethods._(
      "wallet/gettransactioninfobyblocknum", RequestType.post);
  static const TronHTTPMethods listnodes =
      TronHTTPMethods._("wallet/listnodes", RequestType.get);
  static const TronHTTPMethods getnodeinfo =
      TronHTTPMethods._("wallet/getnodeinfo", RequestType.get);
  static const TronHTTPMethods getchainparameters =
      TronHTTPMethods._("wallet/getchainparameters", RequestType.get);
  static const TronHTTPMethods getblockbalance =
      TronHTTPMethods._("wallet/getblockbalance", RequestType.post);
  static const TronHTTPMethods getenergyprices =
      TronHTTPMethods._("wallet/getenergyprices", RequestType.get);
  static const TronHTTPMethods getbandwidthprices =
      TronHTTPMethods._("wallet/getbandwidthprices", RequestType.get);
  static const TronHTTPMethods getburntrx =
      TronHTTPMethods._("wallet/getburntrx", RequestType.get);
  static const TronHTTPMethods getapprovedlist =
      TronHTTPMethods._("wallet/getapprovedlist", RequestType.post);

  static const TronHTTPMethods getassetissuebyaccount =
      TronHTTPMethods._("wallet/getassetissuebyaccount", RequestType.post);
  static const TronHTTPMethods getassetissuebyid =
      TronHTTPMethods._("wallet/getassetissuebyid", RequestType.post);
  static const TronHTTPMethods getassetissuebyname =
      TronHTTPMethods._("wallet/getassetissuebyname", RequestType.post);
  static const TronHTTPMethods getassetissuelist =
      TronHTTPMethods._("wallet/getassetissuelist", RequestType.get);

  static const TronHTTPMethods getassetissuelistbyname =
      TronHTTPMethods._("wallet/getassetissuelistbyname", RequestType.post);
  static const TronHTTPMethods getpaginatedassetissuelist =
      TronHTTPMethods._("wallet/getpaginatedassetissuelist", RequestType.post);
  static const TronHTTPMethods transferasset =
      TronHTTPMethods._("wallet/transferasset", RequestType.post);
  static const TronHTTPMethods createassetissue =
      TronHTTPMethods._("wallet/createassetissue", RequestType.post);
  static const TronHTTPMethods participateassetissue =
      TronHTTPMethods._("wallet/participateassetissue", RequestType.post);
  static const TronHTTPMethods unfreezeasset =
      TronHTTPMethods._("wallet/unfreezeasset", RequestType.post);
  static const TronHTTPMethods updateasset =
      TronHTTPMethods._("wallet/updateasset", RequestType.post);

  static const TronHTTPMethods getcontract =
      TronHTTPMethods._("wallet/getcontract", RequestType.post);
  static const TronHTTPMethods getcontractinfo =
      TronHTTPMethods._("wallet/getcontractinfo", RequestType.post);

  ///
  static const TronHTTPMethods triggersmartcontract =
      TronHTTPMethods._("wallet/triggersmartcontract", RequestType.post);
  static const TronHTTPMethods triggerconstantcontract =
      TronHTTPMethods._("wallet/triggerconstantcontract", RequestType.post);
  static const TronHTTPMethods deploycontract =
      TronHTTPMethods._("wallet/deploycontract", RequestType.post);
  static const TronHTTPMethods updatesetting =
      TronHTTPMethods._("wallet/updatesetting", RequestType.post);
  static const TronHTTPMethods updateenergylimit =
      TronHTTPMethods._("wallet/updateenergylimit", RequestType.post);
  static const TronHTTPMethods clearabi =
      TronHTTPMethods._("wallet/clearabi", RequestType.post);
  static const TronHTTPMethods estimateenergy =
      TronHTTPMethods._("wallet/estimateenergy", RequestType.post);
  static const TronHTTPMethods getexpandedspendingkey =
      TronHTTPMethods._("wallet/getexpandedspendingkey", RequestType.post);

  static const TronHTTPMethods getakfromask =
      TronHTTPMethods._("wallet/getakfromask", RequestType.post);
  static const TronHTTPMethods getnkfromnsk =
      TronHTTPMethods._("wallet/getnkfromnsk", RequestType.post);
  static const TronHTTPMethods getincomingviewingkey =
      TronHTTPMethods._("wallet/getincomingviewingkey", RequestType.post);
  static const TronHTTPMethods getzenpaymentaddress =
      TronHTTPMethods._("wallet/getzenpaymentaddress", RequestType.post);
  static const TronHTTPMethods createshieldedcontractparameters =
      TronHTTPMethods._(
          "wallet/createshieldedcontractparameters", RequestType.post);
  static const TronHTTPMethods createspendauthsig =
      TronHTTPMethods._("wallet/createspendauthsig", RequestType.post);
  static const TronHTTPMethods gettriggerinputforshieldedtrc20contract =
      TronHTTPMethods._(
          "wallet/gettriggerinputforshieldedtrc20contract", RequestType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyivk =
      TronHTTPMethods._("wallet/scanshieldedtrc20notesbyivk", RequestType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyovk =
      TronHTTPMethods._("wallet/scanshieldedtrc20notesbyovk", RequestType.post);
  static const TronHTTPMethods isshieldedtrc20contractnotespent =
      TronHTTPMethods._(
          "wallet/isshieldedtrc20contractnotespent", RequestType.post);

  static const TronHTTPMethods getspendingkey =
      TronHTTPMethods._("wallet/getspendingkey", RequestType.get);

  static const TronHTTPMethods getdiversifier =
      TronHTTPMethods._("wallet/getdiversifier", RequestType.get);
  static const TronHTTPMethods getnewshieldedaddress =
      TronHTTPMethods._("wallet/getnewshieldedaddress", RequestType.get);

  static const TronHTTPMethods listwitnesses =
      TronHTTPMethods._("wallet/listwitnesses", RequestType.get);
  static const TronHTTPMethods getnextmaintenancetime =
      TronHTTPMethods._("wallet/getnextmaintenancetime", RequestType.get);

  static const TronHTTPMethods updatewitness =
      TronHTTPMethods._("wallet/updatewitness", RequestType.post);

  static const TronHTTPMethods getBrokerage =
      TronHTTPMethods._("wallet/getBrokerage", RequestType.post);

  static const TronHTTPMethods updateBrokerage =
      TronHTTPMethods._("wallet/updateBrokerage", RequestType.post);

  static const TronHTTPMethods votewitnessaccount =
      TronHTTPMethods._("wallet/votewitnessaccount", RequestType.post);
  static const TronHTTPMethods getReward =
      TronHTTPMethods._("wallet/getReward", RequestType.post);
  static const TronHTTPMethods withdrawbalance =
      TronHTTPMethods._("wallet/withdrawbalance", RequestType.post);
  static const TronHTTPMethods proposaldelete =
      TronHTTPMethods._("wallet/proposaldelete", RequestType.post);
  static const TronHTTPMethods proposalapprove =
      TronHTTPMethods._("wallet/proposalapprove", RequestType.post);

  static const TronHTTPMethods proposalcreate =
      TronHTTPMethods._("wallet/proposalcreate", RequestType.post);
  static const TronHTTPMethods getproposalbyid =
      TronHTTPMethods._("wallet/getproposalbyid", RequestType.post);

  static const TronHTTPMethods listproposals =
      TronHTTPMethods._("wallet/listproposals", RequestType.get);

  static const TronHTTPMethods listexchanges =
      TronHTTPMethods._("wallet/listexchanges", RequestType.get);

  static const TronHTTPMethods getexchangebyid =
      TronHTTPMethods._("wallet/getexchangebyid", RequestType.post);
  static const TronHTTPMethods exchangecreate =
      TronHTTPMethods._("wallet/exchangecreate", RequestType.post);
  static const TronHTTPMethods exchangeinject =
      TronHTTPMethods._("wallet/exchangeinject", RequestType.post);
  static const TronHTTPMethods exchangewithdraw =
      TronHTTPMethods._("wallet/exchangewithdraw", RequestType.post);
  static const TronHTTPMethods exchangetransaction =
      TronHTTPMethods._("wallet/exchangetransaction", RequestType.post);
  static const TronHTTPMethods gettransactionfrompending =
      TronHTTPMethods._("wallet/gettransactionfrompending", RequestType.post);

  static const TronHTTPMethods gettransactionlistfrompending =
      TronHTTPMethods._(
          "wallet/gettransactionlistfrompending", RequestType.get);

  static const TronHTTPMethods getpendingsize =
      TronHTTPMethods._("wallet/getpendingsize", RequestType.get);
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
