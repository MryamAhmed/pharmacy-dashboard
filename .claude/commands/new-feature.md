---
description: Scaffold a new feature in this project following the Clean Architecture conventions.
---

# New Feature

When the user asks for a new feature, follow this exact procedure. Read `CLAUDE.md` and `PR_GUIDELINES.md` before writing any code. Look at `lib/features/auth/` (and its `docs/auth_feature.md`) for a worked example.

---

## 1. Confirm scope

Before scaffolding anything, confirm:
- The feature name (snake_case folder name).
- The screens involved.
- The endpoints involved (HTTP method, path, request body shape, response body shape).
- Whether this feature mutates global state (`GeneralCubit`).

If anything is unclear — **ask**.

---

## 2. Scaffold

Create the standard structure under `lib/features/<feature_name>/`:

```
data/
  datasources/
    <feature>_remote_data_source.dart        # abstract
    <feature>_remote_data_source_impl.dart   # @LazySingleton(as: ...)
  models/
    <name>_response.dart                     # DTO + fromJson + toDomain
  repositories/
    <feature>_repository_impl.dart           # @LazySingleton(as: ...)
domain/
  entities/
    <name>_entity.dart                       # pure Dart
  repositories/
    <feature>_repository.dart                # abstract — returns Either
  usecases/
    <action>_usecase.dart                    # @injectable, single `call()`
presentation/
  <screen_name>/
    cubit/
      <screen>_cubit.dart                    # @injectable, GoRouter injected if needed
      <screen>_state.dart                    # @freezed
    screens/
      <screen>_screen.dart                   # uses AppScaffold
    widgets/                                 # screen-specific widgets
```

---

## 3. Add constants

Before using them in code, add new entries to:

- `lib/core/constants/app_endpoints.dart` — endpoint paths.
- `lib/core/constants/api_parameters.dart` — request body / query key names.
- `lib/core/constants/test_keys.dart` — every widget Key the feature uses.
- `lib/core/constants/app_error_codes.dart` — every error code the feature handles.

---

## 4. Wire the route

In `lib/core/router/app_router.dart`:
- Add a path to `AppRoutes` and a name to `AppRouteNames`.
- Add a `GoRoute` entry with `BlocProvider(create: (_) => getIt.get<XCubit>(), child: …)`.

---

## 5. Localize

Add every user-facing string to **both** `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`. Reference them via `context.l10n.yourKey`.

---

## 6. Generate

```sh
fvm dart run build_runner build --delete-conflicting-outputs
```

Do **not** commit generated files — they are git-ignored.

---

## 7. Self-review against the PR guidelines

Walk through every checklist in `PR_GUIDELINES.md` for the files you wrote. Most common misses:
- A `Text(...)` instead of `AppText`.
- A `SizedBox(height: 16)` instead of `Gap(AppSpace.s16)`.
- A raw string `'Some text'` instead of `context.l10n.someText`.
- A `BlocListener` triggering a snackbar (should be a callback from the widget instead).
- A repository injected into a Cubit (should be a use case).
