// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../../core/constants/test_keys.dart';
import '../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../shared/domain/entities/app_error_x.dart';
import '../../../../../shared/presentation/widgets/app_coming_soon_view.dart';
import '../../../../../shared/presentation/widgets/app_loading_widget.dart';
import '../../../../../shared/presentation/widgets/app_scaffold.dart';
import '../cubit/home_tab_cubit.dart';
import '../cubit/home_tab_state.dart';

/// "Home" bottom-nav tab.
///
/// Loads its greeting from [HomeTabCubit] (backed by the home module's own
/// data/domain layers — currently a dummy data source). The rest of the
/// dashboard is a placeholder until the real design lands.
class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key(TestKeys.homeTabPage),
      mobileBody: BlocBuilder<HomeTabCubit, HomeTabState>(
        builder: (context, state) {
          if (state.isLoading) return const AppLoadingWidget();
          return AppComingSoonView(
            icon: Icons.home_outlined,
            title: state.greeting ?? context.l10n.homeTitle,
            subtitle: state.error?.resolveMessage(context.l10n) ??
                context.l10n.comingSoon,
          );
        },
      ),
    );
  }
}
