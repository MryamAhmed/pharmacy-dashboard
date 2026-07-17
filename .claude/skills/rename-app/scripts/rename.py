#!/usr/bin/env python3
"""Rename this Flutter template.

Updates:
  * pubspec.yaml         — name, description, dart `package:` imports across lib/ and test/.
  * Android              — namespace + applicationId, app_name strings, MainActivity path.
  * iOS                  — PRODUCT_BUNDLE_IDENTIFIER (all flavor configs + test target),
                            CFBundleDisplayName, CFBundleName.

Defaults expected (the template ships with these):
  pubspec name:          app_template
  Android applicationId: com.mdlabs.template
  iOS bundle id:         com.mdlabs.template
  Android namespace:     com.mdlabs.template
  MainActivity path:     android/app/src/main/kotlin/com/mdlabs/template/MainActivity.kt
  App display name:      MD Template (with " (Dev)" / " (STG)" suffix for dev/staging)

A `.template_renamed` marker file is written on success so the script refuses to run twice.
"""

from __future__ import annotations

import argparse
import re
import shutil
import sys
from pathlib import Path

OLD_PACKAGE = "com.mdlabs.template"
OLD_PUBSPEC_NAME = "app_template"
OLD_DISPLAY_NAME = "MD Template"
OLD_KOTLIN_PATH = "com/mdlabs/template"


