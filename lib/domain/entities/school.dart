enum SchoolStatus { active, inactive, underMaintenance }

enum SchoolType { government, private, international }

class School {
  final String id;
  final String name;
  final String? nameEn;
  final String? districtId;
  final String? cityId;
  final SchoolType? type;
  final SchoolStatus status;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? phone;

  School({
    required this.id,
    required this.name,
    this.nameEn,
    this.districtId,
    this.cityId,
    this.type,
    this.status = SchoolStatus.active,
    this.latitude,
    this.longitude,
    this.address,
    this.phone,
  });
}
