class UserTypeLabelsService {
  static const Map<String, String> labels = {
    'parent': 'ولي أمر',
    'driver': 'سائق',
    'admin': 'مدير',
    'supervisor': 'مشرف',
  };

  static String getLabel(String type) {
    return labels[type] ?? type;
  }
}
