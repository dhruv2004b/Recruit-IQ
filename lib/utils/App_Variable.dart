import 'dart:io';

import 'package:recruit_iq/Model/language_model.dart';
import 'package:recruit_iq/ads/ads_load_util.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:recruit_iq/utils/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recruit_iq/generated/assets.dart';
import 'package:recruit_iq/utils/App_Colors.dart';
import 'package:recruit_iq/widgets/Press_Unpress_Widget.dart';

late SharedPreferences prefs;

bool isLoggedIn = false;

late double screenHeight;
late double screenWidth;
late double textSize;
late bool isTab;

const bold = "Lexend_Bold";
const medium = "Lexend_Medium";
const regular = "Lexend_Regular";
const semiBold = "Lexend_SemiBold";
// const gbold = "gbold";
// const gheavy = "gheavy";
// const glight = "glight";
// const gmedium = "gmedium";
const gregular = "gregular";
const gsemibold = "gsemibold";
const adregular = 'adregular';
const aregular = 'aregular';
// const soregular = 'soregular';


List<String> languageStore = [];
// List<Language> languageList = [
//   //
//   // /// English
//   // Language(
//   //   languageCode: 'en',
//   //   countryCode: 'US',
//   //   languageImg: Assets.languageEnglishIcon,
//   //   languageImgUnselect: Assets.languageEnglishIcon,
//   //   languageName: "English (Default)",
//   // ),
//   //
//   // /// Spanish
//   // Language(
//   //   languageCode: 'sp',
//   //   countryCode: 'SP',
//   //   languageImg: Assets.languageSpanishIcon,
//   //   languageImgUnselect: Assets.languageSpanishIcon,
//   //   languageName: "Spanish (Española)",
//   // ),
//   //
//   // /// French
//   // Language(
//   //   languageCode: 'fr',
//   //   countryCode: 'FR',
//   //   languageImg: Assets.languageFrenchIcon,
//   //   languageImgUnselect: Assets.languageFrenchIcon,
//   //   languageName: "French (Français)",
//   // ),
//   //
//   // /// Dutch
//   // Language(
//   //   languageCode: 'nl',
//   //   countryCode: 'NL',
//   //   languageImg: Assets.languageDutchIcon,
//   //   languageImgUnselect: Assets.languageDutchIcon,
//   //   languageName: "Dutch (Netherlands)",
//   // ),
//   //
//   // /// Italian
//   // Language(
//   //   languageCode: 'it',
//   //   countryCode: 'IT',
//   //   languageImg: Assets.languageItalianIcon,
//   //   languageImgUnselect: Assets.languageItalianIcon,
//   //   languageName: "Italian (Italiana)",
//   // ),
//   //
//   // /// Malaysian
//   // Language(
//   //   languageCode: 'ms',
//   //   countryCode: 'MY',
//   //   languageImg: Assets.languageMalaysianIcon,
//   //   languageImgUnselect: Assets.languageMalaysianIcon,
//   //   languageName: "Malaysian (Malaysia)",
//   // ),
//   //
//   // /// Thai
//   // Language(
//   //   languageCode: 'th',
//   //   countryCode: 'TH',
//   //   languageImg: Assets.languageThaiIcon,
//   //   languageImgUnselect: Assets.languageThaiIcon,
//   //   languageName: "Thai (แบบไทย)",
//   // ),
//   //
//   // /// Turkish
//   // Language(
//   //   languageCode: 'tr',
//   //   countryCode: 'TR',
//   //   languageImg: Assets.languageTurkishIcon,
//   //   languageImgUnselect: Assets.languageTurkishIcon,
//   //   languageName: "Turkish (Türkçe)",
//   // ),
//   //
//   // /// Vietnamese
//   // Language(
//   //   languageCode: 'vi',
//   //   countryCode: 'VN',
//   //   languageImg: Assets.languageVietnameseIcon,
//   //   languageImgUnselect: Assets.languageVietnameseIcon,
//   //   languageName: "Vietnamese (Tiếng Việt)",
//   // ),
//   //
//   // /// Arabic
//   // Language(
//   //   languageCode: 'ar',
//   //   countryCode: 'AR',
//   //   languageImg: Assets.languageArabicIcon,
//   //   languageImgUnselect: Assets.languageArabicIcon,
//   //   languageName: "Arabic (عربي)",
//   // ),
//   //
//   // /// German(Deutsch)
//   // Language(
//   //   languageCode: 'gm',
//   //   countryCode: 'DE',
//   //   languageImg: Assets.languageGermanIcon,
//   //   languageImgUnselect: Assets.languageGermanIcon,
//   //   languageName: "German (Deutsch)",
//   // ),
//   //
//   // /// Indonesian
//   // Language(
//   //   languageCode: 'id',
//   //   countryCode: 'ID',
//   //   languageImg: Assets.languageIndonesiaIcon,
//   //   languageImgUnselect: Assets.languageIndonesiaIcon,
//   //   languageName: "Indonesia (Indonesia)",
//   // ),
//   //
//   // /// Japanese(日本語)
//   // Language(
//   //   languageCode: 'jp',
//   //   countryCode: 'JP',
//   //   languageImg: Assets.languageJapaneseIcon,
//   //   languageImgUnselect: Assets.languageJapaneseIcon,
//   //   languageName: "Japanese (日本語)",
//   // ),
//   //
//   // /// Korean(한국인)
//   // Language(
//   //   languageCode: 'ko',
//   //   countryCode: 'KO',
//   //   languageImg: Assets.languageKoreanIcon,
//   //   languageImgUnselect: Assets.languageKoreanIcon,
//   //   languageName: "Korean (한국인)",
//   // ),
//   //
//   // /// Portuguese(Português)
//   // Language(
//   //   languageCode: 'po',
//   //   countryCode: 'PT',
//   //   languageImg: Assets.languagePortugueseIcon,
//   //   languageImgUnselect: Assets.languagePortugueseIcon,
//   //   languageName: "Portuguese (Português)",
//   // ),
//   //
//   // /// Punjabi(ਪੰਜਾਬੀ)
//   // Language(
//   //   languageCode: 'pu',
//   //   countryCode: 'PA',
//   //   languageImg: Assets.languagePunjabiIcon,
//   //   languageImgUnselect: Assets.languagePunjabiIcon,
//   //   languageName: "Punjabi (ਪੰਜਾਬੀ)",
//   // ),
//   //
//   // /// Chinese (中文)
//   // Language(
//   //   languageCode: 'zh',
//   //   countryCode: 'CN',
//   //   languageImg: Assets.languageChineseIcon,
//   //   languageImgUnselect: Assets.languageChineseIcon,
//   //   languageName: "Chinese (中文)",
//   // ),
//   //
//   // /// Russian(Русский)
//   // Language(
//   //   languageCode: 'ru',
//   //   countryCode: 'RU',
//   //   languageImg: Assets.languageRussianIcon,
//   //   languageImgUnselect: Assets.languageRussianIcon,
//   //   languageName: "Russian (Русский)",
//   // ),
//   //
//   // /// Hindi
//   // Language(
//   //   languageCode: 'hi',
//   //   countryCode: 'IN',
//   //   languageImg: Assets.languageHindiIcon,
//   //   languageImgUnselect: Assets.languageHindiIcon,
//   //   languageName: "Hindi (हिंदी)",
//   // ),
// ];

