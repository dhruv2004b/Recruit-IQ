import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/controllers/stats_controller.dart';
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class CandidateHomeScreen extends StatefulWidget {
  const CandidateHomeScreen({super.key});

  @override
  State<CandidateHomeScreen> createState() => _CandidateHomeScreenState();
}

class _CandidateHomeScreenState extends State<CandidateHomeScreen> {
  final _currentIndex = 0.obs;
  final _auth = Get.find<AuthController>();
  late final ProfileController _profileCtrl;

  @override
  void initState() {
    super.initState();
    _profileCtrl = Get.find<ProfileController>();
    _profileCtrl.fetchRecommendations();
    // Pre-load own profile into candidates controller for detail view
    final profile = _auth.candidateProfile.value;
    if (profile != null) {
      final candCtrl = Get.isRegistered<CandidatesController>()
          ? Get.find<CandidatesController>()
          : null;
      candCtrl?.selectedCandidate.value = profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology_alt_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
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
                  AppUtils.initials(
                    _auth.candidateProfile.value?.fullName ?? 'C',
                  ),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              onSelected: (val) {
                if (val == 'logout') _auth.logout();
                if (val == 'edit') Get.toNamed(Routes.editProfile);
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  enabled: false,
                  child: Text(
                    _auth.candidateProfile.value?.fullName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: 16),
                      SizedBox(width: 10),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 16, color: AppColors.error),
                      SizedBox(width: 10),
                      Text('Logout', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex.value,
          children: const [_OverviewTab(), _RecommendationsTab()],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex.value,
            onTap: (i) => _currentIndex.value = i,
            selectedItemColor: AppColors.primary, // Color for the active icon
            unselectedItemColor:
                AppColors.textSecondary, // Color for the inactive icons

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard_rounded),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_outline_rounded),
                activeIcon: Icon(Icons.star_rounded),
                label: 'Matches',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Overview Tab ─────────────────────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return RefreshIndicator(
      onRefresh: auth.refreshUser,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final profile = auth.candidateProfile.value;
          if (profile == null) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: AppColors.textPrimary),
                  children: [
                    const TextSpan(
                      text: 'Hey, ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: profile.fullName.split(' ').first,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const TextSpan(text: ' 👋'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Your profile is live on RecruitIQ',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),

              // Profile card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppAvatar(name: profile.fullName, radius: 26),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              if (profile.headline != null)
                                Text(
                                  profile.headline!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => Get.toNamed(Routes.editProfile),
                          icon: const Icon(Icons.edit_outlined, size: 14),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 34),
                            textStyle: const TextStyle(fontSize: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    ScoreBar(
                      label: 'Activity Score',
                      value: profile.activityScore,
                    ),
                    const SizedBox(height: 10),
                    ScoreBar(
                      label: 'Trajectory Score',
                      value: profile.trajectoryScore,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Skills summary
              if (profile.skills.isNotEmpty) ...[
                const SectionHeader(title: 'Your Skills'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.skills
                      .take(10)
                      .map((s) => SkillChip(skill: s))
                      .toList(),
                ),
                if (profile.skills.length > 10)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '+${profile.skills.length - 10} more skills',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
              ],

              // Info nudge
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.tips_and_updates_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Complete your career history and certifications to improve your match score in recruiter searches.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Recommendations Tab ──────────────────────────────────────────────────────
class _RecommendationsTab extends StatelessWidget {
  const _RecommendationsTab();

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();

    return Obx(() {
      if (ctrl.isLoadingRecommendations.value) {
        return const LoadingList(count: 4, itemHeight: 100);
      }
      if (ctrl.recommendations.isEmpty) {
        return EmptyState(
          icon: Icons.star_outline_rounded,
          title: 'No recommendations yet',
          subtitle: 'Complete your profile to get AI-powered job matches.',
          action: ElevatedButton.icon(
            onPressed: ctrl.fetchRecommendations,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Refresh'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: ctrl.fetchRecommendations,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: ctrl.recommendations.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) =>
              _RecommendationCard(rec: ctrl.recommendations[i], rank: i + 1),
        ),
      );
    });
  }
}

class _RecommendationCard extends StatelessWidget {
  final JobRecommendation rec;
  final int rank;
  const _RecommendationCard({required this.rec, required this.rank});

  Color get _scoreColor {
    if (rec.matchScore >= 85) return AppColors.success;
    if (rec.matchScore >= 70) return AppColors.primary;
    if (rec.matchScore >= 50) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.work_outline_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rec.jobTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  rec.reason,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _scoreColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${rec.matchScore}%',
              style: TextStyle(
                color: _scoreColor,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
