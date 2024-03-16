

import 'package:on_chain/global_types/provider_request.dart';

class TronHTTPMethods {
  final String uri;
  final HTTPRequestType requestType;
  bool get isPost => requestType == HTTPRequestType.post;
  const TronHTTPMethods._(this.uri, this.requestType);

  static const TronHTTPMethods validateaddress =
      TronHTTPMethods._("wallet/validateaddress", HTTPRequestType.post);
  static const TronHTTPMethods broadcasttransaction =
      TronHTTPMethods._("wallet/broadcasttransaction", HTTPRequestType.post);
  static const TronHTTPMethods broadcasthex =
      TronHTTPMethods._("wallet/broadcasthex", HTTPRequestType.post);
  static const TronHTTPMethods createtransaction =
      TronHTTPMethods._("wallet/createtransaction", HTTPRequestType.post);

  static const TronHTTPMethods createaccount =
      TronHTTPMethods._("wallet/createaccount", HTTPRequestType.post);
  static const TronHTTPMethods getaccount =
      TronHTTPMethods._("wallet/getaccount", HTTPRequestType.post);
  static const TronHTTPMethods updateaccount =
      TronHTTPMethods._("wallet/updateaccount", HTTPRequestType.post);

  static const TronHTTPMethods accountpermissionupdate =
      TronHTTPMethods._("wallet/accountpermissionupdate", HTTPRequestType.post);

  static const TronHTTPMethods getaccountbalance =
      TronHTTPMethods._("wallet/getaccountbalance", HTTPRequestType.post);
  static const TronHTTPMethods getaccountresource =
      TronHTTPMethods._("wallet/getaccountresource", HTTPRequestType.post);
  static const TronHTTPMethods getaccountnet =
      TronHTTPMethods._("wallet/getaccountnet", HTTPRequestType.post);
  static const TronHTTPMethods freezebalance =
      TronHTTPMethods._("wallet/freezebalance", HTTPRequestType.post);
  static const TronHTTPMethods unfreezebalance =
      TronHTTPMethods._("wallet/unfreezebalance", HTTPRequestType.post);
  static const TronHTTPMethods getdelegatedresource =
      TronHTTPMethods._("wallet/getdelegatedresource", HTTPRequestType.post);

  static const TronHTTPMethods getdelegatedresourceaccountindex =
      TronHTTPMethods._(
          "wallet/getdelegatedresourceaccountindex", HTTPRequestType.post);
  static const TronHTTPMethods freezebalancev2 =
      TronHTTPMethods._("wallet/freezebalancev2", HTTPRequestType.post);

  static const TronHTTPMethods unfreezebalancev2 =
      TronHTTPMethods._("wallet/unfreezebalancev2", HTTPRequestType.post);
  static const TronHTTPMethods cancelallunfreezev2 =
      TronHTTPMethods._("wallet/cancelallunfreezev2", HTTPRequestType.post);
  static const TronHTTPMethods delegateresource =
      TronHTTPMethods._("wallet/delegateresource", HTTPRequestType.post);
  static const TronHTTPMethods undelegateresource =
      TronHTTPMethods._("wallet/undelegateresource", HTTPRequestType.post);

  static const TronHTTPMethods withdrawexpireunfreeze =
      TronHTTPMethods._("wallet/withdrawexpireunfreeze", HTTPRequestType.post);
  static const TronHTTPMethods getavailableunfreezecount =
      TronHTTPMethods._("wallet/getavailableunfreezecount", HTTPRequestType.post);
  static const TronHTTPMethods getcanwithdrawunfreezeamount = TronHTTPMethods._(
      "wallet/getcanwithdrawunfreezeamount", HTTPRequestType.post);
  static const TronHTTPMethods getcandelegatedmaxsize =
      TronHTTPMethods._("wallet/getcandelegatedmaxsize", HTTPRequestType.post);
  static const TronHTTPMethods getdelegatedresourcev2 =
      TronHTTPMethods._("wallet/getdelegatedresourcev2", HTTPRequestType.post);
  static const TronHTTPMethods getdelegatedresourceaccountindexv2 =
      TronHTTPMethods._(
          "wallet/getdelegatedresourceaccountindexv2", HTTPRequestType.post);
  static const TronHTTPMethods getblock =
      TronHTTPMethods._("wallet/getblock", HTTPRequestType.post);
  static const TronHTTPMethods getblockbynum =
      TronHTTPMethods._("wallet/getblockbynum", HTTPRequestType.post);

  static const TronHTTPMethods getblockbyid =
      TronHTTPMethods._("wallet/getblockbyid", HTTPRequestType.post);
  static const TronHTTPMethods getblockbylatestnum =
      TronHTTPMethods._("wallet/getblockbylatestnum", HTTPRequestType.post);
  static const TronHTTPMethods getblockbylimitnext =
      TronHTTPMethods._("wallet/getblockbylimitnext", HTTPRequestType.post);
  static const TronHTTPMethods getnowblock =
      TronHTTPMethods._("wallet/getnowblock", HTTPRequestType.post);
  static const TronHTTPMethods gettransactionbyid =
      TronHTTPMethods._("wallet/gettransactionbyid", HTTPRequestType.post);

