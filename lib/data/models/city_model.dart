import '../../domain/entities/city.dart';

class CityModel extends City {
  CityModel({
    required super.id,
    required super.name,
    super.nameEn,
    super.sortOrder,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['name_en'] as String?,
      sortOrder: json['sort_order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'name_en': nameEn, 'sort_order': sortOrder};
  }
}
