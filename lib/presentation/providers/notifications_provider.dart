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
      final updated = <AppNotification>[];
      for (final n in _notifications) {
        if (n.id == id) {
          updated.add(
            AppNotification(
              id: n.id,
              userId: n.userId,
              type: n.type,
              title: n.title,
              body: n.body,
              isRead: true,
              relatedId: n.relatedId,
              relatedType: n.relatedType,
              createdAt: n.createdAt,
            ),
          );
        } else {
          updated.add(n);
        }
      }
      _notifications = updated;
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
