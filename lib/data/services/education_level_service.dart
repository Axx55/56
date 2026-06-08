import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/education_level_model.dart';

class EducationLevelService {
  final SupabaseClient _client;

  EducationLevelService(this._client);

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
}
