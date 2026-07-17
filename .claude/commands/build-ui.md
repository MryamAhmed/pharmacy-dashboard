---
description: Build a Flutter UI in this project following the strict template conventions.
---

# Build UI

Apply the following rules strictly when building any Flutter UI in this project. Ask for clarification before writing any code if the design or requirements are ambiguous.

---

## Before you start

If the required UI is not clearly described, or if there is any ambiguity about layout, states, or interactions — **stop and ask** before implementing anything.

---

## Rules

### 1 — No inline helper methods in widget `build()`
Never extract UI into a private `_buildXxx()` method inside the same class.
If a piece of UI needs to be extracted, create a **dedicated `StatelessWidget` in its own file** under the `widgets/` folder of the current screen.
Only create a separate widget when it's genuinely warranted — do not over-engineer.
If the same widget will be reused across multiple features, place it in `lib/shared/presentation/widgets/`.

### 2 — Zero logic in the UI layer
Screens and widgets must contain **no business logic, no data transformation, and no conditional decisions beyond simple state-driven rendering**.
Any logic belongs in the Cubit. Expose it as a method or a getter, and call it from the widget.

### 3 — Use shared reusable widgets — no reinvention

| Need | Use |
|---|---|
| Any text | `AppText` — `lib/shared/presentation/widgets/app_text.dart` |
| Any button | `AppButtonWidget` — `lib/shared/presentation/widgets/app_button.dart` |
| Any network image | `AppCachedImage` — `lib/shared/presentation/widgets/app_cached_image.dart` |
| Any text field | `AppTextField` — `lib/shared/presentation/widgets/app_text_field.dart` |
| Screen root | `AppScaffold` — `lib/shared/presentation/widgets/app_scaffold.dart` |
| Loading indicator | `AppLoadingWidget` — `lib/shared/presentation/widgets/app_loading_widget.dart` |
| Snack bar | `AppMessageSnackBar` — `lib/shared/presentation/widgets/app_message_snack_bar.dart` |

Check `lib/shared/presentation/widgets/` for any other existing widget before creating a new one.

### 4 — Assets via the generated `Assets` class
Never use raw asset path strings. Always use the generated `Assets` class from `lib/gen/assets.gen.dart`.

### 5 — Spacing: `Gap`, never `SizedBox`
Use the `Gap` widget (from the `gap` package) for all horizontal and vertical spacing.
Never use `SizedBox(height: ...)` or `SizedBox(width: ...)` for spacing.

### 6 — Spacing values must be `const` from `AppSpace`
All padding, gap, and margin values must:
- Be **`const`**
- Come from `lib/core/constants/app_values.dart`

```dart
// Correct
const Gap(AppSpace.s16)
EdgeInsets.all(AppPadding.p16) // for padding
EdgeInsets.all(AppMargin.m16) // for margin

// Wrong
SizedBox(height: 16)
EdgeInsets.all(16)
```

### 7 — Dimensions via `flutter_screenutil`
Use `ScreenUtil` suffixes for all width, height, and border radius values:

```dart
width: 120.w
height: 48.h
BorderRadius.circular(12.r)
```

### 8 — Colors from `AppColors`
Never use raw `Color(0xFF...)` or named Flutter colors in widgets.
Always use a constant from `lib/core/themes/app_colors.dart`.

### 9 — No hardcoded strings anywhere
**UI layer**: all user-facing strings must come from `AppLocalizations` via the `l10n` extension:

```dart
context.l10n.yourKey   // lib/core/extensions/build_context_localizations.dart
```

Add new strings to **both** `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb` before using them.

**Other layers** (Cubits, repositories, constants): string literals belong in the appropriate file under `lib/core/constants/` (e.g. `app_error_codes.dart`, `api_parameters.dart`, `app_endpoints.dart`).

### 10 — Widget keys via `TestKeys`
Every `Key(...)` / `ValueKey(...)` must reference a constant from `lib/core/constants/test_keys.dart`. Add the constant before use.

### 11 — Side effects: snackbars / dialogs / bottom sheets are widget-side, navigation is Cubit-side
Snackbars, dialogs, and bottom sheets need a `BuildContext`, so define them as functions inside the screen widget's `build()` and pass them to the Cubit method as callbacks.
Navigation happens inside the Cubit via an injected `GoRouter`.
**Do not** trigger any of these from inside a `BlocBuilder` or `BlocListener`.
