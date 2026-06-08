class Child {
  final String id;
  final String? parentId;
  final String fullName;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? educationLevel;
  final String? schoolName;
  final String? avatarUrl;
  final String? status;

  Child({
    required this.id,
    this.parentId,
    required this.fullName,
    this.gender,
    this.dateOfBirth,
    this.educationLevel,
    this.schoolName,
    this.avatarUrl,
    this.status,
  });
}
