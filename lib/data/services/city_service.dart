import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city_model.dart';

class CityService {
  final SupabaseClient _client;

  CityService(this._client);

  Future<List<CityModel>> getCities() async {
    final data =
        await _client.from('cities').select('*').order('sort_order') as List;
    return data
        .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
