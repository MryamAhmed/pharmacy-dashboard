import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import 'information_widget.dart';
import 'pharmacy_document_widget.dart';

/// Body shown under the "Pharmacy" tab: the pharmacy's own details plus its
/// uploaded documents.
///
/// Values are static placeholders until the pharmacy details API is wired;
/// they will then come from the cubit state.
class PharmacyInformationSectionWidget extends StatelessWidget {
  const PharmacyInformationSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const Key(TestKeys.pharmacyDetailsPharmacySection),
      children: [
        InformationWidget(
          title: context.l10n.pharmacyDetailsPhone,
          value: '0111',
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsLicenseExpiry,
          value: '',
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsLicenseNo,
          value: '',
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsIndustry,
          value: '',
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsOwnerName,
          value: '',
        ),

        InformationWidget(
          title: context.l10n.pharmacyDetailsWebsite,
          value: '',
        ),
        AppText(
          key: const ValueKey('${TestKeys.pharmacyDetailsPhoneNumberValue}'),
          text: context.l10n.pharmacyDetailsDocumentsUploaded,
          style: AppTextStyles.bold14,
          textAlign: TextAlign.start,
        ),
        const Gap(AppSpace.s12),

        PharmacyDocumentWidget(
          name: context.l10n.pharmacyDetailsTaxCard,
          // TODO: open the document once the details API is wired.
          onViewPressed: () {},
        ),
        const Gap(AppSpace.s8),
        PharmacyDocumentWidget(
          name: context.l10n.pharmacyDetailsTaxCard,
          // TODO: open the document once the details API is wired.
          onViewPressed: () {},
        ),
      ],
    );
  }
}
