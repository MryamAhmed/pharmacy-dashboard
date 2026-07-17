# PR Review Guidelines — Clean Architecture Flutter

> Standards for reviewing and writing code in our feature-based Clean Architecture Flutter project using Bloc/Cubit, Dio, GoRouter, and GetIt + Injectable.

**Tag legend**
- 🔴 **Required** — Merge blocker, must be resolved before approval
- 🟡 **Recommended** — Strong preference, override requires justification
- 🟢 **Suggested** — Nice to have, apply when convenient
- 🔵 **Note** — Informational, context only

---

## Contents

1. [Architecture & Folder Structure](#1-architecture--folder-structure)
2. [Layer Boundaries](#2-layer-boundaries)
3. [Global State — GeneralCubit](#3-global-state--generalcubit) ✦ New
4. [State Management — Cubit + Freezed](#4-state-management--cubit--freezed)
5. [Error Handling — Either Pattern](#5-error-handling--either-pattern)
6. [Dependency Injection — GetIt + Injectable](#6-dependency-injection--getit--injectable)
7. [Routing — GoRouter](#7-routing--gorouter)
8. [Networking — Dio](#8-networking--dio)
9. [UI Rules](#9-ui-rules) ✦ New
10. [Code Readability & Naming](#10-code-readability--naming)
11. [Shared Components](#11-shared-components)
12. [Testing](#12-testing)
13. [PR Size & Process](#13-pr-size--process)
14. [Flavors & Environments](#14-flavors--environments)
15. [Null Safety & Defensive Code](#15-null-safety--defensive-code)
16. [Performance & Widget Optimization](#16-performance--widget-optimization)
17. [Code Generation](#17-code-generation)
18. [Reviewer Checklist](#18-reviewer-checklist)

---

## 1. Architecture & Folder Structure

### The Three Layers

Every feature follows Clean Architecture with three distinct layers. Dependencies always point **inward** — Presentation knows Domain, Data knows Domain, but Domain knows nothing outside itself.

```
Presentation  (Screens · Widgets · Cubits · States)
      ↓ depends on ↓
Domain        (Entities · Repository Interfaces · Use Cases — pure Dart)
      ↑ depends on ↑
Data          (Repository Impls · Data Sources · Response Models)
```

### Required Folder Layout for Each Feature

```
features/your_feature/
├── data/
│   ├── datasources/
│   │   ├── your_remote_data_source.dart        # abstract interface
│   │   └── your_remote_data_source_impl.dart   # implementation
│   ├── models/
│   │   └── your_response.dart                  # DTO + fromJson + toDomain()
│   └── repositories/
│       └── your_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── your_entity.dart                    # pure Dart, no framework imports
│   ├── repositories/
│   │   └── your_repository.dart                # abstract class
│   └── usecases/
│       └── do_something_usecase.dart
└── presentation/
    └── your_screen/
        ├── cubit/
        │   ├── your_cubit.dart
        │   └── your_state.dart
        ├── screens/
        │   └── your_screen.dart
        └── widgets/                            # screen-specific extracted widgets
```

### When to Use `shared/`

- 🔴 **Required** — Any model, entity, widget, or use case used by **2 or more features** must live in `shared/`, following the same `data / domain / presentation` structure.
- 🔴 **Required** — If code belongs to only one feature, it stays **inside that feature folder**. Never put single-feature code in `shared/`.

---

## 2. Layer Boundaries

### Domain Layer — Pure Dart Only

- 🔴 **Required** — Entities must be **pure Dart classes** — no Flutter imports, no Dio, no Freezed annotations. They represent business objects, not data transfer objects.
- 🔴 **Required** — Repository interfaces (abstract classes) must live in `domain/repositories/`. They define *what* the data layer must provide, not *how*.
- 🔴 **Required** — Use cases must have a single public `call()` method and delegate the **data access** entirely to the repository. No direct API calls or Dio usage inside a use case. The single `call()` may still contain **business logic** around that data — for example, when the repository returns a list, the use case can filter, sort, map, or otherwise transform it and return only the processed result. The rule restricts a use case to one public entry point and forbids talking to the network directly; it does **not** forbid business logic.

```dart
@injectable
class GetActiveUsersUseCase {
  GetActiveUsersUseCase(this._repository);
  final UserRepository _repository;

  Future<Either<AppError, List<UserEntity>>> call() async {
    final result = await _repository.getUsers();
    // ✓ business logic lives in the use case: filter before returning
    return result.map(
      (users) => users.where((user) => user.isActive).toList(),
    );
  }
}
```

### Data Layer — DTOs & Implementations

- 🔴 **Required** — Response models (DTOs) must provide both `fromJson()` and a `toDomain()` method returning the domain entity. Never pass a raw model to the domain or presentation layer.
- 🔴 **Required** — Request models flow in the **opposite direction**: when building a request from the presentation/domain layer down into the data layer, the model must provide a `fromDomain()` factory (to construct the DTO from a domain entity or its parameters) and a `toJson()` method (to serialize it for the API). Never hand-build the raw JSON map inside a data source.

```dart
class LoginRequest {
  const LoginRequest({required this.identifier, required this.password});

  final String identifier;
  final String password;

  // build the request DTO from domain-side input
  factory LoginRequest.fromDomain(LoginParams params) => LoginRequest(
        identifier: params.identifier,
        password: params.password,
      );

  // serialize for the API call
  Map<String, dynamic> toJson() => {
        ApiParameterConstant.identifier: identifier,
        ApiParameterConstant.password: password,
      };
}
```
- 🔴 **Required** — Repository implementations must catch all exceptions and return `Either<AppError, T>`. Never let raw `DioException` or generic exceptions bubble up to the presentation layer.
- 🟡 **Recommended** — Data sources must be split into an abstract interface and a concrete implementation. This keeps the data source mockable in tests.

### Presentation Layer — UI Only

- 🔴 **Required** — Screens and widgets must **not** contain business logic. They read state and dispatch events to a Cubit. No direct repository or use case calls from the UI.
- 🔴 **Required** — Do **not** use `BlocListener` to show the four side effects — navigation, dialogs, bottom sheets, and snack bars. Trigger them from the action that causes them (e.g. the submit button's `onPressed`) by calling a Cubit method that accepts **callbacks**; the Cubit folds the `Either` result and invokes the matching callback for each case. Split the responsibilities as follows:
  - **Navigation** runs **inside the Cubit** using an injected `GoRouter` — never pass `BuildContext` into a Cubit.
  - **Dialogs, bottom sheets, and snack bars** need a `BuildContext`, so define them as functions inside the `build()` method of a `StatelessWidget` (in its own file) and pass them to the Cubit method as callbacks.

```dart
// Cubit: folds Either, navigates itself, and calls back for context-bound effects
@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._router) : super(const LoginState());
  final LoginUseCase _loginUseCase;
  final GoRouter _router; // injected — no BuildContext inside the Cubit

  Future<void> submit({
    required VoidCallback onSuccess,
    required void Function(AppError error) onError,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _loginUseCase(
      identifier: identifierController.text,
      password: passwordController.text,
    );

    result.match(
      (error) {
        emit(state.copyWith(isSubmitting: false));
        onError(error);                       // snack bar / dialog — the widget shows it
      },
      (_) {
        emit(state.copyWith(isSubmitting: false));
        _router.goNamed(AppRouteNames.home);  // navigation lives in the Cubit
        onSuccess();                          // optional confirmation — the widget shows it
      },
    );
  }
}
```

```dart
// Widget: a StatelessWidget that defines the context-bound side effects in build()
class LoginScreen extends StatelessWidget {
  const LoginScreen({required super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    // Dialog / bottom sheet / snack bar functions live here, where context exists.
    void showSuccessDialog() => AppConfirmationDialog.show(
          context: context,
          title: context.l10n.loginSuccessTitle,
          message: context.l10n.loginSuccessMessage,
          confirmText: context.l10n.ok,
        );

    void showErrorSnackBar(AppError error) =>
        AppSnackBar.showError(context, error.localized(context));

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AppScaffold(
          key: const Key(TestKeys.loginScaffold),
          showImageBackground: true,
          showCopyright: true,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.s24,
                vertical: AppSpace.s24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppButtonWidget(
                    key: const Key(TestKeys.loginSubmitButton),
                    text: context.l10n.loginButton,
                    isLoading: state.isSubmitting,
                    isDisabled: state.isSubmitting,
                    backgroundColor: AppColors.primaryColor,
                    borderRadius: 12.r,
                    onPressed: () => cubit.submit(
                      onSuccess: showSuccessDialog,
                      onError: showErrorSnackBar,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
```

- 🟡 **Recommended** — Prefer stateless widgets. Only use `StatefulWidget` when managing lifecycle that cannot live in a Cubit (e.g., `AnimationController`).

### Layer Import Cheat-Sheet

| File type | Layer | Can import |
|---|---|---|
| Entity | Domain | Pure Dart only |
| Repository Interface | Domain | Entities, fpdart |
| Use Case | Domain | Entities, repository interfaces, fpdart |
| Response Model (DTO) | Data | Entities, dart:convert |
| Data Source | Data | Models, DioClientService, injectable |
| Repository Impl | Data | Data sources, entities, fpdart, injectable |
| Cubit / State | Presentation | Use cases, entities, fpdart, freezed, GoRouter, GeneralCubit |
| Screen / Widget | Presentation | Flutter, Cubit, shared widgets |

---

## 3. Global State — GeneralCubit

Instead of a traditional *services* layer (e.g., `AuthService`), this project uses **`GeneralCubit`** as the single source of truth for session-wide data and global actions. It is provided at the app root and is the **only `@lazySingleton` Cubit** in the codebase — all other Cubits are transient (`@injectable`).

It currently holds: the logged-in `UserModel`, the auth token, and the current `ShiftDataEntity`. Add new global state here rather than creating a separate singleton service.

### What GeneralCubit Manages

```dart
// lib/shared/presentation/cubit/general_cubit.dart

@lazySingleton  // ← Only GeneralCubit uses this; all other Cubits use @injectable
class GeneralCubit extends Cubit<GeneralState> with ChangeNotifier {
  GeneralCubit(this._dioClientService, this._logoutUseCase)
      : super(const GeneralState());

  // Stores token in Dio interceptor + emits new state
  void setSession({required UserModel user, required String token}) { ... }

  // Replace the full user object (e.g., after a profile update)
  void updateUser(UserModel user) { ... }

  // Attach or detach the active shift
  void setShiftData(ShiftDataEntity? shift) { ... }

  // Clears Dio token + resets all state
  Future<void> logout() async { ... }
}
```

### Injecting GeneralCubit into a Feature Cubit

```dart
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._updateUserUseCase, this._generalCubit)
      : super(const ProfileState());

  final UpdateUserUseCase _updateUserUseCase;
  final GeneralCubit _generalCubit; // ← injected, not getIt.get()

  Future<void> save(...) async {
    final result = await _updateUserUseCase(...);
    result.match(
      (error) => emit(...),
      (updatedUser) {
        _generalCubit.updateUser(updatedUser); // keep global state in sync
        emit(...);
      },
    );
  }
}
```

### Rules

- 🔴 **Required** — `GeneralCubit` is the **only** `@lazySingleton` Cubit. All other feature Cubits must use `@injectable` (a new instance per screen).
- 🔴 **Required** — After a successful API call that changes global data (login, profile update, shift start/end), call the appropriate `GeneralCubit` method to keep in-memory state consistent with the server.
- 🔴 **Required** — Feature Cubits that need global state must inject `GeneralCubit` via the constructor. Never call `getIt.get<GeneralCubit>()` inside a Cubit body.
- 🔴 **Required** — Do **not** create a separate singleton service (e.g., `AuthService`, `UserService`) to hold global session data. Add new global state to `GeneralCubit` and `GeneralState` instead.
- 🟡 **Recommended** — When reading global state in a widget, use `BlocBuilder<GeneralCubit, GeneralState>` with a tight `buildWhen` so the widget only rebuilds when its relevant slice of state changes.

---

## 4. State Management — Cubit + Freezed

### State Class Rules

- 🔴 **Required** — Every Cubit must have a corresponding `*_state.dart` file with a `@freezed` state class. No mutable fields directly on the Cubit.
- 🔴 **Required** — State classes must use `@freezed`. Never define a state class without code generation — it will lack `copyWith`, equality, and `toString`.
- 🔴 **Required** — For screens with loading/success/error states, use a **sealed union** (multiple factory constructors). For forms with incremental field updates, use a **single data class** with `copyWith`.
- 🟡 **Recommended** — Keep state classes small and focused. If a state class has more than ~10 fields, the screen may need splitting.

### Sealed Union State (loading / success / error screens)

```dart
@freezed
sealed class YourState with _$YourState {
  const factory YourState.initial()              = _Initial;
  const factory YourState.loading()              = _Loading;
  const factory YourState.loaded(YourEntity data) = _Loaded;
  const factory YourState.empty()               = _Empty;
  const factory YourState.error(AppError error)  = _Error;
}
```

### Single Data State (forms, filters)

```dart
@freezed
abstract class YourState with _$YourState {
  const factory YourState({
    @Default(false) bool isSubmitting,
    String? fieldError,
    AppError? submitError,
  }) = _YourState;
}
```

### Cubit Rules

- 🔴 **Required** — Cubits must be annotated with `@injectable` and receive all dependencies via the constructor. No `getIt.get()` calls inside a Cubit body.
- 🔴 **Required** — Always `emit` a loading state before starting async work, and always `emit` a final state (success or error) before returning.
- 🔴 **Required** — Never call `emit` after the Cubit is closed. Guard async methods with `if (isClosed) return;` when necessary.
- 🟡 **Recommended** — Use `state.copyWith()` for incremental updates. Avoid emitting multiple rapid states without reason.

### View Rules

- 🔴 **Required** — Use `BlocBuilder` for UI that changes with state. Do **not** use `BlocListener` to trigger the four side effects (navigation, dialogs, bottom sheets, snack bars) — those are callback-driven via Cubit methods (see [§2 Presentation Layer](#2-layer-boundaries)). Reserve `BlocListener` / `BlocConsumer` for the rare reactive side effect that is none of those four.
- 🔴 **Required** — Use `buildWhen` on `BlocBuilder` whenever only part of the state drives that widget's rebuild.

```dart
// ✗ Wrong — side effect inside builder (fires on every build)
BlocBuilder(
  builder: (context, state) {
    if (state is LoginSuccess) context.go('/home');
    return LoginForm();
  },
)

// ✗ Also avoid — using BlocListener to navigate or show a dialog / snack bar / bottom sheet

// ✓ Correct — trigger via a Cubit method that takes callbacks
AppButtonWidget(
  text: context.l10n.loginButton,
  onPressed: () => cubit.submit(
    onSuccess: showSuccessDialog,   // defined in build(), has context
    onError: showErrorSnackBar,     // defined in build(), has context
  ),
)
// navigation happens inside cubit.submit() via the injected GoRouter
```

- 🔵 **Note — `BlocConsumer` vs. separate widgets** — Because the four side effects are callback-driven, you will rarely need a `BlocListener` at all. If you do use one for a genuine reactive side effect: when it shares the **same Cubit and the same state** as a builder, combine them into a single `BlocConsumer`; when they depend on **different Cubits or different states**, keep them as **separate** `BlocListener` and `BlocBuilder` widgets, as shown below.

```dart
// ✓ Same cubit + same state → use BlocConsumer
// (listener does a genuine reactive effect — NOT one of the four side effects)
BlocConsumer<SearchCubit, SearchState>(
  listener: (context, state) {
    if (state.isSubmitting) FocusScope.of(context).unfocus(); // dismiss keyboard
  },
  builder: (context, state) => SearchField(isLoading: state.isSubmitting),
)

// ✓ Different cubits / states → keep them separate
BlocListener<UploadCubit, UploadState>(
  listener: (context, state) {
    if (state is ChunkUploaded) HapticFeedback.selectionClick(); // reactive effect
  },
  child: BlocBuilder<FormCubit, FormState>(
    builder: (_, state) => ProfileForm(state: state),
  ),
)
```

---

## 5. Error Handling — Either Pattern

- 🔴 **Required** — All repository methods and use cases must return `Either<AppError, T>` from `fpdart`. Never return `null` or throw exceptions across layer boundaries.
- 🔴 **Required** — Use the shared `callApi<T>()`, `callApiList<T>()`, or `callApiNoData()` helpers in data sources. They handle all `DioException`-to-`AppError` conversion automatically.
- 🔴 **Required** — In Cubits, always fold the `Either` result with `.match()`. Never access `.right` or `.left` directly.
- 🔴 **Required** — Every `AppError.local(...)` call and every `error.code ==` comparison must use a constant from `AppErrorCodes` in `lib/core/constants/app_error_codes.dart`. Never pass a raw string literal. (See also [§9 UI Rules](#9-ui-rules).)
- 🟡 **Recommended** — Use the `AppErrorX.localized()` extension to convert `AppError` to user-facing localized messages. If an error code has a user-facing message, add a case to `AppErrorX.localized()` in `lib/core/extensions/app_error_localization.dart`.

```dart
// ✓ Correct Either usage in a Cubit
Future<void> submit() async {
  emit(state.copyWith(isSubmitting: true, submitError: null));

  final result = await _loginUseCase(
    identifier: identifierController.text,
    password: passwordController.text,
  );

  result.match(
    (error) => emit(state.copyWith(isSubmitting: false, submitError: error)),
    (data)  => emit(state.copyWith(isSubmitting: false)),
  );
}
```

---

## 6. Dependency Injection — GetIt + Injectable

- 🔴 **Required** — Every injectable class must use the correct annotation. **Never** call `getIt.registerX()` manually — use annotations and code generation only.
- 🔴 **Required** — After adding or removing injectable annotations, always run `dart run build_runner build` locally to verify the project compiles. Generated files such as `core/di/di.config.dart` are **git-ignored** and regenerated by CI/CD and Codemagic — do not commit them (see [§17](#17-code-generation)).
- 🔴 **Required** — Feature Cubits must use `@injectable` (transient). A new instance must be created for each screen. The only exception is `GeneralCubit`, which uses `@lazySingleton` — see [§3](#3-global-state--generalcubit).
- 🔴 **Required** — **Cubits must only inject use cases — never repositories directly.** For every action a Cubit needs to perform, there must be a corresponding use case. Repository interfaces must never appear in Cubit constructor parameters.
- 🔴 **Required** — Interfaces must be registered with `@LazySingleton(as: InterfaceClass)`. Never register only the implementation when an abstract class exists.

### Decorator Quick Reference

```dart
// Transient — new instance per screen (all feature Cubits)
@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(const LoginState());
  final LoginUseCase _loginUseCase;
}

// Singleton registered as the abstract interface
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);
}

// Use case — transient, injected into Cubits
@injectable
class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;
  Future<Either<AppError, LoginResult>> call({...}) => _repository.login(...);
}
```

### Resolving Cubits in Routes

Cubits must be provided via `BlocProvider` inside the GoRouter builder. Never call `getIt.get<YourCubit>()` inside a widget.

```dart
GoRoute(
  path: AppRoutes.login,
  name: AppRouteNames.login,
  builder: (context, state) => BlocProvider(
    create: (_) => getIt.get<LoginCubit>(),
    child: const LoginScreen(),
  ),
),
```

---

## 7. Routing — GoRouter

- 🔴 **Required** — All route paths must be constants in `AppRoutes` and all route names in `AppRouteNames`. Never hardcode strings like `'/home'` in navigation calls.
- 🔴 **Required** — Use `context.goNamed()` or `context.pushNamed()` in widgets. Inside Cubits (which have no `BuildContext`), inject the `GoRouter` instance directly.
- 🔴 **Required** — Never use `Navigator.push()` or `Navigator.pushNamed()`. The project uses GoRouter exclusively.
- 🟡 **Recommended** — Route guards (authentication redirects) must be handled in GoRouter's `redirect` callback, not scattered inside individual screens.

### Adding a New Route — Checklist

- [ ] Add path constant to `AppRoutes`
- [ ] Add name constant to `AppRouteNames`
- [ ] Add `GoRoute` entry in `app_router.dart` with `BlocProvider`
- [ ] Add any URL parameters to `RouteParameters` constants if needed

---

## 8. Networking — Dio

- 🔴 **Required** — All HTTP calls must go through `DioClientService`. Never create a raw `Dio()` instance inside a data source.
- 🔴 **Required** — Every data source call must be wrapped with `callApi<T>()`, `callApiList<T>()`, or `callApiNoData()` so that all `DioException`s are converted to `AppError` automatically.
- 🔴 **Required** — API endpoint paths must be constants in `AppEndpoints`. No hardcoded URL strings in data sources or repositories.
- 🔴 **Required** — Request body / query parameter key names must come from `ApiParameterConstant`, not inline string literals.
- 🟡 **Recommended** — Auth token injection and token refresh are handled by the interceptor in `DioClientService`. Do not manually set `Authorization` headers in data sources.

```dart
// ✓ Correct data source implementation
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final DioClientService _client;

  @override
  Future<Either<AppError, LoginResponse>> login({
    required String identifier,
    required String password,
  }) =>
      callApi<LoginResponse>(
        request: () => _client.dio.post(
          AppEndpoints.login,
          data: {
            ApiParameterConstant.identifier: identifier,
            ApiParameterConstant.password: password,
          },
        ),
        mapSuccess: LoginResponse.fromJson,
      );
}
```

---

## 9. UI Rules

### Widget Extraction

- 🔴 **Required** — Never extract UI into a private `_buildXxx()` method inside the same class. If a piece of the UI needs extracting, create a **dedicated `StatelessWidget` in its own file** under the `widgets/` folder of the current screen. Only extract when genuinely warranted — do not over-engineer.
- 🔴 **Required** — Screens and widgets must contain **zero business logic and zero data transformation**. Any logic belongs in the Cubit — expose it as a method or getter and call it from the widget.

### Use Shared Widgets

- 🔴 **Required** — Use `AppText` for every text node — never a bare `Text()` widget.
- 🔴 **Required** — Use `AppButtonWidget` for every button — never `ElevatedButton`, `TextButton`, or `InkWell` as a standalone button.
- 🔴 **Required** — Use `AppTextField` for every text input.
- 🔴 **Required** — Use `AppScaffold` as the root of every screen. Never use a bare `Scaffold`. See [§11 Shared Components](#11-shared-components) for the full widget catalog.

### Spacing

- 🔴 **Required** — Use the `Gap` widget (from the `gap` package) for all horizontal and vertical spacing. **Never** use `SizedBox(height: ...)` or `SizedBox(width: ...)` for spacing.
- 🔴 **Required** — All spacing values — gaps, paddings, and margins — must be `const` and come from a single `AppSpace` class in `lib/core/constants/app_values.dart`. Do **not** use `AppPadding` or `AppMargin`; every spacing constant lives in `AppSpace`.

```dart
// lib/core/constants/app_values.dart
class AppSpace {
  AppSpace._();

  static const double s4  = 4;
  static const double s8  = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s24 = 24;
  static const double s32 = 32;
  // ...all gap / padding / margin values live here
}
```

```dart
// ✗ Wrong
SizedBox(height: 16)
EdgeInsets.all(16)
const Gap(AppPadding.p16)   // AppPadding / AppMargin are no longer used
EdgeInsets.all(AppMargin.m8)

// ✓ Correct
const Gap(AppSpace.s16)
EdgeInsets.all(AppPadding.p16) // for padding
EdgeInsets.all(AppMargin.m16) // for margin
```

### Colors

- 🔴 **Required** — All colors must come from `AppColors` in `lib/core/themes/app_colors.dart`. Never use raw `Color(0xFF...)` values or named Flutter colors such as `Colors.grey`.

```dart
// ✗ Wrong
color: Color(0xFF3E705F)
color: Colors.grey

// ✓ Correct
color: AppColors.primaryColor
color: AppColors.textGray
```

### Dimensions — ScreenUtil

- 🔴 **Required** — Use ScreenUtil suffixes for all widget widths, heights, and border radii: `.w` for width, `.h` for height, `.r` for border radius. Font sizes are managed through `AppTextStyle` — do not scale them manually.

```dart
// ✗ Wrong
width: 120, height: 48, BorderRadius.circular(12)

// ✓ Correct
width: 120.w, height: 48.h, BorderRadius.circular(12.r)
```

### Assets

- 🔴 **Required** — Never use raw asset path strings. Always reference assets through the generated `Assets` class in `lib/gen/assets.gen.dart`.

```dart
// ✗ Wrong
Image.asset('assets/images/logo.png')
SvgPicture.asset('assets/images/icons/settings.svg')

// ✓ Correct
Assets.images.logo.image()
Assets.images.icons.settingsIcon.svg()
Assets.animations.successAnimation  // Lottie path string property
```

### Widget Keys

- 🔴 **Required** — Every `Key(...)` or `ValueKey(...)` passed to any widget must reference a constant from `TestKeys` in `lib/core/constants/test_keys.dart`. Never pass a raw string literal. Add the new constant to `TestKeys` before using it.

```dart
// ✗ Wrong
key: const Key('loginButton')
key: ValueKey('question_${item.id}')

// ✓ Correct
key: const Key(TestKeys.loginButton)
key: ValueKey('${TestKeys.questionRow}_${item.id}')
```

### Error Codes

- 🔴 **Required** — Every `AppError.local(...)` call and every `error.code ==` comparison must use a constant from `AppErrorCodes` in `lib/core/constants/app_error_codes.dart`. Add the new constant before use. If the code has a user-facing message, also add a case to `AppErrorX.localized()`.

```dart
// ✗ Wrong
AppError.local('ACCOUNT_LOCKED')
if (error.code == 'INVALID_PASSWORD')

// ✓ Correct
AppError.local(AppErrorCodes.accountLocked)
if (error.code == AppErrorCodes.invalidPassword)
```

---

## 10. Code Readability & Naming

### File Naming

- 🔴 **Required** — All file names use **snake_case** with the appropriate suffix: `_cubit`, `_state`, `_screen`, `_repository`, `_repository_impl`, `_data_source`, `_data_source_impl`, `_usecase`, `_response`, `_service`.

### Class & Variable Naming

- 🔴 **Required** — Abstract repository interfaces: `AuthRepository`. Implementations: `AuthRepositoryImpl`. Same pattern for data sources: `AuthRemoteDataSource` / `AuthRemoteDataSourceImpl`.
- 🔴 **Required** — Private fields must use a leading underscore: `_loginUseCase`, `_generalCubit`. Public getters can expose them without the underscore.
- 🔴 **Required** — Use descriptive names. No abbreviations: spell out `controller`, `service`, `repository`, `dataSource`. Avoid `ctrl`, `svc`, `repo`, `ds`.
- 🟡 **Recommended** — Use enums instead of magic strings or integers for state flags, types, and categories — keeps `switch` statements exhaustive and prevents typos.

### Constants & Magic Values

- 🔴 **Required** — No hardcoded strings for API keys, endpoint paths, parameter names, or storage keys. Use: `AppEndpoints`, `ApiParameterConstant`, `SecureStorageConstant`, `LocalStorageConstant`.
- 🔴 **Required** — Use the `AppSpace` class (in `lib/core/constants/app_values.dart`) for all spacing values. Do not use `AppPadding` or `AppMargin`. No raw `EdgeInsets.all(16)` or magic numbers in layout.

### Code Quality

- 🔴 **Required** — Do not push `print()` statements or `debugPrint()` calls. Use the Dio logger interceptor for network logging.
- 🔴 **Required** — No commented-out code blocks in PRs. If code needs to be disabled temporarily, add a `// TODO:` comment with an explanation, or delete it.
- 🔴 **Required** — Ensure `.gitignore` keeps generated files, flavor configs, and secret keys out of the repository, and is not accidentally altered to commit them.

### Localization

- 🔴 **Required** — All user-facing strings must use `context.l10n.yourKey`. No hardcoded English or Arabic text in widgets.
- 🔴 **Required** — New strings must be added to **both** `app_en.arb` and `app_ar.arb` before the PR is merged.

---

## 11. Shared Components

- 🔴 **Required** — Before creating any new widget, check `shared/presentation/widgets/`. If a suitable widget already exists, use it — do not create a duplicate.
- 🔴 **Required** — Use `AppScaffold` as the root of every screen. Never wrap a screen in a bare `Scaffold`.
- 🟡 **Recommended** — If you extend or modify a shared widget, verify that the change does not break any existing screen that already uses it.

### Core Shared Widgets

| Widget | Purpose |
|---|---|
| `AppScaffold` | Root wrapper for every screen |
| `AppButtonWidget` | Gradient / outlined button with loading state |
| `AppTextField` | Styled text input |
| `AppText` | Typography wrapper (directional, auto-size) |
| `AppCachedImage` | Network image with cache |
| `AppLoadingWidget` | Centered loading indicator |

Additional widgets (dialogs, cards, headers, etc.) also live in `shared/presentation/widgets/` — always check there first before creating a new one.

---

## 12. Testing

> **Adoption note:** Testing requirements are enforced progressively. In the first project, Cubit tests are **Recommended**. From the second project onward, all Required items below become hard PR blockers.

- 🔴 **Required** — New use cases must have unit tests. Inject mock repositories via the constructor — no `getIt` calls in tests.
- 🔴 **Required** — New Cubits must have unit tests written with `bloc_test`'s `blocTest()`. Tests must cover at minimum: initial state, success path, and error path.
- 🟡 **Recommended** — Repository implementations should have unit tests that mock the data source and verify `Either` results for both success and failure branches.
- 🔵 **Note** — Widget tests for complex screens are encouraged. Use `TestKeys` constants (not text labels) to find widgets in widget tests.

```dart
// ✓ Correct Cubit test pattern
blocTest<LoginCubit, LoginState>(
  'emits submitting then error on wrong credentials',
  build: () {
    when(() => mockLoginUseCase(
      identifier: any(named: 'identifier'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => Left(AppError(statusCode: 401)));
    return LoginCubit(mockLoginUseCase);
  },
  act: (cubit) => cubit.submit(),
  expect: () => [
    isA<LoginState>().having((s) => s.isSubmitting, 'loading', true),
    isA<LoginState>().having((s) => s.submitError, 'error', isNotNull),
  ],
);
```

---

## 13. PR Size & Process

- 🔴 **Required** — PRs must be **small and focused**: one feature, one bug fix, or one refactor. Avoid mixing unrelated changes in a single PR.
- 🔴 **Required** — Each PR must be reviewed by **at least one team member** before merging. The author must not self-merge.
- 🔴 **Required** — Commit messages must describe *what* changed and *why*. Avoid messages like "fix", "update", or "wip".
- 🔴 **Required** — When adding a feature that spans multiple files, include a short PR description explaining the feature, which screens it touches, and how to test it.
- 🟡 **Recommended** — When a PR introduces a non-obvious architectural decision, add a comment in the PR explaining the reasoning so reviewers have context.

### Branch Naming Convention

- 🔴 **Required** — Branch names must follow `type/short-description`. Accepted types: `feat`, `fix`, `refactor`, `chore`, `test`, `hotfix`.  
  Examples: `feat/login-screen` · `fix/token-refresh-loop` · `chore/update-dependencies`
- 🔴 **Required** — Never push directly to `main`, `master`, `develop`, or any environment branch. All changes go through a PR.
- 🟡 **Recommended** — If a branch is tied to a Jira ticket, include the ticket ID: `feat/PROJ-123-login-screen`.

---

## 14. Flavors & Environments

The project supports multiple build flavors (minimum `dev` and `prod`; `staging` can be added as needed). Each flavor has its own entry point. All environment-specific values are centralized in `lib/flavors.dart` — never hardcoded inside features.

### Folder Layout

```
lib/
├── flavors.dart        # AppFlavor enum + Flavor class (baseUrl, flavorName, …)
├── main_common.dart    # shared bootstrap: HydratedBloc, DI, runApp
├── main_dev.dart       # sets Flavor.appFlavor = AppFlavor.dev; calls mainCommon()
└── main_prod.dart      # sets Flavor.appFlavor = AppFlavor.prod; calls mainCommon()
```

### The Flavor Class

```dart
// lib/flavors.dart
enum AppFlavor { dev, staging, prod }

class Flavor {
  Flavor._();

  static AppFlavor appFlavor = AppFlavor.prod;

  static String get baseUrl {
    switch (appFlavor) {
      case AppFlavor.dev:     return 'https://api-dev.example.com';
      case AppFlavor.staging: return 'https://api-staging.example.com';
      case AppFlavor.prod:    return 'https://api.example.com';
    }
  }
}

// lib/main_dev.dart
Future<void> main() async {
  Flavor.appFlavor = AppFlavor.dev;
  await mainCommon();
}
```

### Rules

- 🔴 **Required** — All environment-specific values (base URLs, feature flags) must be defined in `Flavor` static getters. Never inline environment checks (e.g., `kDebugMode` or hardcoded `if` chains) inside feature code.
- 🔴 **Required** — Secret keys and credentials must **never** be committed to the repository. Use CI/CD secret injection and verify `.gitignore` covers them.
- 🔴 **Required** — The Dio logger interceptor must be **disabled** in the `prod` flavor inside `DioClientService`. Logging sensitive data in production is a security risk.
- 🟡 **Recommended** — Use a visual flavor indicator (e.g., app name suffix like "App [DEV]") in non-production builds so testers always know which environment they are running.

---

## 15. Null Safety & Defensive Code

- 🔴 **Required** — Never use the force-unwrap operator `!` on values that come from API responses, user input, or route parameters. Use null-aware operators (`??`, `?.`) or explicit null checks with early returns.
- 🔴 **Required** — Never suppress analyzer warnings with `// ignore:` without a documented reason. If a warning is suppressed, the PR description must explain why.
- 🔴 **Required** — Do not use `dynamic` as a type outside of raw JSON parsing. All domain entities, state classes, and use case parameters must be fully typed.
- 🟡 **Recommended** — Prefer `final` over `var` for local variables that are not reassigned.
- 🟡 **Recommended** — Use `switch` expressions on sealed classes and enums. The compiler enforces exhaustiveness — a missing case becomes a compile error, not a runtime bug.

```dart
// ✗ Unsafe — force unwrap
final userId = state.user!.id;
final name = response.data!['name'] as String;

// ✓ Safe — null-aware
final userId = state.user?.id ?? '';
final name = response.data?['name'] as String? ?? '';
```

---

## 16. Performance & Widget Optimization

- 🔴 **Required** — Always use `ListView.builder` (or `SliverList`) for lists of unknown or large length. Never use `ListView(children: [...])` with a mapped list — it renders all items upfront.
- 🔴 **Required** — Widgets that do not depend on external state must use the `const` constructor. Flutter skips diffing `const` widgets on rebuild.
- 🔴 **Required** — Use `buildWhen` on `BlocBuilder` to scope rebuilds to only the relevant slice of state. A `BlocBuilder` without `buildWhen` rebuilds on every state change.
- 🟡 **Recommended** — Extract heavy sub-trees into separate `const` widgets rather than building them inline.
- 🟡 **Recommended** — For image-heavy screens, use `AppCachedImage` and provide a reasonable `memCacheWidth` / `memCacheHeight` to limit memory usage.

```dart
// ✗ Renders all items at once
ListView(
  children: items.map((item) => ItemCard(item: item)).toList(),
)

// ✓ Lazy rendering
ListView.builder(
  itemCount: items.length,
  itemBuilder: (_, i) => ItemCard(item: items[i]),
)
```

---

## 17. Code Generation

- 🔴 **Required** — Run `dart run build_runner build --delete-conflicting-outputs` after any change to files annotated with `@freezed`, `@injectable`, or `@LazySingleton` to verify the build locally. Do **not** commit the generated output — it is git-ignored (see the next rule).
- 🔴 **Required** — Never manually edit generated files (`*.g.dart`, `*.freezed.dart`, `core/di/di.config.dart`). They are overwritten on the next build. All changes go through source annotations.
- 🔴 **Required** — Generated files (`*.g.dart`, `*.freezed.dart`, `*.config.dart`, `*.gen.dart`) must be listed in `.gitignore` and **never committed**. Instead, CI/CD and Codemagic must regenerate them by running `build_runner` as a **pre-build script** before compiling. This keeps the repository free of machine-generated diffs while guaranteeing every build has fresh generated code.

```yaml
# codemagic.yaml — run build_runner as a pre-build script
scripts:
  - name: Generate code (build_runner)
    script: |
      flutter pub get
      dart run build_runner build --delete-conflicting-outputs
  - name: Build app
    script: |
      flutter build apk --flavor prod -t lib/main_prod.dart
```

```gitignore
# .gitignore — generated output stays out of the repo
*.g.dart
*.freezed.dart
*.config.dart
*.gen.dart
```
- 🟡 **Recommended** — Run `dart run build_runner watch` during active development to keep generated files in sync automatically.

### Key Generated Files

```
lib/core/di/
└── di.config.dart                  # regenerate after any @injectable change

lib/features/<feature>/presentation/<screen>/cubit/
├── *_state.freezed.dart            # regenerate after any @freezed change
└── *_state.g.dart                  # (if using json_serializable)
```

---

## 18. Reviewer Checklist

Use this checklist when reviewing every PR. Red-tagged items are blockers — the PR cannot merge until they are resolved.

### 🏗 Architecture
- [ ] Feature follows `data / domain / presentation` structure
- [ ] New code placed in correct feature folder (or `shared/`)
- [ ] No import from presentation → data (skipping domain)
- [ ] Repository interface is in `domain/repositories/`
- [ ] Entity has no framework imports

### 🌐 Global State
- [ ] `GeneralCubit` updated after any API call that changes global data
- [ ] Feature Cubits inject `GeneralCubit` via constructor (not `getIt.get()`)
- [ ] No new singleton service created — global state goes in `GeneralCubit`

### 🔀 State Management
- [ ] State class is `@freezed`
- [ ] Loading state emitted before async work
- [ ] Final state (success or error) always emitted
- [ ] Side effects (navigation, dialogs, snack bars, bottom sheets) triggered via Cubit callbacks — navigation inside the Cubit via router; never inside `BlocBuilder`
- [ ] `buildWhen` used where applicable
- [ ] No `emit` called after Cubit is closed

### 💉 Dependency Injection
- [ ] All new classes have the correct `@injectable` decorator
- [ ] Feature Cubits use `@injectable` (not singleton)
- [ ] Cubits inject use cases only (not repositories)
- [ ] Interface registered with `as:` parameter
- [ ] `di.config.dart` git-ignored; regenerated by CI/Codemagic prescript

### 🎨 UI Rules
- [ ] No `_buildXxx()` helpers — extracted to separate widget files
- [ ] `Gap` used for all spacing (no `SizedBox`)
- [ ] All spacing values from `AppSpace`
- [ ] All colors from `AppColors` (no raw `Color()` or `Colors.*`)
- [ ] ScreenUtil suffixes used for dimensions (`.w` / `.h` / `.r`)
- [ ] Assets via generated `Assets` class (no raw path strings)
- [ ] All `Key()` / `ValueKey()` use `TestKeys` constants
- [ ] All error codes use `AppErrorCodes` constants
- [ ] `AppText`, `AppButtonWidget`, `AppTextField` used
- [ ] `AppScaffold` is the root of every new screen

### 🌐 Networking
- [ ] Uses `DioClientService` (no raw Dio instance)
- [ ] API call wrapped in `callApi<T>()`
- [ ] Endpoint defined in `AppEndpoints`
- [ ] Param keys from `ApiParameterConstant`
- [ ] Auth headers not set manually

### 🗺 Routing
- [ ] Route path added to `AppRoutes`
- [ ] Route name added to `AppRouteNames`
- [ ] Navigation uses named methods (no hardcoded paths)
- [ ] No `Navigator.push` calls
- [ ] Branch name follows convention (`feat/`, `fix/`, etc.)

### ⚠️ Error Handling
- [ ] Repository returns `Either<AppError, T>`
- [ ] `Either` folded in Cubit with `.match()`
- [ ] Error state emitted to user (not swallowed)
- [ ] No raw exceptions crossing layer boundaries
- [ ] Error codes use `AppErrorCodes` constants

### 🔒 Environments & Null Safety
- [ ] No hardcoded base URLs or API keys
- [ ] Logger interceptor disabled in `prod` flavor
- [ ] No `!` force-unwrap on API or route data
- [ ] No `dynamic` types outside JSON parsing
- [ ] No secrets committed to the repository

### 🧹 Code Quality
- [ ] No `print()` / debug logs in code
- [ ] No commented-out code blocks
- [ ] All user strings use localization
- [ ] Both `app_en.arb` and `app_ar.arb` updated
- [ ] Shared widgets used where applicable
- [ ] `ListView.builder` used for dynamic lists
- [ ] `const` constructors used where applicable

### 🧪 Tests
- [ ] New use cases have unit tests
- [ ] New Cubit has `blocTest` coverage
- [ ] Tests cover success + error paths
- [ ] No `getIt` calls in tests
- [ ] `TestKeys` used in widget tests (not text labels)

### 📦 Code Generation
- [ ] `build_runner` executed after annotation changes
- [ ] Generated files git-ignored (not committed); CI/Codemagic runs `build_runner` as a pre-build script
- [ ] No manual edits to generated files

---

*These guidelines apply to all PRs in this project. When in doubt, follow the pattern already established in the `auth` feature. Questions? Raise them in the team channel before requesting review.*
