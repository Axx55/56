class Parent {
  final String id;
  final String userId;
  final String fullName;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Parent({
    required this.id,
    required this.userId,
    required this.fullName,
    this.email,
    this.phone,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
  });
}
