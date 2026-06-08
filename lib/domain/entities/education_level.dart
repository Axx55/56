class EducationLevel {
  final String id;
  final String name;
  final String? nameEn;
  final int? sortOrder;

  EducationLevel({
    required this.id,
    required this.name,
    this.nameEn,
    this.sortOrder,
  });
}
