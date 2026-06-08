enum StudentStatus { pending, active, suspended }

enum Gender { male, female }

class Student {
  final String id;
  final String? parentId;
  final String fullName;
  final Gender gender;
  final DateTime? dateOfBirth;
  final String? educationLevelId;
  final String? schoolId;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? avatarUrl;
  final StudentStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Student({
    required this.id,
    this.parentId,
    required this.fullName,
    required this.gender,
    this.dateOfBirth,
    this.educationLevelId,
    this.schoolId,
    this.location,
    this.latitude,
    this.longitude,
    this.avatarUrl,
    this.status = StudentStatus.pending,
    this.createdAt,
    this.updatedAt,
  });
}
