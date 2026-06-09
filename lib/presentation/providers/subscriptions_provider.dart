import 'package:flutter/foundation.dart';
import '../../domain/entities/subscription.dart';
import '../../data/services/subscriptions_service.dart';
import '../../core/helpers/field_naming_helper.dart';

class SubscriptionsProvider extends ChangeNotifier {
  final SubscriptionsService _service;
  List<Subscription> _subscriptions = [];
  bool _isLoading = false;
  String? _error;
  Map<String, int> _stats = {};

  SubscriptionsProvider(this._service);

  List<Subscription> get subscriptions => _subscriptions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, int> get stats => _stats;

  Future<void> loadSubscriptions({String? parentId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _subscriptions = await _service.getSubscriptions(parentId: parentId);
      if (parentId != null) {
        _stats = await _service.getSubscriptionStats(parentId);
      }
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  List<Subscription> getFilteredSubscriptions(String? statusFilter) {
    if (statusFilter == null || statusFilter == 'all') return _subscriptions;
    return _subscriptions
        .where((s) => FieldNamingHelper.enumName(s.status) == statusFilter)
        .toList();
  }
}
