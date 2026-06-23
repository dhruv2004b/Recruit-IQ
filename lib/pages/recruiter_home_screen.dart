// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recruit_iq/controllers/auth_controller.dart';
// import 'package:recruit_iq/pages/candidates_tab.dart';
// import 'package:recruit_iq/pages/dashboard_tab.dart';
// import 'package:recruit_iq/pages/jobs_tab.dart';
//
// import '../utils/app_theme.dart';
// import 'search_tab.dart';
//
// class RecruiterHomeScreen extends StatelessWidget {
//   const RecruiterHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final currentIndex = 0.obs;
//     final auth = Get.find<AuthController>();
//
//     final tabs = const [
//       DashboardTab(),
//       JobsTab(),
//       CandidatesTab(),
//       SearchTab(),
//     ];
//
//     return Obx(() => Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryLight,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.psychology_alt_rounded,
//                   color: AppColors.primary, size: 20),
//             ),
//             const SizedBox(width: 10),
//             const Text('RecruitIQ'),
//           ],
//         ),
//         actions: [
//           PopupMenuButton<String>(
//             icon: CircleAvatar(
//               radius: 16,
//               backgroundColor: AppColors.primaryLight,
//               child: Text(
//                 (auth.recruiterProfile.value?.fullName ?? 'R')[0].toUpperCase(),
//                 style: const TextStyle(
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14),
//               ),
//             ),
//             onSelected: (val) {
//               if (val == 'logout') auth.logout();
//             },
//             itemBuilder: (_) => [
//               PopupMenuItem(
//                 enabled: false,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       auth.recruiterProfile.value?.fullName ?? '',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimary),
//                     ),
//                     if (auth.recruiterProfile.value?.company != null)
//                       Text(
//                         auth.recruiterProfile.value!.company!,
//                         style: const TextStyle(
//                             fontSize: 12,
//                             color: AppColors.textSecondary),
//                       ),
//                   ],
//                 ),
//               ),
//               const PopupMenuDivider(),
//               const PopupMenuItem(
//                 value: 'logout',
//                 child: Row(
//                   children: [
//                     Icon(Icons.logout, size: 18, color: AppColors.error),
//                     SizedBox(width: 10),
//                     Text('Logout',
//                         style: TextStyle(color: AppColors.error)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: IndexedStack(
//         index: currentIndex.value,
//         children: tabs,
//       ),
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           border: Border(top: BorderSide(color: AppColors.divider)),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: currentIndex.value,
//           onTap: (i) => currentIndex.value = i,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard_outlined),
//               activeIcon: Icon(Icons.dashboard_rounded),
//               label: 'Dashboard',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.work_outline_rounded),
//               activeIcon: Icon(Icons.work_rounded),
//               label: 'Jobs',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.people_outline_rounded),
//               activeIcon: Icon(Icons.people_rounded),
//               label: 'Candidates',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search_rounded),
//               activeIcon: Icon(Icons.manage_search_rounded),
//               label: 'Search',
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/nav_controller.dart';
import 'package:recruit_iq/pages/candidates_tab.dart';
import 'package:recruit_iq/pages/dashboard_tab.dart';
import 'package:recruit_iq/pages/jobs_tab.dart';

import '../utils/app_theme.dart';
import 'search_tab.dart';

class RecruiterHomeScreen extends StatelessWidget {
  const RecruiterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.put(NavController());
    // final currentIndex = 0.obs;
    final auth = Get.find<AuthController>();

    final tabs = const [
      DashboardTab(),
      JobsTab(),
      CandidatesTab(),
      SearchTab(),
    ];

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.psychology_alt_rounded,
                  color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('RecruitIQ'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                (auth.recruiterProfile.value?.fullName ?? 'R')[0].toUpperCase(),
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ),
            onSelected: (val) {
              if (val == 'logout') auth.logout();
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auth.recruiterProfile.value?.fullName ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    if (auth.recruiterProfile.value?.company != null)
                      Text(
                        auth.recruiterProfile.value!.company!,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary),
                      ),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18, color: AppColors.error),
                    SizedBox(width: 10),
                    Text('Logout',
                        style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: navCtrl.currentIndex.value,
        children: tabs,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: navCtrl.currentIndex.value,
          onTap: (i) => navCtrl.currentIndex.value = i,
          type: BottomNavigationBarType.fixed, // Keeps labels always visible layout-wise
          selectedItemColor: AppColors.primary, // Color for the active icon
          unselectedItemColor: AppColors.textSecondary, // Color for the inactive icons
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_rounded),
              activeIcon: Icon(Icons.work_rounded),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              activeIcon: Icon(Icons.people_rounded),
              label: 'Candidates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              activeIcon: Icon(Icons.manage_search_rounded),
              label: 'Search',
            ),
          ],
        ),
      ),
    ));
  }
}