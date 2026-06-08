import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/school_model.dart';

class SchoolService {
  final SupabaseClient _client;

  SchoolService(this._client);

  Future<List<SchoolModel>> getSchools({String? districtId}) async {
    var query = _client.from('schools').select('*');
    if (districtId != null) query = query.eq('district_id', districtId);
    final data = await query;
    return data.map((json) => SchoolModel.fromJson(json)).toList();
  }

  Future<SchoolModel?> getSchoolById(String id) async {
    final data = await _client
        .from('schools')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    return data != null ? SchoolModel.fromJson(data) : null;
  }
}
