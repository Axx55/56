import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/subscription.dart';
import '../providers/subscriptions_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/empty_state_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../widgets/subscriptions_simple/simple_stats_overview.dart';
import '../widgets/subscriptions_simple/simple_filter_chips.dart';
import '../widgets/subscriptions_simple/simple_subscription_list.dart';
import '../../core/themes/app_dimensions.dart';

class SubscriptionsSimplePage extends StatefulWidget {
  const SubscriptionsSimplePage({super.key});

  @override
  State<SubscriptionsSimplePage> createState() =>
      _SubscriptionsSimplePageState();
}

class _SubscriptionsSimplePageState extends State<SubscriptionsSimplePage> {
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<SubscriptionsProvider>().loadSubscriptions(
        parentId: userId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionsProvider>();
    final filteredSubscriptions = provider.getFilteredSubscriptions(
      _statusFilter,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('الاشتراكات')),
      body: _buildBody(provider, filteredSubscriptions),
    );
  }

  Widget _buildBody(SubscriptionsProvider provider, List filtered) {
    if (provider.isLoading)
      return const LoadingWidget(message: 'جاري تحميل الاشتراكات...');
    if (provider.error != null)
      return AppErrorWidget(message: provider.error, onRetry: _load);
    if (provider.subscriptions.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.subscriptions_outlined,
        title: 'لا توجد اشتراكات',
        subtitle: 'لم تقم بالاشتراك في أي خدمة نقل بعد',
        actionLabel: 'إضافة اشتراك',
        onAction: () => Navigator.of(context).pushNamed('/add-child'),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: Column(
        children: [
          SimpleStatsOverview(stats: provider.stats),
          const SizedBox(height: AppDimensions.paddingSm),
          SimpleFilterChips(
            selectedFilter: _statusFilter,
            onChanged: (filter) => setState(() => _statusFilter = filter),
          ),
          const SizedBox(height: AppDimensions.paddingSm),
          Expanded(
            child: SimpleSubscriptionList(
              subscriptions: List<Subscription>.from(filtered),
              onTap: (subscription) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تفاصيل الاشتراك')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
