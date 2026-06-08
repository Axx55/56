import '../../domain/entities/parent.dart';
import '../../domain/repositories/parent_repository.dart';
import '../models/parent_model.dart';
import '../services/database_service.dart';

class ParentRepositoryImpl implements ParentRepository {
  final DatabaseService _db;

  ParentRepositoryImpl(this._db);

  @override
  Future<Parent?> getParentByUserId(String userId) async {
    final data = await _db.querySingle(
      'parents',
      eqColumn: 'user_id',
      eqValue: userId,
    );
    return data != null ? ParentModel.fromJson(data) : null;
  }

  @override
  Future<Parent> createParent(Parent parent) async {
    final data = await _db.insert('parents', (parent as ParentModel).toJson());
    return ParentModel.fromJson(data);
  }

  @override
  Future<Parent> updateParent(Parent parent) async {
    await _db.update(
      'parents',
      (parent as ParentModel).toJson(),
      'id',
      parent.id,
    );
    return parent;
  }
}
