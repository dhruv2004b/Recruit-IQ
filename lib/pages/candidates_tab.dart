import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';
import '../utils/app_theme.dart';

class CandidatesTab extends StatelessWidget {
  const CandidatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CandidatesController>();
    final searchQuery = ''.obs;

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: (v) => searchQuery.value = v.toLowerCase(),
            decoration: const InputDecoration(
              hintText: 'Search candidates...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        // List
        Expanded(
          child: Obx(() {
            if (ctrl.isLoading.value) return const LoadingList(itemHeight: 80);

            final filtered = searchQuery.value.isEmpty
                ? ctrl.candidates
                : ctrl.candidates
                .where((c) =>
            c.fullName.toLowerCase().contains(searchQuery.value) ||
                (c.headline?.toLowerCase().contains(searchQuery.value) ?? false) ||
                (c.currentTitle?.toLowerCase().contains(searchQuery.value) ?? false))
                .toList();

            if (filtered.isEmpty) {
              return const EmptyState(
                icon: Icons.people_outline_rounded,
                title: 'No candidates found',
                subtitle: 'Try adjusting your search.',
              );
            }

            return RefreshIndicator(
              onRefresh: ctrl.fetchCandidates,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _CandidateCard(candidate: filtered[i]),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CandidateCard extends StatelessWidget {
  final CandidateProfile candidate;
  const _CandidateCard({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CandidatesController>().selectedCandidate.value = candidate;
        Get.toNamed(Routes.candidateDetail);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            AppAvatar(name: candidate.fullName, radius: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(candidate.fullName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.textPrimary)),
                  if (candidate.headline != null) ...[
                    const SizedBox(height: 2),
                    Text(candidate.headline!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (candidate.yearsExp > 0)
                        InfoChip(
                          label: '${candidate.yearsExp.toStringAsFixed(0)}y exp',
                          color: AppColors.primaryLight,
                        ),
                      const SizedBox(width: 6),
                      if (candidate.location != null)
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 2),
                            Text(candidate.location!,
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
