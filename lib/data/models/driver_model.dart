import '../../domain/entities/driver.dart';

class DriverModel extends Driver {
  DriverModel({
    required super.id,
    required super.fullName,
    super.phone,
    super.photoUrl,
    super.vehiclePlate,
    super.vehicleModel,
    super.vehicleColor,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String?,
      photoUrl: json['photo_url'] as String?,
      vehiclePlate: json['vehicle_plate'] as String?,
      vehicleModel: json['vehicle_model'] as String?,
      vehicleColor: json['vehicle_color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'photo_url': photoUrl,
      'vehicle_plate': vehiclePlate,
      'vehicle_model': vehicleModel,
      'vehicle_color': vehicleColor,
    };
  }
}
