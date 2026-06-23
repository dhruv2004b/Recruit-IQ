import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/auth_controller.dart';
import 'package:recruit_iq/controllers/candidates_controller.dart';
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class CandidateDetailScreen extends StatelessWidget {
  const CandidateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CandidatesController>();
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Profile'),
        actions: [
          // Only candidate can edit their own profile
          if (auth.isCandidate)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Get.toNamed(Routes.editProfile),
            ),
        ],
      ),
      body: Obx(() {
        if (ctrl.isLoadingDetail.value) {
          return const LoadingList(count: 6, itemHeight: 80);
        }
        final c = ctrl.selectedCandidate.value;
        if (c == null) {
          return const EmptyState(
              icon: Icons.person_off_outlined, title: 'Profile not found');
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeader(candidate: c),
              const SizedBox(height: 16),
              _ScoresCard(candidate: c),
              const SizedBox(height: 16),
              if (c.skills.isNotEmpty) _SkillsCard(skills: c.skills),
              if (c.skills.isNotEmpty) const SizedBox(height: 16),
              if (c.careerHistory.isNotEmpty) _CareerCard(history: c.careerHistory),
              if (c.careerHistory.isNotEmpty) const SizedBox(height: 16),
              if (c.education.isNotEmpty) _EducationCard(education: c.education),
              if (c.education.isNotEmpty) const SizedBox(height: 16),
              if (c.certifications.isNotEmpty) _CertificationsCard(certs: c.certifications),
              if (c.certifications.isNotEmpty) const SizedBox(height: 16),
              if (c.languages.isNotEmpty) _LanguagesCard(languages: c.languages),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final CandidateProfile candidate;
  const _ProfileHeader({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(name: candidate.fullName, radius: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(candidate.fullName,
                    style: Theme.of(context).textTheme.titleLarge),
                if (candidate.headline != null) ...[
                  const SizedBox(height: 2),
                  Text(candidate.headline!,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (candidate.location != null)
                      _MetaChip(
                        icon: Icons.location_on_outlined,
                        label: candidate.location!,
                      ),
                    if (candidate.yearsExp > 0)
                      _MetaChip(
                        icon: Icons.work_history_outlined,
                        label:
                        '${candidate.yearsExp.toStringAsFixed(1)} yrs exp',
                      ),
                    if (candidate.currentTitle != null)
                      _MetaChip(
                        icon: Icons.badge_outlined,
                        label: candidate.currentTitle!,
                      ),
                  ],
                ),
                if (candidate.domain.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: candidate.domain
                        .map((d) => InfoChip(label: d))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _ScoresCard extends StatelessWidget {
  final CandidateProfile candidate;
  const _ScoresCard({required this.candidate});

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
          const SectionHeader(title: 'AI Signals'),
          ScoreBar(label: 'Activity Score', value: candidate.activityScore),
          const SizedBox(height: 10),
          ScoreBar(
              label: 'Trajectory Score', value: candidate.trajectoryScore),
          if (candidate.redrobSignals.isNotEmpty) ...[
            const SizedBox(height: 12),
            if (candidate.redrobSignals['profile_completeness_score'] != null)
              ScoreBar(
                label: 'Profile Completeness',
                value:
                ((candidate.redrobSignals['profile_completeness_score'] as num) / 100),
              ),
          ],
        ],
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  final List<Skill> skills;
  const _SkillsCard({required this.skills});

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
          SectionHeader(
            title: 'Skills',
            trailing: Text('${skills.length} total',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => SkillChip(skill: s)).toList(),
          ),
        ],
      ),
    );
  }
}

class _CareerCard extends StatelessWidget {
  final List<CareerHistory> history;
  const _CareerCard({required this.history});

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
          const SectionHeader(title: 'Career History'),
          ...history.asMap().entries.map((entry) {
            final i = entry.key;
            final c = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: c.isCurrent
                              ? AppColors.success
                              : AppColors.divider,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (i < history.length - 1)
                        Container(
                          width: 2,
                          height: 50,
                          color: AppColors.divider,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.textPrimary)),
                        Text(c.company,
                            style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.primary)),
                        const SizedBox(height: 2),
                        Text(
                          c.isCurrent
                              ? '${AppUtils.formatDate(c.startDate)} — Present'
                              : '${AppUtils.formatDate(c.startDate)} — ${AppUtils.formatDate(c.endDate)}',
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary),
                        ),
                        if (c.durationMonths != null)
                          Text('${c.durationMonths} months',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                        if (c.description != null) ...[
                          const SizedBox(height: 4),
                          Text(c.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  height: 1.4)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final List<Education> education;
  const _EducationCard({required this.education});

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
          const SectionHeader(title: 'Education'),
          ...education.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.school_outlined,
                      color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.institution,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      Text('${e.degree} • ${e.fieldOfStudy}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary)),
                      if (e.startYear != null || e.endYear != null)
                        Text(
                          '${e.startYear ?? ''} — ${e.endYear ?? 'Present'}',
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary),
                        ),
                      if (e.tier != null)
                        InfoChip(
                            label: 'Tier ${e.tier}',
                            color: AppColors.primaryLight),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _CertificationsCard extends StatelessWidget {
  final List<Certification> certs;
  const _CertificationsCard({required this.certs});

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
          const SectionHeader(title: 'Certifications'),
          ...certs.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.verified_outlined,
                    size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      if (c.issuer != null)
                        Text(
                          '${c.issuer}${c.year != null ? ' • ${c.year}' : ''}',
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _LanguagesCard extends StatelessWidget {
  final List<Language> languages;
  const _LanguagesCard({required this.languages});

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
          const SectionHeader(title: 'Languages'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: languages
                .map((l) => InfoChip(
                label: '${l.language} (${AppUtils.capitalize(l.proficiency)})'))
                .toList(),
          ),
        ],
      ),
    );
  }
}
