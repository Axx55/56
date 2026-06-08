import '../../domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    super.parentId,
    required super.fullName,
    required super.gender,
    super.dateOfBirth,
    super.educationLevelId,
    super.schoolId,
    super.location,
    super.latitude,
    super.longitude,
    super.avatarUrl,
    super.status,
    super.createdAt,
    super.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      parentId: json['parent_id'] as String?,
      fullName: json['full_name'] as String,
      gender: _parseGender(json['gender'] as String?),
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      educationLevelId: json['education_level_id'] as String?,
      schoolId: json['school_id'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      avatarUrl: json['avatar_url'] as String?,
      status: _parseStatus(json['status'] as String?),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'full_name': fullName,
      'gender': gender.name,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'education_level_id': educationLevelId,
      'school_id': schoolId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'avatar_url': avatarUrl,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static Gender _parseGender(String? gender) {
    switch (gender) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  static StudentStatus _parseStatus(String? status) {
    switch (status) {
      case 'active':
        return StudentStatus.active;
      case 'suspended':
        return StudentStatus.suspended;
      default:
        return StudentStatus.pending;
    }
  }
}
