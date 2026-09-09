# Rate details module

## Purpose
Read-only detail view for a single pending review, opened by tapping a `RateCardWidget` in the Home module's Rate tab. Shows the same data as the card (pharmacy, reviewer, stars, status, date, review text) with no truncation, and no actions yet — approve/reject still only exist as a no-op button on the card itself.

## Architecture
No `data`/`domain` layers of its own — this module is pure presentation, nested under `lib/features/home/presentation/rate_modules/rate_details/` (a sibling of `rate_modules/rate/`, the tab itself). It receives an already-fetched `RateEntity` (defined in the `home` module: `lib/features/home/domain/entities/rate_entity.dart`) via the route, so there is nothing to fetch or map.

- `presentation/rate_details/cubit/rate_details_state.dart` — **`@freezed`** state: a single required `RateEntity rate` field. No `isLoading`/`error` — unlike `HomeTabState`/`RateState`, this state never transitions; it just holds the value the cubit was constructed with.
- `presentation/rate_details/cubit/rate_details_cubit.dart` — `@injectable` `RateDetailsCubit(@factoryParam RateEntity rate)`, seeds `super(RateDetailsState(rate: rate))` and does nothing else. Exists so the screen reads `rate` off the cubit (`BlocBuilder`) instead of taking it as a constructor field directly — kept consistent with every other screen in this app being Cubit-driven, even though there's no async work here.
- `presentation/rate_details/screens/rate_details_screen.dart` — `RateDetailsScreen({required Key key})`, a `StatelessWidget` wrapping its body in `BlocBuilder<RateDetailsCubit, RateDetailsState>` and reading `state.rate`. Renders:
  - `TextAvatarWidget` (reused from `rate_modules/rate/widgets/`) seeded with `rate.pharmacyName[0].toUpperCase()`.
  - Pharmacy name (`TestKeys.rateDetailsPharmacyName`) and `context.l10n.rateForUser(rate.userName)` (`TestKeys.rateDetailsUserName`).
  - Stars (`TestKeys.rateDetailsStars`) — `List.filled(rate.rate, '★').join(' ')`, same construction as the card.
  - Status (`TestKeys.rateDetailsStatus`) — a private `_statusLabel(BuildContext, RateEntity)` switch over `RateStatus` resolving `context.l10n.rateStatusApprove/Pending/Reject`. (A plain `String`-returning helper, not a `Widget`-returning one — the latter is a merge blocker per `CLAUDE.md`.)
  - Date (`TestKeys.rateDetailsDate`) — `DateFormat.yMMMd().add_jm().format(rate.dateTime)` (`package:intl`).
  - Full review text (`TestKeys.rateDetailsDescription`), no `maxLines`/ellipsis (unlike the card).

## State management
`Cubit` + Freezed, matching every other screen — but `RateDetailsCubit` only ever holds one value; it never re-emits after construction.

## Routing
Registered at `AppRoutes.rateDetails` (`/rate-details`, name `rateDetails`) in `core/router/app_router.dart`. The `GoRoute`'s `pageBuilder` wraps `RateDetailsScreen` in `BlocProvider(create: (_) => getIt.get<RateDetailsCubit>(param1: state.extra! as RateEntity))` — the `RateEntity` travels as the route's `extra`, forwarded into the cubit's `@factoryParam` constructor arg. There is no id-based re-fetch, since the tapped card already had the full entity in memory. Reached only via `RateCubit.openRateDetails(rate)` (in `rate_modules/rate/`) — never linked to directly.

## Localization
Reuses `rateForUser` from the Home module's arb entries, plus its own: `rateDetailsTitle` (app-bar title), `rateStatusApprove`/`rateStatusPending`/`rateStatusReject`.

## Non-obvious decisions
- **No id + re-fetch.** Since the Rate tab already holds the full `RateEntity` list in `RateCubit`'s state, passing the whole entity via `extra` avoids a redundant "get rate by id" round trip. If this screen is ever deep-linked to directly (e.g. push notification), it will need a fallback fetch-by-id path — there is none today.
- **No actions here yet.** Approve/reject wiring was scoped to the card's button only; this screen is intentionally read-only until that's designed.
