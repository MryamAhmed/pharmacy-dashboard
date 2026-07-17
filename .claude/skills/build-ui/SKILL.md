---
name: build-ui
description: Defines the rukes and considerations of building UI widgets
---

Apply the following rules strictly when building any Flutter UI in this project. Ask for clarification before writing any code if the design or requirements are ambiguous.

---

## Before you start

If the required UI is not clearly described, or if there is any ambiguity about layout, states, or interactions — **stop and ask** before implementing anything.

---

## Rules

### 1 — No inline helper methods in widget `build()`
Never extract UI into a private `_buildXxx()` method inside the same class.  
If a piece of the UI needs to be extracted, create a **dedicated `StatelessWidget` in its own file** under the `widgets/` folder of the current screen.  
Only create a separate widget when it is genuinely warranted — do not over-engineer.  
If the same widget will be reused across multiple features, place it in `lib/shared/presentation/widgets/`.

### 2 — Zero logic in the UI layer
Screens and widgets must contain **no business logic, no data transformation, and no conditional decisions beyond simple state-driven rendering**.  
Any logic belongs in the Cubit. Expose it as a method or a getter, and call it from the widget.

### 3 — Use shared reusable widgets — no reinvention

| Need | Use |
|---|---|
| Any text | `AppText` — `lib/shared/presentation/widgets/app_text.dart` |
| Any button | `AppButtonWidget` — `lib/shared/presentation/widgets/app_button.dart` |
| Any network image | `AppImage` — `lib/shared/presentation/widgets/app_cached_image.dart` |
| Any text field | `AppTextField` — `lib/shared/presentation/widgets/app_text_field.dart` |
| Screen root | `AppScaffold` — `lib/shared/presentation/widgets/app_scaffold.dart` |
| Loading indicator | `AppLoadingWidget` — `lib/shared/presentation/widgets/app_loading_widget.dart` |
| Snack bar | `AppMessageSnackBar` — `lib/shared/presentation/widgets/app_message_snack_bar.dart` |

Check `lib/shared/presentation/widgets/` for any other existing widget before creating a new one.

### 4 — Assets via the generated `Assets` class
Never use raw asset path strings. Always use the generated `Assets` class:  
`lib/gen/assets.gen.dart`

```dart
Assets.images.icons.settingsIcon.svg(...)   // SVG
Assets.images.logo.image(...)               // PNG/image
Assets.animations.successLottieAnimation    // Lottie path
```

### 5 — Spacing: `Gap`, never `SizedBox`
Use the `Gap` widget (from the `gap` package) for all horizontal and vertical spacing.  
Never use `SizedBox(height: ...)` or `SizedBox(width: ...)` for spacing.

### 6 — Spacing values must be `const` from `AppPadding` / `AppMargin`
All padding, gap, and margin values must:
- Be **`const`**
- Come from `AppPadding` or `AppMargin` in `lib/core/constants/app_values.dart`

```dart
// Correct
const Gap(AppSpace.s16)
EdgeInsets.all(AppPadding.p12)

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
Always use a constant from `lib/core/themes/app_colors.dart`:

```dart
// Correct
color: AppColors.primaryColor
color: AppColors.textGray

// Wrong
color: Color(0xFF3E705F)
color: Colors.grey
```

### 9 — No hardcoded strings anywhere
**UI layer**: all user-facing strings must come from `AppLocalizations` via the `l10n` extension:

```dart
context.l10n.yourKey   // lib/core/extensions/build_context_localizations.dart
```

Add new strings to **both** `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb` before using them.

**Other layers** (Cubits, repositories, constants): string literals belong in the appropriate file under `lib/core/constants/` (e.g. `app_error_codes.dart`, `api_parameters.dart`, `app_endpoints.dart`).

### 10 — All widget keys must use `TestKeys` constants
Every `Key(...)` or `ValueKey(...)` passed to any widget must reference a constant from `lib/core/constants/test_keys.dart`. Never pass a raw string literal.

```dart
// Correct
key: const Key(TestKeys.activityCounterCard)
key: ValueKey('${TestKeys.activityQuestionRow}_${item.id}')

// Wrong
key: const Key('activityCounterCard')
key: ValueKey('question_${item.id}')
```

Add new keys to `TestKeys` before using them.

---

### 11 — All error codes must use `AppErrorCodes` constants
Every `AppError.local(...)` call and every `error.code ==` comparison must use a constant from `lib/core/constants/app_error_codes.dart`. Never pass a raw string literal.

```dart
// Correct
AppError.local(AppErrorCodes.noActiveShift)
if (error.code == AppErrorCodes.noActiveShift)

// Wrong
AppError.local('NO_ACTIVE_SHIFT')
if (error.code == 'NO_ACTIVE_SHIFT')
```

Add new codes to `AppErrorCodes` before using them. If the code has a user-facing message, also add a case to `AppErrorX.localized()` in `lib/core/extensions/app_error_localization.dart`.

---

## Quick mental checklist before submitting

- [ ] No `_buildXxx()` methods — extracted widgets are in separate files
- [ ] No logic inside `build()` — only state-driven rendering
- [ ] `AppText` used for every text node
- [ ] `AppButtonWidget` used for every button
- [ ] `AppTextField` used for every input
- [ ] `AppImage` used for every network image
- [ ] `AppScaffold` is the root of every new screen
- [ ] All assets via `Assets.images...` / `Assets.animations...`
- [ ] `Gap` instead of `SizedBox` for spacing
- [ ] All spacing values are `const` from `AppPadding` / `AppMargin`
- [ ] Widths, heights, and radii use `.w` / `.h` / `.r` from ScreenUtil
- [ ] All colors from `AppColors`
- [ ] All strings from `context.l10n.*`, added to both ARB files
