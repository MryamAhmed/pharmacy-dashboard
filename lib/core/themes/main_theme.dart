// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class MainTheme {
  MainTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    // ---------- Per-mode palette ----------
    // Surfaces, foregrounds, and input fills branch on brightness here so
    // every consumer of `Theme.of(context)` picks up the right colour.
    final Color scaffoldBackground = isDark
        ? const Color(0xFF101218)
        : AppColors.mainWhiteColor;
    final Color surface = isDark
        ? const Color(0xFF181B22)
        : AppColors.mainWhiteColor;
    final Color onSurface = isDark ? AppColors.textWhite : AppColors.textBlack;
    final Color onSurfaceMuted = isDark
        ? const Color(0xFFA4ADBD)
        : AppColors.hintStyleColor;
    final Color outline = isDark
        ? const Color(0xFF2A2F3A)
        : AppColors.textFieldBorder;
    final Color inputFill = isDark
        ? const Color(0xFF1E222B)
        : AppColors.mainWhiteColor;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          brightness: brightness,
        ).copyWith(
          error: AppColors.mainRedColor,
          onError: AppColors.textWhite,
          surface: surface,
          onSurface: onSurface,
          onSurfaceVariant: onSurfaceMuted,
          outline: outline,
        );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: FontFamily.dMSans,

      // Drives DefaultTextStyle across the app for any [Text]/[AppText] that
      // doesn't go through [AppTextStyles].
      textTheme: Typography.material2021(platform: TargetPlatform.android)
          .geometryThemeFor(ScriptCategory.englishLike)
          .apply(
            fontFamily: FontFamily.dMSans,
            bodyColor: onSurface,
            displayColor: onSurface,
            decorationColor: onSurface,
          ),

      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70.h,
        iconTheme: IconThemeData(color: onSurface),
        titleTextStyle: AppTextStyles.medium18.copyWith(color: onSurface),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
              ),
      ),

      iconTheme: IconThemeData(color: onSurface),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.regular12.copyWith(color: onSurfaceMuted),
        errorStyle: AppTextStyles.regular14Red,
        filled: true,
        fillColor: inputFill,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.mainRedColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.mainRedColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textWhite;
            }
            return onSurface;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryColor;
            }
            return surface;
          }),
          side: WidgetStateProperty.all(BorderSide(color: outline)),
        ),
      ),
    );
  }
}
