import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/app_services.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';
import '../../routes/app_routes.dart';

class SearchController extends GetxController {
  final _service = SearchService();

  final isSearching = false.obs;
  final searchResponse = Rxn<SearchResponse>();
  final sessionDetail = Rxn<SessionDetail>();
  final isLoadingSession = false.obs;

  // Feedback map: candidateId → 'up'|'down'
  final feedback = <String, String>{}.obs;

  // Selected job & filter state
  final selectedJobId = ''.obs;
  final minYearsExp = Rxn<int>();
  final locationFilter = ''.obs;

  Future<void> runSearch({int topK = 20, int shortlistN = 10}) async {
    if (selectedJobId.value.isEmpty) {
      Get.snackbar(
        'Select a Job',
        'Please select a job before searching.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    isSearching.value = true;
    feedback.clear();
    try {
      final filters = SearchFilters(
        minYearsExp: minYearsExp.value,
        location: locationFilter.value.isEmpty ? null : locationFilter.value,
      );
      searchResponse.value = await _service.runSearch(
        jobId: selectedJobId.value,
        topK: topK,
        shortlistN: shortlistN,
        filters: filters,
      );
      Get.toNamed(Routes.searchResults);
    } on ApiException catch (e) {
      Get.snackbar(
        'Search Failed',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Error',
        'Search failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> submitFeedback(String candidateId, String signal) async {
    final sessionId = searchResponse.value?.sessionId;
    if (sessionId == null) return;
    // Optimistic update
    feedback[candidateId] = signal;
    try {
      await _service.submitFeedback(sessionId, candidateId, signal);
    } on ApiException catch (e) {
      // Revert
      feedback.remove(candidateId);
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> loadSession(String sessionId) async {
    isLoadingSession.value = true;
    try {
      sessionDetail.value = await _service.getSession(sessionId);
      feedback.value = Map<String, String>.from(sessionDetail.value!.feedback);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingSession.value = false;
    }
  }

  void resetSearch() {
    searchResponse.value = null;
    feedback.clear();
    selectedJobId.value = '';
    minYearsExp.value = null;
    locationFilter.value = '';
  }

  Color feedbackColor(String candidateId) {
    final f = feedback[candidateId];
    if (f == 'up') return Colors.green;
    if (f == 'down') return Colors.red;
    return Colors.grey;
  }
}
