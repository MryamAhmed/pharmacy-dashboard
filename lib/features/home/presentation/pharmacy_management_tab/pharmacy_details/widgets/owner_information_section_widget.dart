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

/// Body shown under the "Owner" tab: the [pharmacy] owner's details from
/// `GET Dashboard/pharmacies` (`pharmacyOwnerName`,
/// `pharmacyOwnerPhoneNumber`, `ownerNationalId`). Email is not in the API
/// yet. Empty values show `pharmacyDetailsEmptyValue` ("-").
class OwnerInformationSectionWidget extends StatelessWidget {
  const OwnerInformationSectionWidget({super.key, required this.pharmacy});

  final PharmacyEntity pharmacy;

  @override
  Widget build(BuildContext context) {
    final empty = context.l10n.pharmacyDetailsEmptyValue;
    // Treat null and "" the same so the row shows "-" instead of blank.
    String orEmpty(String? value) =>
        (value == null || value.isEmpty) ? empty : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const Key(TestKeys.pharmacyDetailsOwnerSection),
      children: [
        InformationWidget(
          title: context.l10n.pharmacyDetailsOwnerName,
          value: orEmpty(pharmacy.ownerName),
        ),
        InformationWidget(
          title: context.l10n.pharmacyDetailsPhone,
          value: orEmpty(pharmacy.ownerPhoneNumber),
        ),
        // Not in the pharmacies response yet.
        InformationWidget(title: context.l10n.pharmacyDetailsEmail, value: empty),
        InformationWidget(
          title: context.l10n.pharmacyDetailsNationalId,
          value: orEmpty(pharmacy.ownerNationalId),
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
