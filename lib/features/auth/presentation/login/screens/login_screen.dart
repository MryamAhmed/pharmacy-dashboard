// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/core/themes/app_colors.dart';
import 'package:pharmacy_app/features/auth/presentation/login/widgets/login_remember_widget.dart';

// Project imports:
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../../../../core/extensions/app_error_localization.dart';
import '../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/login_fields_widget.dart';

/// The login screen — a minimal email/password form.
///
/// UI-only for this template: [LoginCubit.submit] validates the inputs and
/// navigates to the home screen on success.
class LoginScreen extends StatelessWidget {
  const LoginScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return AppScaffold(
      backgroundColor: AppColors.screenBackground,
      key: const Key(TestKeys.loginScaffold),
      mobileBody: SafeArea(
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(AppSpace.s56),

                  AppText(
                    key: const Key(TestKeys.loginTitle),
                    text: context.l10n.loginWelcomeTitle(
                      AppConstants.loginPlaceholderUserName,
                    ),
                    style: AppTextStyles.bold30,
                    textAlign: TextAlign.center,
                  ),

                  const Gap(AppSpace.s56),

                  LoginFieldsWidget(cubit: cubit, state: state),
                  const Gap(AppSpace.s12),

                  LoginRememberWidget(cubit: cubit, state: state),

                  if (state.error != null) ...[
                    const Gap(AppSpace.s12),
                    AppText(
                      key: const Key(TestKeys.loginGeneralError),
                      text: state.error!.localized(context),
                      style: AppTextStyles.regular14Red,
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const Gap(AppSpace.s58),
                  AppButtonWidget(
                    height: 50.h,
                    radius: 8.r,
                    key: const Key(TestKeys.loginSubmitButton),
                    text: context.l10n.loginSubmitButton,
                    isLoading: state.isSubmitting,
                    onPressed: cubit.submit,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
