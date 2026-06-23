import 'dart:io';
import 'package:recruit_iq/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/App_Strings.dart';
import 'package:recruit_iq/utils/App_Variable.dart';

class DialogService {
  static void showLoading(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.transparent,
              dialogTheme: const DialogThemeData(
                backgroundColor: Colors.transparent,
              ),
            ),
            child: const CupertinoAlertDialog(
              title: Center(child: CupertinoActivityIndicator()),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
  }

  static void restorePurchasesDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppStrings.strnoPurchaseFound.tr),
            content: Text(AppStrings.strPurchaseInfo.tr),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
  }

  static void successRestoreDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppStrings.strPurchaseFound.tr).marginOnly(bottom: 5.w),
            content: Text(AppStrings.strPurchaseInfo1.tr),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () async {
                  SharedPreferences? prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isFirstTimePurchased", true);
                  AdsVariable.isFirstTimePurchased = true;
                  AdsVariable.isPurchase.value = true;
                  resetId();
                  Get.offAll(
                    () => const HomeScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
  }

  static void selectDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Oops"),
            content: const Text("Please Upload Image"),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Oops"),
            content: const Text("Please Upload Image"),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  static void successPurchasesDialog(BuildContext context, bool isGen) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              AppStrings.strPurchaseSuccess.tr,
            ).marginOnly(bottom: 5.w),
            content: Text(AppStrings.strpPurchaseInfoSuccess.tr),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () async {
                  SharedPreferences? prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isFirstTimePurchased", true);
                  AdsVariable.isFirstTimePurchased = true;
                  AdsVariable.isPurchase.value = true;
                  resetId();
                  if (isGen) {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  } else {
                    Get.offAll(
                      () => const HomeScreen(),
                      transition: Transition.rightToLeft,
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppStrings.strPurchaseSuccess.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize * 0.03,
                fontWeight: FontWeight.w600,
                fontFamily: medium,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).marginOnly(bottom: 5.w),
            content: Text(
              AppStrings.strpPurchaseInfoSuccess.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize * 0.03,
                fontWeight: FontWeight.w500,
                fontFamily: medium,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () async {
                  SharedPreferences? prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isFirstTimePurchased", true);
                  AdsVariable.isFirstTimePurchased = true;
                  AdsVariable.isPurchase.value = true;
                  resetId();
                  if (isGen) {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  } else {
                    Get.offAll(
                      () => const HomeScreen(),
                      transition: Transition.rightToLeft,
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  static void showCheckConnectivity(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Connection'),
            content: const Text('Check your internet connection.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Text('Connection'),
            content: const Text('Check your internet connection.'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // static void deleteFile(BuildContext context, Function()? onTap) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       bool isTab = (Get.height < (Get.width * 2)) ? true : false;
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(25.w),
  //         ),
  //         backgroundColor: AppColors.whiteColor,
  //         surfaceTintColor: AppColors.whiteColor,
  //         alignment: Alignment.center,
  //         title: Container(
  //           alignment: Alignment.center,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 AppStrings.strAreYou.tr,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.w600,
  //                   fontFamily: textFamily,
  //                 ),
  //                 textAlign: TextAlign.center,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               Text(
  //                 AppStrings.strRemoveText.tr,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 12.sp,
  //                   fontWeight: FontWeight.w400,
  //                   fontFamily: textFamily,
  //                 ),
  //                 textAlign: TextAlign.center,
  //                 maxLines: 4,
  //                 overflow: TextOverflow.ellipsis,
  //               ).marginOnly(bottom: 10.w),
  //               // SizedBox(
  //               //   width: Get.width * 0.4,
  //               //   height: Get.width * 0.11,
  //               //   child: PressUnpressWithText(
  //               //     mainAxisAlignment: MainAxisAlignment.end,
  //               //     crossAxisAlignment: CrossAxisAlignment.center,
  //               //     imageAssetUnPress: Assets.imagesRateNowUnpressed,
  //               //     imageAssetPress: Assets.imagesRateNowPressed,
  //               //     text: AppStrings.strDelete.tr,
  //               //     imagewidth: Get.width * 0.4,
  //               //     imagehieght: Get.width * 0.11,
  //               //     textStyle: TextStyle(
  //               //       fontFamily: textFamily,
  //               //       fontSize: 16.sp,
  //               //       fontWeight: FontWeight.w400,
  //               //       color: AppColors.whiteColor,
  //               //     ),
  //               //     textPressColor: AppColors.lightcolor,
  //               //     onTap: onTap,
  //               //     width: Get.width * 0.25,
  //               //     maxLines: 1,
  //               //     overflow: TextOverflow.ellipsis,
  //               //     textAlign: TextAlign.center,
  //               //   ),
  //               // ),
  //               PressUnpressCommen(
  //                   widget: SizedBox(
  //                     width: Get.width * 0.4,
  //                     height: Get.width * 0.07,
  //                     child: Text(
  //                       textAlign: TextAlign.center,
  //                       "${AppStrings.strCancle.tr}",
  //                       style: TextStyle(fontSize: 16.sp, fontFamily: textFamily, fontWeight: FontWeight.w400, color: AppColors.textColor3),
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                   onTap: () async {
  //                     Get.back();
  //                   }).marginSymmetric(vertical: isTab ? 2.w : 10.w),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // static void creditLost(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(25.w),
  //         ),
  //         backgroundColor: AppColors.whiteColor,
  //         surfaceTintColor: AppColors.whiteColor,
  //         title: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               AppStrings.strCreditMainText.tr,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600,
  //                 fontFamily: textFamily,
  //               ),
  //               textAlign: TextAlign.center,
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ).marginOnly(bottom: 2.w),
  //             Text(
  //               AppStrings.strCreditText.tr,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 12.sp,
  //                 fontWeight: FontWeight.w500,
  //                 fontFamily: textFamily,
  //               ),
  //               textAlign: TextAlign.center,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ).marginOnly(bottom: 10.w),
  //             // SizedBox(
  //             //   width: Get.width * 0.4,
  //             //   height: Get.width * 0.11,
  //             //   child: PressUnpressWithText(
  //             //     mainAxisAlignment: MainAxisAlignment.center,
  //             //     crossAxisAlignment: CrossAxisAlignment.center,
  //             //     imageAssetUnPress: Assets.imagesRateNowUnpressed,
  //             //     imageAssetPress: Assets.imagesRateNowPressed,
  //             //     text: AppStrings.strNoContinue.tr,
  //             //     imagewidth: Get.width * 0.4,
  //             //     imagehieght: Get.width * 0.11,
  //             //     textStyle: TextStyle(
  //             //       fontFamily: textFamily,
  //             //       fontSize: 14.sp,
  //             //       fontWeight: FontWeight.w600,
  //             //       color: AppColors.whiteColor,
  //             //     ),
  //             //     textPressColor: AppColors.lightcolor,
  //             //     onTap: () {
  //             //       Get.back();
  //             //     },
  //             //     width: Get.width * 0.25,
  //             //     maxLines: 1,
  //             //     overflow: TextOverflow.ellipsis,
  //             //     textAlign: TextAlign.center,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // static void creditInfo(BuildContext context, String Credits, Function()? onTap) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(25.w),
  //         ),
  //         backgroundColor: AppColors.whiteColor,
  //         surfaceTintColor: AppColors.whiteColor,
  //         title: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               AppStrings.strCreditCostMain.tr,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.w600,
  //                 fontFamily: textFamily,
  //               ),
  //               textAlign: TextAlign.center,
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ).marginOnly(bottom: 2.w),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   AppStrings.strCreditCostSub.tr,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w400,
  //                     fontFamily: textFamily,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ).marginOnly(
  //                   bottom: 10.w,
  //                 ),
  //                 Text(
  //                   " $Credits",
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w600,
  //                     fontFamily: textFamily,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ).marginOnly(bottom: 10.w, right: 2.w),
  //                 // Container(width: 20.w, height: 20.w, child: Image.asset(Assets.premiumCoin)).marginOnly(bottom: 10.w),
  //               ],
  //             ),
  //             // SizedBox(
  //             //   width: Get.width * 0.4,
  //             //   height: Get.width * 0.11,
  //             //   child: PressUnpressWithText(
  //             //     mainAxisAlignment: MainAxisAlignment.center,
  //             //     crossAxisAlignment: CrossAxisAlignment.center,
  //             //     imageAssetUnPress: Assets.imagesRateNowUnpressed,
  //             //     imageAssetPress: Assets.imagesRateNowPressed,
  //             //     text: AppStrings.strCreditCosttextContinue.tr,
  //             //     imagewidth: Get.width * 0.4,
  //             //     imagehieght: Get.width * 0.11,
  //             //     textStyle: TextStyle(
  //             //       fontFamily: textFamily,
  //             //       fontSize: 12.sp,
  //             //       fontWeight: FontWeight.w400,
  //             //       color: AppColors.whiteColor,
  //             //     ),
  //             //     textPressColor: AppColors.lightcolor,
  //             //     onTap: onTap,
  //             //     width: Get.width * 0.25,
  //             //     maxLines: 1,
  //             //     overflow: TextOverflow.ellipsis,
  //             //     textAlign: TextAlign.center,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // static void noImage(BuildContext context, String text) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(25.w),
  //         ),
  //         backgroundColor: AppColors.whiteColor,
  //         surfaceTintColor: AppColors.whiteColor,
  //         title: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               AppStrings.strCreditCostMain.tr,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.w600,
  //                 fontFamily: textFamily,
  //               ),
  //               textAlign: TextAlign.center,
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ).marginOnly(bottom: 2.w),
  //             Text(
  //               text.split("error_msg:").last,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w400,
  //                 fontFamily: textFamily,
  //               ),
  //               textAlign: TextAlign.center,
  //               maxLines: 3,
  //               overflow: TextOverflow.ellipsis,
  //             ).marginOnly(
  //               bottom: 10.w,
  //             ),
  //             // SizedBox(
  //             //   width: Get.width * 0.4,
  //             //   height: Get.width * 0.11,
  //             //   child: PressUnpressWithText(
  //             //     mainAxisAlignment: MainAxisAlignment.center,
  //             //     crossAxisAlignment: CrossAxisAlignment.center,
  //             //     imageAssetUnPress: Assets.imagesRateNowUnpressed,
  //             //     imageAssetPress: Assets.imagesRateNowPressed,
  //             //     text: AppStrings.strCreditCosttextContinue.tr,
  //             //     imagewidth: Get.width * 0.4,
  //             //     imagehieght: Get.width * 0.11,
  //             //     textStyle: TextStyle(
  //             //       fontFamily: textFamily,
  //             //       fontSize: 12.sp,
  //             //       fontWeight: FontWeight.w400,
  //             //       color: AppColors.whiteColor,
  //             //     ),
  //             //     textPressColor: AppColors.lightcolor,
  //             //     onTap: () {
  //             //       Get.back();
  //             //     },
  //             //     width: Get.width * 0.25,
  //             //     maxLines: 1,
  //             //     overflow: TextOverflow.ellipsis,
  //             //     textAlign: TextAlign.center,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
