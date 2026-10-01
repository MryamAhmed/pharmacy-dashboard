import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_button_widget.dart';

class RateDetailsBottomNavigatorsWidget extends StatelessWidget {
  const RateDetailsBottomNavigatorsWidget({
    super.key,
    required this.backgroundColor,
    required this.rejectedColor,
  });
  final backgroundColor;
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
      child: Expanded(
        child: AppButtonWidget(
          height: 50.h,
          radius: 8.r,
          key: const ValueKey('${TestKeys.rateDetailsButtonLabel}'),
          text: context.l10n.rateDetailsRejectButton,
          onPressed: () {
            context.pop();
          },
          backgroundColor: backgroundColor,

          style: rejectedColor
              ? AppTextStyles.bold12RateRejectTextColor
              : AppTextStyles.bold12White,
        ),
      ),
    );
  }
}
