/// Review workflow status for a single pending rating.
enum RateStatus {
  approve,
  pending,
  reject;

  static const String _approveValue = 'approve';
  static const String _rejectValue = 'reject';

  /// Parses a backend status string, defaulting to [pending] when unknown.
  static RateStatus fromValue(String? value) => switch (value) {
    _approveValue => RateStatus.approve,
    _rejectValue => RateStatus.reject,
    _ => RateStatus.pending,
  };
}
