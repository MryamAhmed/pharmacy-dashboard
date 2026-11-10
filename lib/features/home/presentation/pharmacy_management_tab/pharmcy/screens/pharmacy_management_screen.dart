// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/app_error_localization.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_loading_widget.dart';
import '../../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/pharmacy_cubit.dart';
import '../cubit/pharmacy_states.dart';
import '../widgets/pharmacy_management_list_widget.dart';

/// "Pharmacy Management" bottom-nav tab.
///
/// Dummy placeholder — replace with the real pharmacy-management dashboard
/// (inventory, orders, branches, etc.) once that feature is designed.
class PharmacyManagementScreen extends StatelessWidget {
  const PharmacyManagementScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeTabPage),
      backgroundColor: AppColors.screenBackground,
      showAppBar: true,
      appBarTitle: context.l10n.pharmacyManagementTitle,
      appBarTitleStyle: AppTextStyles.bold16,
      showBackButton: false,
      mobileBody: BlocConsumer<PharmacyCubit, PharmacyState>(
        // A failed Verify tap shows a SnackBar; the list stays visible.
        listenWhen: (previous, current) =>
            previous.actionError != current.actionError &&
            current.actionError != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppText(
                text: state.actionError!.localized(context),
                style: AppTextStyles.medium14White,
              ),
            ),
          );
        },
        builder: (context, state) {
          if (state.isLoading) return const AppLoadingWidget();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p24),
            child: PharmacyManagementListWidget(state: state),
          );
        },
      ),
    );
  }
}
