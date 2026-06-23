import 'package:recruit_iq/Model/all_models.dart';
import 'package:recruit_iq/services/api_client.dart';

// ─────────────────────────────────────────────────────────────────────────────
// JOBS SERVICE
// ─────────────────────────────────────────────────────────────────────────────

class JobsService {
  final _client = ApiClient();

  Future<List<Job>> getJobs() async {
    final data = await _client.get('/jobs');
    return (data as List).map((j) => Job.fromJson(j)).toList();
  }

  Future<Job> getJob(String id) async {
    final data = await _client.get('/jobs/$id');
    return Job.fromJson(data);
  }

  Future<Job> createJob(String title, String rawJd) async {
    final data = await _client.post('/jobs', {'title': title, 'raw_jd': rawJd});
    return Job.fromJson(data);
  }

  Future<Job> updateJob(String id, String title, String rawJd) async {
    final data = await _client.put('/jobs/$id', {
      'title': title,
      'raw_jd': rawJd,
    });
    return Job.fromJson(data);
  }

  Future<void> deleteJob(String id) async {
    await _client.delete('/jobs/$id');
  }

  Future<List<SearchSession>> getJobSessions(String jobId) async {
    final data = await _client.get('/jobs/$jobId/sessions');
    return (data as List).map((s) => SearchSession.fromJson(s)).toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CANDIDATES SERVICE
// ─────────────────────────────────────────────────────────────────────────────
class CandidatesService {
  final _client = ApiClient();

  Future<List<CandidateProfile>> getCandidates() async {
    final data = await _client.get('/candidates');
    return (data as List).map((c) => CandidateProfile.fromJson(c)).toList();
  }

  Future<CandidateProfile> getCandidate(String id) async {
    final data = await _client.get('/candidates/$id');
    return CandidateProfile.fromJson(data);
  }

  Future<void> updateCandidate(String id, Map<String, dynamic> payload) async {
    await _client.put('/candidates/$id', payload);
  }

  Future<List<JobRecommendation>> getRecommendedJobs() async {
    final data = await _client.get('/candidates/me/recommended_jobs');
    return (data as List).map((r) => JobRecommendation.fromJson(r)).toList();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH SERVICE
// ─────────────────────────────────────────────────────────────────────────────
class SearchService {
  final _client = ApiClient();

  Future<SearchResponse> runSearch({
    required String jobId,
    int topK = 20,
    int shortlistN = 10,
    SearchFilters? filters,
  }) async {
    final body = <String, dynamic>{
      'job_id': jobId,
      'top_k': topK,
      'shortlist_n': shortlistN,
    };
    if (filters != null && !filters.isEmpty) {
      body['filters'] = filters.toJson();
    }
    final data = await _client.post('/search', body);
    return SearchResponse.fromJson(data);
  }

  Future<void> submitFeedback(
    String sessionId,
    String candidateId,
    String signal,
  ) async {
    await _client.post('/search/$sessionId/feedback', {
      'candidate_id': candidateId,
      'signal': signal,
    });
  }

  Future<SessionDetail> getSession(String sessionId) async {
    final data = await _client.get('/search/$sessionId');
    return SessionDetail.fromJson(data);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STATS SERVICE
// ─────────────────────────────────────────────────────────────────────────────
class StatsService {
  final _client = ApiClient();

  Future<StatsResponse> getStats() async {
    final data = await _client.get('/stats');
    return StatsResponse.fromJson(data);
  }
}
