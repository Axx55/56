import 'package:supabase_flutter/supabase_flutter.dart';

class DirectQueryService {
  final SupabaseClient _client;

  DirectQueryService(this._client);

  Future<List<Map<String, dynamic>>> select(
    String table, {
    String? column,
    String? eqColumn,
    dynamic eqValue,
    String? orderColumn,
    bool ascending = true,
    int? limit,
  }) async {
    dynamic query = _client.from(table).select(column ?? '*');
    if (eqColumn != null && eqValue != null) {
      query = query.eq(eqColumn, eqValue);
    }
    if (orderColumn != null) {
      query = query.order(orderColumn, ascending: ascending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    return (await query).map((e) => e as Map<String, dynamic>).toList();
  }

  Future<Map<String, dynamic>?> selectSingle(
    String table,
    String column,
    dynamic value,
  ) async {
    final result = await _client
        .from(table)
        .select('*')
        .eq(column, value)
        .maybeSingle();
    return result;
  }

  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final result = await _client.from(table).insert(data).select().single();
    return result;
  }

  Future<void> update(
    String table,
    Map<String, dynamic> data,
    String eqColumn,
    dynamic eqValue,
  ) async {
    await _client.from(table).update(data).eq(eqColumn, eqValue);
  }

  Future<void> delete(String table, String eqColumn, dynamic eqValue) async {
    await _client.from(table).delete().eq(eqColumn, eqValue);
  }
}
