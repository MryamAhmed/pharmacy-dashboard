// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_context_card_widget.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_pending_widget.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_previous_rate_widget.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_rate_text_card_widget.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_details_user_card_widget.dart';
import 'package:pharmacy_app/features/home/presentation/rate_modules_tab/rate_details/presentation/rate_details/widgets/rate_given_widget.dart';

// Project imports:
import '../../../../../../../../core/constants/app_values.dart';
import '../../../../../../../../core/constants/test_keys.dart';
import '../../../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../../core/themes/app_text_style.dart';
import '../../../../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../cubit/rate_details_cubit.dart';
import '../cubit/rate_details_state.dart';
import '../widgets/rate_details_bottom_navigators_widget.dart';
import '../widgets/rate_details_pharmacy_card_widget.dart';

/// Full details of a single review, opened by tapping a card in the Rate
/// tab's list ([RateCubit.openRateDetails]). Read-only for now — no
/// approve/reject action lives here yet.
class RateDetailsScreen extends StatelessWidget {
  const RateDetailsScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RateDetailsCubit, RateDetailsState>(
      builder: (context, state) {
        final rate = state.rate;
        return AppScaffold(
          key: const Key(TestKeys.rateDetailsPage),
          backgroundColor: AppColors.screenBackground,
          showAppBar: true,
          appBarTitle: context.l10n.rateDetailsTitle,
          appBarTitleStyle: AppTextStyles.bold16,
          mobileBody: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RateDetailsPendingWidget(rate: rate),
                const Gap(AppSpace.s12),
                RateDetailsPharmacyCardWidget(rate: rate),
                const Gap(AppSpace.s12),

                RateDetailsUserCardWidget(rate: rate),
                const Gap(AppSpace.s12),
                RateGivenWidget(rate: rate),
                const Gap(AppSpace.s12),
                RateDetailsRateTextCardWidget(rate: rate),
                const Gap(AppSpace.s12),
                const RateDetailsContextCardWidget(),

                const Gap(AppSpace.s12),
                const RateDetailsPreviousRateWidget(),
              ],
            ),
          ),
          bottomNavigationBar: const RateDetailsBottomNavigatorsWidget(),
        );
      },
    );
  }
}
