import '../../domain/entities/notification.dart';

class NotificationModel extends AppNotification {
  NotificationModel({
    required super.id,
    super.userId,
    required super.type,
    required super.title,
    required super.body,
    super.isRead,
    super.relatedId,
    super.relatedType,
    super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      type: _parseType(json['type'] as String?),
      title: json['title'] as String,
      body: json['body'] as String,
      isRead: json['is_read'] as bool? ?? false,
      relatedId: json['related_id'] as String?,
      relatedType: json['related_type'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.name,
      'title': title,
      'body': body,
      'is_read': isRead,
      'related_id': relatedId,
      'related_type': relatedType,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  static NotificationType _parseType(String? type) {
    switch (type) {
      case 'bill_payment_confirmed':
        return NotificationType.billPaymentConfirmed;
      case 'bill_payment_rejected':
        return NotificationType.billPaymentRejected;
      case 'bill_created':
        return NotificationType.billCreated;
      case 'bill_overdue':
        return NotificationType.billOverdue;
      case 'child_request_approved':
        return NotificationType.childRequestApproved;
      case 'child_request_rejected':
        return NotificationType.childRequestRejected;
      case 'child_request_pending':
        return NotificationType.childRequestPending;
      case 'subscription_activated':
        return NotificationType.subscriptionActivated;
      case 'subscription_expired':
        return NotificationType.subscriptionExpired;
      case 'subscription_cancelled':
        return NotificationType.subscriptionCancelled;
      case 'system_announcement':
        return NotificationType.systemAnnouncement;
      case 'trip_update':
        return NotificationType.tripUpdate;
      default:
        return NotificationType.general;
    }
  }
}
