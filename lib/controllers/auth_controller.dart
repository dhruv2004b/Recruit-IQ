import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/api_client.dart';
import 'package:recruit_iq/services/auth_services.dart';
import 'package:recruit_iq/services/hive_services.dart';
import 'package:recruit_iq/services/secure_storage.dart';
import 'package:recruit_iq/utils/app_connectivity.dart';
import 'package:recruit_iq/utils/app_constant.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final _authService = AuthService();

  // ── Observables ──────────────────────────────────────────────────
  final isLoading = false.obs;
  final recruiterProfile = Rxn<RecruiterProfile>();
  final candidateProfile = Rxn<CandidateProfile>();
  final role = ''.obs;

  // ── Getters ──────────────────────────────────────────────────────
  bool get isRecruiter => role.value == AppConstants.roleRecruiter;
  bool get isCandidate => role.value == AppConstants.roleCandidate;

  // ── Splash: restore session ──────────────────────────────────────
  Future<void> checkSession() async {
    isLoading.value = true;
    try {
      final token = await SecureStorageService.getToken();
      if (token == null) {
        Get.offAllNamed(Routes.login);
        return;
      }
      ApiClient().setToken(token);
      await _fetchAndRouteUser();
    } catch (_) {
      await _clearSession();
      Get.offAllNamed(Routes.login);
    } finally {
      isLoading.value = false;
    }
  }

  // ── Login ────────────────────────────────────────────────────────
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      showLog("accessToken: before access token");
      final auth = await _authService.login(email, password);
      showLog("accessToken: ${auth.accessToken}");
      await _persistTokenAndRoute(auth.accessToken);
    } on ApiException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to connect. Check your network.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ── Register ─────────────────────────────────────────────────────
  Future<void> register(Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      final auth = await _authService.register(payload);
      await _persistTokenAndRoute(auth.accessToken);
      Get.snackbar(
        'Welcome!',
        'Account created successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );
    } on ApiException catch (e) {
      final msg = e.message.contains('duplicate')
          ? 'Email already exists.'
          : e.message;
      Get.snackbar(
        'Registration Failed',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } catch (_) {
      Get.snackbar(
        'Error',
        'Unable to connect. Check your network.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ── Logout ───────────────────────────────────────────────────────
  Future<void> logout() async {
    await _clearSession();
    Get.offAllNamed(Routes.login);
  }

  // ── Refresh current user (called after profile update) ───────────
  Future<void> refreshUser() async {
    try {
      await _fetchAndRouteUser(navigate: false);
    } catch (_) {}
  }

  // ── Private helpers ──────────────────────────────────────────────
  Future<void> _persistTokenAndRoute(String token) async {
    await SecureStorageService.saveToken(token);
    showLog("saved token to secure storgae");
    ApiClient().setToken(token);
    showLog("saved token to secure storgae after");
    await _fetchAndRouteUser();
    showLog("sfetch Route suer done");
  }

  Future<void> _fetchAndRouteUser({bool navigate = true}) async {
    final me = await _authService.getMe();
    final userRole = me['role'] as String;
    role.value = userRole;
    await HiveStorage.saveRole(userRole);

    if (userRole == AppConstants.roleRecruiter) {
      recruiterProfile.value = RecruiterProfile.fromJson(me);
      if (navigate) Get.offAllNamed(Routes.recruiterHome);
    } else {
      candidateProfile.value = CandidateProfile.fromJson(me);
      await HiveStorage.saveCandidateId(candidateProfile.value!.id);
      if (navigate) Get.offAllNamed(Routes.candidateHome);
    }
  }

  Future<void> _clearSession() async {
    await SecureStorageService.clearAll();
    await HiveStorage.clearUser();
    ApiClient().clearToken();
    recruiterProfile.value = null;
    candidateProfile.value = null;
    role.value = '';
  }
}
