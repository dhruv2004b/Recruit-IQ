// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recruit_iq/Model/all_models.dart';
// import 'package:recruit_iq/services/app_services.dart';
// import 'package:recruit_iq/utils/app_exceptions.dart';
// import '../controllers/auth_controller.dart';
//
// // ─────────────────────────────────────────────────────────────────────────────
// // STATS CONTROLLER
// // ─────────────────────────────────────────────────────────────────────────────
// class StatsController extends GetxController {
//   final _service = StatsService();
//
//   final stats = Rxn<StatsResponse>();
//   final isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchStats();
//   }
//
//   Future<void> fetchStats() async {
//     isLoading.value = true;
//     try {
//       stats.value = await _service.getStats();
//     } on ApiException catch (e) {
//       Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // PROFILE CONTROLLER (Candidate)
// // ─────────────────────────────────────────────────────────────────────────────
// class ProfileController extends GetxController {
//   final _service = CandidatesService();
//   final _auth = Get.find<AuthController>();
//
//   final isUpdating = false.obs;
//   final isLoadingRecommendations = false.obs;
//   final recommendations = <JobRecommendation>[].obs;
//
//   CandidateProfile? get profile => _auth.candidateProfile.value;
//
//   Future<void> updateProfile(Map<String, dynamic> payload) async {
//     final id = profile?.id;
//     if (id == null) return;
//     isUpdating.value = true;
//     try {
//       await _service.updateCandidate(id, payload);
//       await _auth.refreshUser();
//       Get.back();
//       Get.snackbar(
//         'Profile Updated',
//         'Your search ranking has been recalculated.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade100,
//       );
//     } on ApiException catch (e) {
//       Get.snackbar(
//         'Update Failed',
//         e.message,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isUpdating.value = false;
//     }
//   }
//
//   Future<void> fetchRecommendations() async {
//     isLoadingRecommendations.value = true;
//     try {
//       recommendations.value = await _service.getRecommendedJobs();
//     } on ApiException catch (e) {
//       Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoadingRecommendations.value = false;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/app_services.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';
import '../controllers/auth_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATS CONTROLLER
// ─────────────────────────────────────────────────────────────────────────────
class StatsController extends GetxController {
  final _service = StatsService();
  final _auth = Get.find<AuthController>(); // Added reference to clear state bounds

  final stats = Rxn<StatsResponse>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    isLoading.value = true;
    try {
      // 1. Fetch fresh operational dashboard counters from the stats service
      stats.value = await _service.getStats();

      // 2. Synchronously update profile strings (like names/companies) to avoid cross-tab mismatches
      await _auth.refreshUser();
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROFILE CONTROLLER (Candidate)
// ─────────────────────────────────────────────────────────────────────────────
class ProfileController extends GetxController {
  final _service = CandidatesService();
  final _auth = Get.find<AuthController>();

  final isUpdating = false.obs;
  final isLoadingRecommendations = false.obs;
  final recommendations = <JobRecommendation>[].obs;

  CandidateProfile? get profile => _auth.candidateProfile.value;

  Future<void> updateProfile(Map<String, dynamic> payload) async {
    final id = profile?.id;
    if (id == null) return;
    isUpdating.value = true;
    try {
      await _service.updateCandidate(id, payload);
      await _auth.refreshUser();
      Get.back();
      Get.snackbar(
        'Profile Updated',
        'Your search ranking has been recalculated.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Update Failed',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> fetchRecommendations() async {
    isLoadingRecommendations.value = true;
    try {
      recommendations.value = await _service.getRecommendedJobs();
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingRecommendations.value = false;
    }
  }
}