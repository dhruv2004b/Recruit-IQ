import 'dart:io';
import 'package:recruit_iq/pages/rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recruit_iq/ads/ads_load_util.dart';
import 'package:recruit_iq/generated/assets.dart';
import 'package:recruit_iq/in_app_purchase/app.dart';
import 'package:recruit_iq/pages/home_screen.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/App_Colors.dart';
import 'package:recruit_iq/utils/App_Strings.dart';
import 'package:recruit_iq/utils/App_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:recruit_iq/widgets/Press_Unpress_Widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController(initialPage: 0);

  final RxInt _activePage = 0.obs;

  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageNative(),
    const PageThree(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              color: AppColors.blackColor,
              // image: DecorationImage(image: AssetImage(Assets.commonBg), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth,
                  child: PageView.builder(
                    controller: _pageController,
                    allowImplicitScrolling: false,
                    onPageChanged: (int page) {
                      if (_activePage.value == 1 && page == 2) {
                        if ((AdsVariable.nativeFull == "11" ||
                            (!AdsLoadUtil.isNativeAdLoaded.value ||
                                AdsLoadUtil.isNativeAdFailed.value))) {
                          _activePage.value = page + 1;
                          _pageController.animateToPage(
                            3,
                            duration: const Duration(milliseconds: 1),
                            curve: Curves.easeIn,
                          );
                        } else {
                          _activePage.value = page;
                        }
                      } else if (_activePage.value == 3 && page == 2) {
                        if ((AdsVariable.nativeFull == "11" ||
                            (!AdsLoadUtil.isNativeAdLoaded.value ||
                                AdsLoadUtil.isNativeAdFailed.value))) {
                          _activePage.value = page - 1;
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 1),
                            curve: Curves.easeIn,
                          );
                        } else {
                          _activePage.value = page;
                        }
                      } else {
                        _activePage.value = page;
                      }
                    },
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[index % _pages.length];
                    },
                  ),
                ),
                Positioned.fill(
                  child: Obx(
                    () => _activePage.value == 2
                        ? const SizedBox() // disable gradient on native ad page
                        : IgnorePointer(
                            ignoring: true,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.25, 0.35],
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Obx(
                  () =>
                      ((AdsVariable.nativeFull != "11" ||
                              (AdsLoadUtil.isNativeAdLoaded.value)) &&
                          (_activePage.value == 2))
                      ? const SizedBox()
                      : Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            // decoration: const BoxDecoration(
                            //   gradient: LinearGradient(
                            //     begin: Alignment.bottomCenter,
                            //     end: Alignment.topCenter,
                            //     colors: [
                            //       Colors.black,
                            //       Colors.transparent,
                            //     ],
                            //   ),
                            // ),
                            margin: EdgeInsets.only(left: 50.w, right: 50.w),
                            child: SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //   width: constraints.maxWidth * 0.55,
                                  //   child: Stack(
                                  //     alignment: Alignment.centerRight,
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Obx(
                                  //                 () => _activePage.value == 0
                                  //                 ? Image.asset(
                                  //               Assets.introIndicator1,
                                  //               width: constraints.maxWidth * 0.13,
                                  //             )
                                  //                 : _activePage.value == 1
                                  //                 ? Image.asset(
                                  //               Assets.introIndicator2,
                                  //               width: constraints.maxWidth * 0.13,
                                  //             )
                                  //                 : Image.asset(
                                  //               Assets.introIndicator3,
                                  //               width: constraints.maxWidth * 0.13,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         width: constraints.maxWidth * 0.1,
                                  //         child: Lottie.asset(Assets.introLeft),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   child:
                                  //   SizedBox(
                                  //     width: constraints.maxWidth * 0.18,
                                  //     child: Lottie.asset(Assets.introLeft),
                                  //   ).marginOnly(right: 500.w),
                                  // ),
                                  SizedBox(
                                    // width: constraints.maxWidth * 0.55,
                                    width: constraints.maxWidth,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Obx(
                                              () => _activePage.value == 0
                                                  ? Image.asset(
                                                      Assets.introIndicator1,
                                                      width:
                                                          constraints.maxWidth *
                                                          0.16,
                                                    )
                                                  : _activePage.value == 1
                                                  ? Image.asset(
                                                      Assets.introIndicator2,
                                                      width:
                                                          constraints.maxWidth *
                                                          0.16,
                                                    )
                                                  : Image.asset(
                                                      Assets.introIndicator3,
                                                      width:
                                                          constraints.maxWidth *
                                                          0.16,
                                                    ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   width: constraints.maxWidth * 0.18,
                                        //   child: Lottie.asset(Assets.introLeft),
                                        // ).marginOnly(right: 500.w),
                                      ],
                                    ),
                                  ).marginOnly(bottom: 10),
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    child: Obx(
                                      () => _activePage.value == 0
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [

                                                Text(
                                                  AppStrings.intro1txt.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.038,

                                                    color: AppColors.whiteColor,
                                                    fontFamily: aregular,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                // .marginSymmetric(horizontal: 60.w,vertical: 30.w),
                                                Text(
                                                  AppStrings.intro1sub.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.024,
                                                    fontFamily: gregular,
                                                    color: Color(0xFF6D6D6D),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ).marginSymmetric(horizontal: 80.w),
                                              ],
                                              // children: [
                                              //   Image.asset(
                                              //     width:
                                              //         constraints.maxWidth *
                                              //         0.50,
                                              //     Assets.introIntro1Text,
                                              //   ),
                                              // ],
                                            ).marginSymmetric(vertical: 10.w)
                                          : _activePage.value == 1
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [

                                                Text(
                                                  AppStrings.intro2txt.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.038,

                                                    color: AppColors.whiteColor,
                                                    fontFamily: aregular,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                // .marginSymmetric(horizontal: 60.w,vertical: 30.w),
                                                Text(
                                                  AppStrings.intro2sub.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.024,
                                                    fontFamily: gregular,
                                                    color: Color(0xFF6D6D6D),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ).marginSymmetric(horizontal: 80.w),
                                              ],
                                              // children: [
                                              //   Image.asset(
                                              //     width:
                                              //         constraints.maxWidth *
                                              //         0.70,
                                              //     Assets.introIntro2Text,
                                              //   ),
                                              // ],
                                            ).marginSymmetric(vertical: 10.w)
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [

                                                Text(
                                                  AppStrings.intro3txt.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.038,

                                                    color: AppColors.whiteColor,
                                                    fontFamily: aregular,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                // .marginSymmetric(horizontal: 60.w,vertical: 30.w),
                                                Text(
                                                  AppStrings.intro3sub.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: textSize * 0.024,
                                                    fontFamily: gregular,
                                                    color: Color(0xFF6D6D6D),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ).marginSymmetric(horizontal: 80.w),
                                              ],
                                              // children: [
                                              //   Image.asset(
                                              //     width:
                                              //         constraints.maxWidth *
                                              //         0.70,
                                              //     Assets.introIntro3Text,
                                              //   ),
                                              // ],
                                            ).marginSymmetric(vertical: 10.w),
                                    ),
                                  ).marginSymmetric(vertical: 10.w),

                                  PressUnPressWidget(
                                        widget: Container(
                                          width: constraints.maxWidth * 0.86,
                                          height: constraints.maxWidth * 0.18,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                Assets.commonMainBtn,
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                _activePage.value != 3
                                                    ? AppStrings.strContinue.tr
                                                    : AppStrings.strContinue.tr,
                                                style: TextStyle(
                                                  fontFamily: gsemibold,
                                                  fontSize: textSize * 0.030,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blackColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ).marginOnly(right: 20.w),
                                              // Image.asset(
                                              //   Assets.introForwardIc,
                                              //   height: constraints.maxWidth * 0.04,
                                              //   width: constraints.maxWidth * 0.04,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        onTap: () async {
                                          if (_activePage.value == 0) {
                                            _pageController.animateToPage(
                                              1,
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          } else if (_activePage.value == 1) {
                                            _pageController.animateToPage(
                                              2,
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          } else if (_activePage.value ==
                                              (_pages.length - 1)) {
                                            if (AdsVariable.showRateScreen) {
                                              Get.offAll(
                                                () => RateScreen(),
                                                transition:
                                                    Transition.cupertino,
                                              );
                                            } else {
                                              SharedPreferences prefs =
                                                  await SharedPreferences.getInstance();
                                              prefs.setBool(
                                                "isFirstTime",
                                                true,
                                              );

                                              if (await checkConnectivity()) {
                                                if (Platform.isIOS) {
                                                  // if (!AdsVariable
                                                  //     .isPurchase
                                                  //     .value) {
                                                  //   Get.offAll(
                                                  //     () => const UpsellScreen(
                                                  //       isNotFromSplash: false,
                                                  //       isFromGenerate: false,
                                                  //       screen: "Intro",
                                                  //     ),
                                                  //     transition: Transition
                                                  //         .rightToLeft,
                                                  //   );
                                                  // } else {

                                                    Get.offAll(
                                                      () => const HomeScreen(),
                                                      transition: Transition
                                                          .rightToLeft,
                                                    );

                                                  // }
                                                } else {
                                                  Get.offAll(
                                                    () => const HomeScreen(),
                                                    transition:
                                                        Transition.rightToLeft,
                                                  );
                                                }
                                              } else {
                                                Get.offAll(
                                                  () => const HomeScreen(),
                                                  transition:
                                                      Transition.rightToLeft,
                                                );
                                              }
                                            }
                                          }
                                        },
                                      )
                                      .marginSymmetric(vertical: 10.w)
                                      .marginOnly(bottom: 10.w),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class PageOne extends StatefulWidget {
//   const PageOne({super.key});
//
//   @override
//   State<PageOne> createState() => _PageOneState();
// }
//
// class _PageOneState extends State<PageOne> {
//   // late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller = VideoPlayerController.asset(Assets.introIntro1VideoBg)
//     //   ..initialize().then((_) {
//     //     _controller
//     //       ..setLooping(true)
//     //       ..setVolume(0)
//     //       ..play();
//     //     setState(() {});
//     //   });
//     //
//   }
//
//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Image.asset(
//           width: constraints.maxWidth,
//           Assets.introIntro1Bg,
//           fit: BoxFit.cover,
//         );
//       },
//     );
//   }
// }
//
// class PageTwo extends StatefulWidget {
//   const PageTwo({super.key});
//
//   @override
//   State<PageTwo> createState() => _PageTwoState();
// }
//
// class _PageTwoState extends State<PageTwo> {
//   // late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller = VideoPlayerController.asset(Assets.introIntro2VideoBg)
//     //   ..initialize().then((_) {
//     //     setState(() {});
//     //   });
//     //
//     // _controller.setLooping(true);
//     // _controller.setVolume(0);
//     // _controller.play();
//   }
//
//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Image.asset(
//           width: constraints.maxWidth,
//           Assets.introIntro2Bg,
//           fit: BoxFit.cover,
//         );
//       },
//     );
//   }
// }
//
// class PageThree extends StatefulWidget {
//   const PageThree({super.key});
//
//   @override
//   State<PageThree> createState() => _PageThreeState();
// }
//
// class _PageThreeState extends State<PageThree> {
//   // late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // _controller = VideoPlayerController.asset(Assets.introIntro3VideoBg)
//     //   ..initialize().then((_) {
//     //     setState(() {});
//     //   });
//     //
//     // _controller.setLooping(true);
//     // _controller.setVolume(0);
//     // _controller.play();
//   }
//
//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Image.asset(
//           width: constraints.maxWidth,
//           Assets.introIntro3Bg,
//           fit: BoxFit.cover,
//         );
//       },
//     );
//   }
// }

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minimalistic, glowing AI/Talent hub visual anchor
                Container(
                  height: constraints.maxHeight * 0.28,
                  width: constraints.maxHeight * 0.28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Leave bottom spacing open for the main IntroPage text framework
                SizedBox(height: constraints.maxHeight * 0.25),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// PAGE TWO: Core Intelligence / Matching Anchor
// ──────────────────────────────────────────────────────────────────
class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Abstract multi-layered dashboard visual
                SizedBox(
                  height: constraints.maxHeight * 0.28,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: -0.15,
                        child: Container(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: 0.1,
                        child: Container(
                          width: constraints.maxWidth * 0.45,
                          height: constraints.maxHeight * 0.16,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.psychology_rounded, color: Colors.blueAccent, size: 20),
                                  const SizedBox(width: 8),
                                  Container(width: 60, height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(4))),
                                ],
                              ),
                              Container(width: double.infinity, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(3))),
                              Container(width: constraints.maxWidth * 0.25, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(3))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.25),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ──────────────────────────────────────────────────────────────────
// PAGE THREE: Final Verification / Success Anchor
// ──────────────────────────────────────────────────────────────────
class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Clean system check-mark completion graphic
                Container(
                  height: constraints.maxHeight * 0.28,
                  width: constraints.maxHeight * 0.28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.greenAccent.withOpacity(0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.4),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 72,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.25),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PageNative extends StatelessWidget {
  const PageNative({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: (!AdsVariable.isPurchase.value)
                ? ((AdsVariable.nativeFull != "11" &&
                          !AdsVariable.nativeFull
                              .toString()
                              .split("/")
                              .last
                              .contains("vv")))
                      ? NativeAdsWidget(
                          showNativeAd: AdsVariable.nativeAdFullScreen,
                          isSmallNative: false,
                          isFullNative: true,
                        )
                      : Container()
                : Container(),
          );
        },
      ),
    );
  }
}