  static const TronHTTPMethods gettransactioninfobyid =
      TronHTTPMethods._("wallet/gettransactioninfobyid", HTTPRequestType.post);
  static const TronHTTPMethods gettransactioninfobyblocknum = TronHTTPMethods._(
      "wallet/gettransactioninfobyblocknum", HTTPRequestType.post);
  static const TronHTTPMethods listnodes =
      TronHTTPMethods._("wallet/listnodes", HTTPRequestType.get);
  static const TronHTTPMethods getnodeinfo =
      TronHTTPMethods._("wallet/getnodeinfo", HTTPRequestType.get);
  static const TronHTTPMethods getchainparameters =
      TronHTTPMethods._("wallet/getchainparameters", HTTPRequestType.get);
  static const TronHTTPMethods getblockbalance =
      TronHTTPMethods._("wallet/getblockbalance", HTTPRequestType.post);
  static const TronHTTPMethods getenergyprices =
      TronHTTPMethods._("wallet/getenergyprices", HTTPRequestType.get);
  static const TronHTTPMethods getbandwidthprices =
      TronHTTPMethods._("wallet/getbandwidthprices", HTTPRequestType.get);
  static const TronHTTPMethods getburntrx =
      TronHTTPMethods._("wallet/getburntrx", HTTPRequestType.get);
  static const TronHTTPMethods getapprovedlist =
      TronHTTPMethods._("wallet/getapprovedlist", HTTPRequestType.post);

  static const TronHTTPMethods getassetissuebyaccount =
      TronHTTPMethods._("wallet/getassetissuebyaccount", HTTPRequestType.post);
  static const TronHTTPMethods getassetissuebyid =
      TronHTTPMethods._("wallet/getassetissuebyid", HTTPRequestType.post);
  static const TronHTTPMethods getassetissuebyname =
      TronHTTPMethods._("wallet/getassetissuebyname", HTTPRequestType.post);
  static const TronHTTPMethods getassetissuelist =
      TronHTTPMethods._("wallet/getassetissuelist", HTTPRequestType.get);

  static const TronHTTPMethods getassetissuelistbyname =
      TronHTTPMethods._("wallet/getassetissuelistbyname", HTTPRequestType.post);
  static const TronHTTPMethods getpaginatedassetissuelist =
      TronHTTPMethods._("wallet/getpaginatedassetissuelist", HTTPRequestType.post);
  static const TronHTTPMethods transferasset =
      TronHTTPMethods._("wallet/transferasset", HTTPRequestType.post);
  static const TronHTTPMethods createassetissue =
      TronHTTPMethods._("wallet/createassetissue", HTTPRequestType.post);
  static const TronHTTPMethods participateassetissue =
      TronHTTPMethods._("wallet/participateassetissue", HTTPRequestType.post);
  static const TronHTTPMethods unfreezeasset =
      TronHTTPMethods._("wallet/unfreezeasset", HTTPRequestType.post);
  static const TronHTTPMethods updateasset =
      TronHTTPMethods._("wallet/updateasset", HTTPRequestType.post);

  static const TronHTTPMethods getcontract =
      TronHTTPMethods._("wallet/getcontract", HTTPRequestType.post);
  static const TronHTTPMethods getcontractinfo =
      TronHTTPMethods._("wallet/getcontractinfo", HTTPRequestType.post);

  ///
  static const TronHTTPMethods triggersmartcontract =
      TronHTTPMethods._("wallet/triggersmartcontract", HTTPRequestType.post);
  static const TronHTTPMethods triggerconstantcontract =
      TronHTTPMethods._("wallet/triggerconstantcontract", HTTPRequestType.post);
  static const TronHTTPMethods deploycontract =
      TronHTTPMethods._("wallet/deploycontract", HTTPRequestType.post);
  static const TronHTTPMethods updatesetting =
      TronHTTPMethods._("wallet/updatesetting", HTTPRequestType.post);
  static const TronHTTPMethods updateenergylimit =
      TronHTTPMethods._("wallet/updateenergylimit", HTTPRequestType.post);
  static const TronHTTPMethods clearabi =
      TronHTTPMethods._("wallet/clearabi", HTTPRequestType.post);
  static const TronHTTPMethods estimateenergy =
      TronHTTPMethods._("wallet/estimateenergy", HTTPRequestType.post);
  static const TronHTTPMethods getexpandedspendingkey =
      TronHTTPMethods._("wallet/getexpandedspendingkey", HTTPRequestType.post);

