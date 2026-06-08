import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  static DatabaseService? _instance;
  final SupabaseClient _client;

  DatabaseService._internal(this._client);

  static DatabaseService get instance {
    _instance ??= DatabaseService._internal(Supabase.instance.client);
    return _instance!;
  }

  SupabaseClient get client => _client;

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? select,
    String? eqColumn,
    dynamic eqValue,
    String? orderColumn,
    bool ascending = true,
    int? limit,
  }) async {
    dynamic query = _client.from(table).select(select ?? '*');
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

  Future<Map<String, dynamic>?> querySingle(
    String table, {
    String? select,
    required String eqColumn,
    required dynamic eqValue,
  }) async {
    final result = await _client
        .from(table)
        .select(select ?? '*')
        .eq(eqColumn, eqValue)
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

  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    final result = await _client.rpc(query);
    return (result as List?)?.cast<Map<String, dynamic>>() ?? [];
  }
}
