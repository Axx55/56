import '../entities/add_child_request.dart';

abstract class RequestsRepository {
  Future<List<AddChildRequest>> getRequests({String? parentId});
  Future<AddChildRequest> createRequest(AddChildRequest request);
  Future<void> deleteRequest(String id);
}
