class Rating {
  final String id;
  final String? userId;
  final int stars;
  final String? comment;
  final DateTime? createdAt;

  Rating({
    required this.id,
    this.userId,
    required this.stars,
    this.comment,
    this.createdAt,
  });
}
