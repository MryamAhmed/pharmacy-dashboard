import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';

class TextAvatarWidget extends StatelessWidget {
  final double? size;
  final Color? backgroundColor;
  final String title;
  final TextStyle? style;
  const TextAvatarWidget({
    super.key,
    this.backgroundColor,
    this.size,
    this.style,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.spMin ?? 40.spMin,
      width: size?.spMin ?? 40.spMin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.textAvatarBackgroundColor,
      ),
      child: Center(
        child: AppText(
          key: const Key(TestKeys.textAvatarLabel),
          text: title,
          style: style ?? AppTextStyles.bold14PrimaryColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
