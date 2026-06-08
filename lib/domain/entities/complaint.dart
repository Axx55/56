class Complaint {
  final String id;
  final String? userId;
  final String subject;
  final String description;
  final String? status;
  final DateTime? createdAt;

  Complaint({
    required this.id,
    this.userId,
    required this.subject,
    required this.description,
    this.status,
    this.createdAt,
  });
}
