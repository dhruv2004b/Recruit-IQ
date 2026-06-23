import 'dart:io';
import 'package:recruit_iq/ads/ads_load_util.dart';
import 'package:recruit_iq/ads/ads_splash_utils.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/App_Colors.dart';
import 'package:recruit_iq/utils/App_Strings.dart';
import 'package:recruit_iq/utils/App_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (AdsVariable.interPreLoad != "11") {
        AdsLoadUtil().loadInterCommon(AdsVariable.interPreLoad);
      }
      if (Platform.isIOS) {
        setupNotification();
      }
      Connectivity().onConnectivityChanged.listen((
        List<ConnectivityResult> connectivityResult,
      ) async {
        if (connectivityResult.contains(ConnectivityResult.wifi) ||
            connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.ethernet)) {
          if (!AdsVariable.isSDKInitialized) {
            // await premiumInit();
            // await configureSDK();
          }
        }
      });

      if (AdsVariable.isFirstTimeVisited! && Platform.isIOS) {
        InAppReview inAppReview = InAppReview.instance;
        bool revCheck = await inAppReview.isAvailable();
        if (revCheck) {
          inAppReview.requestReview();
        }
      }
      await AdsSplashUtils().loadAppLifecycleReactor();

      AdsVariable.isShowingAd.value = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isFirstTime", true);
      AdsVariable.isFirstTimeVisited = prefs.getBool("isFirstTime") ?? false;
      setState(() {});
    });
    setState(() {});
  }

  setupNotification() {
    showLog("setupNotification 1");
    const platformMethodChannel = MethodChannel('notificationChannel');
    showLog("setupNotification 2");
    platformMethodChannel.invokeMethod('setNotification', {
      'isPurchase': AdsVariable.isPurchase.toString(),
    });
    showLog("setupNotification 3");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (AdsVariable.adShowHomeFlag == "1") {
      await AdsLoadUtil().loadInterCommon(
        Platform.isAndroid
            ? AdsVariable.interPreLoad
            : AdsVariable.interPreLoad,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(Assets.commonMainBg),
              //   fit: BoxFit.cover,
              // ),
              color: AppColors.blackColor
            ),
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.splashText1.tr,
                          style: TextStyle(
                            color: Color(0xFFFFFBCE),
                            fontSize: textSize * 0.040,
                            fontFamily: adregular,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ).marginAll(40.w),

                  ///Body
                  Expanded(
                    child: Column(
                      children: [],
                    ).marginSymmetric(horizontal: 30.w),
                  ),

                  // if (AdsVariable.adShowHomeFlag == "1" &&
                  //     !AdsVariable.isPurchase.value)
                  //   (AdsVariable.nativeHome != "11" &&
                  //           !AdsVariable.nativeHome
                  //               .toString()
                  //               .split("/")
                  //               .last
                  //               .contains("vv"))
                  //       ? NativeAdsWidget(
                  //           showNativeAd: AdsVariable.nativeAdHome,
                  //           isSmallNative: true,
                  //           isFullNative: false,
                  //         ).marginOnly(top: constraints.maxWidth * 0.02)
                  //       : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
