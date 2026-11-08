// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../../../../shared/domain/entities/app_error.dart';
import '../../../../../../domain/entities/rate_entity.dart';

part 'rate_details_state.freezed.dart';

/// State for the rate-details screen — the [RateEntity] passed in when the
/// screen was opened, plus the status of the Delete action.
@freezed
abstract class RateDetailsState with _$RateDetailsState {
  const factory RateDetailsState({
    required RateEntity rate,

    /// True while the DELETE request is in flight (button shows a loader).
    @Default(false) bool isDeleting,

    /// Set when the delete fails — the screen shows it in a SnackBar.
    AppError? error,
  }) = _RateDetailsState;
}
