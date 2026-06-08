import '../../domain/entities/child.dart';
import '../../domain/repositories/children_repository.dart';
import '../models/child_model.dart';
import '../services/database_service.dart';

class ChildrenRepositoryImpl implements ChildrenRepository {
  final DatabaseService _db;

  ChildrenRepositoryImpl(this._db);

  @override
  Future<List<Child>> getChildren({String? parentId}) async {
    final data = await _db.query(
      'students',
      eqColumn: 'parent_id',
      eqValue: parentId,
    );
    return data.map((json) => ChildModel.fromJson(json)).toList();
  }

  @override
  Future<Child?> getChildById(String id) async {
    final data = await _db.querySingle('students', eqColumn: 'id', eqValue: id);
    return data != null ? ChildModel.fromJson(data) : null;
  }
}
