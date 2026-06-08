import '../../domain/entities/child.dart';

class ChildModel extends Child {
  ChildModel({
    required super.id,
    super.parentId,
    required super.fullName,
    super.gender,
    super.dateOfBirth,
    super.educationLevel,
    super.schoolName,
    super.avatarUrl,
    super.status,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'] as String,
      parentId: json['parent_id'] as String?,
      fullName: json['full_name'] as String,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      educationLevel: json['education_level'] as String?,
      schoolName: json['school_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'full_name': fullName,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'education_level': educationLevel,
      'school_name': schoolName,
      'avatar_url': avatarUrl,
      'status': status,
    };
  }
}
