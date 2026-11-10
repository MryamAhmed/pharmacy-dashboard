import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../core/constants/app_values.dart';
import '../../../../../../core/constants/test_keys.dart';
import '../../../../../../core/extensions/build_context_localizations.dart';
import '../../../../../../core/themes/app_text_style.dart';
import '../../../../../../shared/presentation/widgets/app_text.dart';
import '../../../../domain/entities/pharmacy_entity.dart';
import 'information_widget.dart';
import 'pharmacy_document_widget.dart';

/// Body shown under the "Pharmacy" tab: the tapped [pharmacy]'s own details
/// plus its uploaded documents.
///
/// Values come from `GET Dashboard/pharmacies`. Empty values and rows the
/// API doesn't send yet (license) show `pharmacyDetailsEmptyValue` ("-").
class PharmacyInformationSectionWidget extends StatelessWidget {
  const PharmacyInformationSectionWidget({super.key, required this.pharmacy});

  final PharmacyEntity pharmacy;

  @override
  Widget build(BuildContext context) {
    final empty = context.l10n.pharmacyDetailsEmptyValue;
    // Treat null and "" the same so the row shows "-" instead of blank.
    String orEmpty(String? value) =>
        (value == null || value.isEmpty) ? empty : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const Key(TestKeys.pharmacyDetailsPharmacySection),
      children: [
        InformationWidget(
          title: context.l10n.pharmacyDetailsPhone,
          value: orEmpty(pharmacy.pharmacyPhoneNumber),
        ),
        // License fields are not in the pharmacies response yet.
        InformationWidget(
          title: context.l10n.pharmacyDetailsLicenseExpiry,
          value: empty,
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsLicenseNo,
          value: empty,
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsIndustry,
          value: orEmpty(pharmacy.industry),
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsOwnerName,
          value: orEmpty(pharmacy.ownerName),
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsWebsite,
          value: orEmpty(pharmacy.website),
        ),
        AppText(
          key: const ValueKey(TestKeys.pharmacyDetailsPhoneNumberValue),
          text: context.l10n.pharmacyDetailsDocumentsUploaded,
          style: AppTextStyles.bold14,
          textAlign: TextAlign.start,
        ),
        const Gap(AppSpace.s12),
        // Only show the tax card row when the API actually sent one.
        if (pharmacy.taxCard?.isNotEmpty ?? false)
          PharmacyDocumentWidget(
            name: context.l10n.pharmacyDetailsTaxCard,
            // TODO: open pharmacy.taxCard in a viewer.
            onViewPressed: () {},
          ),
      ],
    );
  }
}
