enum TripType { go, return_both, goAndReturn }

class TransportPlan {
  final String id;
  final String? schoolId;
  final String? gatheringPointId;
  final String? name;
  final TripType? tripType;
  final double? price;
  final String? startTime;
  final String? endTime;
  final List<String>? studyDays;
  final bool? isActive;

  TransportPlan({
    required this.id,
    this.schoolId,
    this.gatheringPointId,
    this.name,
    this.tripType,
    this.price,
    this.startTime,
    this.endTime,
    this.studyDays,
    this.isActive,
  });
}
