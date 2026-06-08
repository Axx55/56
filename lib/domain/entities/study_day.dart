class StudyDay {
  final String id;
  final String dayName;
  final String? dayNameEn;
  final int? dayNumber;

  StudyDay({
    required this.id,
    required this.dayName,
    this.dayNameEn,
    this.dayNumber,
  });
}
