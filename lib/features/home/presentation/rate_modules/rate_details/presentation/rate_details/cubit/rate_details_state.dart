// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../../../domain/entities/rate_entity.dart';

part 'rate_details_state.freezed.dart';

/// State for the rate-details screen — just the [RateEntity] passed in when
/// the screen was opened. No loading/error branch: the entity already comes
/// fully loaded from the Rate tab's list, so there is nothing to fetch.
@freezed
abstract class RateDetailsState with _$RateDetailsState {
  const factory RateDetailsState({required RateEntity rate}) =
      _RateDetailsState;
}
