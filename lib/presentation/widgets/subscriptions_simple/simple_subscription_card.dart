import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';
import '../../../core/helpers/field_naming_helper.dart';
import '../../../domain/entities/subscription.dart';
import '../../../core/utils/time_formatter.dart';

class SimpleSubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback? onTap;

  const SimpleSubscriptionCard({
    super.key,
    required this.subscription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMd,
        vertical: AppDimensions.paddingXs,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getStatusColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
          child: Icon(Icons.subscriptions, color: _getStatusColor()),
        ),
        title: Text(
          'اشتراك ${FieldNamingHelper.getSubscriptionPeriodLabel(subscription.period.name)}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subscription.amount != null)
              Text(TimeFormatter.formatCurrency(subscription.amount!)),
            Text(
              '${subscription.startDate != null ? TimeFormatter.formatDate(subscription.startDate) : ''} - ${subscription.endDate != null ? TimeFormatter.formatDate(subscription.endDate) : ''}',
              style: const TextStyle(fontSize: 12, color: AppColors.textHint),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor().withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            FieldNamingHelper.getStatusLabel(subscription.status.name),
            style: TextStyle(
              color: _getStatusColor(),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (subscription.status) {
      case SubscriptionStatus.active:
      case SubscriptionStatus.trialActive:
        return AppColors.success;
      case SubscriptionStatus.expired:
      case SubscriptionStatus.trialExpired:
        return AppColors.overdue;
      case SubscriptionStatus.suspended:
        return AppColors.warning;
      case SubscriptionStatus.cancelled:
        return AppColors.error;
      default:
        return AppColors.textHint;
    }
  }
}
