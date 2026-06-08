import 'package:flutter/foundation.dart';
import '../../domain/entities/bill.dart';
import '../../domain/entities/bills_statistics.dart';
import '../../domain/repositories/bills_repository.dart';

class BillsProvider extends ChangeNotifier {
  final BillsRepository _repository;
  List<Bill> _bills = [];
  bool _isLoading = false;
  String? _error;
  BillsStatistics? _statistics;

  BillsProvider(this._repository);

  List<Bill> get bills => _bills;
  bool get isLoading => _isLoading;
  String? get error => _error;
  BillsStatistics? get statistics => _statistics;

  Future<void> loadBills({String? parentId, String? status}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _bills = await _repository.getBills(parentId: parentId, status: status);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadStatistics(String parentId) async {
    try {
      _statistics = await _repository.getBillsStatistics(parentId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  List<Bill> get billsByStatus {
    return _bills;
  }

  List<Bill> get unpaidBills =>
      _bills.where((b) => b.status.name == 'pending').toList();

  List<Bill> get underReviewBills => _bills
      .where((b) => b.status.name == 'pending' && b.paidAt != null)
      .toList();

  List<Bill> get paidBills =>
      _bills.where((b) => b.status.name == 'paid').toList();

  Future<void> payBill(
    String billId, {
    String? paymentMethod,
    String? receiptUrl,
  }) async {
    try {
      await _repository.payBill(
        billId,
        paymentMethod: paymentMethod,
        receiptUrl: receiptUrl,
      );
      await loadBills();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
