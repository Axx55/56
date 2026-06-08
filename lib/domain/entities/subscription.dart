enum SubscriptionStatus {
  active,
  inactive,
  suspended,
  expired,
  cancelled,
  trialPending,
  trialActive,
  trialExpired,
}

enum SubscriptionPeriod { monthly, semester, yearly }

enum SubscriptionType { monthly, term, yearly }

class Subscription {
  final String id;
  final String? studentId;
  final String? transportPlanId;
  final SubscriptionStatus status;
  final SubscriptionPeriod period;
  final SubscriptionType type;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Subscription({
    required this.id,
    this.studentId,
    this.transportPlanId,
    required this.status,
    required this.period,
    required this.type,
    this.startDate,
    this.endDate,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });
}
