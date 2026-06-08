import '../../domain/entities/district.dart';

class DistrictModel extends District {
  DistrictModel({
    required super.id,
    required super.name,
    super.nameEn,
    super.cityId,
    super.sortOrder,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      cityId: json['city_id'] as String?,
      sortOrder: json['sort_order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'city_id': cityId,
      'sort_order': sortOrder,
    };
  }
}
