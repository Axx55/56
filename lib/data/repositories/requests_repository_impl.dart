import '../../domain/entities/add_child_request.dart';
import '../../domain/repositories/requests_repository.dart';
import '../services/requests_service.dart';
import '../models/add_child_request_model.dart';

class RequestsRepositoryImpl implements RequestsRepository {
  final RequestsService _service;

  RequestsRepositoryImpl(this._service);

  @override
  Future<List<AddChildRequest>> getRequests({String? parentId}) {
    return _service.getRequests(parentId: parentId);
  }

  @override
  Future<AddChildRequest> createRequest(AddChildRequest request) {
    return _service.createRequest((request as AddChildRequestModel).toJson());
  }

  @override
  Future<void> deleteRequest(String id) => _service.deleteRequest(id);
}
