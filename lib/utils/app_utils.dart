import 'package:intl/intl.dart';

class AppUtils {
  static String formatDate(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '—';
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('MMM dd, yyyy').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  static String formatDateTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '—';
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('MMM dd, yyyy • hh:mm a').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  /// Converts 0.0–1.0 score to percentage string e.g. "91.0%"
  static String toPercent(double score, {int decimals = 0}) {
    return '${(score * 100).toStringAsFixed(decimals)}%';
  }

  /// Color code for match score
  static String scoreLabel(double score) {
    final pct = score * 100;
    if (pct >= 85) return 'Excellent';
    if (pct >= 70) return 'Good';
    if (pct >= 50) return 'Fair';
    return 'Low';
  }

  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static String initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Parse "CAND_0000001" → display friendly ID
  static String shortCandidateId(String id) {
    if (id.startsWith('CAND_')) return id;
    return id.substring(0, 8).toUpperCase();
  }
}
