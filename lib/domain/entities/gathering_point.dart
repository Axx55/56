class GatheringPoint {
  final String id;
  final String name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? districtId;

  GatheringPoint({
    required this.id,
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.districtId,
  });
}
