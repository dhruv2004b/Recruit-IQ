// import 'dart:io';
// import 'package:recruit_iq/pages/home_screen.dart';
// import 'package:recruit_iq/pages/intro_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:lottie/lottie.dart';
// import 'package:recruit_iq/ads/ads_load_util.dart';
// import 'package:recruit_iq/ads/ads_splash_utils.dart';
// import 'package:recruit_iq/generated/assets.dart';
// import 'package:recruit_iq/in_app_purchase/app.dart';
// import 'package:recruit_iq/utils/Ads_Variable.dart';
// import 'package:recruit_iq/utils/App_Colors.dart';
// import 'package:recruit_iq/utils/App_Strings.dart';
// import 'package:recruit_iq/utils/App_Variable.dart';
// import 'package:recruit_iq/utils/app_connectivity.dart';
// import 'package:video_player/video_player.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await AdsSplashUtils().getOnlineIds(navigateScreen);
//       await AdsLoadUtil().loadInterSplash(
//         () {
//           loadPreLoadAds();
//           if (AdsVariable.isFirstTimeVisited == true && Platform.isAndroid) {
//             AdsVariable.homeFlag++;
//             print("AdsVariable.homeFlag--->${AdsVariable.homeFlag}");
//           }
//         },
//         () {
//           navigateScreen();
//         },
//         Platform.isAndroid ? AdsVariable.interSplash : AdsVariable.interSplash,
//       );
//     });
//     super.initState();
//   }
//
//   void navigateScreen() async {
//     showLog("Call method navigation");
//     // if (AdsVariable.isFirstTimeVisited == true) {
//     //   if (await checkConnectivity()) {
//     //     if (Platform.isIOS) {
//     //       if (!AdsVariable.isPurchase.value) {
//     //         Get.offAll(
//     //           () => const UpsellScreen(
//     //             isNotFromSplash: false,
//     //             isFromGenerate: false,
//     //             screen: 'SplashScreen',
//     //           ),
//     //           transition: Transition.rightToLeft,
//     //         );
//     //       } else {
//     //         Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
//     //       }
//     //     } else {
//     //       AdsVariable.homeFlag++;
//     //       Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
//     //     }
//     //   } else {
//     //     Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
//     //   }
//     // } else {
//     //   // Get.offAll(() => LanguageScreen(fromSplash: true), transition: Transition.rightToLeft);
//     //   Get.offAll(() => IntroPage(), transition: Transition.rightToLeft);
//     // }
//
//     Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
//   }
//
//   void loadPreLoadAds() async {
//     showLog("Call Method loadPreLoadAds");
//     showLog("AdsVariable.isFirstTime---->${AdsVariable.isFirstTimeVisited}");
//     if (AdsVariable.isFirstTimeVisited == false) {
//       if (AdsVariable.adShowLanguageFlag == "1" &&
//           AdsVariable.nativeLanguage != "11") {
//         AdsVariable.nativeAdLanguage = await AdsLoadUtil().loadNative(
//           Platform.isAndroid
//               ? AdsVariable.nativeLanguage
//               : AdsVariable.nativeLanguage,
//           false,
//           false,
//         );
//         showLog(
//           "AdsVariable.nativeAdLanguage --->${AdsVariable.nativeAdLanguage}",
//         );
//       }
//       if (AdsVariable.adShowLanguageFlag == "1" &&
//           AdsVariable.nativeLanguage2 != "11") {
//         AdsVariable.nativeAdLanguage2 = await AdsLoadUtil().loadNative(
//           Platform.isAndroid
//               ? AdsVariable.nativeLanguage2
//               : AdsVariable.nativeLanguage2,
//           false,
//           false,
//         );
//         showLog(
//           "AdsVariable.nativeAdLanguage --->${AdsVariable.nativeAdLanguage2}",
//         );
//       }
//     } else {
//       if (AdsVariable.adShowHomeFlag == "1" && AdsVariable.nativeHome != "11") {
//         AdsVariable.nativeAdHome = await AdsLoadUtil().loadNative(
//           Platform.isAndroid ? AdsVariable.nativeHome : AdsVariable.nativeHome,
//           true,
//           false,
//         );
//       }
//     }
//     setState(() {});
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.blackColor,
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return Container(
//             decoration: BoxDecoration(color: AppColors.blackColor),
//             height: constraints.maxHeight,
//             width: constraints.maxWidth,
//             child: SafeArea(
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Image.asset(Assets.commonMainBg, fit: BoxFit.cover),
//
//                   _controller.value.isInitialized
//                       ? AspectRatio(
//                           aspectRatio: _controller.value.aspectRatio,
//                           child: VideoPlayer(_controller),
//                         )
//                       : Image.asset(Assets.splashSplashBg, fit: BoxFit.fill),
//
//                   // Image.asset(Assets.splashFetherBg, fit: BoxFit.fill),
//                   Container(
//                     width: constraints.maxWidth,
//                     height: constraints.maxHeight,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(Assets.splashFetherBg),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Image.asset(
//                         Assets.splashIcon,
//                         width: constraints.maxWidth * 0.20,
//                       ).marginOnly(bottom: 20.w),
//                       Text(
//                         AppStrings.splashText1.tr,
//                         style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontFamily: adregular,
//                           fontSize: textSize * 0.036,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ).marginOnly(bottom: 60.w),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/ads/ads_load_util.dart';
import 'package:recruit_iq/ads/ads_splash_utils.dart';
import 'package:recruit_iq/in_app_purchase/app.dart';
import 'package:recruit_iq/pages/home_screen.dart';
import 'package:recruit_iq/pages/intro_screen.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import '../../controllers/auth_controller.dart';
import '../utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Get.find<AuthController>().checkSession();
      await AdsSplashUtils().getOnlineIds(navigateScreen);
      await AdsLoadUtil().loadInterSplash(
        () {
          loadPreLoadAds();
          if (AdsVariable.isFirstTimeVisited == true && Platform.isAndroid) {
            AdsVariable.homeFlag++;
            print("AdsVariable.homeFlag--->${AdsVariable.homeFlag}");
          }
        },
        () {
          navigateScreen();
        },
        Platform.isAndroid ? AdsVariable.interSplash : AdsVariable.interSplash,
      );
    });
    super.initState();
  }

  void navigateScreen() async {
    showLog("Call method navigation");
    if (AdsVariable.isFirstTimeVisited == true) {
      if (await checkConnectivity()) {
        if (Platform.isIOS) {
          // if (!AdsVariable.isPurchase.value) {
          //   Get.offAll(
          //     () => const UpsellScreen(
          //       isNotFromSplash: false,
          //       isFromGenerate: false,
          //       screen: 'SplashScreen',
          //     ),
          //     transition: Transition.rightToLeft,
          //   );
          // } else {
            Get.find<AuthController>().checkSession();
            // Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
          // }
        } else {
          Get.find<AuthController>().checkSession();
          AdsVariable.homeFlag++;
          // Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
        }
      } else {
        Get.find<AuthController>().checkSession();
        // Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
      }
    } else {
      // Get.offAll(() => LanguageScreen(fromSplash: true), transition: Transition.rightToLeft);
      Get.offAll(() => IntroPage(), transition: Transition.rightToLeft);
    }

    // Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
  }

  void loadPreLoadAds() async {
    showLog("Call Method loadPreLoadAds");
    showLog("AdsVariable.isFirstTime---->${AdsVariable.isFirstTimeVisited}");
    if (AdsVariable.isFirstTimeVisited == false) {


      // if (AdsVariable.adShowLanguageFlag == "1" &&
      //     AdsVariable.nativeLanguage != "11") {
      //   AdsVariable.nativeAdLanguage = await AdsLoadUtil().loadNative(
      //     Platform.isAndroid
      //         ? AdsVariable.nativeLanguage
      //         : AdsVariable.nativeLanguage,
      //     false,
      //     false,
      //   );
      //   showLog(
      //     "AdsVariable.nativeAdLanguage --->${AdsVariable.nativeAdLanguage}",
      //   );
      // }
      //
      // if (AdsVariable.adShowLanguageFlag == "1" &&
      //     AdsVariable.nativeLanguage2 != "11") {
      //   AdsVariable.nativeAdLanguage2 = await AdsLoadUtil().loadNative(
      //     Platform.isAndroid
      //         ? AdsVariable.nativeLanguage2
      //         : AdsVariable.nativeLanguage2,
      //     false,
      //     false,
      //   );
      //   showLog(
      //     "AdsVariable.nativeAdLanguage --->${AdsVariable.nativeAdLanguage2}",
      //   );
      // }

      if (AdsVariable.nativeFull != "11" && AdsVariable.nativeAdFullScreen == null) {
        AdsLoadUtil.isNativeAdFailed.value = false;
        AdsLoadUtil.isNativeAdLoaded.value = false;
        AdsVariable.nativeAdFullScreen = await AdsLoadUtil().loadNative(AdsVariable.nativeFull, true, true);
      }


    } else {
      if (AdsVariable.adShowHomeFlag == "1" && AdsVariable.nativeHome != "11") {
        AdsVariable.nativeAdHome = await AdsLoadUtil().loadNative(
          Platform.isAndroid ? AdsVariable.nativeHome : AdsVariable.nativeHome,
          true,
          false,
        );
      }
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.psychology_alt_rounded,
                  size: 72, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'RecruitIQ',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'AI-Powered Talent Matching',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 60),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
