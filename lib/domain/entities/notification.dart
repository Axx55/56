enum NotificationType {
  billPaymentConfirmed,
  billPaymentRejected,
  billCreated,
  billOverdue,
  childRequestApproved,
  childRequestRejected,
  childRequestPending,
  subscriptionActivated,
  subscriptionExpired,
  subscriptionCancelled,
  systemAnnouncement,
  tripUpdate,
  general,
}

class AppNotification {
  final String id;
  final String? userId;
  final NotificationType type;
  final String title;
  final String body;
  final bool isRead;
  final String? relatedId;
  final String? relatedType;
  final DateTime? createdAt;

  AppNotification({
    required this.id,
    this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.isRead = false,
    this.relatedId,
    this.relatedType,
    this.createdAt,
  });
}
