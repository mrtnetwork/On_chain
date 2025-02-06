class AptosProviderConst {
  static const String viewFunctionBcsContentType =
      "application/x.aptos.view_function+bcs";
  static const List<int> errorStatusCodes = [400, 403, 404, 410, 500, 503, 507];
  static const List<int> successStatusCodes = [200, 202, 206];
  static const String accountNotFoundErrorCode = "account_not_found";
}
