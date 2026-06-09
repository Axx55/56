import '../../domain/entities/trip_record.dart';

class TripRecordModel extends TripRecord {
  TripRecordModel({
    required super.id,
    super.studentId,
    super.driverName,
    super.tripDate,
    super.startTime,
    super.endTime,
    required super.status,
    super.pickupLocation,
    super.dropoffLocation,
  });

  factory TripRecordModel.fromJson(Map<String, dynamic> json) {
    return TripRecordModel(
      id: json['id'] as String,
      studentId: json['student_id'] as String?,
      driverName: json['driver_name'] as String?,
      tripDate: json['trip_date'] != null
          ? DateTime.parse(json['trip_date'] as String)
          : null,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      status: _parseStatus(json['status'] as String?),
      pickupLocation: json['pickup_location'] as String?,
      dropoffLocation: json['dropoff_location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'driver_name': driverName,
      'trip_date': tripDate?.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'status': status.name,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
    };
  }

  static TripStatus _parseStatus(String? status) {
    switch (status) {
      case 'completed':
        return TripStatus.completed;
      case 'cancelled':
        return TripStatus.cancelled;
      default:
        return TripStatus.upcoming;
    }
  }
}
