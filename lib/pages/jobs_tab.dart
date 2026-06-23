import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class JobsTab extends StatelessWidget {
  const JobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<JobsController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.createJob),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Post Job'),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) return const LoadingList(itemHeight: 90);

        if (ctrl.jobs.isEmpty) {
          return EmptyState(
            icon: Icons.work_outline_rounded,
            title: 'No jobs yet',
            subtitle: 'Post your first job and let AI find the best candidates.',
            action: ElevatedButton.icon(
              onPressed: () => Get.toNamed(Routes.createJob),
              icon: const Icon(Icons.add),
              label: const Text('Post a Job'),
              style: ElevatedButton.styleFrom(minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: ctrl.fetchJobs,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: ctrl.jobs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _JobCard(job: ctrl.jobs[i]),
          ),
        );
      }),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Job job;
  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<JobsController>().selectedJob.value = job;
        Get.toNamed(Routes.jobDetail);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.work_outline_rounded,
                  color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(AppUtils.formatDate(job.createdAt),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  if (job.parsedSignals != null &&
                      job.parsedSignals!.requiredSkills.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: job.parsedSignals!.requiredSkills
                          .take(3)
                          .map((s) => InfoChip(label: s))
                          .toList(),
                    ),
                  ],
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
