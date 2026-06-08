import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy/MM/dd').format(date);
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy/MM/dd HH:mm').format(date);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  static String formatRelative(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inHours < 1) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inDays < 1) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';
    return formatDate(date);
  }

  static String formatCurrency(double amount) {
    return '${amount.toStringAsFixed(2)} ر.س';
  }
}
