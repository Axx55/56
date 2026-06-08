import '../entities/city.dart';
import '../entities/district.dart';
import '../entities/school.dart';
import '../entities/education_level.dart';
import '../entities/gathering_point.dart';

abstract class CitiesRepository {
  Future<List<City>> getCities();
  Future<List<District>> getDistricts(String cityId);
  Future<List<School>> getSchools(String districtId);
  Future<List<EducationLevel>> getEducationLevels();
  Future<List<GatheringPoint>> getGatheringPoints(String districtId);
}
