import '../../domain/entities/add_child_request.dart';

class AddChildRequestModel extends AddChildRequest {
  AddChildRequestModel({
    required super.id,
    super.parentId,
    super.studentId,
    super.studentName,
    required super.status,
    super.rejectionReason,
    super.createdAt,
    super.updatedAt,
  });

  factory AddChildRequestModel.fromJson(Map<String, dynamic> json) {
    return AddChildRequestModel(
      id: json['id'] as String,
      parentId: json['parent_id'] as String?,
      studentId: json['student_id'] as String?,
      studentName: json['student_name'] as String?,
      status: _parseStatus(json['status'] as String?),
      rejectionReason: json['rejection_reason'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'student_id': studentId,
      'student_name': studentName,
      'status': status.name,
      'rejection_reason': rejectionReason,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static RequestStatus _parseStatus(String? status) {
    switch (status) {
      case 'approved':
        return RequestStatus.approved;
      case 'rejected':
        return RequestStatus.rejected;
      default:
        return RequestStatus.pending;
    }
  }
}
