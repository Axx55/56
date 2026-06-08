import '../../domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    required super.id,
    super.userId,
    required super.subject,
    required super.description,
    super.status,
    super.createdAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      subject: json['subject'] as String,
      description: json['description'] as String,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'subject': subject,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
