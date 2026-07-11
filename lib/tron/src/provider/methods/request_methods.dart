import 'package:blockchain_utils/service/service.dart';

class TronHTTPMethods {
  final String uri;
  final RequestMethod requestType;
  bool get isPost => requestType == RequestMethod.post;
  const TronHTTPMethods._(this.uri, this.requestType);

  static const TronHTTPMethods validateaddress = TronHTTPMethods._(
    'wallet/validateaddress',
    RequestMethod.post,
  );
  static const TronHTTPMethods broadcasttransaction = TronHTTPMethods._(
    'wallet/broadcasttransaction',
    RequestMethod.post,
  );
  static const TronHTTPMethods broadcasthex = TronHTTPMethods._(
    'wallet/broadcasthex',
    RequestMethod.post,
  );
  static const TronHTTPMethods createtransaction = TronHTTPMethods._(
    'wallet/createtransaction',
    RequestMethod.post,
  );

  static const TronHTTPMethods createaccount = TronHTTPMethods._(
    'wallet/createaccount',
    RequestMethod.post,
  );
  static const TronHTTPMethods getaccount = TronHTTPMethods._(
    'wallet/getaccount',
    RequestMethod.post,
  );
  static const TronHTTPMethods updateaccount = TronHTTPMethods._(
    'wallet/updateaccount',
    RequestMethod.post,
  );

  static const TronHTTPMethods accountpermissionupdate = TronHTTPMethods._(
    'wallet/accountpermissionupdate',
    RequestMethod.post,
  );

  static const TronHTTPMethods getaccountbalance = TronHTTPMethods._(
    'wallet/getaccountbalance',
    RequestMethod.post,
  );
  static const TronHTTPMethods getaccountresource = TronHTTPMethods._(
    'wallet/getaccountresource',
    RequestMethod.post,
  );
  static const TronHTTPMethods getaccountnet = TronHTTPMethods._(
    'wallet/getaccountnet',
    RequestMethod.post,
  );
  static const TronHTTPMethods freezebalance = TronHTTPMethods._(
    'wallet/freezebalance',
    RequestMethod.post,
  );
  static const TronHTTPMethods unfreezebalance = TronHTTPMethods._(
    'wallet/unfreezebalance',
    RequestMethod.post,
  );
  static const TronHTTPMethods getdelegatedresource = TronHTTPMethods._(
    'wallet/getdelegatedresource',
    RequestMethod.post,
  );

  static const TronHTTPMethods getdelegatedresourceaccountindex =
      TronHTTPMethods._(
        'wallet/getdelegatedresourceaccountindex',
        RequestMethod.post,
      );
  static const TronHTTPMethods freezebalancev2 = TronHTTPMethods._(
    'wallet/freezebalancev2',
    RequestMethod.post,
  );

  static const TronHTTPMethods unfreezebalancev2 = TronHTTPMethods._(
    'wallet/unfreezebalancev2',
    RequestMethod.post,
  );
  static const TronHTTPMethods cancelallunfreezev2 = TronHTTPMethods._(
    'wallet/cancelallunfreezev2',
    RequestMethod.post,
  );
  static const TronHTTPMethods delegateresource = TronHTTPMethods._(
    'wallet/delegateresource',
    RequestMethod.post,
  );
  static const TronHTTPMethods undelegateresource = TronHTTPMethods._(
    'wallet/undelegateresource',
    RequestMethod.post,
  );

