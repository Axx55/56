import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/gathering_point_model.dart';

class GatheringPointService {
  final SupabaseClient _client;

  GatheringPointService(this._client);

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
