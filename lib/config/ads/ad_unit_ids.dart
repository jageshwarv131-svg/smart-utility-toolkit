/// Google AdMob Test Ad Unit IDs
/// Replace with production IDs before publishing to Play Store
class AdUnitIds {
  // Test Banner Ad Unit ID
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  // Test Interstitial Ad Unit ID
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';

  // Test Rewarded Ad Unit ID
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  // Test Native Advanced Ad Unit ID
  static const String nativeAdvancedAdUnitId = 'ca-app-pub-3940256099942544/2247696110';

  // Test App ID
  static const String appId = 'ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy';

  /// Production Ad Unit IDs (Replace these with your actual production IDs)
  /// From: https://admob.google.com
  static const String prodBannerAdUnitId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy';
  static const String prodInterstitialAdUnitId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy';
  static const String prodRewardedAdUnitId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy';
  static const String prodNativeAdvancedAdUnitId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy';
  static const String prodAppId = 'ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy';

  // Use this flag to switch between test and production ads
  static const bool isProduction = false; // Set to true for production

  static String getBannerAdUnitId() {
    return isProduction ? prodBannerAdUnitId : bannerAdUnitId;
  }

  static String getInterstitialAdUnitId() {
    return isProduction ? prodInterstitialAdUnitId : interstitialAdUnitId;
  }

  static String getRewardedAdUnitId() {
    return isProduction ? prodRewardedAdUnitId : rewardedAdUnitId;
  }

  static String getNativeAdvancedAdUnitId() {
    return isProduction ? prodNativeAdvancedAdUnitId : nativeAdvancedAdUnitId;
  }
}
