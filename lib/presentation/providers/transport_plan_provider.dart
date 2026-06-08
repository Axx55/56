import 'package:flutter/foundation.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/district.dart';
import '../../domain/entities/school.dart';
import '../../domain/entities/education_level.dart';
import '../../domain/entities/gathering_point.dart';
import '../../domain/entities/transport_plan.dart';
import '../../domain/repositories/cities_repository.dart';

class TransportPlanProvider extends ChangeNotifier {
  final CitiesRepository _repository;
  List<City> _cities = [];
  List<District> _districts = [];
  List<School> _schools = [];
  List<EducationLevel> _educationLevels = [];
  List<GatheringPoint> _gatheringPoints = [];
  List<TransportPlan> _plans = [];
  bool _isLoading = false;
  String? _error;

  City? _selectedCity;
  District? _selectedDistrict;
  School? _selectedSchool;
  EducationLevel? _selectedLevel;

  TransportPlanProvider(this._repository);

  List<City> get cities => _cities;
  List<District> get districts => _districts;
  List<School> get schools => _schools;
  List<EducationLevel> get educationLevels => _educationLevels;
  List<GatheringPoint> get gatheringPoints => _gatheringPoints;
  List<TransportPlan> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  City? get selectedCity => _selectedCity;
  District? get selectedDistrict => _selectedDistrict;
  School? get selectedSchool => _selectedSchool;
  EducationLevel? get selectedLevel => _selectedLevel;

  Future<void> loadCities() async {
    _isLoading = true;
    notifyListeners();
    try {
      _cities = await _repository.getCities();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadDistricts(String cityId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _districts = await _repository.getDistricts(cityId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadSchools(String districtId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _schools = await _repository.getSchools(districtId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadEducationLevels() async {
    try {
      _educationLevels = await _repository.getEducationLevels();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadGatheringPoints(String districtId) async {
    try {
      _gatheringPoints = await _repository.getGatheringPoints(districtId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void selectCity(City city) {
    _selectedCity = city;
    _selectedDistrict = null;
    _selectedSchool = null;
    _districts = [];
    _schools = [];
    notifyListeners();
  }

  void selectDistrict(District district) {
    _selectedDistrict = district;
    _selectedSchool = null;
    _schools = [];
    notifyListeners();
  }

  void selectSchool(School school) {
    _selectedSchool = school;
    notifyListeners();
  }

  void selectLevel(EducationLevel level) {
    _selectedLevel = level;
    notifyListeners();
  }

  void clear() {
    _selectedCity = null;
    _selectedDistrict = null;
    _selectedSchool = null;
    _selectedLevel = null;
    _cities = [];
    _districts = [];
    _schools = [];
    _educationLevels = [];
    _gatheringPoints = [];
    _plans = [];
    notifyListeners();
  }
}
