import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bills_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../core/helpers/field_naming_helper.dart';
import '../../core/utils/time_formatter.dart';

class BillsMainPage extends StatefulWidget {
  const BillsMainPage({super.key});

  @override
  State<BillsMainPage> createState() => _BillsMainPageState();
}

class _BillsMainPageState extends State<BillsMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<BillsProvider>().loadBills(parentId: userId);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BillsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفواتير'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'غير مدفوعة (${provider.unpaidBills.length})'),
            Tab(text: 'قيد المراجعة (${provider.underReviewBills.length})'),
            Tab(text: 'مدفوعة (${provider.paidBills.length})'),
          ],
        ),
      ),
      body: provider.isLoading
          ? const LoadingWidget()
          : provider.error != null
          ? AppErrorWidget(message: provider.error, onRetry: _load)
          : TabBarView(
              controller: _tabController,
              children: [
                _buildBillList(provider.unpaidBills, _BillType.unpaid),
                _buildBillList(
                  provider.underReviewBills,
                  _BillType.underReview,
                ),
                _buildBillList(provider.paidBills, _BillType.paid),
              ],
            ),
    );
  }

  Widget _buildBillList(List bills, _BillType type) {
    if (bills.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              type == _BillType.unpaid
                  ? 'لا توجد فواتير غير مدفوعة'
                  : type == _BillType.underReview
                  ? 'لا توجد فواتير قيد المراجعة'
                  : 'لا توجد فواتير مدفوعة',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: AppDimensions.paddingSm),
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingXs,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TimeFormatter.formatCurrency(bill.amount),
                        style: const TextStyle(
                          fontSize: AppDimensions.fontLg,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            bill.status.name,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          FieldNamingHelper.getStatusLabel(bill.status.name),
                          style: TextStyle(
                            color: _getStatusColor(bill.status.name),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingSm),
                  if (bill.dueDate != null)
                    Text(
                      'تاريخ الاستحقاق: ${TimeFormatter.formatDate(bill.dueDate)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  if (bill.paidAt != null)
                    Text(
                      'تاريخ الدفع: ${TimeFormatter.formatDate(bill.paidAt)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  if (type == _BillType.unpaid) ...[
                    const SizedBox(height: AppDimensions.paddingSm),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showPaymentSheet(context, bill),
                        child: const Text('دفع'),
                      ),
                    ),
                  ],
                  if (type == _BillType.underReview)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 16,
                              color: AppColors.warning,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'الدفع قيد المراجعة من قبل الإدارة',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return AppColors.success;
      case 'overdue':
        return AppColors.overdue;
      case 'pending':
        return AppColors.pending;
      default:
        return AppColors.textHint;
    }
  }

  void _showPaymentSheet(BuildContext context, dynamic bill) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'تفاصيل الدفع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المبلغ'),
                Text(
                  TimeFormatter.formatCurrency(bill.amount),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: AppDimensions.buttonHeight,
              child: ElevatedButton(
                onPressed: () => context.read<BillsProvider>().payBill(bill.id),
                child: const Text('تأكيد الدفع'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _BillType { unpaid, underReview, paid }
