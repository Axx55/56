import 'package:flutter/foundation.dart';
import '../../core/services/user_type_labels_service.dart';

class UserTypeProvider extends ChangeNotifier {
  String? _userType;
  String? _userId;

  String? get userType => _userType;
  String? get userId => _userId;
  String get userTypeLabel => UserTypeLabelsService.getLabel(_userType ?? '');

  void setUserType(String type, String id) {
    _userType = type;
    _userId = id;
    notifyListeners();
  }

  bool get isParent => _userType == 'parent';
  bool get isDriver => _userType == 'driver';

  void clear() {
    _userType = null;
    _userId = null;
    notifyListeners();
  }
}
