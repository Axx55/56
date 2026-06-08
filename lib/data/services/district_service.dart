import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/district_model.dart';

class DistrictService {
  final SupabaseClient _client;

  DistrictService(this._client);

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
}
