# Pharmacy

A clean Flutter starter template, derived from an existing Clean-Architecture
project. It keeps the reusable foundation (theming, ScreenUtil, localization,
routing, DI, Dio networking + `Either` error handling, and the shared widget
library) and ships a minimal **splash → login → home** flow.

- **App id / bundle id:** `com.pharmacy.app`
- **Dart package name:** `pharmacy_app`
- **Display name:** Pharmacy
- No Firebase, no bundled image/font assets, default Flutter launcher icon.

## First-time setup

Run these once after cloning/copying the project:

```bash
# 1. Fetch dependencies (also generates the l10n localizations).
flutter pub get

# 2. Restore the default Flutter launcher icon + iOS launch/app-icon assets.
#    The custom icons were removed; this recreates the stock defaults without
#    touching your existing app id, manifest, or Gradle/plist edits.
flutter create --org com.pharmacy --project-name pharmacy_app \
  --platforms android,ios,web .

# 3. Run a flavor.
flutter run --flavor dev -t lib/main_dev.dart
```

> This template deliberately avoids `build_runner` codegen: state classes are
> plain immutable classes and dependency injection is wired by hand in
> `lib/core/di/di.dart`. Only Flutter's built-in l10n generation runs (via
> `generate: true`), which happens automatically during `flutter pub get`/build.

## Flavors & entry points

| Flavor  | Entry point            | Display name       |
|---------|------------------------|--------------------|
| dev     | `lib/main_dev.dart`    | Pharmacy (Dev)     |
| staging | `lib/main_staging.dart`| Pharmacy (STG)     |
| prod    | `lib/main_prod.dart`   | Pharmacy           |

Set the API base URL per flavor in `lib/flavors.dart` (currently placeholders).

## Structure

```
lib/
├── core/            # constants, DI, extensions, router, themes, utils
├── features/
│   ├── splash/      # Flutter-logo splash → login
│   ├── auth/login/  # email/password login (UI stub)
│   └── home/        # placeholder post-login screen
├── shared/          # Dio client, error handling, GeneralCubit, shared widgets
├── l10n/            # ARB files + generated localizations (en, ar)
└── main_*.dart      # per-flavor entry points → main_common.dart
```

## Notes
- `lib/main.dart` is an unused standalone stub; the real entry points are the
  `main_*.dart` flavor files.
- The project-convention docs (`CLAUDE.md`, `.wolf/`) still describe the
  original source project and can be trimmed to taste.
