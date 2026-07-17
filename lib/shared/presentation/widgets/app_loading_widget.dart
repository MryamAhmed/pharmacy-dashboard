// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../core/themes/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primaryColor,
      ),
    );
  }
}
