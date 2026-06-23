import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/jobs_controller.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as sc;
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<JobsController>();

    return Obx(() {
      final job = ctrl.selectedJob.value;
      if (job == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

      return Scaffold(
        appBar: AppBar(
          title: const Text('Job Details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit',
              onPressed: () => Get.toNamed(Routes.editJob),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              tooltip: 'Delete',
              onPressed: () => ctrl.deleteJob(job.id),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text('Posted ${AppUtils.formatDate(job.createdAt)}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Parsed signals
              if (job.parsedSignals != null) ...[
                _SignalsCard(signals: job.parsedSignals!),
                const SizedBox(height: 20),
              ],

              // Raw JD (collapsed)
              _RawJdCard(jd: job.rawJd),
              const SizedBox(height: 20),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.find<sc.SearchController>().selectedJobId.value = job.id;
                        // Navigate to search tab (index 3)
                        Get.back();
                        // User needs to go to search tab themselves
                        Get.snackbar(
                          'Job Selected',
                          'Go to Search tab to run AI matching.',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 3),
                        );
                      },
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: const Text('Run AI Search'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => Get.toNamed(Routes.sessionList,
                        arguments: {'jobId': job.id}),
                    icon: const Icon(Icons.history_rounded, size: 18),
                    label: const Text('History'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SignalsCard extends StatelessWidget {
  final ParsedSignals signals;
  const _SignalsCard({required this.signals});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              const Text('AI Parsed Signals',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 14),
          if (signals.seniorityLevel != null)
            _SignalRow(
              icon: Icons.stairs_rounded,
              label: 'Seniority',
              content: AppUtils.capitalize(signals.seniorityLevel!),
            ),
          if (signals.yearsExpMin != null)
            _SignalRow(
              icon: Icons.trending_up_rounded,
              label: 'Min Experience',
              content: '${signals.yearsExpMin} years',
            ),
          if (signals.requiredSkills.isNotEmpty)
            _ChipRow(
              icon: Icons.check_circle_outline,
              label: 'Required Skills',
              chips: signals.requiredSkills,
              color: AppColors.success,
            ),
          if (signals.preferredSkills.isNotEmpty)
            _ChipRow(
              icon: Icons.star_outline_rounded,
              label: 'Preferred Skills',
              chips: signals.preferredSkills,
              color: AppColors.warning,
            ),
          if (signals.domain.isNotEmpty)
            _ChipRow(
              icon: Icons.category_outlined,
              label: 'Domain',
              chips: signals.domain,
              color: AppColors.secondary,
            ),
          if (signals.softSkills.isNotEmpty)
            _ChipRow(
              icon: Icons.psychology_outlined,
              label: 'Soft Skills',
              chips: signals.softSkills,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String content;
  const _SignalRow({required this.icon, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
          Text(content,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> chips;
  final Color color;
  const _ChipRow({required this.icon, required this.label, required this.chips, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: chips
                .map((s) => InfoChip(
                label: s,
                color: color.withOpacity(0.1),
                textColor: color))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RawJdCard extends StatefulWidget {
  final String jd;
  const _RawJdCard({required this.jd});

  @override
  State<_RawJdCard> createState() => _RawJdCardState();
}

class _RawJdCardState extends State<_RawJdCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Job Description',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(widget.jd,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.6)),
          ],
        ],
      ),
    );
  }
}
