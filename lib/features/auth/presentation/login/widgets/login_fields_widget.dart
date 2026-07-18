import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/app_error_localization.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginFieldsWidget extends StatelessWidget {
  final LoginCubit cubit;
  final LoginState state;
  const LoginFieldsWidget({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          fieldKey: const Key(TestKeys.loginEmailField),
          labelText: context.l10n.loginEmailLabel,
          labelStyle: AppTextStyles.medium12,
          controller: cubit.emailController,
          hintText: AppConstants.loginEmailPlaceholder,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textDirection: TextDirection.ltr,
          onChanged: (_) => cubit.onEmailEdited(),
          errorText: state.emailFieldError.fieldErrorText(context),
          fillColor: AppColors.textWhite,
        ),
        const Gap(AppSpace.s12),
        AppTextField(
          fillColor: AppColors.textWhite,
          labelText: context.l10n.loginPasswordLabel,
          labelStyle: AppTextStyles.medium12,
          fieldKey: const Key(TestKeys.loginPasswordField),
          controller: cubit.passwordController,
          hintText: AppConstants.loginPasswordPlaceholder,
          obscureText: state.obscurePassword,
          textInputAction: TextInputAction.done,
          textDirection: TextDirection.ltr,
          onChanged: (_) => cubit.onPasswordEdited(),
          errorText: state.passwordFieldError.fieldErrorText(context),
          suffix: IconButton(
            key: const Key(TestKeys.loginPasswordVisibilityToggle),
            icon: Icon(
              state.obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: cubit.toggleObscurePassword,
          ),
        ),
      ],
    );
  }
}
