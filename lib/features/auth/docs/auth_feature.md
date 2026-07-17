# Auth feature (login)

## Purpose
A minimal email/password login screen. This is still a **UI stub**: it validates inputs locally and, on success, navigates to the home screen. There is no real authentication call, signup, password reset, or social sign-in yet.

## Architecture
Layered under `features/auth/presentation/login`:
- `cubit/login_state.dart` — `LoginState`, a **`@freezed` single-data-class** (`obscurePassword`, `emailFieldError`, `passwordFieldError`, `isSubmitting`). Field-error fields hold an `AppErrorCodes` constant (or `null`), never a raw message.
- `cubit/login_cubit.dart` — `@injectable` `LoginCubit`. Injects `GoRouter` directly (never `BuildContext`) and owns the two `TextEditingController`s. `_validateEmail`/`_validatePassword` return `AppErrorCodes.fieldRequired`/`invalidEmail` (via `AppValidations.emailRegExp`); on success calls `_goRouter.clearStackAndGo(AppRouteNames.home)` (the `GoRouterNavigationX` extension), dropping the login screen from history.
- `screens/login_screen.dart` — `LoginScreen` builds the form from shared widgets (`AppScaffold`, `AppText`, `AppTextField`, `AppButtonWidget`) and a `BlocBuilder<LoginCubit, LoginState>`. A local `_fieldErrorText(BuildContext, String? code)` helper resolves the state's `AppErrorCodes` to localized text. All copy (`loginTitle`, `loginSubtitle`, `loginEmailHint`, `loginPasswordHint`, `loginSubmitButton`) comes from `context.l10n` — no hardcoded strings.

## State management
`Cubit` + **Freezed** single-data-class state (form-style: incremental field updates via `copyWith`, including explicit `null` to clear a field error — supported by Freezed's generated `copyWith`, unlike a hand-written one).

## Dependency injection
`LoginCubit` is `@injectable` (a new instance per screen, registered into `di.config.dart` via `build_runner`) — not manually registered in `core/di/di.dart`.

## Routing
Registered at `AppRoutes.login` (`/login`). Navigation to home happens **inside the Cubit** via the injected `GoRouter`, never via `context.go`/`context.push` from the widget.

## Localization
All auth strings live in `lib/l10n/app_en.arb` / `app_ar.arb`: `loginTitle`, `loginSubtitle`, `loginEmailHint`, `loginPasswordHint`, `loginSubmitButton`, `validationFieldRequired`, `validationInvalidEmail`, `errorInvalidCredentials`, `errorEmailAlreadyRegistered`, `errorSocialSignInFailed`, `forgotPasswordEmailNotRegistered`, `validationPasswordMismatch`. No hardcoded strings remain in `login_screen.dart`.

## To make it real
Add a data source → repository → use case (returning `Either<AppError, T>` via the existing `callApi` helpers), annotate them `@LazySingleton(as: Interface)`/`@injectable` per this project's DI convention, inject the use case into `LoginCubit`, and replace the simulated delay in `submit()` with the real call.