  static const TronHTTPMethods withdrawexpireunfreeze = TronHTTPMethods._(
    'wallet/withdrawexpireunfreeze',
    RequestMethod.post,
  );
  static const TronHTTPMethods getavailableunfreezecount = TronHTTPMethods._(
    'wallet/getavailableunfreezecount',
    RequestMethod.post,
  );
  static const TronHTTPMethods getcanwithdrawunfreezeamount = TronHTTPMethods._(
    'wallet/getcanwithdrawunfreezeamount',
    RequestMethod.post,
  );
  static const TronHTTPMethods getcandelegatedmaxsize = TronHTTPMethods._(
    'wallet/getcandelegatedmaxsize',
    RequestMethod.post,
  );
  static const TronHTTPMethods getdelegatedresourcev2 = TronHTTPMethods._(
    'wallet/getdelegatedresourcev2',
    RequestMethod.post,
  );
  static const TronHTTPMethods getdelegatedresourceaccountindexv2 =
      TronHTTPMethods._(
        'wallet/getdelegatedresourceaccountindexv2',
        RequestMethod.post,
      );
  static const TronHTTPMethods getblock = TronHTTPMethods._(
    'wallet/getblock',
    RequestMethod.post,
  );
  static const TronHTTPMethods getblockbynum = TronHTTPMethods._(
    'wallet/getblockbynum',
    RequestMethod.post,
  );

  static const TronHTTPMethods getblockbyid = TronHTTPMethods._(
    'wallet/getblockbyid',
    RequestMethod.post,
  );
  static const TronHTTPMethods getblockbylatestnum = TronHTTPMethods._(
    'wallet/getblockbylatestnum',
    RequestMethod.post,
  );
  static const TronHTTPMethods getblockbylimitnext = TronHTTPMethods._(
    'wallet/getblockbylimitnext',
    RequestMethod.post,
  );
  static const TronHTTPMethods getnowblock = TronHTTPMethods._(
    'wallet/getnowblock',
    RequestMethod.post,
  );
  static const TronHTTPMethods gettransactionbyid = TronHTTPMethods._(
    'wallet/gettransactionbyid',
    RequestMethod.post,
  );

  static const TronHTTPMethods gettransactioninfobyid = TronHTTPMethods._(
    'wallet/gettransactioninfobyid',
    RequestMethod.post,
  );
  static const TronHTTPMethods gettransactioninfobyblocknum = TronHTTPMethods._(
    'wallet/gettransactioninfobyblocknum',
    RequestMethod.post,
  );
  static const TronHTTPMethods listnodes = TronHTTPMethods._(
    'wallet/listnodes',
    RequestMethod.get,
  );
  static const TronHTTPMethods getnodeinfo = TronHTTPMethods._(
    'wallet/getnodeinfo',
    RequestMethod.get,
  );
  static const TronHTTPMethods getchainparameters = TronHTTPMethods._(
    'wallet/getchainparameters',
    RequestMethod.get,
  );
  static const TronHTTPMethods getblockbalance = TronHTTPMethods._(
    'wallet/getblockbalance',
    RequestMethod.post,
  );
  static const TronHTTPMethods getenergyprices = TronHTTPMethods._(
    'wallet/getenergyprices',
    RequestMethod.get,
  );
  static const TronHTTPMethods getbandwidthprices = TronHTTPMethods._(
    'wallet/getbandwidthprices',
    RequestMethod.get,
  );
  static const TronHTTPMethods getburntrx = TronHTTPMethods._(
    'wallet/getburntrx',
    RequestMethod.get,
  );
  static const TronHTTPMethods getapprovedlist = TronHTTPMethods._(
    'wallet/getapprovedlist',
    RequestMethod.post,
  );

  static const TronHTTPMethods getassetissuebyaccount = TronHTTPMethods._(
    'wallet/getassetissuebyaccount',
    RequestMethod.post,
  );
  static const TronHTTPMethods getassetissuebyid = TronHTTPMethods._(
    'wallet/getassetissuebyid',
    RequestMethod.post,
  );
  static const TronHTTPMethods getassetissuebyname = TronHTTPMethods._(
    'wallet/getassetissuebyname',
    RequestMethod.post,
  );
  static const TronHTTPMethods getassetissuelist = TronHTTPMethods._(
    'wallet/getassetissuelist',
    RequestMethod.get,
  );

