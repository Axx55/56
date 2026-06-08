import '../../domain/entities/city.dart';
import '../../domain/entities/district.dart';
import '../../domain/entities/school.dart';
import '../../domain/entities/education_level.dart';
import '../../domain/entities/gathering_point.dart';
import '../../domain/repositories/cities_repository.dart';
import '../services/lookup_service.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final LookupService _service;

  CitiesRepositoryImpl(this._service);

  @override
  Future<List<City>> getCities() => _service.getCities();

  @override
  Future<List<District>> getDistricts(String cityId) =>
      _service.getDistricts(cityId);

  @override
  Future<List<School>> getSchools(String districtId) =>
      _service.getSchools(districtId);

  @override
  Future<List<EducationLevel>> getEducationLevels() =>
      _service.getEducationLevels();

  @override
  Future<List<GatheringPoint>> getGatheringPoints(String districtId) =>
      _service.getGatheringPoints(districtId);
}
