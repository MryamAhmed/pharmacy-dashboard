# Home module

## Purpose
Landing experience shown after a successful login. A bottom-navigation shell hosting four tabs: **Home**, **Pharmacy Management**, **Rate**, and **User Management**. Only Home has real (if dummy) data wiring; the other three are placeholder screens — this module establishes the Clean Architecture scaffolding and tab-navigation shell so each tab's real feature can be built out independently.

## Architecture
Module-level `data`/`domain` layers (shared by the module, not per-tab):
- `domain/entities/home_summary_entity.dart` — `HomeSummaryEntity` (pure Dart), currently just a `greeting` string.
- `domain/repositories/home_repository.dart` — `HomeRepository` abstract contract.
- `domain/usecases/get_home_summary_usecase.dart` — `@injectable` `GetHomeSummaryUseCase`, single `call()`.
- `data/models/home_summary_response.dart` — `HomeSummaryResponse` (`fromJson` / `toDomain`).
- `data/datasources/home_remote_data_source.dart` — `HomeRemoteDataSource` (abstract) / `HomeRemoteDataSourceImpl`, annotated `@LazySingleton(as: HomeRemoteDataSource)`. **Dummy for now**: returns a static greeting after a simulated delay instead of calling a real endpoint. Swap the body for a real `callApi(...)` call against `DioClientService` when the backend exists — the `Either<AppError, HomeSummaryResponse>` return shape already matches every other data source in the app.
- `data/repositories/home_repository_impl.dart` — `HomeRepositoryImpl`, annotated `@LazySingleton(as: HomeRepository)`, maps failures to `AppError`.

Presentation, one folder per tab:
- `presentation/home_shell/screens/home_shell_screen.dart` — `HomeShellScreen`, a `StatefulWidget` holding the selected tab index and an `IndexedStack` of the four tab widgets (so switching tabs preserves each tab's state). Resolves `HomeTabCubit` via `getIt.get<HomeTabCubit>()` inside a `BlocProvider` wrapping just the Home tab.
- `presentation/home_shell/widgets/home_bottom_nav_bar.dart` — `HomeBottomNavBar`, the `BottomNavigationBar` with four items. Labels come from `context.l10n.navHome/navPharmacy/navRate/navUsers` (short, so all four fit on one line at narrow widths); each tab's on-screen title is the longer form (`homeTitle`, `pharmacyManagementTitle`, `rateTitle`, `userManagementTitle`).
- `presentation/home_tab/` — the only tab with real (if dummy) data wiring:
  - `cubit/home_tab_state.dart` — **`@freezed`** state: `isLoading`, `greeting`, and the raw `AppError? error` (not a pre-resolved string — resolving display text is left to the screen via `AppErrorX.resolveMessage(context.l10n)`, keeping the Cubit free of `BuildContext`).
  - `cubit/home_tab_cubit.dart` — `@injectable` `HomeTabCubit`, calls `GetHomeSummaryUseCase` on creation, folds the `Either` result with `.fold()`, guarded by `if (isClosed) return;`.
  - `screens/home_tab_screen.dart` — `HomeTabScreen`, renders `state.greeting ?? context.l10n.homeTitle` and `state.error?.resolveMessage(context.l10n) ?? context.l10n.comingSoon` via `BlocBuilder`.
- `presentation/pharmacy_management/screens/pharmacy_management_screen.dart`, `presentation/rate/screens/rate_screen.dart`, `presentation/user_management/screens/user_management_screen.dart` — pure UI stubs rendering the shared `AppComingSoonView` widget with a tab-specific icon and `context.l10n.<tab>Title` / `context.l10n.comingSoon`. No cubits yet — add one per tab as each becomes real.

## State management
`Cubit` + **Freezed** state throughout (`HomeTabState`; `PharmacyManagementScreen`/`RateScreen`/`UserManagementScreen` have no state yet since they're static placeholders).

## Dependency injection
`HomeRemoteDataSourceImpl`, `HomeRepositoryImpl`, `GetHomeSummaryUseCase`, and `HomeTabCubit` are all registered via Injectable annotations (`@LazySingleton(as: Interface)` / `@injectable`) — nothing in this module is manually registered in `core/di/di.dart`. Wiring is generated into `di.config.dart` by `build_runner` (gitignored — regenerate locally with `dart run build_runner build --delete-conflicting-outputs`).

## Routing
Registered at `AppRoutes.home` (`/home`) as `HomeShellScreen`. Navigated to by `LoginCubit.submit()` via `GoRouterNavigationX.clearStackAndGo`. Tab switches are in-memory (`setState` on the shell) — not represented in the URL. Upgrade to `StatefulShellRoute.indexedStack` if deep-linking to a specific tab is needed later.

## Localization
All Home strings live in `app_en.arb`/`app_ar.arb`: `homeTitle`, `pharmacyManagementTitle`, `rateTitle`, `userManagementTitle`, `navHome`, `navPharmacy`, `navRate`, `navUsers`, `comingSoon`, `searchHint`. No hardcoded strings remain in any Home screen, the bottom nav bar, or `AppSearchWidget`'s default hint.

## To make each tab real
1. **Home**: replace `HomeRemoteDataSourceImpl`'s dummy body with a real API call; extend `HomeSummaryEntity` with the actual dashboard fields.
2. **Pharmacy Management / Rate / User Management**: give each its own `data`/`domain` (if needed) and `cubit`/`state` following the same Freezed + Injectable pattern, then swap its screen's `AppComingSoonView` body for the real UI.
