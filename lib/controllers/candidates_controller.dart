import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/app_services.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';

class CandidatesController extends GetxController {
  final _service = CandidatesService();

  final candidates = <CandidateProfile>[].obs;
  final isLoading = false.obs;
  final selectedCandidate = Rxn<CandidateProfile>();
  final isLoadingDetail = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCandidates();
  }

  Future<void> fetchCandidates() async {
    isLoading.value = true;
    try {
      candidates.value = await _service.getCandidates();
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCandidate(String id) async {
    // Return cached if already loaded
    final cached = candidates.firstWhereOrNull((c) => c.id == id);
    if (cached != null) {
      selectedCandidate.value = cached;
      return;
    }
    isLoadingDetail.value = true;
    try {
      selectedCandidate.value = await _service.getCandidate(id);
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingDetail.value = false;
    }
  }
}
