import '../entities/parent.dart';

abstract class ParentRepository {
  Future<Parent?> getParentByUserId(String userId);
  Future<Parent> createParent(Parent parent);
  Future<Parent> updateParent(Parent parent);
}
