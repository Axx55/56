import '../../domain/entities/bills_statistics.dart';

class BillsStatisticsModel extends BillsStatistics {
  BillsStatisticsModel({
    super.totalBills,
    super.paidBills,
    super.unpaidBills,
    super.overdueBills,
    super.underReviewBills,
    super.totalPaidAmount,
    super.totalUnpaidAmount,
  });
}
