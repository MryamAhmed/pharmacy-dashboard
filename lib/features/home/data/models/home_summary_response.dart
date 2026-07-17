// Project imports:
import '../../domain/entities/home_summary_entity.dart';

/// Data-layer shape of the home summary response.
class HomeSummaryResponse {
  const HomeSummaryResponse({required this.greeting});

  factory HomeSummaryResponse.fromJson(Map<String, dynamic> json) =>
      HomeSummaryResponse(greeting: json['greeting'] as String? ?? '');

  final String greeting;

  HomeSummaryEntity toDomain() => HomeSummaryEntity(greeting: greeting);
}
