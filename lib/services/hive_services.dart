import 'package:hive_flutter/hive_flutter.dart';
import 'package:recruit_iq/utils/app_constant.dart';

/// Simple key-value Hive storage for non-sensitive user data (role, name, etc.)
/// Uses dynamic box — no TypeAdapters/build_runner needed.
class HiveStorage {
  static late Box _userBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(AppConstants.userBox);
  }

  // ── User Box helpers ──────────────────────────────────────────────

  static Future<void> saveUserData(Map<String, dynamic> data) async {
    await _userBox.put(AppConstants.userKey, data);
  }

  static Map<String, dynamic>? getUserData() {
    final raw = _userBox.get(AppConstants.userKey);
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw as Map);
  }

  static Future<void> saveRole(String role) async {
    await _userBox.put(AppConstants.roleKey, role);
  }

  static String? getRole() {
    return _userBox.get(AppConstants.roleKey) as String?;
  }

  static Future<void> saveCandidateId(String id) async {
    await _userBox.put(AppConstants.candidateIdKey, id);
  }

  static String? getCandidateId() {
    return _userBox.get(AppConstants.candidateIdKey) as String?;
  }

  static Future<void> clearUser() async {
    await _userBox.clear();
  }
}
