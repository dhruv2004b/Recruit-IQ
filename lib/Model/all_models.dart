// ─────────────────────────────────────────────────────────────────────────────
// AUTH MODELS
// ─────────────────────────────────────────────────────────────────────────────

class AuthResponse {
  final String accessToken;
  final String tokenType;

  AuthResponse({required this.accessToken, required this.tokenType});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    accessToken: json['access_token'],
    tokenType: json['token_type'],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// USER / PROFILE MODELS
// ─────────────────────────────────────────────────────────────────────────────

class RecruiterProfile {
  final String id;
  final String fullName;
  final String? company;
  final String createdAt;
  final String role;

  RecruiterProfile({
    required this.id,
    required this.fullName,
    this.company,
    required this.createdAt,
    required this.role,
  });

  factory RecruiterProfile.fromJson(Map<String, dynamic> json) =>
      RecruiterProfile(
        id: json['id'],
        fullName: json['full_name'],
        company: json['company'],
        createdAt: json['created_at'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'company': company,
    'created_at': createdAt,
    'role': role,
  };
}

class Skill {
  final String name;
  final String proficiency;
  final int endorsements;
  final int? durationMonths;

  Skill({
    required this.name,
    required this.proficiency,
    this.endorsements = 0,
    this.durationMonths,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    name: json['name'] ?? '',
    proficiency: json['proficiency'] ?? 'beginner',
    endorsements: json['endorsements'] ?? 0,
    durationMonths: json['duration_months'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'proficiency': proficiency,
    'endorsements': endorsements,
    if (durationMonths != null) 'duration_months': durationMonths,
  };

  Skill copyWith({String? name, String? proficiency, int? endorsements}) =>
      Skill(
        name: name ?? this.name,
        proficiency: proficiency ?? this.proficiency,
        endorsements: endorsements ?? this.endorsements,
        durationMonths: durationMonths,
      );
}

class Education {
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final int? startYear;
  final int? endYear;
  final String? tier;

  Education({
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    this.startYear,
    this.endYear,
    this.tier,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    institution: json['institution'] ?? '',
    degree: json['degree'] ?? '',
    fieldOfStudy: json['field_of_study'] ?? '',
    startYear: json['start_year'],
    endYear: json['end_year'],
    tier: json['tier'],
  );

  Map<String, dynamic> toJson() => {
    'institution': institution,
    'degree': degree,
    'field_of_study': fieldOfStudy,
    if (startYear != null) 'start_year': startYear,
    if (endYear != null) 'end_year': endYear,
    if (tier != null) 'tier': tier,
  };
}

class CareerHistory {
  final String company;
  final String title;
  final String? startDate;
  final String? endDate;
  final int? durationMonths;
  final bool isCurrent;
  final String? industry;
  final String? companySize;
  final String? description;

  CareerHistory({
    required this.company,
    required this.title,
    this.startDate,
    this.endDate,
    this.durationMonths,
    this.isCurrent = false,
    this.industry,
    this.companySize,
    this.description,
  });

  factory CareerHistory.fromJson(Map<String, dynamic> json) => CareerHistory(
    company: json['company'] ?? '',
    title: json['title'] ?? '',
    startDate: json['start_date'],
    endDate: json['end_date'],
    durationMonths: json['duration_months'],
    isCurrent: json['is_current'] ?? false,
    industry: json['industry'],
    companySize: json['company_size'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'company': company,
    'title': title,
    'start_date': startDate,
    'end_date': endDate,
    'duration_months': durationMonths,
    'is_current': isCurrent,
    if (industry != null) 'industry': industry,
    if (companySize != null) 'company_size': companySize,
    if (description != null) 'description': description,
  };
}

class Certification {
  final String name;
  final String? issuer;
  final int? year;

  Certification({required this.name, this.issuer, this.year});

  factory Certification.fromJson(Map<String, dynamic> json) => Certification(
    name: json['name'] ?? '',
    issuer: json['issuer'],
    year: json['year'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    if (issuer != null) 'issuer': issuer,
    if (year != null) 'year': year,
  };
}

class Language {
  final String language;
  final String proficiency;

  Language({required this.language, required this.proficiency});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    language: json['language'] ?? '',
    proficiency: json['proficiency'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'language': language,
    'proficiency': proficiency,
  };
}

class CandidateProfile {
  final String id;
  final String? userId;
  final String fullName;
  final String? headline;
  final String? email;
  final String? location;
  final double yearsExp;
  final String? currentTitle;
  final String? currentCompany;
  final List<String> domain;
  final List<Skill> skills;
  final List<Education> education;
  final List<CareerHistory> careerHistory;
  final List<Certification> certifications;
  final List<Language> languages;
  final Map<String, dynamic> redrobSignals;
  final double activityScore;
  final double trajectoryScore;
  final String createdAt;
  final String role;

  CandidateProfile({
    required this.id,
    this.userId,
    required this.fullName,
    this.headline,
    this.email,
    this.location,
    this.yearsExp = 0,
    this.currentTitle,
    this.currentCompany,
    this.domain = const [],
    this.skills = const [],
    this.education = const [],
    this.careerHistory = const [],
    this.certifications = const [],
    this.languages = const [],
    this.redrobSignals = const {},
    this.activityScore = 0,
    this.trajectoryScore = 0,
    required this.createdAt,
    required this.role,
  });

  factory CandidateProfile.fromJson(Map<String, dynamic> json) =>
      CandidateProfile(
        id: json['id'] ?? '',
        userId: json['user_id'],
        fullName: json['full_name'] ?? '',
        headline: json['headline'],
        email: json['email'],
        location: json['location'],
        yearsExp: (json['years_exp'] ?? 0).toDouble(),
        currentTitle: json['current_title'],
        currentCompany: json['current_company'],
        domain: List<String>.from(json['domain'] ?? []),
        skills: (json['skills'] as List? ?? [])
            .map((s) => Skill.fromJson(s))
            .toList(),
        education: (json['education'] as List? ?? [])
            .map((e) => Education.fromJson(e))
            .toList(),
        careerHistory: (json['career_history'] as List? ?? [])
            .map((c) => CareerHistory.fromJson(c))
            .toList(),
        certifications: (json['certifications'] as List? ?? [])
            .map((c) => Certification.fromJson(c))
            .toList(),
        languages: (json['languages'] as List? ?? [])
            .map((l) => Language.fromJson(l))
            .toList(),
        redrobSignals: Map<String, dynamic>.from(json['redrob_signals'] ?? {}),
        activityScore: (json['activity_score'] ?? 0).toDouble(),
        trajectoryScore: (json['trajectory_score'] ?? 0).toDouble(),
        createdAt: json['created_at'] ?? '',
        role: json['role'] ?? 'candidate',
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    if (headline != null) 'headline': headline,
    if (email != null) 'email': email,
    if (location != null) 'location': location,
    'years_exp': yearsExp,
    if (currentTitle != null) 'current_title': currentTitle,
    if (currentCompany != null) 'current_company': currentCompany,
    'domain': domain,
    'skills': skills.map((s) => s.toJson()).toList(),
    'education': education.map((e) => e.toJson()).toList(),
    'career_history': careerHistory.map((c) => c.toJson()).toList(),
    'certifications': certifications.map((c) => c.toJson()).toList(),
    'languages': languages.map((l) => l.toJson()).toList(),
    'redrob_signals': redrobSignals,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// JOB MODELS
// ─────────────────────────────────────────────────────────────────────────────

class ParsedSignals {
  final List<String> requiredSkills;
  final List<String> preferredSkills;
  final String? seniorityLevel;
  final int? yearsExpMin;
  final List<String> domain;
  final List<String> cultureSignals;
  final List<String> softSkills;

  ParsedSignals({
    this.requiredSkills = const [],
    this.preferredSkills = const [],
    this.seniorityLevel,
    this.yearsExpMin,
    this.domain = const [],
    this.cultureSignals = const [],
    this.softSkills = const [],
  });

  factory ParsedSignals.fromJson(Map<String, dynamic> json) => ParsedSignals(
    requiredSkills: List<String>.from(json['required_skills'] ?? []),
    preferredSkills: List<String>.from(json['preferred_skills'] ?? []),
    seniorityLevel: json['seniority_level'],
    yearsExpMin: json['years_exp_min'],
    domain: List<String>.from(json['domain'] ?? []),
    cultureSignals: List<String>.from(json['culture_signals'] ?? []),
    softSkills: List<String>.from(json['soft_skills'] ?? []),
  );
}

class Job {
  final String id;
  final String title;
  final String rawJd;
  final ParsedSignals? parsedSignals;
  final String createdAt;

  Job({
    required this.id,
    required this.title,
    required this.rawJd,
    this.parsedSignals,
    required this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['id'],
    title: json['title'],
    rawJd: json['raw_jd'],
    parsedSignals: json['parsed_signals'] != null
        ? ParsedSignals.fromJson(json['parsed_signals'])
        : null,
    createdAt: json['created_at'],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH MODELS
// ─────────────────────────────────────────────────────────────────────────────

class ScoreBreakdown {
  final double semanticSimilarity;
  final double skillMatch;
  final double seniorityFit;
  final double trajectoryScore;
  final double behavioralScore;

  ScoreBreakdown({
    this.semanticSimilarity = 0,
    this.skillMatch = 0,
    this.seniorityFit = 0,
    this.trajectoryScore = 0,
    this.behavioralScore = 0,
  });

  factory ScoreBreakdown.fromJson(Map<String, dynamic> json) => ScoreBreakdown(
    semanticSimilarity: (json['semantic_similarity'] ?? 0).toDouble(),
    skillMatch: (json['skill_match'] ?? 0).toDouble(),
    seniorityFit: (json['seniority_fit'] ?? 0).toDouble(),
    trajectoryScore: (json['trajectory_score'] ?? 0).toDouble(),
    behavioralScore: (json['behavioral_score'] ?? 0).toDouble(),
  );
}

class SearchResult {
  final int rank;
  final String candidateId;
  final String fullName;
  final String? headline;
  final double matchScore;
  final ScoreBreakdown scoreBreakdown;
  final String? whyThisCandidate;
  final List<String> whyNotFlags;

  SearchResult({
    required this.rank,
    required this.candidateId,
    required this.fullName,
    this.headline,
    required this.matchScore,
    required this.scoreBreakdown,
    this.whyThisCandidate,
    this.whyNotFlags = const [],
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    rank: json['rank'] ?? 0,
    candidateId: json['candidate_id'],
    fullName: json['full_name'],
    headline: json['headline'],
    matchScore: (json['match_score'] ?? 0).toDouble(),
    scoreBreakdown: json['score_breakdown'] != null
        ? ScoreBreakdown.fromJson(json['score_breakdown'])
        : ScoreBreakdown(),
    whyThisCandidate: json['why_this_candidate'],
    whyNotFlags: List<String>.from(json['why_not_flags'] ?? []),
  );
}

class SearchResponse {
  final String sessionId;
  final String jobId;
  final List<SearchResult> results;
  final int processingTimeMs;

  SearchResponse({
    required this.sessionId,
    required this.jobId,
    required this.results,
    this.processingTimeMs = 0,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    sessionId: json['session_id'],
    jobId: json['job_id'],
    results: (json['results'] as List? ?? [])
        .map((r) => SearchResult.fromJson(r))
        .toList(),
    processingTimeMs: json['processing_time_ms'] ?? 0,
  );
}

class SearchSession {
  final String id;
  final String createdAt;

  SearchSession({required this.id, required this.createdAt});

  factory SearchSession.fromJson(Map<String, dynamic> json) =>
      SearchSession(id: json['id'], createdAt: json['created_at']);
}

class SessionDetail {
  final String id;
  final String recruiterId;
  final String jobId;
  final List<SearchResult> results;
  final Map<String, String> feedback;
  final String createdAt;

  SessionDetail({
    required this.id,
    required this.recruiterId,
    required this.jobId,
    required this.results,
    required this.feedback,
    required this.createdAt,
  });

  factory SessionDetail.fromJson(Map<String, dynamic> json) => SessionDetail(
    id: json['id'],
    recruiterId: json['recruiter_id'],
    jobId: json['job_id'],
    results: (json['results'] as List? ?? [])
        .map((r) => SearchResult.fromJson(r))
        .toList(),
    feedback: Map<String, String>.from(json['feedback'] ?? {}),
    createdAt: json['created_at'],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// STATS MODEL
// ─────────────────────────────────────────────────────────────────────────────

class StatsResponse {
  final int totalJobs;
  final int totalCandidates;
  final int totalSessions;

  StatsResponse({
    required this.totalJobs,
    required this.totalCandidates,
    required this.totalSessions,
  });

  factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
    totalJobs: json['total_jobs'] ?? 0,
    totalCandidates: json['total_candidates'] ?? 0,
    totalSessions: json['total_sessions'] ?? 0,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// JOB RECOMMENDATION MODEL
// ─────────────────────────────────────────────────────────────────────────────

class JobRecommendation {
  final String jobId;
  final String jobTitle;
  final String reason;
  final int matchScore;

  JobRecommendation({
    required this.jobId,
    required this.jobTitle,
    required this.reason,
    required this.matchScore,
  });

  factory JobRecommendation.fromJson(Map<String, dynamic> json) =>
      JobRecommendation(
        jobId: json['job_id'],
        jobTitle: json['job_title'],
        reason: json['reason'],
        matchScore: json['match_score'] ?? 0,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH FILTERS MODEL
// ─────────────────────────────────────────────────────────────────────────────

class SearchFilters {
  final int? minYearsExp;
  final String? location;
  final List<String>? domain;

  const SearchFilters({this.minYearsExp, this.location, this.domain});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (minYearsExp != null) map['min_years_exp'] = minYearsExp;
    if (location != null && location!.isNotEmpty) map['location'] = location;
    if (domain != null && domain!.isNotEmpty) map['domain'] = domain;
    return map;
  }

  bool get isEmpty =>
      minYearsExp == null &&
      (location == null || location!.isEmpty) &&
      (domain == null || domain!.isEmpty);
}
