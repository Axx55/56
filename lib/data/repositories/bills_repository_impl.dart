import '../../domain/entities/bill.dart';
import '../../domain/entities/bills_statistics.dart';
import '../../domain/repositories/bills_repository.dart';
import '../services/bill_service.dart';

class BillsRepositoryImpl implements BillsRepository {
  final BillService _service;

  BillsRepositoryImpl(this._service);

  @override
  Future<List<Bill>> getBills({String? parentId, String? status}) {
    return _service.getBills(parentId: parentId, status: status);
  }

  @override
  Future<Bill?> getBillById(String id) => _service.getBillById(id);

  @override
  Future<BillsStatistics> getBillsStatistics(String parentId) {
    return _service.getBillsStatistics(parentId);
  }

  @override
  Future<Bill> payBill(
    String billId, {
    String? paymentMethod,
    String? receiptUrl,
  }) {
    return _service.payBill(
      billId,
      paymentMethod: paymentMethod,
      receiptUrl: receiptUrl,
    );
  }
}
