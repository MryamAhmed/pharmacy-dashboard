// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../core/constants/app_error_codes.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../../shared/presentation/widgets/app_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

/// The login screen — a minimal email/password form.
///
/// UI-only for this template: [LoginCubit.submit] validates the inputs and
/// navigates to the home screen on success.
class LoginScreen extends StatelessWidget {
  const LoginScreen({required Key key}) : super(key: key);

  /// Resolves a field-error **code** (from [AppErrorCodes], as emitted by
  /// [LoginCubit]) to localized display text. Lives here — not in the
  /// Cubit — because only the widget has a `BuildContext` to localize with.
  String? _fieldErrorText(BuildContext context, String? code) {
    switch (code) {
      case AppErrorCodes.fieldRequired:
        return context.l10n.validationFieldRequired;
      case AppErrorCodes.invalidEmail:
        return context.l10n.validationInvalidEmail;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return AppScaffold(
      key: const Key(TestKeys.loginScaffold),
      mobileBody: SafeArea(
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gap(AppSpace.s80.h),
                  const FlutterLogo(size: 96),
                  const Gap(AppSpace.s24),
                  AppText(
                    key: const Key(TestKeys.loginTitle),
                    text: context.l10n.loginTitle,
                    style: AppTextStyles.bold28,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppSpace.s8),
                  AppText(
                    key: const Key(TestKeys.loginSubtitle),
                    text: context.l10n.loginSubtitle,
                    style: AppTextStyles.regular14Gray,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppSpace.s36),
                  AppTextField(
                    fieldKey: const Key(TestKeys.loginEmailField),
                    controller: cubit.emailController,
                    hintText: context.l10n.loginEmailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => cubit.onEmailEdited(),
                    errorText: _fieldErrorText(context, state.emailFieldError),
                  ),
                  const Gap(AppSpace.s16),
                  AppTextField(
                    fieldKey: const Key(TestKeys.loginPasswordField),
                    controller: cubit.passwordController,
                    hintText: context.l10n.loginPasswordHint,
                    obscureText: state.obscurePassword,
                    textInputAction: TextInputAction.done,
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => cubit.onPasswordEdited(),
                    errorText: _fieldErrorText(
                      context,
                      state.passwordFieldError,
                    ),
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
                  const Gap(AppSpace.s36),
                  AppButtonWidget(
                    key: const Key(TestKeys.loginSubmitButton),
                    text: context.l10n.loginSubmitButton,
                    isLoading: state.isSubmitting,
                    onPressed: cubit.submit,
                  ),
                  const Gap(AppSpace.s24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
