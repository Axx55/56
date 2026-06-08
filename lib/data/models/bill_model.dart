import '../../domain/entities/bill.dart';

class BillModel extends Bill {
  BillModel({
    required super.id,
    super.subscriptionId,
    super.parentId,
    required super.amount,
    super.paidAmount,
    required super.status,
    super.dueDate,
    super.paidAt,
    super.paymentMethod,
    super.receiptUrl,
    super.notes,
    super.createdAt,
    super.updatedAt,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      id: json['id'] as String,
      subscriptionId: json['subscription_id'] as String?,
      parentId: json['parent_id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      status: _parseStatus(json['status'] as String?),
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      paidAt: json['paid_at'] != null
          ? DateTime.parse(json['paid_at'] as String)
          : null,
      paymentMethod: json['payment_method'] as String?,
      receiptUrl: json['receipt_url'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subscription_id': subscriptionId,
      'parent_id': parentId,
      'amount': amount,
      'paid_amount': paidAmount,
      'status': status.name,
      'due_date': dueDate?.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'payment_method': paymentMethod,
      'receipt_url': receiptUrl,
      'notes': notes,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static BillStatus _parseStatus(String? status) {
    switch (status) {
      case 'paid':
        return BillStatus.paid;
      case 'overdue':
        return BillStatus.overdue;
      case 'cancelled':
        return BillStatus.cancelled;
      default:
        return BillStatus.pending;
    }
  }
}
