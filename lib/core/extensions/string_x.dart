extension StringX on String {
  bool get isArabic => this.startsWith(RegExp(r'[\u0600-\u06FF]'));

  /// Avatar initials: first letter of the first two words (e.g. "Ahmed
  /// Ibrahim" \u2192 "AI"), or just the first letter for a single-word name.
  String get initials {
    final parts = trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}