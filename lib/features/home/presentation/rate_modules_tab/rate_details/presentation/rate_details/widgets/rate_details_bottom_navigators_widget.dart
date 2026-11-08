import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../cubit/rate_details_cubit.dart';
import '../cubit/rate_details_state.dart';

/// Bottom bar of the rate-details screen holding the Delete button.
/// Calls [RateDetailsCubit.deleteRate] and shows a loader while it runs.
class RateDetailsBottomNavigatorsWidget extends StatelessWidget {
  const RateDetailsBottomNavigatorsWidget({
    super.key,
    required this.backgroundColor,
    required this.rejectedColor,
  });

  final Color backgroundColor;
  final bool rejectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.textWhite,
      padding: const EdgeInsets.fromLTRB(
        AppPaddings.p4,
        AppPaddings.p14,
        AppPaddings.p4,
        AppPaddings.p24,
      ),
      // Rebuild only the button when the deleting flag flips.
      child: BlocBuilder<RateDetailsCubit, RateDetailsState>(
        buildWhen: (previous, current) =>
            previous.isDeleting != current.isDeleting,
        builder: (context, state) {
          return AppButtonWidget(
            height: 50.h,
            radius: 8.r,
            key: const ValueKey(TestKeys.rateDetailsButtonLabel),
            text: context.l10n.rateDetailsRejectButton,
            isLoading: state.isDeleting,
            onPressed: () => context.read<RateDetailsCubit>().deleteRate(),
            backgroundColor: backgroundColor,
            style: rejectedColor
                ? AppTextStyles.bold12RateRejectTextColor
                : AppTextStyles.bold12White,
          );
        },
      ),
    );
  }
}
