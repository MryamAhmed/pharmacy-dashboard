import 'package:flutter/material.dart';

import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text_field.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppTextField(
        fieldKey: const Key(TestKeys.loginEmailField),
        labelStyle: AppTextStyles.medium12,
        controller: TextEditingController(),
        hintText: context.l10n.searchHint,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
