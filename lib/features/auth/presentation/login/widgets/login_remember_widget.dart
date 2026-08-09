import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_check_box_widget.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginRememberWidget extends StatelessWidget {
  final LoginCubit cubit;
  final LoginState state;
  const LoginRememberWidget({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppCheckBoxWidget(
              scale: 1.2,
              key: const Key(TestKeys.loginRememberMeCheckbox),
              value: state.rememberMe,
              onChanged: (_) => cubit.toggleRememberMe(),
            ),
            const Gap(AppSpace.s2),
            AppText(
              key: const Key(TestKeys.loginRememberMeLabel),
              text: context.l10n.loginRememberMe,
              style: AppTextStyles.regular12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        AppText(
          key: const Key(TestKeys.loginForgotPasswordButton),
          text: context.l10n.loginForgotPassword,
          style: AppTextStyles.regular12PrimaryColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
