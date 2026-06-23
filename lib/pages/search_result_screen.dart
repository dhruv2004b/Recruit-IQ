import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as sc;
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<sc.SearchController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Search Results'),
        actions: [
          Obx(() {
            final count = ctrl.searchResponse.value?.results.length ?? 0;
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: InfoChip(
                  label: '$count candidates',
                  color: AppColors.primaryLight,
                ),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        final response = ctrl.searchResponse.value;
        if (response == null) {
          return const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'No results',
            subtitle: 'Run a search to see candidates here.',
          );
        }

        if (response.results.isEmpty) {
          return const EmptyState(
            icon: Icons.people_outline_rounded,
            title: 'No candidates matched',
            subtitle: 'Try relaxing the filters or updating the job description.',
          );
        }

        return Column(
          children: [
            // Processing time banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.primaryLight,
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      size: 14, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'AI pipeline completed in ${response.processingTimeMs}ms',
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: response.results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _ResultCard(result: response.results[i]),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final SearchResult result;
  const _ResultCard({required this.result});

  Color get _rankColor {
    if (result.rank == 1) return AppColors.gold;
    if (result.rank == 2) return AppColors.silver;
    if (result.rank == 3) return AppColors.bronze;
    return AppColors.textSecondary;
  }

  Color get _scoreColor {
    final pct = result.matchScore * 100;
    if (pct >= 85) return AppColors.success;
    if (pct >= 70) return AppColors.primary;
    if (pct >= 50) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final searchCtrl = Get.find<sc.SearchController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Rank badge
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _rankColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '#${result.rank}',
                      style: TextStyle(
                          color: _rankColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AppAvatar(name: result.fullName, radius: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.fullName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppColors.textPrimary)),
                      if (result.headline != null)
                        Text(result.headline!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                // Match score
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _scoreColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    AppUtils.toPercent(result.matchScore),
                    style: TextStyle(
                        color: _scoreColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          // Score breakdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: _ScoreBreakdownRow(breakdown: result.scoreBreakdown),
          ),
          const SizedBox(height: 10),

          // Why this candidate
          if (result.whyThisCandidate != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.success.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline,
                        size: 14, color: AppColors.success),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        result.whyThisCandidate!,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Why-not flags
          if (result.whyNotFlags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Wrap(
                spacing: 6,
                children: result.whyNotFlags
                    .map((f) => InfoChip(
                  label: '⚠ $f',
                  color: AppColors.warning.withOpacity(0.1),
                  textColor: AppColors.warning,
                ))
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 12),

          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                // View profile
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.find<CandidatesController>()
                          .loadCandidate(result.candidateId);
                      Get.toNamed(Routes.candidateDetail);
                    },
                    icon: const Icon(Icons.person_outline, size: 16),
                    label: const Text('View Profile'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 38),
                      textStyle: const TextStyle(fontSize: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Thumbs up
                Obx(() {
                  final fb = searchCtrl.feedback[result.candidateId];
                  return Row(
                    children: [
                      _FeedbackBtn(
                        icon: Icons.thumb_up_alt_rounded,
                        active: fb == 'up',
                        activeColor: AppColors.success,
                        onTap: () => searchCtrl.submitFeedback(
                            result.candidateId,
                            fb == 'up' ? 'neutral' : 'up'),
                      ),
                      const SizedBox(width: 6),
                      _FeedbackBtn(
                        icon: Icons.thumb_down_alt_rounded,
                        active: fb == 'down',
                        activeColor: AppColors.error,
                        onTap: () => searchCtrl.submitFeedback(
                            result.candidateId,
                            fb == 'down' ? 'neutral' : 'down'),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreBreakdownRow extends StatelessWidget {
  final ScoreBreakdown breakdown;
  const _ScoreBreakdownRow({required this.breakdown});

  @override
  Widget build(BuildContext context) {
    final scores = [
      ('Semantic', breakdown.semanticSimilarity),
      ('Skills', breakdown.skillMatch),
      ('Seniority', breakdown.seniorityFit),
      ('Trajectory', breakdown.trajectoryScore),
      ('Behavioral', breakdown.behavioralScore),
    ];

    return Row(
      children: scores.map((s) {
        final color = s.$2 >= 0.75
            ? AppColors.success
            : s.$2 >= 0.5
            ? AppColors.warning
            : AppColors.error;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              children: [
                Text(s.$1,
                    style: const TextStyle(
                        fontSize: 9, color: AppColors.textSecondary)),
                const SizedBox(height: 3),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: s.$2.clamp(0.0, 1.0),
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FeedbackBtn extends StatelessWidget {
  final IconData icon;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  const _FeedbackBtn({
    required this.icon,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active
              ? activeColor.withOpacity(0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: active ? activeColor : AppColors.divider),
        ),
        child: Icon(icon,
            size: 18,
            color: active ? activeColor : AppColors.textSecondary),
      ),
    );
  }
}
