import '../../domain/entities/transport_plan.dart';

class TransportPlanModel extends TransportPlan {
  TransportPlanModel({
    required super.id,
    super.schoolId,
    super.gatheringPointId,
    super.name,
    super.tripType,
    super.price,
    super.startTime,
    super.endTime,
    super.studyDays,
    super.isActive,
  });

  factory TransportPlanModel.fromJson(Map<String, dynamic> json) {
    return TransportPlanModel(
      id: json['id'] as String,
      schoolId: json['school_id'] as String?,
      gatheringPointId: json['gathering_point_id'] as String?,
      name: json['name'] as String?,
      tripType: _parseTripType(json['trip_type'] as String?),
      price: (json['price'] as num?)?.toDouble(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      studyDays: json['study_days'] != null
          ? List<String>.from(json['study_days'] as List)
          : null,
      isActive: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'gathering_point_id': gatheringPointId,
      'name': name,
      'trip_type': tripType?.name,
      'price': price,
      'start_time': startTime,
      'end_time': endTime,
      'study_days': studyDays,
      'is_active': isActive,
    };
  }

  static TripType? _parseTripType(String? type) {
    switch (type) {
      case 'go':
        return TripType.go;
      case 'return_both':
        return TripType.return_both;
      case 'go_and_return':
        return TripType.goAndReturn;
      default:
        return null;
    }
  }
}
