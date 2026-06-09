class Driver {
  final String id;
  final String fullName;
  final String? phone;
  final String? photoUrl;
  final String? vehiclePlate;
  final String? vehicleModel;
  final String? vehicleColor;

  Driver({
    required this.id,
    required this.fullName,
    this.phone,
    this.photoUrl,
    this.vehiclePlate,
    this.vehicleModel,
    this.vehicleColor,
  });
}