  static const TronHTTPMethods getassetissuelistbyname = TronHTTPMethods._(
    'wallet/getassetissuelistbyname',
    RequestMethod.post,
  );
  static const TronHTTPMethods getpaginatedassetissuelist = TronHTTPMethods._(
    'wallet/getpaginatedassetissuelist',
    RequestMethod.post,
  );
  static const TronHTTPMethods transferasset = TronHTTPMethods._(
    'wallet/transferasset',
    RequestMethod.post,
  );
  static const TronHTTPMethods createassetissue = TronHTTPMethods._(
    'wallet/createassetissue',
    RequestMethod.post,
  );
  static const TronHTTPMethods participateassetissue = TronHTTPMethods._(
    'wallet/participateassetissue',
    RequestMethod.post,
  );
  static const TronHTTPMethods unfreezeasset = TronHTTPMethods._(
    'wallet/unfreezeasset',
    RequestMethod.post,
  );
  static const TronHTTPMethods updateasset = TronHTTPMethods._(
    'wallet/updateasset',
    RequestMethod.post,
  );

  static const TronHTTPMethods getcontract = TronHTTPMethods._(
    'wallet/getcontract',
    RequestMethod.post,
  );
  static const TronHTTPMethods getcontractinfo = TronHTTPMethods._(
    'wallet/getcontractinfo',
    RequestMethod.post,
  );

  ///
  static const TronHTTPMethods triggersmartcontract = TronHTTPMethods._(
    'wallet/triggersmartcontract',
    RequestMethod.post,
  );
  static const TronHTTPMethods triggerconstantcontract = TronHTTPMethods._(
    'wallet/triggerconstantcontract',
    RequestMethod.post,
  );
  static const TronHTTPMethods deploycontract = TronHTTPMethods._(
    'wallet/deploycontract',
    RequestMethod.post,
  );
  static const TronHTTPMethods updatesetting = TronHTTPMethods._(
    'wallet/updatesetting',
    RequestMethod.post,
  );
  static const TronHTTPMethods updateenergylimit = TronHTTPMethods._(
    'wallet/updateenergylimit',
    RequestMethod.post,
  );
  static const TronHTTPMethods clearabi = TronHTTPMethods._(
    'wallet/clearabi',
    RequestMethod.post,
  );
  static const TronHTTPMethods estimateenergy = TronHTTPMethods._(
    'wallet/estimateenergy',
    RequestMethod.post,
  );
  static const TronHTTPMethods getexpandedspendingkey = TronHTTPMethods._(
    'wallet/getexpandedspendingkey',
    RequestMethod.post,
  );

  static const TronHTTPMethods getakfromask = TronHTTPMethods._(
    'wallet/getakfromask',
    RequestMethod.post,
  );
  static const TronHTTPMethods getnkfromnsk = TronHTTPMethods._(
    'wallet/getnkfromnsk',
    RequestMethod.post,
  );
  static const TronHTTPMethods getincomingviewingkey = TronHTTPMethods._(
    'wallet/getincomingviewingkey',
    RequestMethod.post,
  );
  static const TronHTTPMethods getzenpaymentaddress = TronHTTPMethods._(
    'wallet/getzenpaymentaddress',
    RequestMethod.post,
  );
  static const TronHTTPMethods createshieldedcontractparameters =
      TronHTTPMethods._(
        'wallet/createshieldedcontractparameters',
        RequestMethod.post,
      );
  static const TronHTTPMethods createspendauthsig = TronHTTPMethods._(
    'wallet/createspendauthsig',
    RequestMethod.post,
  );
  static const TronHTTPMethods gettriggerinputforshieldedtrc20contract =
      TronHTTPMethods._(
        'wallet/gettriggerinputforshieldedtrc20contract',
        RequestMethod.post,
      );
  static const TronHTTPMethods scanshieldedtrc20notesbyivk = TronHTTPMethods._(
    'wallet/scanshieldedtrc20notesbyivk',
    RequestMethod.post,
  );
  static const TronHTTPMethods scanshieldedtrc20notesbyovk = TronHTTPMethods._(
    'wallet/scanshieldedtrc20notesbyovk',
    RequestMethod.post,
  );
  static const TronHTTPMethods isshieldedtrc20contractnotespent =
      TronHTTPMethods._(
        'wallet/isshieldedtrc20contractnotespent',
        RequestMethod.post,
      );

