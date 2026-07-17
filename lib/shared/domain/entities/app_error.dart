/// A domain-layer error: a code (string from the backend or [AppErrorCodes]),
/// an optional human-readable [message] surfaced verbatim to the UI,
/// an optional HTTP status, a network-failure flag, and a local-error flag.
///
/// Use [isLocal] to discriminate UI routing: local errors (built via
/// [AppError.local]) render inline in submit-error widgets; remote errors
/// (server responses, connectivity failures) show in a snackbar.
class AppError {
  const AppError({
    this.code,
    this.message,
    this.statusCode,
    this.isNetwork = false,
    this.fieldErrors,
    this.isLocal = false,
  });

  final String? code;

  /// Human-readable error string from the backend, shown verbatim in the UI.
  final String? message;

  final int? statusCode;
   final bool isLocal;
  final bool isNetwork;

  /// Per-field validation messages from the backend (e.g. 400 bad request).
  /// Keys are API parameter names; values are localized server messages.
  final Map<String, String>? fieldErrors;


  factory AppError.local(String code) => AppError(code: code, isLocal: true);


  @override
  String toString() =>
      'AppError(code: $code, message: $message, statusCode: $statusCode, isNetwork: $isNetwork, isLocal: $isLocal)';
}
