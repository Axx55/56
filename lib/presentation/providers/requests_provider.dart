import 'package:flutter/foundation.dart';
import '../../domain/entities/add_child_request.dart';
import '../../domain/repositories/requests_repository.dart';

class RequestsProvider extends ChangeNotifier {
  final RequestsRepository _repository;
  List<AddChildRequest> _requests = [];
  bool _isLoading = false;
  String? _error;

  RequestsProvider(this._repository);

  List<AddChildRequest> get requests => _requests;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadRequests({String? parentId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _requests = await _repository.getRequests(parentId: parentId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteRequest(String id) async {
    try {
      await _repository.deleteRequest(id);
      _requests.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
