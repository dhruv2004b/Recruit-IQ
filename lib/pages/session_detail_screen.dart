import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as sc;
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<sc.SearchController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Session Details')),
      body: Obx(() {
        if (ctrl.isLoadingSession.value) {
          return const LoadingList(count: 5, itemHeight: 120);
        }
        final session = ctrl.sessionDetail.value;
        if (session == null) {
          return const EmptyState(
              icon: Icons.history_rounded, title: 'Session not found');
        }

        return Column(
          children: [
            // Session metadata
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: AppColors.primary, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${session.results.length} candidates matched',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                        Text(
                            'Searched on ${AppUtils.formatDateTime(session.createdAt)}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: session.results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final r = session.results[i];
                  final fb = session.feedback[r.candidateId];
                  return _SessionResultCard(result: r, feedback: fb);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _SessionResultCard extends StatelessWidget {
  final SearchResult result;
  final String? feedback;

  const _SessionResultCard({required this.result, this.feedback});

  Color get _scoreColor {
    final pct = result.matchScore * 100;
    if (pct >= 85) return AppColors.success;
    if (pct >= 70) return AppColors.primary;
    if (pct >= 50) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
              // Rank
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('#${result.rank}',
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 10)),
                ),
              ),
              const SizedBox(width: 10),
              AppAvatar(name: result.fullName, radius: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result.fullName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                    if (result.headline != null)
                      Text(result.headline!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppUtils.toPercent(result.matchScore),
                    style: TextStyle(
                        color: _scoreColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 15),
                  ),
                  if (feedback != null)
                    Row(
                      children: [
                        Icon(
                          feedback == 'up'
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_down_alt_rounded,
                          size: 12,
                          color: feedback == 'up'
                              ? AppColors.success
                              : AppColors.error,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          feedback == 'up' ? 'Liked' : 'Passed',
                          style: TextStyle(
                            fontSize: 11,
                            color: feedback == 'up'
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          if (result.whyThisCandidate != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                result.whyThisCandidate!,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.4),
              ),
            ),
          ],
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              Get.find<CandidatesController>().loadCandidate(result.candidateId);
              Get.toNamed(Routes.candidateDetail);
            },
            icon: const Icon(Icons.person_outline, size: 14),
            label: const Text('View Profile'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 36),
              textStyle: const TextStyle(fontSize: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
