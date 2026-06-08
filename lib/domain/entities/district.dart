class District {
  final String id;
  final String name;
  final String? nameEn;
  final String? cityId;
  final int? sortOrder;

  District({
    required this.id,
    required this.name,
    this.nameEn,
    this.cityId,
    this.sortOrder,
  });
}