  static const TronHTTPMethods getspendingkey = TronHTTPMethods._(
    'wallet/getspendingkey',
    RequestMethod.get,
  );

  static const TronHTTPMethods getdiversifier = TronHTTPMethods._(
    'wallet/getdiversifier',
    RequestMethod.get,
  );
  static const TronHTTPMethods getnewshieldedaddress = TronHTTPMethods._(
    'wallet/getnewshieldedaddress',
    RequestMethod.get,
  );

  static const TronHTTPMethods listwitnesses = TronHTTPMethods._(
    'wallet/listwitnesses',
    RequestMethod.get,
  );
  static const TronHTTPMethods getnextmaintenancetime = TronHTTPMethods._(
    'wallet/getnextmaintenancetime',
    RequestMethod.get,
  );

  static const TronHTTPMethods updatewitness = TronHTTPMethods._(
    'wallet/updatewitness',
    RequestMethod.post,
  );

  static const TronHTTPMethods getBrokerage = TronHTTPMethods._(
    'wallet/getBrokerage',
    RequestMethod.post,
  );

  static const TronHTTPMethods updateBrokerage = TronHTTPMethods._(
    'wallet/updateBrokerage',
    RequestMethod.post,
  );

  static const TronHTTPMethods votewitnessaccount = TronHTTPMethods._(
    'wallet/votewitnessaccount',
    RequestMethod.post,
  );
  static const TronHTTPMethods getReward = TronHTTPMethods._(
    'wallet/getReward',
    RequestMethod.post,
  );
  static const TronHTTPMethods withdrawbalance = TronHTTPMethods._(
    'wallet/withdrawbalance',
    RequestMethod.post,
  );
  static const TronHTTPMethods proposaldelete = TronHTTPMethods._(
    'wallet/proposaldelete',
    RequestMethod.post,
  );
  static const TronHTTPMethods proposalapprove = TronHTTPMethods._(
    'wallet/proposalapprove',
    RequestMethod.post,
  );

  static const TronHTTPMethods proposalcreate = TronHTTPMethods._(
    'wallet/proposalcreate',
    RequestMethod.post,
  );
  static const TronHTTPMethods getproposalbyid = TronHTTPMethods._(
    'wallet/getproposalbyid',
    RequestMethod.post,
  );

  static const TronHTTPMethods listproposals = TronHTTPMethods._(
    'wallet/listproposals',
    RequestMethod.get,
  );

  static const TronHTTPMethods listexchanges = TronHTTPMethods._(
    'wallet/listexchanges',
    RequestMethod.get,
  );

  static const TronHTTPMethods getexchangebyid = TronHTTPMethods._(
    'wallet/getexchangebyid',
    RequestMethod.post,
  );
  static const TronHTTPMethods exchangecreate = TronHTTPMethods._(
    'wallet/exchangecreate',
    RequestMethod.post,
  );
  static const TronHTTPMethods exchangeinject = TronHTTPMethods._(
    'wallet/exchangeinject',
    RequestMethod.post,
  );
  static const TronHTTPMethods exchangewithdraw = TronHTTPMethods._(
    'wallet/exchangewithdraw',
    RequestMethod.post,
  );
  static const TronHTTPMethods exchangetransaction = TronHTTPMethods._(
    'wallet/exchangetransaction',
    RequestMethod.post,
  );
  static const TronHTTPMethods gettransactionfrompending = TronHTTPMethods._(
    'wallet/gettransactionfrompending',
    RequestMethod.post,
  );

  static const TronHTTPMethods gettransactionlistfrompending =
      TronHTTPMethods._(
        'wallet/gettransactionlistfrompending',
        RequestMethod.get,
      );

  static const TronHTTPMethods getpendingsize = TronHTTPMethods._(
    'wallet/getpendingsize',
    RequestMethod.get,
  );
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
    getblockbalance,
  ];
}
