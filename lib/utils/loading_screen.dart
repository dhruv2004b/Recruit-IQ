import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/utils/App_Colors.dart';
import 'package:recruit_iq/utils/App_Strings.dart';
import 'package:recruit_iq/utils/App_Variable.dart';

@protected
final scaffoldGlobalKey = GlobalKey<ScaffoldState>();

class LoadingScreen {
  final GlobalKey globalKey;

  LoadingScreen(this.globalKey);

  show([String? text]) {
    showDialog<String>(
      context: Get.context!,
      builder:
          (BuildContext context) => Scaffold(
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15.w),
                    color: AppColors.blackColor.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCube(
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                            ),
                          );
                        },
                        size: constraints.maxWidth * 0.08,
                      ).marginOnly(bottom: constraints.maxWidth * 0.03),
                      SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: Text(
                          AppStrings.strLoadingAds.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: medium,
                            fontSize: textSize * 0.024,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }

  hide() {
    if (Get.context == null) return;

    Navigator.pop(Get.context!);
  }
}

@protected
var loadingScreen = LoadingScreen(scaffoldGlobalKey);
