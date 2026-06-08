import '../../domain/entities/student.dart';
import '../../domain/repositories/students_repository.dart';
import '../services/student_service.dart';
import '../models/student_model.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentService _service;

  StudentsRepositoryImpl(this._service);

  @override
  Future<List<Student>> getStudents({String? parentId}) =>
      _service.getStudents(parentId: parentId);

  @override
  Future<Student?> getStudentById(String id) => _service.getStudentById(id);

  @override
  Future<Student> addStudent(Student student) {
    return _service.addStudent((student as StudentModel).toJson());
  }

  @override
  Future<Student> updateStudent(Student student) {
    return _service.updateStudent(
      student.id,
      (student as StudentModel).toJson(),
    );
  }

  @override
  Future<void> deleteStudent(String id) => _service.deleteStudent(id);
}
