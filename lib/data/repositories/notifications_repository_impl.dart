import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../services/notification_service.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationService _service;

  NotificationsRepositoryImpl(this._service);

  @override
  Future<List<AppNotification>> getNotifications({String? userId}) {
    return _service.getNotifications(userId: userId);
  }

  @override
  Future<int> getUnreadCount(String userId) => _service.getUnreadCount(userId);

  @override
  Future<void> markAsRead(String notificationId) =>
      _service.markAsRead(notificationId);

  @override
  Future<void> markAllAsRead(String userId) => _service.markAllAsRead(userId);
}
