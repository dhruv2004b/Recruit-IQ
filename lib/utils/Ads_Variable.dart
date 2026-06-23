import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uuid = '';
RxBool isLoggedIn = false.obs;
RxInt creditGlobal = 0.obs;

class AdsVariable {
  static bool? isFirstTimeVisited;
  static bool? isFirstTimePurchased;
  static AppOpenAd? appOpenAd;
  static AppOpenAd? appOpenAdSplash;
  static RxBool isShowingAd = false.obs;
  static late ConnectivityResult connectivityResult;
  static RxBool isPurchase = false.obs;
  static bool isSDKInitialized = false;
  static RxBool isLoggedIn = false.obs;
  static RxBool isPrivacyOptionsRequired = false.obs;
  static late SharedPreferences prefs;
  static String uuid = "Xyz";

  static String uuid1 = "Xyz";
  static String expiry = "Xyz";
  static String appKey = "FaceSwap_124565";
  static String expirykey = "Expiry_12343333";
  static RxInt credit = 0.obs;
  static bool showRateScreen = true;



  /// Ads
  NativeAd? languageNative;
  NativeAd? nativeAdSmallIntroScreen;

// Interstitial? appOpenInterstitial;
  bool nativeAdIsLoadedLanguageScreen = false;
  bool nativeAdIsLoadedIntroScreen = false;
  RxBool nativeAdIsLoaded = false.obs;


  static String nativeBGColor = "F4F4F4";
  static String btnBgColor = "FF2F5C";
  static String btnBgColor1 = "FF6561";
  static String btnBgColor2 = "FF6561";
  static String btnAdBgColor = "E3E3E3";
  static String btnTextColor = "FFFFFF";
  static String btnAdTextColor = "000000";
  static String headerTextColor = "000000";
  static String bodyTextColor = "000000";


  static int homeFlag = 0;
  static int saveFlag = 0;

  static int freeUsageCount = 1;

  /// Screen wise flag
  static String homeFlagOnline = "1"; // 0 = Ad show continue
  static String adShowHomeFlag = "1"; // 1 = show ads | 0 = not show ads
  static String adShowLanguageFlag = "1"; // 1 = show ads | 0 = not show ads

  static NativeAd? nativeAdHome;
  static NativeAd? nativeAdFullScreen;
  static NativeAd? nativeAdLanguage;
  static NativeAd? nativeAdLanguage2;

  /// Facebook
  static String facebookId = "11";
  static String facebookToken = "11";
  static String defaultCredit = "10";
  static String activePackage = "";

  // static String appOpenSplash = "11";
  /// Ads - Android
  static String appOpenAds = "";
  static String appOpenSplash = "11";

  static String interSplash = "11";
  static String interPreLoad = "11";
  static String bannerIntro = "11";
  static String bannerIntro1 = "11";
  static String nativeLanguage = "11";
  static String nativeLanguage2 = "11";
  static String nativeHome = "11";
  static String nativeFull = "11";

  static String imidiateUpdate = "0";

  static bool showDiscount = true;
  static bool inappView = false;
  static bool isIamTester = false;

  static String weShopCookie = "";
  // static String poseDetectApiKey = "";
  static String immediateUpdate = "";
  static String premiumShow = "";
  static String testerPass = "admin";
  static String testerEmail = "admin";
  static String premiumMandatory = "admin";
  static String backendUri = "";

  static int freeCredit = 0;
  static int weeklyBonusCredit = 0;
  static int yearlyBonusCredit = 0;
  static int firstCredit = 0;
  static int secondCredit = 0;
  static int adsShowCreditCount=0;
  static int maxFreeTries=0;
  static RxBool isCreditMore = false.obs;

  static int xRayCutCredit= 10;
  static int ghostMannequinCutCredit= 10;
  static int outfitGenCutCredit= 10;
  static int clothPieceCutCredit= 10;
  static int clothChangerCutCredit= 10;
  static int virtualTryonCutCredit= 10;
  // static int angleCutCredit= 10;


  // static int satelliteFree = 0;
  // static int threeDFree = 0;
  // static int skew = 0;




/// Ads - IOS
// static String Afs_appOpenAdsIOS = "ca-app-pub-3940256099942544/5575463023";
// static String Afs_appOpenSplashIOS = "11";
// static String Afs_interSplashIOS = "ca-app-pub-3940256099942544/4411468910";
// static String Afs_interPreLoadIOS = "ca-app-pub-3940256099942544/4411468910";
// static String Afs_bannerIntroIOS = "ca-app-pub-3940256099942544/2934735716";
// static String Afs_bannerFaceEditorIOS = "ca-app-pub-3940256099942544/2934735716";
// static String Afs_nativeLanguageIOS = "ca-app-pub-3940256099942544/3986624511";
// static String Afs_nativeLanguageIOS2 = "ca-app-pub-3940256099942544/3986624511";
// static String Afs_nativeHomeIOS = "ca-app-pub-3940256099942544/3986624511";
// static String Afs_nativeFullIOS = "ca-app-pub-3940256099942544/3986624511";

  static Future<void> addAdIds() async {
    var prefs = await SharedPreferences.getInstance();
    AdsVariable.appOpenAds = prefs.getString("appOpenAds") ?? "11";
    AdsVariable.appOpenSplash = prefs.getString("appOpenSplash") ?? "11";
    AdsVariable.interSplash = prefs.getString("interSplash") ?? "11";
    AdsVariable.interPreLoad = prefs.getString("interPreLoad") ?? "11";
    // AdsVariable.interInside = prefs.getString("interInside") ?? "11";
    AdsVariable.nativeLanguage = prefs.getString("nativeLanguage") ?? "11";
    AdsVariable.nativeLanguage2 = prefs.getString("nativeLanguage2") ?? "11";
    AdsVariable.nativeHome = prefs.getString("nativeHome") ?? "11";
    AdsVariable.nativeFull = prefs.getString("nativeFull") ?? "11";

}
}
void resetId() {
  AdsVariable.appOpenAds = "11";
  AdsVariable.interSplash = "11";
  AdsVariable.interPreLoad = "11";
  AdsVariable.bannerIntro = "11";
  AdsVariable.nativeLanguage = "11";
  AdsVariable.nativeLanguage2 = "11";
  AdsVariable.nativeHome = "11";
  AdsVariable.nativeFull = "11";

  AdsVariable.isPurchase.value = true;
}



