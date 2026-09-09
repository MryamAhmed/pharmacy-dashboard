// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_loading_widget.dart';
import '../../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../cubit/rate_cubit.dart';
import '../cubit/rate_state.dart';
import '../widgets/rate_list_widget.dart';

/// "Rate" bottom-nav tab — the pending-reviews approval queue.
class RateScreen extends StatelessWidget {
  const RateScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeTabPage),
      backgroundColor: AppColors.screenBackground,
      showAppBar: true,
      appBarTitle: context.l10n.ratePendingTitle,
      appBarTitleStyle: AppTextStyles.bold16,
      showBackButton: false,
      mobileBody: BlocBuilder<RateCubit, RateState>(
        builder: (context, state) {
          if (state.isLoading) return const AppLoadingWidget();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p24),
            child: RateListWidget(state: state),
          );
        },
      ),
    );
  }
}
