import '../../domain/entities/study_day.dart';

class StudyDayModel extends StudyDay {
  StudyDayModel({
    required super.id,
    required super.dayName,
    super.dayNameEn,
    super.dayNumber,
  });

  factory StudyDayModel.fromJson(Map<String, dynamic> json) {
    return StudyDayModel(
      id: json['id'] as String,
      dayName: json['day_name'] as String,
      dayNameEn: json['day_name_en'] as String?,
      dayNumber: json['day_number'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day_name': dayName,
      'day_name_en': dayNameEn,
      'day_number': dayNumber,
    };
  }
}
