import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../cubit/pharmacy_datails_cubit.dart';
import '../cubit/pharmacy_details_states.dart';

/// Bottom bar of the pharmacy details screen: Verify (`Dashboard/verify`)
/// and Reject (`Dashboard/unverify`).
///
/// Replaces the reused `RateDetailsBottomNavigatorsWidget`, which now depends
/// on `RateDetailsCubit` and would throw here.
class PharmacyDetailsActionsWidget extends StatelessWidget {
  const PharmacyDetailsActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.textWhite,
      padding: const EdgeInsets.fromLTRB(
        AppPaddings.p24,
        AppPaddings.p14,
        AppPaddings.p24,
        AppPaddings.p24,
      ),
      // Rebuild only when a request starts/ends or the pharmacy changes.
      child: BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
        buildWhen: (previous, current) =>
            previous.isVerifying != current.isVerifying ||
            previous.isRejecting != current.isRejecting ||
            previous.pharmacy != current.pharmacy,
        builder: (context, state) {
          final cubit = context.read<PharmacyDetailsCubit>();
          final isVerified = state.pharmacy.isVerified;
          return Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  key: const Key(TestKeys.pharmacyDetailsVerifyButton),
                  height: 50.h,
                  radius: 8.r,
                  // Already verified → disabled "Verified" label.
                  text: isVerified
                      ? context.l10n.pharmacyVerifiedLabel
                      : context.l10n.pharmacyVerifyButton,
                  isEnabled: !isVerified && !state.isRejecting,
                  isLoading: state.isVerifying,
                  onPressed: cubit.verify,
                  backgroundColor: AppColors.dashboardItem2Color,
                  style: AppTextStyles.bold12White,
                ),
              ),
              const Gap(AppSpace.s12),
              Expanded(
                child: AppButtonWidget(
                  key: const Key(TestKeys.pharmacyDetailsRejectButton),
                  height: 50.h,
                  radius: 8.r,
                  text: context.l10n.pharmacyRejectButton,
                  isEnabled: !state.isVerifying,
                  isLoading: state.isRejecting,
                  onPressed: cubit.reject,
                  backgroundColor: AppColors.rateRejectBackgroundColor,
                  style: AppTextStyles.bold12RateRejectTextColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
