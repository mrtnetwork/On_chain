/// https://blockfrost.dev/api/blockfrost-io-api-documentation
class BlockfrostStatusCode {
  static const int invalidRequest = 400;
  static const int exceedRequestLimit = 402;
  static const int inValidAuthenticated = 403;
  static const int resourceDoesNotExist = 404;
  static const int rateLimit = 429;
  static const int bannedToMuchRequest = 418;
  static String? getErrorMessage(int statusCode) {
    switch (statusCode) {
      case invalidRequest:
        return 'Invalid request.';
      case exceedRequestLimit:
        return 'The projects exceed their daily request limit.';
      case inValidAuthenticated:
        return 'The request is not authenticated.';
      case resourceDoesNotExist:
        return "Resource doesn't exist.";
      case rateLimit:
        return 'Too many requests.';
      case bannedToMuchRequest:
        return 'The user has been banned.';
      default:
        return null;
    }
  }
}
