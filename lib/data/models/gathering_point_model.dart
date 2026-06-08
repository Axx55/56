import '../../domain/entities/gathering_point.dart';

class GatheringPointModel extends GatheringPoint {
  GatheringPointModel({
    required super.id,
    required super.name,
    super.address,
    super.latitude,
    super.longitude,
    super.districtId,
  });

  factory GatheringPointModel.fromJson(Map<String, dynamic> json) {
    return GatheringPointModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      districtId: json['district_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'district_id': districtId,
    };
  }
}
