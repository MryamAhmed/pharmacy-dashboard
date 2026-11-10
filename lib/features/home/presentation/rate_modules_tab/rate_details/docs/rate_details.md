# Rate details module

## Purpose
Detail view for a single pending review, opened by tapping a `RateCardWidget` in the Home module's Rate tab. Shows the full review (pharmacy, reviewer, stars, date, review text) and has one action: **Delete** (bottom bar).

## Architecture
This module is presentation-only, nested under `lib/features/home/presentation/rate_modules_tab/rate_details/`. It receives an already-fetched `RateEntity` via the route. The delete call uses the Home module's rate data/domain layers:

| Layer | Class | Delete member |
|---|---|---|
| Endpoint | `AppEndPoints.deleteReview(id)` | `/Dashboard/review/{id}` |
| Data source | `RateRemoteDataSource` / `RateRemoteDataSourceImpl` | `deleteRate(id)` → `callApiNoData(dio.delete(...))` → `Either<Failure, Unit>` |
| Repository | `RateRepository` / `RateRepositoryImpl` | `deleteRate(id)` → `mapLeft(toAppError)` |
| Use case | `DeleteRateUseCase` (`domain/usecases/delete_rate_usecase.dart`) | `call(id)` |
| Cubit | `RateDetailsCubit` | `deleteRate()` |

- `cubit/rate_details_state.dart` — `@freezed`: `RateEntity rate`, `bool isDeleting` (default false), `AppError? error`.
- `cubit/rate_details_cubit.dart` — `@injectable RateDetailsCubit(@factoryParam RateEntity rate, DeleteRateUseCase, GoRouter)`. `deleteRate()`: ignores double taps / null id → emits `isDeleting: true, error: null` → on failure emits `error`; on success calls `_goRouter.pop(true)`.
- `screens/rate_details_screen.dart` — `BlocConsumer`; the listener shows a `SnackBar` (`AppText` + `AppErrorX.localized`) whenever a new `error` arrives.
- `widgets/rate_details_bottom_navigators_widget.dart` — `BlocBuilder` (`buildWhen: isDeleting` changed) around `AppButtonWidget`; `isLoading: state.isDeleting`, `onPressed: cubit.deleteRate`.

## Where the data comes from
There is **no review-details API**: `GET Dashboard/review/{id}` returns 405 (that route is DELETE-only), and other guessed paths return 404. The screen shows the `RateEntity` from `GET Dashboard/reviews` that was tapped in the list, passed via `extra`. Every value comes from that response:

| Widget | Field(s) |
|---|---|
| `RateDetailsPharmacyCardWidget` (who wrote it) | `profilePicture` (else first letter), `reviewerName` |
| `RateDetailsUserCardWidget` ("Rating for") | `revieweeName` (+ `.initials`), subtitle `exp · revieweeAddress` (empty parts skipped) |
| `RateGivenWidget` / `RateDetailsRateTextCardWidget` / `RateDetailsPendingWidget` | `rate` / `comment` / `createdAt` |
| `RateDetailsContextCardWidget` | Position = `reviewerPosition`; Shift date = "-" (not in the API) |

`exp` and `revieweeAddress` are read with `?.toString()`. If the backend adds a details endpoint, fetch it in `RateDetailsCubit` by `rate.id`.

## Data flow (delete)
Tap Delete → `RateDetailsCubit.deleteRate()` → `DeleteRateUseCase` → `RateRepository` → `DELETE /Dashboard/review/{id}` → success: `pop(true)` → `RateCubit.openRateDetails` (which `await`s `pushNamed<bool>`) receives `true` and removes that id from `state.rates` locally (no refetch).

## State management
`Cubit` + Freezed. `error` is cleared at the start of every attempt so a repeated failure still triggers the listener.

## Routing
`AppRoutes.rateDetails` (`/rate-details`, name `rateDetails`) in `core/router/app_router.dart`. `BlocProvider(create: (_) => getIt.get<RateDetailsCubit>(param1: state.extra! as RateEntity))`. Reached only via `RateCubit.openRateDetails(rate)`; returns `bool?` (`true` = deleted).

## Localization
`rateDetailsTitle`, `rateDetailsRejectButton` (Delete button label), plus the Home module's `rateForUser`.

## Non-obvious decisions
- **No id + re-fetch.** The full `RateEntity` travels via `extra`. A deep link to this screen would need a fetch-by-id path, and there isn't one today.
- **Pop result instead of shared state.** The list is updated via the `pop(true)` result rather than sharing `RateCubit` with this screen, so the two cubits stay independent.
- **No confirmation dialog** before delete yet.
