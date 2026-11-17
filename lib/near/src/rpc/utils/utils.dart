class NearRpcError {
  static bool isDoesNotExistsError(String err) {
    return err.contains("does not exist");
  }
}
