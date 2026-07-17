// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// Shared text widget.
///
/// Per PR guidelines: every piece of text in the app must go through this
/// widget instead of a bare [Text] — never build `Text(...)` directly in a
/// screen or shared widget.
///
/// Backed by [AutoSizeText] so long/localised content shrinks to fit its
/// available space instead of overflowing or wrapping unexpectedly.
class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textDirection,
    this.minFontSize = 8,
    this.softWrap = true,
  });

  /// The string to render.
  final String text;

  /// Text style. When omitted, inherits from the surrounding
  /// [DefaultTextStyle] (see [AppTextStyles] conventions).
  final TextStyle? style;

  final TextAlign? textAlign;

  /// Maximum number of lines before the text starts shrinking to fit.
  final int? maxLines;

  final TextOverflow? overflow;

  final TextDirection? textDirection;

  /// Smallest font size [AutoSizeText] will shrink down to.
  final double minFontSize;

  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      minFontSize: minFontSize,
      softWrap: softWrap,
    );
  }
}
