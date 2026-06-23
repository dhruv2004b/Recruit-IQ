import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/api_client.dart';

class AuthService {
  final _client = ApiClient();

  Future<AuthResponse> login(String email, String password) async {
    final data = await _client.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> register(Map<String, dynamic> payload) async {
    final data = await _client.post('/auth/register', payload);
    return AuthResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> getMe() async {
    final data = await _client.get('/auth/me');
    return Map<String, dynamic>.from(data);
  }
}
