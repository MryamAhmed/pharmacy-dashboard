// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../core/extensions/build_context_localizations.dart';
import 'app_text_field.dart';

/// A specialised [AppTextField] pre-configured for search input (leading
/// search icon, no label). Use this instead of building a search field
/// directly from [AppTextField] so every search box in the app looks and
/// behaves the same.
class AppSearchWidget extends StatelessWidget {
  const AppSearchWidget({
    required this.fieldKey,
    required this.onChanged,
    this.controller,
    this.hintText,
    this.focusNode,
  });

  final Key fieldKey;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      fieldKey: fieldKey,
      controller: controller ?? TextEditingController(),
      focusNode: focusNode,
      hintText: hintText ?? context.l10n.searchHint,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      prefix: const Icon(Icons.search),
    );
  }
}
