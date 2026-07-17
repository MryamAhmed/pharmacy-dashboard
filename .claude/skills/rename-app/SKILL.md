---
name: rename-app
description: Rename this Flutter template — change the Android applicationId / namespace, iOS bundle identifier (all flavors), display name, pubspec package name, MainActivity path/package, and Dart imports. Use when the user says things like "change the package name to com.X.Y", "rename the app to ...", "set the bundle id to ...", "rebrand this template", or any similar one-shot rename request after cloning the template.
---

# rename-app

Run this once after cloning the template. Renames every package/bundle identifier and display name so the project no longer says "MD Template" / `com.mdlabs.template`.

## When to trigger

The user says any of:
- "Change the package name to `com.X.Y.Z`."
- "Rename the app to `Whatever`."
- "Set the bundle id to `com.X.Y.Z` and the app name to `Foo`."
- "Rebrand this template as `…`."

Both **package name** and **app name** are required to run the rename. If the user gave only one, ask for the other before doing anything.

## How to run

1. **Check the marker.** If `.template_renamed` exists at the project root, the rename has already run — tell the user and stop. (To re-rename, they can delete the marker manually.)

2. **Parse inputs:**
   - `--package` — e.g. `com.mycompany.mynewapp` (must be a valid Java/Android package: lowercase, dot-separated, alphanumeric + underscores).
   - `--name` — the user-facing app name (e.g. `My New App`).
   - Optionally derive a Dart `pubspec` package name from `--name` (snake_case) — or accept `--pubspec-name` explicitly.

3. **Run the helper:**

   ```sh
   python3 .claude/skills/rename-app/scripts/rename.py \
     --package "com.mycompany.mynewapp" \
     --name "My New App"
   ```

   If the user is on Windows without `python3` on PATH, run with `python` instead.

4. **Report the diff:** read the output of the script (it prints every file touched), then summarise to the user.

5. **Tell the user the follow-up commands they need to run:**

   ```sh
   fvm flutter pub get
   fvm dart run build_runner build --delete-conflicting-outputs
   cd ios && pod install && cd ..
   ```

## What the script does

- `pubspec.yaml` — updates `name:` (derived from `--name` as snake_case, or `--pubspec-name`) and `description:`.
- `android/app/build.gradle.kts` — replaces `namespace` and `defaultConfig.applicationId`.
- `android/app/src/main/res/values/strings.xml` — replaces the default `app_name`.
- `android/app/build.gradle.kts` `productFlavors` block — updates the per-flavor `resValue("string", "app_name", ...)` to use `"<name> (Dev)" / (STG) / <name>`.
- **Moves** `android/app/src/main/kotlin/com/mdlabs/template/MainActivity.kt` to the new package path and rewrites its `package` declaration.
- `ios/Runner.xcodeproj/project.pbxproj` — replaces **every** `PRODUCT_BUNDLE_IDENTIFIER = com.mdlabs.template;` (app target, all 9 flavor configs) and `com.mdlabs.template.RunnerTests` (test target).
- `ios/Runner/Info.plist` — updates `CFBundleDisplayName` and `CFBundleName`.
- Every `.dart` file under `lib/` and `test/` — replaces `package:app_template/` imports with `package:<new_pubspec_name>/`.
- Writes `.template_renamed` containing the new identifiers so the skill won't run twice.

## Notes

- Bundle ids are the **same across all flavors** in this template (no `.dev` suffix). The script preserves that. If the user wants flavor-specific bundle ids, that's a separate ask.
- The script is idempotent in the sense that it only acts on the original template defaults — running it after manual edits may miss some occurrences. Always check the marker first.
