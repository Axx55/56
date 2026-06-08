import '../../domain/entities/education_level.dart';

class EducationLevelModel extends EducationLevel {
  EducationLevelModel({
    required super.id,
    required super.name,
    super.nameEn,
    super.sortOrder,
  });

  factory EducationLevelModel.fromJson(Map<String, dynamic> json) {
    return EducationLevelModel(
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
