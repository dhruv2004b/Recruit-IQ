import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:recruit_iq/services/secure_storage.dart';
import 'package:recruit_iq/utils/app_constant.dart';
import 'package:recruit_iq/utils/app_exceptions.dart';
import '../../routes/app_routes.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  String? _token;

  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  // ── HTTP Methods ──────────────────────────────────────────────────

  Future<dynamic> get(String endpoint) async {
    final res = await http.get(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: _headers,
    );
    return _handleResponse(res);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(res);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(res);
  }

  Future<dynamic> delete(String endpoint) async {
    final res = await http.delete(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: _headers,
    );
    return _handleResponse(res);
  }

  // ── Response Handler ──────────────────────────────────────────────

  dynamic _handleResponse(http.Response res) {
    final body = jsonDecode(res.body);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return body;
    }

    if (res.statusCode == 401) {
      clearToken();
      SecureStorageService.clearAll();
      // Navigate to login and clear nav stack
      Get.offAllNamed(Routes.login);
      throw UnauthorizedException(body['detail'] ?? 'Session expired. Please login again.');
    }

    throw ApiException(
      res.statusCode,
      body['detail'] ?? 'Something went wrong. Please try again.',
    );
  }
}
