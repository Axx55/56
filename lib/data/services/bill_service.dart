import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/bill_model.dart';
import '../models/bills_statistics_model.dart';

class BillService {
  final SupabaseClient _client;

  BillService(this._client);

  Future<List<BillModel>> getBills({String? parentId, String? status}) async {
    var query = _client.from('bills').select('*');
    if (parentId != null) query = query.eq('parent_id', parentId);
    if (status != null) query = query.eq('status', status);
    final data = await query;
    return data.map((json) => BillModel.fromJson(json)).toList();
  }

  Future<BillModel?> getBillById(String id) async {
    final data = await _client
        .from('bills')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    return data != null ? BillModel.fromJson(data) : null;
  }

  Future<BillsStatisticsModel> getBillsStatistics(String parentId) async {
    final bills = await getBills(parentId: parentId);
    return BillsStatisticsModel(
      totalBills: bills.length,
      paidBills: bills.where((b) => b.status.name == 'paid').length,
      unpaidBills: bills.where((b) => b.status.name == 'pending').length,
      overdueBills: bills.where((b) => b.status.name == 'overdue').length,
      underReviewBills: 0,
      totalPaidAmount: bills
          .where((b) => b.status.name == 'paid')
          .fold<double>(0, (sum, b) => sum + (b.paidAmount ?? 0)),
      totalUnpaidAmount: bills
          .where(
            (b) => b.status.name == 'pending' || b.status.name == 'overdue',
          )
          .fold<double>(0, (sum, b) => sum + b.amount),
    );
  }

  Future<BillModel> payBill(
    String billId, {
    String? paymentMethod,
    String? receiptUrl,
  }) async {
    final data = {
      'status': 'pending',
      'payment_method': paymentMethod,
      'receipt_url': receiptUrl,
      'paid_at': DateTime.now().toIso8601String(),
    };
    final result = await _client
        .from('bills')
        .update(data)
        .eq('id', billId)
        .select()
        .single();
    return BillModel.fromJson(result);
  }
}
