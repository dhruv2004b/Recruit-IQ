import 'package:get/get.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as app_search;
import 'package:recruit_iq/controllers/stats_controller.dart';
import 'package:recruit_iq/pages/Splash_Screen.dart';
import 'package:recruit_iq/pages/candidate_detail_screen.dart';
import 'package:recruit_iq/pages/candidate_home_screen.dart';
import 'package:recruit_iq/pages/create_job_screen.dart';
import 'package:recruit_iq/pages/edit_job_screen.dart';
import 'package:recruit_iq/pages/edit_profile_screen.dart';
import 'package:recruit_iq/pages/job_detail_screen.dart';
import 'package:recruit_iq/pages/login_screen.dart';
import 'package:recruit_iq/pages/recruiter_home_screen.dart';
import 'package:recruit_iq/pages/register_screen.dart';
import 'package:recruit_iq/pages/search_result_screen.dart';
import 'package:recruit_iq/pages/session_detail_screen.dart';
import 'package:recruit_iq/pages/session_list_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),
    ),
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.register, page: () => const RegisterScreen()),
    GetPage(
      name: Routes.recruiterHome,
      page: () => const RecruiterHomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => JobsController());
        Get.lazyPut(() => CandidatesController());
        Get.lazyPut(() => app_search.SearchController());
        Get.lazyPut(() => StatsController());
      }),
    ),
    GetPage(name: Routes.createJob, page: () => const CreateJobScreen()),
    GetPage(name: Routes.jobDetail, page: () => const JobDetailScreen()),
    GetPage(name: Routes.editJob, page: () => const EditJobScreen()),
    GetPage(
      name: Routes.candidateDetail,
      page: () => const CandidateDetailScreen(),
      binding: BindingsBuilder(() {
        // CandidatesController may not exist on candidate flow
        if (!Get.isRegistered<CandidatesController>()) {
          Get.lazyPut(() => CandidatesController());
        }
      }),
    ),
    GetPage(
      name: Routes.searchResults,
      page: () => const SearchResultsScreen(),
    ),
    GetPage(name: Routes.sessionList, page: () => const SessionListScreen()),
    GetPage(
      name: Routes.sessionDetail,
      page: () => const SessionDetailScreen(),
    ),
    GetPage(
      name: Routes.candidateHome,
      page: () => const CandidateHomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
        if (!Get.isRegistered<CandidatesController>()) {
          Get.lazyPut(() => CandidatesController());
        }
      }),
    ),
    GetPage(name: Routes.editProfile, page: () => const EditProfileScreen()),
  ];
}