  static const TronHTTPMethods getakfromask =
      TronHTTPMethods._("wallet/getakfromask", HTTPRequestType.post);
  static const TronHTTPMethods getnkfromnsk =
      TronHTTPMethods._("wallet/getnkfromnsk", HTTPRequestType.post);
  static const TronHTTPMethods getincomingviewingkey =
      TronHTTPMethods._("wallet/getincomingviewingkey", HTTPRequestType.post);
  static const TronHTTPMethods getzenpaymentaddress =
      TronHTTPMethods._("wallet/getzenpaymentaddress", HTTPRequestType.post);
  static const TronHTTPMethods createshieldedcontractparameters =
      TronHTTPMethods._(
          "wallet/createshieldedcontractparameters", HTTPRequestType.post);
  static const TronHTTPMethods createspendauthsig =
      TronHTTPMethods._("wallet/createspendauthsig", HTTPRequestType.post);
  static const TronHTTPMethods gettriggerinputforshieldedtrc20contract =
      TronHTTPMethods._(
          "wallet/gettriggerinputforshieldedtrc20contract", HTTPRequestType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyivk =
      TronHTTPMethods._("wallet/scanshieldedtrc20notesbyivk", HTTPRequestType.post);
  static const TronHTTPMethods scanshieldedtrc20notesbyovk =
      TronHTTPMethods._("wallet/scanshieldedtrc20notesbyovk", HTTPRequestType.post);
  static const TronHTTPMethods isshieldedtrc20contractnotespent =
      TronHTTPMethods._(
          "wallet/isshieldedtrc20contractnotespent", HTTPRequestType.post);

  static const TronHTTPMethods getspendingkey =
      TronHTTPMethods._("wallet/getspendingkey", HTTPRequestType.get);

  static const TronHTTPMethods getdiversifier =
      TronHTTPMethods._("wallet/getdiversifier", HTTPRequestType.get);
  static const TronHTTPMethods getnewshieldedaddress =
      TronHTTPMethods._("wallet/getnewshieldedaddress", HTTPRequestType.get);

  static const TronHTTPMethods listwitnesses =
      TronHTTPMethods._("wallet/listwitnesses", HTTPRequestType.get);
  static const TronHTTPMethods getnextmaintenancetime =
      TronHTTPMethods._("wallet/getnextmaintenancetime", HTTPRequestType.get);

  static const TronHTTPMethods updatewitness =
      TronHTTPMethods._("wallet/updatewitness", HTTPRequestType.post);

  static const TronHTTPMethods getBrokerage =
      TronHTTPMethods._("wallet/getBrokerage", HTTPRequestType.post);

  static const TronHTTPMethods updateBrokerage =
      TronHTTPMethods._("wallet/updateBrokerage", HTTPRequestType.post);

  static const TronHTTPMethods votewitnessaccount =
      TronHTTPMethods._("wallet/votewitnessaccount", HTTPRequestType.post);
  static const TronHTTPMethods getReward =
      TronHTTPMethods._("wallet/getReward", HTTPRequestType.post);
  static const TronHTTPMethods withdrawbalance =
      TronHTTPMethods._("wallet/withdrawbalance", HTTPRequestType.post);
  static const TronHTTPMethods proposaldelete =
      TronHTTPMethods._("wallet/proposaldelete", HTTPRequestType.post);
  static const TronHTTPMethods proposalapprove =
      TronHTTPMethods._("wallet/proposalapprove", HTTPRequestType.post);

  static const TronHTTPMethods proposalcreate =
      TronHTTPMethods._("wallet/proposalcreate", HTTPRequestType.post);
  static const TronHTTPMethods getproposalbyid =
      TronHTTPMethods._("wallet/getproposalbyid", HTTPRequestType.post);

  static const TronHTTPMethods listproposals =
      TronHTTPMethods._("wallet/listproposals", HTTPRequestType.get);

  static const TronHTTPMethods listexchanges =
      TronHTTPMethods._("wallet/listexchanges", HTTPRequestType.get);

  static const TronHTTPMethods getexchangebyid =
      TronHTTPMethods._("wallet/getexchangebyid", HTTPRequestType.post);
  static const TronHTTPMethods exchangecreate =
      TronHTTPMethods._("wallet/exchangecreate", HTTPRequestType.post);
  static const TronHTTPMethods exchangeinject =
      TronHTTPMethods._("wallet/exchangeinject", HTTPRequestType.post);
  static const TronHTTPMethods exchangewithdraw =
      TronHTTPMethods._("wallet/exchangewithdraw", HTTPRequestType.post);
  static const TronHTTPMethods exchangetransaction =
      TronHTTPMethods._("wallet/exchangetransaction", HTTPRequestType.post);
  static const TronHTTPMethods gettransactionfrompending =
      TronHTTPMethods._("wallet/gettransactionfrompending", HTTPRequestType.post);

  static const TronHTTPMethods gettransactionlistfrompending =
      TronHTTPMethods._(
          "wallet/gettransactionlistfrompending", HTTPRequestType.get);

  static const TronHTTPMethods getpendingsize =
      TronHTTPMethods._("wallet/getpendingsize", HTTPRequestType.get);
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
