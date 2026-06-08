import '../../domain/entities/subscription.dart';

class SubscriptionModel extends Subscription {
  SubscriptionModel({
    required super.id,
    super.studentId,
    super.transportPlanId,
    required super.status,
    required super.period,
    required super.type,
    super.startDate,
    super.endDate,
    super.amount,
    super.createdAt,
    super.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      studentId: json['student_id'] as String?,
      transportPlanId: json['transport_plan_id'] as String?,
      status: _parseStatus(json['status'] as String?),
      period: _parsePeriod(json['period'] as String?),
      type: _parseType(json['type'] as String?),
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      amount: (json['amount'] as num?)?.toDouble(),
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
      'student_id': studentId,
      'transport_plan_id': transportPlanId,
      'status': status.name,
      'period': period.name,
      'type': type.name,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'amount': amount,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static SubscriptionStatus _parseStatus(String? status) {
    switch (status) {
      case 'active':
        return SubscriptionStatus.active;
      case 'inactive':
        return SubscriptionStatus.inactive;
      case 'suspended':
        return SubscriptionStatus.suspended;
      case 'expired':
        return SubscriptionStatus.expired;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      case 'trial_pending':
        return SubscriptionStatus.trialPending;
      case 'trial_active':
        return SubscriptionStatus.trialActive;
      case 'trial_expired':
        return SubscriptionStatus.trialExpired;
      default:
        return SubscriptionStatus.inactive;
    }
  }

  static SubscriptionPeriod _parsePeriod(String? period) {
    switch (period) {
      case 'monthly':
        return SubscriptionPeriod.monthly;
      case 'semester':
        return SubscriptionPeriod.semester;
      case 'yearly':
        return SubscriptionPeriod.yearly;
      default:
        return SubscriptionPeriod.monthly;
    }
  }

  static SubscriptionType _parseType(String? type) {
    switch (type) {
      case 'monthly':
        return SubscriptionType.monthly;
      case 'term':
        return SubscriptionType.term;
      case 'yearly':
        return SubscriptionType.yearly;
      default:
        return SubscriptionType.monthly;
    }
  }
}
