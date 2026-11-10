import '../../../../core/constants/api_param_constatnts.dart';
import '../../domain/entities/pharmacy_entity.dart';

/// One item of `GET Dashboard/pharmacies` → `data[]`.
///
/// Keys mirror the real response exactly (see [ApiParamConstants]). Note the
/// status key is `verificationStatus`, not `status`.
class PharmasyDataModel {
  String? id;
  String? website;
  String? pharmacyName;
  String? pharmacyPhoneNumber;
  String? logo;
  String? taxCard;
  String? verificationStatus;
  String? pharmacyAddress;
  String? pharmacyIndustry;
  String? pharmacyOwnerName;
  String? pharmacyOwnerPhoneNumber;
  String? ownerUniversity;
  String? ownerFaculty;
  String? ownerSpecification;
  String? ownerDateOfBirth;
  String? ownerGender;
  String? ownerNationalId;

  PharmasyDataModel({
    this.id,
    this.website,
    this.pharmacyName,
    this.pharmacyPhoneNumber,
    this.logo,
    this.taxCard,
    this.verificationStatus,
    this.pharmacyAddress,
    this.pharmacyIndustry,
    this.pharmacyOwnerName,
    this.pharmacyOwnerPhoneNumber,
    this.ownerUniversity,
    this.ownerFaculty,
    this.ownerSpecification,
    this.ownerDateOfBirth,
    this.ownerGender,
    this.ownerNationalId,
  });

  PharmasyDataModel.fromJson(Map<String, dynamic> json) {
    // `?.toString()` instead of `as String?`: every value so far is null in
    // the sample for some of these (phone, national id, birth date), so the
    // real type is unknown — a number would otherwise throw and drop the
    // whole list (same failure as the reviews `rate: 4.0` bug).
    id = json[ApiParamConstants.id]?.toString();
    website = json[ApiParamConstants.website]?.toString();
    pharmacyName = json[ApiParamConstants.pharmacyName]?.toString();
    pharmacyPhoneNumber = json[ApiParamConstants.pharmacyPhoneNumber]
        ?.toString();
    logo = json[ApiParamConstants.logo]?.toString();
    taxCard = json[ApiParamConstants.taxCard]?.toString();
    verificationStatus = json[ApiParamConstants.verificationStatus]
        ?.toString();
    pharmacyAddress = json[ApiParamConstants.pharmacyAddress]?.toString();
    pharmacyIndustry = json[ApiParamConstants.pharmacyIndustry]?.toString();
    pharmacyOwnerName = json[ApiParamConstants.pharmacyOwnerName]?.toString();
    pharmacyOwnerPhoneNumber = json[ApiParamConstants.pharmacyOwnerPhoneNumber]
        ?.toString();
    ownerUniversity = json[ApiParamConstants.ownerUniversity]?.toString();
    ownerFaculty = json[ApiParamConstants.ownerFaculty]?.toString();
    ownerSpecification = json[ApiParamConstants.ownerSpecification]
        ?.toString();
    ownerDateOfBirth = json[ApiParamConstants.ownerDateOfBirth]?.toString();
    ownerGender = json[ApiParamConstants.ownerGender]?.toString();
    ownerNationalId = json[ApiParamConstants.ownerNationalId]?.toString();
  }

  Map<String, dynamic> toJson() => {
    ApiParamConstants.id: id,
    ApiParamConstants.website: website,
    ApiParamConstants.pharmacyName: pharmacyName,
    ApiParamConstants.pharmacyPhoneNumber: pharmacyPhoneNumber,
    ApiParamConstants.logo: logo,
    ApiParamConstants.taxCard: taxCard,
    ApiParamConstants.verificationStatus: verificationStatus,
    ApiParamConstants.pharmacyAddress: pharmacyAddress,
    ApiParamConstants.pharmacyIndustry: pharmacyIndustry,
    ApiParamConstants.pharmacyOwnerName: pharmacyOwnerName,
    ApiParamConstants.pharmacyOwnerPhoneNumber: pharmacyOwnerPhoneNumber,
    ApiParamConstants.ownerUniversity: ownerUniversity,
    ApiParamConstants.ownerFaculty: ownerFaculty,
    ApiParamConstants.ownerSpecification: ownerSpecification,
    ApiParamConstants.ownerDateOfBirth: ownerDateOfBirth,
    ApiParamConstants.ownerGender: ownerGender,
    ApiParamConstants.ownerNationalId: ownerNationalId,
  };

  /// Maps to the domain entity. `verificationStatus` becomes the entity's
  /// `status` (the name the filters and `isVerified` already use).
  PharmacyEntity toDomain() {
    return PharmacyEntity(
      id: id,
      pharmacyName: pharmacyName,
      pharmacyPhoneNumber: pharmacyPhoneNumber,
      website: website,
      logo: logo,
      taxCard: taxCard,
      status: verificationStatus,
      address: pharmacyAddress,
      industry: pharmacyIndustry,
      ownerName: pharmacyOwnerName,
      ownerPhoneNumber: pharmacyOwnerPhoneNumber,
      ownerUniversity: ownerUniversity,
      ownerFaculty: ownerFaculty,
      ownerSpecification: ownerSpecification,
      ownerDateOfBirth: ownerDateOfBirth,
      ownerGender: ownerGender,
      ownerNationalId: ownerNationalId,
    );
  }
}
