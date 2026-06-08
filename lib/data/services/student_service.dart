import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student_model.dart';

class StudentService {
  final SupabaseClient _client;

  StudentService(this._client);

  Future<List<StudentModel>> getStudents({String? parentId}) async {
    var query = _client.from('students').select('*');
    if (parentId != null) {
      query = query.eq('parent_id', parentId);
    }
    final data = await query;
    return data.map((json) => StudentModel.fromJson(json)).toList();
  }

  Future<StudentModel?> getStudentById(String id) async {
    final data = await _client
        .from('students')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    return data != null ? StudentModel.fromJson(data) : null;
  }

  Future<StudentModel> addStudent(Map<String, dynamic> data) async {
    final result = await _client
        .from('students')
        .insert(data)
        .select()
        .single();
    return StudentModel.fromJson(result);
  }

  Future<StudentModel> updateStudent(
    String id,
    Map<String, dynamic> data,
  ) async {
    final result = await _client
        .from('students')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return StudentModel.fromJson(result);
  }

  Future<void> deleteStudent(String id) async {
    await _client.from('students').delete().eq('id', id);
  }
}
