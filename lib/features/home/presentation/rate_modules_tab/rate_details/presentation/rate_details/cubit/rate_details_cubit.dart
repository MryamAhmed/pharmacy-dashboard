// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import '../../../../../../domain/entities/rate_entity.dart';
import 'rate_details_state.dart';

/// Drives the rate-details screen. Just holds the [RateEntity] the screen
/// was opened with — passed in via the route's `extra` and forwarded here as
/// an injectable `@factoryParam`, so the screen reads it from the cubit
/// instead of taking it as a constructor field directly.
@injectable
class RateDetailsCubit extends Cubit<RateDetailsState> {
  RateDetailsCubit(@factoryParam RateEntity rate)
    : super(RateDetailsState(rate: rate));
}
