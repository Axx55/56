import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/requests_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/empty_state_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../core/helpers/field_naming_helper.dart';
import '../../core/utils/time_formatter.dart';
import '../../domain/entities/add_child_request.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<RequestsProvider>().loadRequests(parentId: userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestsProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('الطلبات')),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(RequestsProvider provider) {
    if (provider.isLoading)
      return const LoadingWidget(message: 'جاري تحميل الطلبات...');
    if (provider.error != null)
      return AppErrorWidget(message: provider.error, onRetry: _load);
    if (provider.requests.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.assignment_outlined,
        title: 'لا توجد طلبات',
        subtitle: 'لم تقم بتقديم أي طلب إضافة أبناء بعد',
        actionLabel: 'إضافة ابن',
        onAction: () => Navigator.of(context).pushNamed('/add-child'),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: AppDimensions.paddingSm),
        itemCount: provider.requests.length,
        itemBuilder: (context, index) {
          final request = provider.requests[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingXs,
            ),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(request.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
                child: Icon(
                  _getStatusIcon(request.status),
                  color: _getStatusColor(request.status),
                ),
              ),
              title: Text(
                request.studentName ?? 'طلب إضافة',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الحالة: ${FieldNamingHelper.getStatusLabel(FieldNamingHelper.enumName(request.status))}',
                  ),
                  if (request.createdAt != null)
                    Text(
                      TimeFormatter.formatRelative(request.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'delete') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('تأكيد الحذف'),
                        content: const Text('هل أنت متأكد من حذف هذا الطلب؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('إلغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('حذف'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await context.read<RequestsProvider>().deleteRequest(
                        request.id,
                      );
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('حذف', style: TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () => _showRequestDetails(context, request),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return AppColors.success;
      case RequestStatus.rejected:
        return AppColors.error;
      case RequestStatus.pending:
        return AppColors.pending;
    }
  }

  IconData _getStatusIcon(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return Icons.check_circle;
      case RequestStatus.rejected:
        return Icons.cancel;
      case RequestStatus.pending:
        return Icons.hourglass_empty;
    }
  }

  void _showRequestDetails(BuildContext context, dynamic request) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              request.studentName ?? 'تفاصيل الطلب',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _row('الطالب', request.studentName ?? 'غير محدد'),
            _row(
              'الحالة',
              FieldNamingHelper.getStatusLabel(
                FieldNamingHelper.enumName(request.status),
              ),
            ),
            if (request.rejectionReason != null)
              _row('سبب الرفض', request.rejectionReason!),
            if (request.createdAt != null)
              _row(
                'تاريخ التقديم',
                TimeFormatter.formatDate(request.createdAt),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
