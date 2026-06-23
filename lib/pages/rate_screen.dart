import 'dart:io';
import 'dart:ui'; // Required for ImageFilter

import 'package:recruit_iq/ads/ads_load_util.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/generated/assets.dart';
import 'package:recruit_iq/in_app_purchase/app.dart';
import 'package:recruit_iq/pages/home_screen.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/App_Colors.dart';
import 'package:recruit_iq/utils/App_Strings.dart';
import 'package:recruit_iq/utils/App_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:recruit_iq/widgets/Press_Unpress_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  RxBool isRateDone = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            // Modern premium gradient instead of an image background
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A1A24), // Subtle deep blue-gray hint at the top
                  AppColors.blackColor, // Smooth fall to pitch black
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    const Spacer(),

                    // Glassmorphic Content Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Decorative Star Icon/Image on top
                              // Image.asset(
                              //   Assets.commonRateStar,
                              //   width: constraints.maxWidth * 0.25,
                              // ).marginOnly(bottom: 24.w),

                              Icon(Icons.star, color: Colors.yellowAccent, size: textSize * 0.050,).marginOnly(bottom: 24.w),
                              // Main Heading
                              Text(
                                AppStrings.rateTxt.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: aregular,
                                  color: const Color(0xFFEAEAEA),
                                  fontSize: textSize * 0.034,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 12.w),

                              // Subtext Description
                              Text(
                                AppStrings.rateTxtSub.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: gregular,
                                  color: const Color(0xFF9E9E9E),
                                  fontSize: textSize * 0.022,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Call To Action (Button) Section
                    PressUnPressWidget(
                      widget: Container(
                        width: constraints.maxWidth * 0.86,
                        height: constraints.maxWidth * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage(Assets.commonMainBtn),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Text(
                                textAlign: TextAlign.center,

                                isRateDone.value
                                    ? AppStrings.strContinue.tr
                                    : AppStrings.strRate.tr,
                                style: TextStyle(
                                  fontFamily: gsemibold,
                                  fontSize: textSize * 0.030,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).marginOnly(right: 20.w);
                            }),
                            // Image.asset(
                            //   Assets.introForwardIc,
                            //   height: constraints.maxWidth * 0.04,
                            //   width: constraints.maxWidth * 0.04,
                            // ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        if (!isRateDone.value) {
                          InAppReview inAppReview =
                              InAppReview.instance;
                          bool revCheck = await inAppReview
                              .isAvailable();
                          if (revCheck) {
                            inAppReview.requestReview();
                          }
                          isRateDone.value = true;
                        } else {
                          AdsLoadUtil.isNativeAdFailed.value = false;
                          AdsLoadUtil.isNativeAdLoaded.value = false;

                          if (AdsVariable.adShowHomeFlag == "1" &&
                              AdsVariable.nativeHome != "11") {
                            AdsVariable.nativeAdHome =
                            await AdsLoadUtil().loadNative(
                              Platform.isAndroid
                                  ? AdsVariable.nativeHome
                                  : AdsVariable.nativeHome,
                              true,
                              false,
                            );
                          }

                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setBool("isFirstTime", true);

                          if (await checkConnectivity()) {
                            if (Platform.isIOS) {
                              // if (!AdsVariable.isPurchase.value) {
                              //   Get.offAll(
                              //         () => const UpsellScreen(
                              //       isNotFromSplash: false,
                              //       isFromGenerate: false,
                              //       screen: "Intro",
                              //     ),
                              //     transition: Transition.rightToLeft,
                              //   );
                              // } else {
                                Get.find<AuthController>()
                                    .checkSession();
                                // Get.offAll(
                                //       () => const HomeScreen(),
                                //   transition:
                                //   Transition.rightToLeft,
                                // );
                              // }
                            } else {
                              Get.find<AuthController>()
                                  .checkSession();
                              // Get.offAll(
                              //       () => const HomeScreen(),
                              //   transition:
                              //   Transition.rightToLeft,
                              // );
                            }
                          } else {
                            Get.find<AuthController>().checkSession();
                            // Get.offAll(
                            //       () => const HomeScreen(),
                            //   transition: Transition
                            //       .rightToLeft,
                            // );
                          }
                        }
                      },
                    )
                        .marginSymmetric(vertical: 10.w)
                        .marginOnly(bottom: 30.w),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}