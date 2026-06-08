enum RequestStatus { pending, approved, rejected }

class AddChildRequest {
  final String id;
  final String? parentId;
  final String? studentId;
  final String? studentName;
  final RequestStatus status;
  final String? rejectionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddChildRequest({
    required this.id,
    this.parentId,
    this.studentId,
    this.studentName,
    required this.status,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
  });
}