void showPermissionDialog(BuildContext context, String item) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text('Allow access to $item in the Setting.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Setting'),
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
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
          titlePadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(0),
          title: Container(
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Column(
              children: [
                Text(
                      "Allow access to $item in the Setting.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: medium,
                        fontSize: textSize * 0.03,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackColor,
                      ),
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                    )
                    .marginAll(10.w)
                    .marginOnly(bottom: 10.w)
                    .marginSymmetric(horizontal: 10.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PressUnPressWidget(
                      widget: Container(
                        width: Get.width * 0.32,
                        height: Get.width * 0.12,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.blackColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Setting",
                              style: TextStyle(
                                fontFamily: medium,
                                fontSize: textSize * 0.028,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).marginSymmetric(horizontal: 5.w),
                          ],
                        ).paddingSymmetric(horizontal: 10.w),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                    ).marginSymmetric(horizontal: 2.w),
                  ],
                ).marginOnly(bottom: 5.w),
              ],
            ).marginSymmetric(vertical: 10.h),
          ),
        );
      },
    );
  }
}

Future<void> onTapInter(Function() onTap) async {
  AdsVariable.isShowingAd.value = false;
  if (await checkConnectivity()) {
    if (!AdsVariable.isPurchase.value) {
      print(Platform.isAndroid ? AdsVariable.interPreLoad : AdsVariable.interPreLoad);
      if (AdsVariable.adShowHomeFlag == "1" &&
          (Platform.isAndroid ? AdsVariable.interPreLoad : AdsVariable.interPreLoad) != "11") {
        if (AdsVariable.homeFlagOnline == "0") {
          AdsVariable.homeFlag = 0;
        }

        if (AdsVariable.homeFlag % 2 == 0) {
          loadingScreen.show();
          Future.delayed(const Duration(seconds: 2)).then((value) async {
            loadingScreen.hide();
            AdsLoadUtil().showInterCommon(() {}, onTap);
          });
        } else {
          onTap();
        }
        AdsVariable.homeFlag++;
      } else {
        onTap();
      }
    } else {
      onTap();
    }
  } else {
    showToast("Please Start your internet.");
  }
}

