class BatchBill {
  final String id;
  final String? batchName;
  final String? status;
  final int? totalBills;
  final double? totalAmount;
  final DateTime? createdAt;

  BatchBill({
    required this.id,
    this.batchName,
    this.status,
    this.totalBills,
    this.totalAmount,
    this.createdAt,
  });
}
