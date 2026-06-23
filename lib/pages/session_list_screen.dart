import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/search_controller.dart' as sc;
import 'package:recruit_iq/routes/app_routes.dart';
import 'package:recruit_iq/services/app_services.dart';
import 'package:recruit_iq/utils/app_utils.dart';
import 'package:recruit_iq/widgets/common_widgets.dart';

import '../utils/app_theme.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  final _jobsService = JobsService();
  final _isLoading = true.obs;
  final _sessions = <SearchSession>[].obs;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    final jobId = args?['jobId'] as String?;
    if (jobId != null) _loadSessions(jobId);
  }

  Future<void> _loadSessions(String jobId) async {
    _isLoading.value = true;
    try {
      _sessions.value = await _jobsService.getJobSessions(jobId);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search History')),
      body: Obx(() {
        if (_isLoading.value) return const LoadingList(count: 4, itemHeight: 70);
        if (_sessions.isEmpty) {
          return const EmptyState(
            icon: Icons.history_rounded,
            title: 'No search sessions yet',
            subtitle: 'Run a search for this job to see history here.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final session = _sessions[i];
            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.divider),
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.manage_search_rounded,
                    color: AppColors.primary, size: 20),
              ),
              title: Text('Session ${i + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(AppUtils.formatDateTime(session.createdAt),
                  style: const TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary),
              onTap: () {
                Get.find<sc.SearchController>().loadSession(session.id);
                Get.toNamed(Routes.sessionDetail);
              },
            );
          },
        );
      }),
    );
  }
}