def _to_snake_case(name: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_").lower()
    if not cleaned:
        raise ValueError(f"Cannot derive a pubspec name from {name!r}")
    if cleaned[0].isdigit():
        cleaned = "app_" + cleaned
    return cleaned


def _validate_package(pkg: str) -> None:
    if not re.fullmatch(r"[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+", pkg):
        raise SystemExit(
            f"Invalid package: {pkg!r}. Must be lowercase dotted, e.g. com.example.myapp"
        )


def _replace_in_file(path: Path, replacements: list[tuple[str, str]]) -> bool:
    if not path.exists():
        return False
    text = path.read_text(encoding="utf-8")
    new_text = text
    for old, new in replacements:
        new_text = new_text.replace(old, new)
    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        return True
    return False


def _replace_regex_in_file(
    path: Path, replacements: list[tuple[re.Pattern[str], str]]
) -> bool:
    if not path.exists():
        return False
    text = path.read_text(encoding="utf-8")
    new_text = text
    for pattern, repl in replacements:
        new_text = pattern.sub(repl, new_text)
    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        return True
    return False


def _root() -> Path:
    # Script lives at .claude/skills/rename-app/scripts/rename.py
    return Path(__file__).resolve().parents[4]


def main() -> int:
    parser = argparse.ArgumentParser(description="Rename this Flutter template.")
    parser.add_argument(
        "--package",
        required=True,
        help="New Android applicationId / iOS bundle id (e.g. com.mycompany.myapp)",
    )
    parser.add_argument("--name", required=True, help='New app display name (e.g. "My App")')
    parser.add_argument(
        "--pubspec-name",
        default=None,
        help="Override the pubspec package name (snake_case). Default: derived from --name.",
    )
    args = parser.parse_args()

    _validate_package(args.package)
    new_package: str = args.package
    new_name: str = args.name.strip()
    if not new_name:
        raise SystemExit("--name must not be empty")
    new_pubspec_name = args.pubspec_name or _to_snake_case(new_name)
    new_kotlin_path = new_package.replace(".", "/")

    root = _root()
    marker = root / ".template_renamed"
    if marker.exists():
        print(
            f"Refusing to run: {marker} already exists. Delete it to re-rename.",
            file=sys.stderr,
        )
        return 1

    touched: list[Path] = []

    # ---- pubspec.yaml ----
    pubspec = root / "pubspec.yaml"
    if _replace_regex_in_file(
        pubspec,
        [
            (re.compile(rf"^name:\s*{re.escape(OLD_PUBSPEC_NAME)}\s*$", re.M),
             f"name: {new_pubspec_name}"),
            (re.compile(r'^description:.*$', re.M),
             f'description: "{new_name} — Flutter app."'),
        ],
    ):
        touched.append(pubspec)

    # ---- Dart imports across lib/ and test/ ----
    for src_dir in (root / "lib", root / "test"):
        if not src_dir.exists():
            continue
        for dart in src_dir.rglob("*.dart"):
            if _replace_in_file(
                dart,
                [(f"package:{OLD_PUBSPEC_NAME}/", f"package:{new_pubspec_name}/")],
            ):
                touched.append(dart)

    # ---- Android: build.gradle.kts ----
    gradle = root / "android" / "app" / "build.gradle.kts"
    if _replace_regex_in_file(
        gradle,
        [
            (re.compile(rf'namespace\s*=\s*"{re.escape(OLD_PACKAGE)}"'),
             f'namespace = "{new_package}"'),
            (re.compile(rf'applicationId\s*=\s*"{re.escape(OLD_PACKAGE)}"'),
             f'applicationId = "{new_package}"'),
            (re.compile(rf'resValue\("string",\s*"app_name",\s*"{re.escape(OLD_DISPLAY_NAME)} \(Dev\)"\)'),
             f'resValue("string", "app_name", "{new_name} (Dev)")'),
            (re.compile(rf'resValue\("string",\s*"app_name",\s*"{re.escape(OLD_DISPLAY_NAME)} \(STG\)"\)'),
             f'resValue("string", "app_name", "{new_name} (STG)")'),
            (re.compile(rf'resValue\("string",\s*"app_name",\s*"{re.escape(OLD_DISPLAY_NAME)}"\)'),
             f'resValue("string", "app_name", "{new_name}")'),
        ],
    ):
        touched.append(gradle)

    # ---- Android: strings.xml ----
    strings = root / "android" / "app" / "src" / "main" / "res" / "values" / "strings.xml"
    if _replace_in_file(strings, [(OLD_DISPLAY_NAME, new_name)]):
        touched.append(strings)

    # ---- Android: move MainActivity ----
    old_kotlin_dir = root / "android" / "app" / "src" / "main" / "kotlin" / OLD_KOTLIN_PATH
    new_kotlin_dir = root / "android" / "app" / "src" / "main" / "kotlin" / new_kotlin_path
    main_activity_src = old_kotlin_dir / "MainActivity.kt"
    if main_activity_src.exists():
        new_kotlin_dir.mkdir(parents=True, exist_ok=True)
        main_activity_dst = new_kotlin_dir / "MainActivity.kt"
        content = main_activity_src.read_text(encoding="utf-8")
        content = content.replace(
            f"package {OLD_PACKAGE}", f"package {new_package}"
        )
        main_activity_dst.write_text(content, encoding="utf-8")
        main_activity_src.unlink()
        touched.append(main_activity_dst)
        # Walk back up and clean empty kotlin subdirs.
        cursor = old_kotlin_dir
        kotlin_root = root / "android" / "app" / "src" / "main" / "kotlin"
        while cursor != kotlin_root and cursor.exists() and not any(cursor.iterdir()):
            cursor.rmdir()
            cursor = cursor.parent

    # ---- iOS: project.pbxproj ----
    pbxproj = root / "ios" / "Runner.xcodeproj" / "project.pbxproj"
    if _replace_in_file(
        pbxproj,
        [
            # RunnerTests bundle ids must keep the .RunnerTests suffix — replace those first.
            (f"PRODUCT_BUNDLE_IDENTIFIER = {OLD_PACKAGE}.RunnerTests;",
             f"PRODUCT_BUNDLE_IDENTIFIER = {new_package}.RunnerTests;"),
            (f"PRODUCT_BUNDLE_IDENTIFIER = {OLD_PACKAGE};",
             f"PRODUCT_BUNDLE_IDENTIFIER = {new_package};"),
        ],
    ):
        touched.append(pbxproj)

    # ---- iOS: Info.plist ----
    info_plist = root / "ios" / "Runner" / "Info.plist"
    if _replace_regex_in_file(
        info_plist,
        [
            (re.compile(
                rf"<key>CFBundleDisplayName</key>\s*<string>{re.escape(OLD_DISPLAY_NAME)}</string>"
            ),
             f"<key>CFBundleDisplayName</key>\n\t\t<string>{new_name}</string>"),
            (re.compile(
                rf"<key>CFBundleName</key>\s*<string>{re.escape(OLD_PUBSPEC_NAME)}</string>"
            ),
             f"<key>CFBundleName</key>\n\t\t<string>{new_pubspec_name}</string>"),
        ],
    ):
        touched.append(info_plist)

    # ---- Marker ----
    marker.write_text(
        f"package: {new_package}\n"
        f"name: {new_name}\n"
        f"pubspec_name: {new_pubspec_name}\n",
        encoding="utf-8",
    )

    print("Renamed template:")
    print(f"  package      = {new_package}")
    print(f"  name         = {new_name}")
    print(f"  pubspec name = {new_pubspec_name}")
    print()
    print("Files touched:")
    for path in touched:
        try:
            rel = path.relative_to(root)
        except ValueError:
            rel = path
        print(f"  {rel}")
    print()
    print("Marker: .template_renamed")
    print()
    print("Next steps:")
    print("  fvm flutter pub get")
    print("  fvm dart run build_runner build --delete-conflicting-outputs")
    print("  (iOS) cd ios && pod install && cd ..")

    return 0


if __name__ == "__main__":
    sys.exit(main())
