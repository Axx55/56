import 'package:flutter/foundation.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsRepository _repository;
  List<AppNotification> _notifications = [];
  int _unreadCount = 0;
  bool _isLoading = false;
  String? _error;

  NotificationsProvider(this._repository);

  List<AppNotification> get notifications => _notifications;
  int get unreadCount => _unreadCount;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadNotifications({String? userId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _notifications = await _repository.getNotifications(userId: userId);
      if (userId != null) {
        _unreadCount = await _repository.getUnreadCount(userId);
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    await _repository.markAsRead(id);
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = AppNotification(
        id: _notifications[index].id,
        userId: _notifications[index].userId,
        type: _notifications[index].type,
        title: _notifications[index].title,
        body: _notifications[index].body,
        isRead: true,
        relatedId: _notifications[index].relatedId,
        relatedType: _notifications[index].relatedType,
        createdAt: _notifications[index].createdAt,
      );
      _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);
      notifyListeners();
    }
  }

  Future<void> markAllAsRead(String userId) async {
    await _repository.markAllAsRead(userId);
    _unreadCount = 0;
    notifyListeners();
  }
}
