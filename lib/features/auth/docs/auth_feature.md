# Auth feature (login)

## Purpose
A minimal email/password login screen. This is still a **UI stub**: it validates inputs locally and, on success, navigates to the home screen. There is no real authentication call, signup, password reset, or social sign-in yet.

## Architecture
Layered under `features/auth/presentation/login`:
- `cubit/login_state.dart` — `LoginState`, a **`@freezed` single-data-class** (`obscurePassword`, `rememberMe`, `emailFieldError`, `passwordFieldError`, `error`, `isSubmitting`). Field-error fields hold an `AppErrorCodes` constant (or `null`), never a raw message. `error` holds the raw domain `AppError` for a general (non-field) submit failure — mirrors `HomeTabState`'s shape.
- `cubit/login_cubit.dart` — `@injectable` `LoginCubit`. Injects `GoRouter` directly (never `BuildContext`) and owns the two `TextEditingController`s. `_validateEmail`/`_validatePassword` return `AppErrorCodes.fieldRequired`/`invalidEmail` (via `AppValidations.emailRegExp`). `submit()` wraps the sign-in call in `try/catch`: on success it calls `_goRouter.clearStackAndGo(AppRouteNames.home)` (the `GoRouterNavigationX` extension), dropping the login screen from history; on any thrown exception it emits `AppError(isNetwork: true)` onto `state.error` instead of navigating. `toggleRememberMe()`/`toggleObscurePassword()` are plain state toggles, same shape.
- `screens/login_screen.dart` — `LoginScreen` builds the form from shared widgets (`AppScaffold`, `AppText`, `AppTextField`, `AppButtonWidget`, `AppCheckBoxWidget`) and a `BlocBuilder<LoginCubit, LoginState>`. Field errors resolve via `state.emailFieldError.fieldErrorText(context)` / `state.passwordFieldError.fieldErrorText(context)` — a shared `AppErrorCodeX` extension in `core/extensions/app_error_localization.dart` (not a private screen method), since only the widget has a `BuildContext` to localize with. `state.error` (when non-null) is resolved via `AppErrorX.resolveMessage(context.l10n)` and shown as inline red text above the submit button. The "remember me" checkbox is wired to `state.rememberMe` / `cubit.toggleRememberMe()` — previously this referenced undefined `value`/`onChanged` locals (a compile error). Every visible string comes from `context.l10n`; the two example field placeholders (sample email, password mask) and the placeholder greeting name are plain `AppConstants` values since they're not translatable copy.

## State management
`Cubit` + **Freezed** single-data-class state (form-style: incremental field updates via `copyWith`, including explicit `null` to clear a field/general error — supported by Freezed's generated `copyWith`, unlike a hand-written one).

## Dependency injection
`LoginCubit` is `@injectable` (a new instance per screen, registered into `di.config.dart` via `build_runner`) — not manually registered in `core/di/di.dart`.

## Routing
Registered at `AppRoutes.login` (`/login`). Navigation to home happens **inside the Cubit** via the injected `GoRouter`, never via `context.go`/`context.push` from the widget.

## Localization
All auth strings live in `lib/l10n/app_en.arb` / `app_ar.arb`: `loginTitle`, `loginSubtitle`, `loginEmailHint`, `loginPasswordHint`, `loginSubmitButton`, `loginWelcomeTitle` (parameterized — `{name}`), `loginEmailLabel`, `loginPasswordLabel`, `loginRememberMe`, `loginForgotPassword`, `validationFieldRequired`, `validationInvalidEmail`, `errorInvalidCredentials`, `errorEmailAlreadyRegistered`, `errorSocialSignInFailed`, `errorNetwork`, `errorGeneric`, `forgotPasswordEmailNotRegistered`, `validationPasswordMismatch`. Non-translatable example/placeholder values (`loginPlaceholderUserName`, `loginEmailPlaceholder`, `loginPasswordPlaceholder`) live in `AppConstants` instead — they're stand-in demo values, not language-dependent UI copy. No hardcoded strings remain in `login_screen.dart`.

## To make it real
Add a data source → repository → use case (returning `Either<AppError, T>` via the existing `callApi` helpers), annotate them `@LazySingleton(as: Interface)`/`@injectable` per this project's DI convention, inject the use case into `LoginCubit`, replace the simulated delay in `submit()` with the real call, and swap `AppConstants.loginPlaceholderUserName` for the authenticated user's real display name.
