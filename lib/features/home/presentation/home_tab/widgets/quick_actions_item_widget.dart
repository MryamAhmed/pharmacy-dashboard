import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_text_style.dart';
import '../../../../../shared/presentation/widgets/app_text.dart';

class QuickActionsItemWidget extends StatelessWidget {
  final Color itemColor;
  final String itemName;
  final String itemKey;
  const QuickActionsItemWidget({
    super.key,
    required this.itemColor,
    required this.itemKey,
    required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: itemColor,
      ),
      child: Center(
        child: AppText(
          key: Key(itemKey),
          text: itemName,
          style: AppTextStyles.bold10White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
