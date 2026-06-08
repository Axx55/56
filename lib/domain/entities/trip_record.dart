enum TripStatus { upcoming, completed, cancelled }

class TripRecord {
  final String id;
  final String? studentId;
  final String? driverName;
  final DateTime? tripDate;
  final String? startTime;
  final String? endTime;
  final TripStatus status;
  final String? pickupLocation;
  final String? dropoffLocation;

  TripRecord({
    required this.id,
    this.studentId,
    this.driverName,
    this.tripDate,
    this.startTime,
    this.endTime,
    required this.status,
    this.pickupLocation,
    this.dropoffLocation,
  });
}
