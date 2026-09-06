import '../../domain/entities/pharmacy_entity.dart';

class PharmasyDataModel {
  String? id;
  String? website;
  String? pharmacyName;
  String? pharmacyPhoneNumber;
  String? logo;
  String? taxCard;

  PharmasyDataModel({
    this.id,
    this.website,
    this.pharmacyName,
    this.pharmacyPhoneNumber,
    this.logo,
    this.taxCard,
  });

  PharmasyDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    website = json['website'];
    pharmacyName = json['pharmacyName'];
    pharmacyPhoneNumber = json['pharmacyPhoneNumber'];
    logo = json['logo'];
    taxCard = json['taxCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['website'] = this.website;
    data['pharmacyName'] = this.pharmacyName;
    data['pharmacyPhoneNumber'] = this.pharmacyPhoneNumber;
    data['logo'] = this.logo;
    data['taxCard'] = this.taxCard;
    return data;
  }

  //to domain
  PharmacyEntity toDomain() {
    return PharmacyEntity(
      id: id,
      pharmacyName: pharmacyName,
      pharmacyPhoneNumber: pharmacyPhoneNumber,
      logo: logo,
      taxCard: taxCard,
    );
  }
}
