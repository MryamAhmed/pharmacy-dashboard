// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_button_widget.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../domain/entities/rate_entity.dart';
import '../cubit/rate_cubit.dart';

/// A single pending review shown in the Rate tab's list.
///
/// Tapping anywhere on the card opens the review's details via
/// [RateCubit.openRateDetails] (navigation is owned by the cubit, not this
/// widget, matching [LoginCubit]'s pattern elsewhere in the app).
class RateCardWidget extends StatelessWidget {
  const RateCardWidget({super.key, required this.rate});

  final RateEntity rate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey('${TestKeys.rateCardItem}_${rate.id}'),
      onTap: () => context.read<RateCubit>().openRateDetails(rate),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppPaddings.p12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.textWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        rate.profilePicture ?? '',
                        width: 40.w,
                        height: 40.h,
                        fit: BoxFit.cover,
                      ),
                      const Gap(AppSpace.s12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText(
                                key: ValueKey(
                                  '${TestKeys.pharmacyRateLabel}_${rate.id}',
                                ),
                                text: rate.reviewerName ?? '',
                                style: AppTextStyles.bold12,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(AppSpace.s8),
                              AppText(
                                key: ValueKey(
                                  '${TestKeys.userRateLabel}_${rate.id}',
                                ),
                                text: context.l10n.rateForUser(
                                  rate.reviewerName ?? '',
                                ),
                                style: AppTextStyles.regular10Hintstyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          AppText(
                            key: ValueKey(
                              '${TestKeys.rateStarsLabel}_${rate.id}',
                            ),
                            text: List.filled(rate.rate ?? 0, '★').join(' '),
                            style: AppTextStyles.regular14RateStarsColor,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppText(
                    key: ValueKey('${TestKeys.rateDurationLabel}_${rate.id}'),
                    text: rate.createdAt ?? '',
                    style: AppTextStyles.regular10Hintstyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Gap(AppSpace.s12),
            SizedBox(
              width: double.infinity,
              child: AppText(
                key: ValueKey('${TestKeys.rateDescriptionLabel}_${rate.id}'),
                text: rate.comment ?? '',
                style: AppTextStyles.regular12,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(AppSpace.s12),
            AppButtonWidget(
              height: 32.h,
              width: 80.w,
              radius: 8.r,
              key: ValueKey('${TestKeys.rateButtonLabel}_${rate.id}'),
              text: context.l10n.rateApproveButton,
              onPressed: () {},
              style: AppTextStyles.bold10White,
            ),
          ],
        ),
      ),
    );
  }
}
