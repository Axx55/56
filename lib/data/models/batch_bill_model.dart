import '../../domain/entities/batch_bill.dart';

class BatchBillModel extends BatchBill {
  BatchBillModel({
    required super.id,
    super.batchName,
    super.status,
    super.totalBills,
    super.totalAmount,
    super.createdAt,
  });

  factory BatchBillModel.fromJson(Map<String, dynamic> json) {
    return BatchBillModel(
      id: json['id'] as String,
      batchName: json['batch_name'] as String?,
      status: json['status'] as String?,
      totalBills: json['total_bills'] as int?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batch_name': batchName,
      'status': status,
      'total_bills': totalBills,
      'total_amount': totalAmount,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
