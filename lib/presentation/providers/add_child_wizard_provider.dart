import 'package:flutter/material.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/transport_plan.dart';
import '../../domain/entities/add_child_request.dart';
import '../../domain/repositories/students_repository.dart';
import '../../domain/repositories/requests_repository.dart';
import '../../data/models/student_model.dart';
import '../../data/models/add_child_request_model.dart';

class WizardStep {
  final int step;
  final String title;

  const WizardStep({required this.step, required this.title});
}

class AddChildWizardProvider extends ChangeNotifier {
  final StudentsRepository _studentsRepo;
  final RequestsRepository _requestsRepo;

  int _currentStep = 0;
  bool _isLoading = false;
  String? _error;

  // Step 1: Child Info
  String? _childImagePath;
  Gender _gender = Gender.male;
  final _fullNameController = TextEditingController();
  String? _educationLevelId;

  // Step 2: School Info
  String? _cityId;
  String? _districtId;
  String? _schoolId;
  String? _gatheringPointId;
  String? _startTime;
  String? _endTime;
  List<String> _selectedDays = [];

  // Step 3: Plan Selection
  TripType _tripType = TripType.goAndReturn;
  String? _subscriptionPeriod;

  static const List<WizardStep> steps = [
    WizardStep(step: 0, title: 'معلومات الطفل'),
    WizardStep(step: 1, title: 'معلومات المدرسة'),
    WizardStep(step: 2, title: 'اختيار الخطة'),
  ];

  AddChildWizardProvider({
    required StudentsRepository studentsRepo,
    required RequestsRepository requestsRepo,
  }) : _studentsRepo = studentsRepo,
       _requestsRepo = requestsRepo;

  // Getters
  int get currentStep => _currentStep;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == steps.length - 1;
  double get progress => (_currentStep + 1) / steps.length;

  String? get childImagePath => _childImagePath;
  Gender get gender => _gender;
  TextEditingController get fullNameController => _fullNameController;
  String? get educationLevelId => _educationLevelId;

  String? get cityId => _cityId;
  String? get districtId => _districtId;
  String? get schoolId => _schoolId;
  String? get gatheringPointId => _gatheringPointId;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  List<String> get selectedDays => _selectedDays;

  TripType get tripType => _tripType;
  String? get subscriptionPeriod => _subscriptionPeriod;

  // Step 1 setters
  void setChildImage(String path) {
    _childImagePath = path;
    notifyListeners();
  }

  void setGender(Gender gender) {
    _gender = gender;
    notifyListeners();
  }

  void setEducationLevel(String id) {
    _educationLevelId = id;
    notifyListeners();
  }

  // Step 2 setters
  void setCity(String id) {
    _cityId = id;
    _districtId = null;
    _schoolId = null;
    _gatheringPointId = null;
    notifyListeners();
  }

  void setDistrict(String id) {
    _districtId = id;
    _schoolId = null;
    _gatheringPointId = null;
    notifyListeners();
  }

  void setSchool(String id) {
    _schoolId = id;
    notifyListeners();
  }

  void setGatheringPoint(String id) {
    _gatheringPointId = id;
    notifyListeners();
  }

  void setStartTime(String time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(String time) {
    _endTime = time;
    notifyListeners();
  }

  void toggleDay(String day) {
    if (_selectedDays.contains(day)) {
      _selectedDays.remove(day);
    } else {
      _selectedDays.add(day);
    }
    notifyListeners();
  }

  // Step 3 setters
  void setTripType(TripType type) {
    _tripType = type;
    notifyListeners();
  }

  void setSubscriptionPeriod(String period) {
    _subscriptionPeriod = period;
    notifyListeners();
  }

  // Navigation
  void nextStep() {
    if (_currentStep < steps.length - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  bool validateStep(int step) {
    switch (step) {
      case 0:
        return _fullNameController.text.trim().isNotEmpty &&
            _educationLevelId != null;
      case 1:
        return _cityId != null &&
            _districtId != null &&
            _schoolId != null &&
            _startTime != null &&
            _endTime != null &&
            _selectedDays.isNotEmpty;
      case 2:
        return _subscriptionPeriod != null;
      default:
        return false;
    }
  }

  Future<bool> submit({required String parentId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final student = StudentModel(
        id: '',
        parentId: parentId,
        fullName: _fullNameController.text.trim(),
        gender: _gender,
        educationLevelId: _educationLevelId,
        schoolId: _schoolId,
        location: '',
        status: StudentStatus.pending,
      );

      final addedStudent = await _studentsRepo.addStudent(student);

      await _requestsRepo.createRequest(
        AddChildRequestModel(
          id: '',
          parentId: parentId,
          studentId: addedStudent.id,
          studentName: addedStudent.fullName,
          status: RequestStatus.pending,
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _currentStep = 0;
    _childImagePath = null;
    _gender = Gender.male;
    _fullNameController.clear();
    _educationLevelId = null;
    _cityId = null;
    _districtId = null;
    _schoolId = null;
    _gatheringPointId = null;
    _startTime = null;
    _endTime = null;
    _selectedDays = [];
    _tripType = TripType.goAndReturn;
    _subscriptionPeriod = null;
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }
}
