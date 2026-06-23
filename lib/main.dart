import 'package:recruit_iq/pages/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recruit_iq/routes/app_pages.dart';
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/services/hive_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:recruit_iq/utils/App_Text.dart';
import 'package:recruit_iq/utils/App_Variable.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await HiveStorage.init();
  // WakelockPlus.enable();
  String mLanguageCode = prefs.getString("languagecode") ?? "en";
  String mCountryCode = prefs.getString("countrycode") ?? "US";
  AdsVariable.isFirstTimeVisited = prefs.getBool("isFirstTime") ?? false;
  showLog("isFirstTime-main---->${AdsVariable.isFirstTimeVisited}");
  AdsVariable.isFirstTimePurchased =
      prefs.getBool("isFirstTimePurchased") ?? false;
  showLog("isFirstTimePurchased-main---->${AdsVariable.isFirstTimePurchased}");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    value,
  ) {
    runApp(MyApp(languageCode: mLanguageCode, countryCode: mCountryCode));
  });
}

class MyApp extends StatelessWidget {
  final String languageCode;
  final String countryCode;

  const MyApp({
    super.key,
    required this.languageCode,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height.roundToDouble();
    screenWidth = MediaQuery.of(context).size.width.roundToDouble();
    textSize =
        ((MediaQuery.of(context).size.height +
                    MediaQuery.of(context).size.width) /
                2)
            .roundToDouble();
    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    isTab = smallestDimension >= 600;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(1242, 2688),
      builder: (context, child) {
        return GetMaterialApp(
          translations: LocalString(),
          textDirection: TextDirection.ltr,
          locale: Locale(languageCode, countryCode),
          debugShowCheckedModeBanner: false,
          title: "Recruit IQ",
          theme: ThemeData(
            primarySwatch: Colors.grey,
            unselectedWidgetColor: Colors.transparent,
          ),
          // home: SplashScreen(),
          initialRoute: Routes.splash,
          getPages: AppPages.pages,
          defaultTransition: Transition.cupertino,
        );
      },
    );
  }
}
