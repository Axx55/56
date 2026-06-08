enum BillStatus { pending, paid, overdue, cancelled }

class Bill {
  final String id;
  final String? subscriptionId;
  final String? parentId;
  final double amount;
  final double? paidAmount;
  final BillStatus status;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final String? paymentMethod;
  final String? receiptUrl;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Bill({
    required this.id,
    this.subscriptionId,
    this.parentId,
    required this.amount,
    this.paidAmount,
    required this.status,
    this.dueDate,
    this.paidAt,
    this.paymentMethod,
    this.receiptUrl,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
}
