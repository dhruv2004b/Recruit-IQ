import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/controllers/stats_controller.dart';
import 'package:recruit_iq/services/app_services.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';
import '../../routes/app_routes.dart';

class JobsController extends GetxController {
  final _service = JobsService();

  final jobs = <Job>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final selectedJob = Rxn<Job>();

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    isLoading.value = true;
    try {
      jobs.value = await _service.getJobs();
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectJob(String id) async {
    isLoading.value = true;
    try {
      selectedJob.value = await _service.getJob(id);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createJob(String title, String rawJd) async {
    isSubmitting.value = true;
    try {
      final job = await _service.createJob(title, rawJd);
      jobs.insert(0, job);
      final stats = Get.find<StatsController>();
      stats.fetchStats();
      Get.back();
      Get.snackbar(
        'Success',
        'Job created and AI signals parsed!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateJob(String id, String title, String rawJd) async {
    isSubmitting.value = true;
    try {
      final updated = await _service.updateJob(id, title, rawJd);
      final idx = jobs.indexWhere((j) => j.id == id);
      if (idx != -1) jobs[idx] = updated;
      selectedJob.value = updated;
      Get.back();
      Get.snackbar(
        'Updated',
        'Job re-parsed successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteJob(String id) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Job'),
        content: const Text(
          'This will also remove all associated search sessions. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    isLoading.value = true;
    try {
      await _service.deleteJob(id);
      jobs.removeWhere((j) => j.id == id);
      if (Get.currentRoute == Routes.jobDetail) Get.back();
      Get.snackbar(
        'Deleted',
        'Job removed.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
