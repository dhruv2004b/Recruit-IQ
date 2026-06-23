import 'package:recruit_iq/in_app_purchase/app_credit.dart';
import 'package:recruit_iq/in_app_purchase/credit_manager.dart';
import 'package:recruit_iq/utils/Ads_Variable.dart';
import 'package:get/get.dart';

const androidAppId = "com.example.recruit_iq";
const iOSAppId = "12345678";
const iOSPrivacyPolicy =
    "https://example.com/privacy_policy.html";
const androidPrivacyPolicy =
    "https://example.com/page/privacy_policy.html";
const iOSTermsOfUse = "http://example.com/pages/Terms%20of%20Use.html";
const termsOfUseAndroid =
    "https://example.com/page/terms_of_use.html";

// Future<void> checkPurchase(int count, Function() onTap) async {
//   // await onTap();
//   print("${AdsVariable.isPurchase}");
//   CreditsManager creditsManager = CreditsManager();
//   String date1 = await creditsManager.getUserExpireDate();
//   if (AdsVariable.premiumShow != "0" && !AdsVariable.isLoggedIn.value) {
//     if (date1 != "11") {
//       if (AdsVariable.isPurchase.value != true) {
//         if (AdsVariable.credit.value >= count) {
//           await onTap();
//         } else {
//           var result = await Get.to(
//             () => AppCreditScreen(
//               isNotFromSplash: true,
//               isFromGenerate: true,
//               showTester: true,
//               screen: 'UploadScreen',
//             ),
//             transition: Transition.downToUp,
//           );
//           if (result ?? false) {
//             await onTap();
//           }
//         }
//       } else {
//         if (AdsVariable.credit.value >= count) {
//           await onTap();
//         } else {
//           var result = await Get.to(
//             () => AppCreditScreen(
//               isNotFromSplash: true,
//               isFromGenerate: true,
//               showTester: true,
//               screen: 'UploadScreen',
//             ),
//             transition: Transition.downToUp,
//           );
//           if (result ?? false) {
//             await onTap();
//           }
//         }
//       }
//     } else {
//       if (AdsVariable.credit.value >= count) {
//         await onTap();
//       } else {
//         var result = await Get.to(
//           () => AppCreditScreen(
//             isNotFromSplash: true,
//             isFromGenerate: true,
//             showTester: true,
//             screen: 'UploadScreen',
//           ),
//           transition: Transition.downToUp,
//         );
//         if (result ?? false) {
//           await onTap();
//         }
//       }
//     }
//   } else {
//     await onTap();
//   }
// }

class AppConstants {
  // Change this to your actual server IP/URL
  static final String baseUrl = AdsVariable.backendUri;
  // static const String baseUrl = 'http://localhost:8005';

  // Hive Box Names
  static const String userBox = 'user_box';

  // Hive Keys
  static const String userKey = 'current_user';
  static const String roleKey = 'user_role';
  static const String candidateIdKey = 'candidate_id';

  // Secure Storage Keys
  static const String tokenKey = 'access_token';

  // Roles
  static const String roleRecruiter = 'recruiter';
  static const String roleCandidate = 'candidate';

  // Skill Proficiency Options
  static const List<String> proficiencyLevels = [
    'beginner',
    'intermediate',
    'advanced',
    'expert',
  ];

  // Company Size Options
  static const List<String> companySizes = [
    '1-10',
    '11-50',
    '51-200',
    '201-500',
    '501-1000',
    '1001-5000',
    '5001-10000',
    '10001+',
  ];
}
