class FieldNamingHelper {
  static String enumName(Enum value) {
    final s = value.toString();
    return s.substring(s.indexOf('.') + 1);
  }

  static String getGenderLabel(String? gender) {
    switch (gender) {
      case 'male':
        return 'ذكر';
      case 'female':
        return 'أنثى';
      default:
        return 'غير محدد';
    }
  }

  static String getStatusLabel(String? status) {
    switch (status) {
      case 'active':
        return 'نشط';
      case 'inactive':
        return 'غير نشط';
      case 'pending':
        return 'قيد الانتظار';
      case 'approved':
        return 'مقبول';
      case 'rejected':
        return 'مرفوض';
      case 'paid':
        return 'مدفوع';
      case 'overdue':
        return 'متأخر';
      case 'cancelled':
        return 'ملغي';
      case 'suspended':
        return 'موقوف';
      case 'expired':
        return 'منتهي';
      default:
        return status ?? 'غير معروف';
    }
  }

  static String getSubscriptionPeriodLabel(String? period) {
    switch (period) {
      case 'monthly':
        return 'شهري';
      case 'semester':
        return 'فصلي';
      case 'yearly':
        return 'سنوي';
      default:
        return period ?? '';
    }
  }

  static String getTripTypeLabel(String? type) {
    switch (type) {
      case 'go':
        return 'ذهاب فقط';
      case 'return_both':
        return 'عودة فقط';
      case 'go_and_return':
        return 'ذهاب وعودة';
      default:
        return type ?? '';
    }
  }
}
