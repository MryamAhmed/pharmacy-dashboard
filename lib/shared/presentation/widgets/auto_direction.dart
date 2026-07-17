// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart' as intl;

/// Wraps a child in a [Directionality] that flips between LTR/RTL based on
/// whether [text] contains RTL characters. Useful for user-generated content
/// that may be in any language.
class AutoDirection extends StatelessWidget {
  const AutoDirection({
    required Key key,
    required this.text,
    required this.child,
  }) : super(key: key);

  final String text;
  final Widget child;

  bool _isRtl(BuildContext context) {
    if (text.isEmpty) {
      return Directionality.of(context) == TextDirection.rtl;
    }
    return intl.Bidi.detectRtlDirectionality(text);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _isRtl(context) ? TextDirection.rtl : TextDirection.ltr,
      child: child,
    );
  }
}
