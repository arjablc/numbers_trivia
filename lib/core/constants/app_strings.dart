class AppString {
  AppString._privateConstructor();

  // Static final instance
  static final AppString _instance = AppString._privateConstructor();

  // Static method
  static AppString get instance {
    return _instance;
  }

  static const String serverFailureMessage = 'Server Failure';
  static const String cacheFailureMessage = 'Cache Failure';
  static const String invalidInputFailureMessage =
      'Invalid Input - The number must be a positive integer or zero.';
}
