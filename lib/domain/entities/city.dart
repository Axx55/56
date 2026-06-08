class City {
  final String id;
  final String name;
  final String? nameEn;
  final int? sortOrder;

  City({required this.id, required this.name, this.nameEn, this.sortOrder});
}
