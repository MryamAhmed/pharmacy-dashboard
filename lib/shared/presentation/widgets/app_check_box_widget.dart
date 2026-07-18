import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/app_colors.dart';

class AppCheckBoxWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;
  final double? scale;
  const AppCheckBoxWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale ?? 0.8,
      child: Checkbox(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        activeColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
