import '../../../../core/enums/pharmacy_status.dart';

/// A single pharmacy from `GET Dashboard/pharmacies`. The details screen
/// shows this same object (passed via the route's `extra`), so it holds
/// everything that screen displays.
class PharmacyEntity {
  PharmacyEntity({
    this.id,
    this.pharmacyName,
    this.pharmacyPhoneNumber,
    this.website,
    this.logo,
    this.taxCard,
    this.status,
    this.address,
    this.industry,
    this.ownerName,
    this.ownerPhoneNumber,
    this.ownerUniversity,
    this.ownerFaculty,
    this.ownerSpecification,
    this.ownerDateOfBirth,
    this.ownerGender,
    this.ownerNationalId,
  });
  String? id;
  String? pharmacyName;
  String? pharmacyPhoneNumber;
  String? website;
  String? logo;
  String? taxCard;

  /// API `verificationStatus`, e.g. "Pending".
  String? status;
  String? address;
  String? industry;
  String? ownerName;
  String? ownerPhoneNumber;
  String? ownerUniversity;
  String? ownerFaculty;
  String? ownerSpecification;
  String? ownerDateOfBirth;
  String? ownerGender;
  String? ownerNationalId;

  /// True when [status] is "verified" (case-insensitive — the API sends
  /// "Pending", so presumably "Verified").
  bool get isVerified =>
      status?.toLowerCase() == PharmacyStatus.verified.name;

  /// Readable output in logs (BlocObserver printed `Instance of
  /// 'PharmacyEntity'`). Images are reduced to their length — they can be
  /// huge base64 strings.
  @override
  String toString() =>
      'PharmacyEntity(id: $id, name: $pharmacyName, status: $status, '
      'phone: $pharmacyPhoneNumber, owner: $ownerName, '
      'logo: ${logo?.length ?? 0} chars, taxCard: ${taxCard?.length ?? 0} chars)';
}
