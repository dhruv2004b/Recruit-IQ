// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recruit_iq/controllers/auth_controller.dart';
// import 'package:recruit_iq/controllers/nav_controller.dart';
// import 'package:recruit_iq/controllers/stats_controller.dart';
// import 'package:recruit_iq/widgets/common_widgets.dart';
//
// import '../utils/app_theme.dart';
//
// class DashboardTab extends StatelessWidget {
//   const DashboardTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final stats = Get.find<StatsController>();
//     final auth = Get.find<AuthController>();
//     final navCtrl = Get.find<NavController>();
//     return RefreshIndicator(
//       onRefresh: stats.fetchStats,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Greeting
//             RichText(
//               text: TextSpan(
//                 style: const TextStyle(color: AppColors.textPrimary),
//                 children: [
//                   const TextSpan(
//                     text: 'Hello, ',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
//                   ),
//                   TextSpan(
//                     text: auth.recruiterProfile.value?.fullName.split(' ').first ?? 'Recruiter',
//                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
//                   ),
//                   const TextSpan(text: ' 👋'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Text('Here\'s your hiring overview',
//                 style: TextStyle(color: AppColors.textSecondary)),
//             const SizedBox(height: 24),
//
//             // Stats cards
//             // Obx(() {
//             //   if (stats.isLoading.value) {
//             //     return Row(
//             //       children: [
//             //         Expanded(child: ShimmerCard(height: 110)),
//             //         const SizedBox(width: 10),
//             //         Expanded(child: ShimmerCard(height: 110)),
//             //         const SizedBox(width: 10),
//             //         Expanded(child: ShimmerCard(height: 110)),
//             //       ],
//             //     );
//             //   }
//             //   final s = stats.stats.value;
//             //   return Row(
//             //     children: [
//             //       StatCard(
//             //         label: 'Jobs Posted',
//             //         value: '${s?.totalJobs ?? 0}',
//             //         icon: Icons.work_rounded,
//             //         color: AppColors.primary,
//             //       ),
//             //       const SizedBox(width: 10),
//             //       StatCard(
//             //         label: 'Candidates',
//             //         value: '${s?.totalCandidates ?? 0}',
//             //         icon: Icons.people_rounded,
//             //         color: AppColors.success,
//             //       ),
//             //       const SizedBox(width: 10),
//             //       StatCard(
//             //         label: 'AI Searches',
//             //         value: '${s?.totalSessions ?? 0}',
//             //         icon: Icons.manage_search_rounded,
//             //         color: AppColors.secondary,
//             //       ),
//             //     ],
//             //   );
//             // }),
// // Stats cards
//             Obx(() {
//               if (stats.isLoading.value) {
//                 return Row(
//                   children: [
//                     Expanded(child: ShimmerCard(height: 110)),
//                     const SizedBox(width: 10),
//                     Expanded(child: ShimmerCard(height: 110)),
//                     const SizedBox(width: 10),
//                     Expanded(child: ShimmerCard(height: 110)),
//                   ],
//                 );
//               }
//
//               // Point directly to the values inline through the controller stream
//               return Row(
//                 children: [
//                   Expanded(
//                     child: StatCard(
//                       label: 'Jobs Posted',
//                       value: '${stats.stats.value?.totalJobs ?? 0}',
//                       icon: Icons.work_rounded,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: StatCard(
//                       label: 'Candidates',
//                       value: '${stats.stats.value?.totalCandidates ?? 0}',
//                       icon: Icons.people_rounded,
//                       color: AppColors.success,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: StatCard(
//                       label: 'AI Searches',
//                       value: '${stats.stats.value?.totalSessions ?? 0}',
//                       icon: Icons.manage_search_rounded,
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//             const SizedBox(height: 32),
//
//             // Tips card
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [AppColors.primary, Color(0xFF6366F1)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Icon(Icons.lightbulb_outline,
//                           color: Colors.white, size: 20),
//                       SizedBox(width: 8),
//                       Text('AI Tip',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14)),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Add detailed job descriptions with required skills and experience for more accurate AI-powered candidate matching.',
//                     style: TextStyle(
//                         color: Colors.white.withOpacity(0.9), fontSize: 13, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Quick actions
//             const SectionHeader(title: 'Quick Actions'),
//             Row(
//               children: [
//                 _QuickActionCard(
//                   icon: Icons.add_circle_outline_rounded,
//                   label: 'Post a Job',
//                   color: AppColors.primary,
//                   onTap: () => Get.toNamed('/create-job'),
//                 ),
//                 const SizedBox(width: 12),
//                 _QuickActionCard(
//                   icon: Icons.manage_search_rounded,
//                   label: 'AI Search',
//                   color: AppColors.success,
//                   onTap: () {
//                     navCtrl.changeTab(3);
//                     // Switch to Search tab (index 3)
//                     // This is handled by parent nav — just navigate there
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _QuickActionCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;
//
//   const _QuickActionCard({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.08),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: color.withOpacity(0.2)),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: color, size: 22),
//               const SizedBox(width: 10),
//               Text(label,
//                   style: TextStyle(
//                       color: color,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/nav_controller.dart';
import 'package:recruit_iq/controllers/stats_controller.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = Get.find<StatsController>();
    final auth = Get.find<AuthController>();
    final navCtrl = Get.find<NavController>();
    return RefreshIndicator(
      onRefresh: stats.fetchStats,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.textPrimary),
                children: [
                  const TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: auth.recruiterProfile.value?.fullName.split(' ').first ?? 'Recruiter',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const TextSpan(text: ' 👋'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text('Here\'s your hiring overview',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),

            // Stats cards
            Obx(() {
              if (stats.isLoading.value) {
                return Row(
                  children: [
                    Expanded(child: ShimmerCard(height: 110)),
                    const SizedBox(width: 10),
                    Expanded(child: ShimmerCard(height: 110)),
                    const SizedBox(width: 10),
                    Expanded(child: ShimmerCard(height: 110)),
                  ],
                );
              }

              // Removed outer Expanded widgets since StatCard already contains an internal Expanded
              return Row(
                children: [
                  StatCard(
                    label: 'Jobs Posted',
                    value: '${stats.stats.value?.totalJobs ?? 0}',
                    icon: Icons.work_rounded,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    label: 'Candidates',
                    value: '${stats.stats.value?.totalCandidates ?? 0}',
                    icon: Icons.people_rounded,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    label: 'AI Searches',
                    value: '${stats.stats.value?.totalSessions ?? 0}',
                    icon: Icons.manage_search_rounded,
                    color: AppColors.secondary,
                  ),
                ],
              );
            }),
            const SizedBox(height: 32),

            // Tips card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF6366F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('AI Tip',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add detailed job descriptions with required skills and experience for more accurate AI-powered candidate matching.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick actions
            const SectionHeader(title: 'Quick Actions'),
            Row(
              children: [
                _QuickActionCard(
                  icon: Icons.add_circle_outline_rounded,
                  label: 'Post a Job',
                  color: AppColors.primary,
                  onTap: () => Get.toNamed('/create-job'),
                ),
                const SizedBox(width: 12),
                _QuickActionCard(
                  icon: Icons.manage_search_rounded,
                  label: 'AI Search',
                  color: AppColors.success,
                  onTap: () {
                    navCtrl.changeTab(3);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Text(label,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}