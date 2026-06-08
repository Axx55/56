import '../../domain/entities/school.dart';

class SchoolModel extends School {
  SchoolModel({
    required super.id,
    required super.name,
    super.nameEn,
    super.districtId,
    super.cityId,
    super.type,
    super.status,
    super.latitude,
    super.longitude,
    super.address,
    super.phone,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      districtId: json['district_id'] as String?,
      cityId: json['city_id'] as String?,
      type: _parseType(json['type'] as String?),
      status: _parseStatus(json['status'] as String?),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'district_id': districtId,
      'city_id': cityId,
      'type': type?.name,
      'status': status.name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'phone': phone,
    };
  }

  static SchoolType? _parseType(String? type) {
    switch (type) {
      case 'government':
        return SchoolType.government;
      case 'private':
        return SchoolType.private;
      case 'international':
        return SchoolType.international;
      default:
        return null;
    }
  }

  static SchoolStatus _parseStatus(String? status) {
    switch (status) {
      case 'inactive':
        return SchoolStatus.inactive;
      case 'under_maintenance':
        return SchoolStatus.underMaintenance;
      default:
        return SchoolStatus.active;
    }
  }
}
