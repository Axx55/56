import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/empty_state_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../core/utils/time_formatter.dart';
import '../../domain/entities/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<NotificationsProvider>().loadNotifications(
        userId: userId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          if (provider.unreadCount > 0)
            TextButton(
              onPressed: () async {
                final userId = context.read<AuthProvider>().user?.id;
                if (userId != null) {
                  await context.read<NotificationsProvider>().markAllAsRead(
                    userId,
                  );
                }
              },
              child: const Text(
                'تحديد الكل كمقروء',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(NotificationsProvider provider) {
    if (provider.isLoading)
      return const LoadingWidget(message: 'جاري تحميل الإشعارات...');
    if (provider.error != null)
      return AppErrorWidget(message: provider.error, onRetry: _load);
    if (provider.notifications.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.notifications_none,
        title: 'لا توجد إشعارات',
        subtitle: 'سوف تظهر الإشعارات هنا عند ورودها',
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: AppDimensions.paddingSm),
        itemCount: provider.notifications.length,
        itemBuilder: (context, index) {
          final notification = provider.notifications[index];
          return _buildNotificationCard(context, notification, provider);
        },
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    AppNotification notification,
    NotificationsProvider provider,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMd,
        vertical: AppDimensions.paddingXs,
      ),
      color: notification.isRead
          ? Colors.white
          : AppColors.primary.withValues(alpha: 0.05),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(
            notification.type,
          ).withValues(alpha: 0.1),
          child: Icon(
            _getTypeIcon(notification.type),
            color: _getTypeColor(notification.type),
            size: 20,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead
                ? FontWeight.normal
                : FontWeight.bold,
            fontSize: AppDimensions.fontSm,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.body,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              TimeFormatter.formatRelative(notification.createdAt),
              style: const TextStyle(fontSize: 10, color: AppColors.textHint),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          context.read<NotificationsProvider>().markAsRead(notification.id);
          _handleNotificationNavigation(context, notification);
        },
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.billPaymentConfirmed:
      case NotificationType.billPaymentRejected:
      case NotificationType.billCreated:
      case NotificationType.billOverdue:
        return AppColors.warning;
      case NotificationType.childRequestApproved:
      case NotificationType.childRequestRejected:
      case NotificationType.childRequestPending:
        return AppColors.primary;
      case NotificationType.subscriptionActivated:
      case NotificationType.subscriptionExpired:
      case NotificationType.subscriptionCancelled:
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.billPaymentConfirmed:
      case NotificationType.billPaymentRejected:
      case NotificationType.billCreated:
      case NotificationType.billOverdue:
        return Icons.receipt;
      case NotificationType.childRequestApproved:
      case NotificationType.childRequestRejected:
      case NotificationType.childRequestPending:
        return Icons.person;
      case NotificationType.subscriptionActivated:
      case NotificationType.subscriptionExpired:
      case NotificationType.subscriptionCancelled:
        return Icons.subscriptions;
      case NotificationType.tripUpdate:
        return Icons.directions_bus;
      default:
        return Icons.notifications;
    }
  }

  void _handleNotificationNavigation(
    BuildContext context,
    AppNotification notification,
  ) {
    if (notification.relatedType == 'bill') {
      Navigator.of(context).pushNamed('/bills');
    } else if (notification.relatedType == 'request') {
      Navigator.of(context).pushNamed('/requests');
    } else if (notification.relatedType == 'child') {
      Navigator.of(context).pushNamed('/children');
    }
  }
}
