import '../entities/student.dart';

abstract class StudentsRepository {
  Future<List<Student>> getStudents({String? parentId});
  Future<Student?> getStudentById(String id);
  Future<Student> addStudent(Student student);
  Future<Student> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}
