import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/enums/pharmacy_details_tab.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../cubit/pharmacy_datails_cubit.dart';

class InformationTabWidget extends StatelessWidget {
  const InformationTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.textLightGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Gap(AppSpace.s4),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<PharmacyDetailsCubit>().changeTab(
                  PharmacyDetailsTab.pharmacy,
                );
              },
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.textLightGray,
                ),
                child: Center(
                  child: AppText(
                    key: const ValueKey('${TestKeys.pharmacyDetailsTab}'),
                    text: "Pharmacy",
                    style: AppTextStyles.bold12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpace.s4),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.textWhite,
                ),
                child: Center(
                  child: AppText(
                    key: const ValueKey('${TestKeys.pharmacyDetailsOwnerTab}'),
                    text: "Owner",
                    style: AppTextStyles.bold12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpace.s4),
        ],
      ),
    );
  }
}
