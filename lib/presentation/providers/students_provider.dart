import 'package:flutter/foundation.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/students_repository.dart';

class StudentsProvider extends ChangeNotifier {
  final StudentsRepository _repository;
  List<Student> _students = [];
  bool _isLoading = false;
  String? _error;

  StudentsProvider(this._repository);

  List<Student> get students => _students;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadStudents({String? parentId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _students = await _repository.getStudents(parentId: parentId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Student?> getStudentById(String id) async {
    try {
      return await _repository.getStudentById(id);
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }
}
