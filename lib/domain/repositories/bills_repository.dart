import '../entities/bill.dart';
import '../entities/bills_statistics.dart';

abstract class BillsRepository {
  Future<List<Bill>> getBills({String? parentId, String? status});
  Future<Bill?> getBillById(String id);
  Future<BillsStatistics> getBillsStatistics(String parentId);
  Future<Bill> payBill(
    String billId, {
    String? paymentMethod,
    String? receiptUrl,
  });
}
