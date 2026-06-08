class BillsStatistics {
  final int totalBills;
  final int paidBills;
  final int unpaidBills;
  final int overdueBills;
  final int underReviewBills;
  final double totalPaidAmount;
  final double totalUnpaidAmount;

  BillsStatistics({
    this.totalBills = 0,
    this.paidBills = 0,
    this.unpaidBills = 0,
    this.overdueBills = 0,
    this.underReviewBills = 0,
    this.totalPaidAmount = 0.0,
    this.totalUnpaidAmount = 0.0,
  });
}
