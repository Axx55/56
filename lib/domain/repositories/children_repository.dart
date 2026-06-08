import '../entities/child.dart';

abstract class ChildrenRepository {
  Future<List<Child>> getChildren({String? parentId});
  Future<Child?> getChildById(String id);
}
