import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city_model.dart';
import '../models/district_model.dart';
import '../models/school_model.dart';
import '../models/education_level_model.dart';
import '../models/gathering_point_model.dart';

class LookupService {
  final SupabaseClient _client;

  LookupService(this._client);

  Future<List<CityModel>> getCities() async {
    final data =
        await _client.from('cities').select('*').order('sort_order') as List;
    return data
        .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<DistrictModel>> getDistricts(String cityId) async {
    final data =
        await _client
                .from('districts')
                .select('*')
                .eq('city_id', cityId)
                .order('sort_order')
            as List;
    return data
        .map((json) => DistrictModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<SchoolModel>> getSchools(String districtId) async {
    final data =
        await _client
                .from('schools')
                .select('*')
                .eq('district_id', districtId)
                .eq('status', 'active')
            as List;
    return data
        .map((json) => SchoolModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<EducationLevelModel>> getEducationLevels() async {
    final data =
        await _client.from('education_levels').select('*').order('sort_order')
            as List;
    return data
        .map(
          (json) => EducationLevelModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<GatheringPointModel>> getGatheringPoints(
    String districtId,
  ) async {
    final data =
        await _client
                .from('gathering_points')
                .select('*')
                .eq('district_id', districtId)
            as List;
    return data
        .map(
          (json) => GatheringPointModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
