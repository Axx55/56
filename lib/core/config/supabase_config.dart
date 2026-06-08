import 'app_config.dart';

class SupabaseConfig {
  static const String url = AppConfig.supabaseUrl;
  static const String anonKey = AppConfig.supabaseAnonKey;

  // Table names
  static const String tableStudents = 'students';
  static const String tableParents = 'parents';
  static const String tableSubscriptions = 'subscriptions';
  static const String tableBills = 'bills';
  static const String tableRequests = 'add_child_requests';
  static const String tableNotifications = 'notifications';
  static const String tableSchools = 'schools';
  static const String tableCities = 'cities';
  static const String tableDistricts = 'districts';
  static const String tableEducationLevels = 'education_levels';
  static const String tableGatheringPoints = 'gathering_points';
  static const String tableTransportPlans = 'transport_plans';
  static const String tableStudyDays = 'study_days';
  static const String tableBatchBills = 'batch_bills';
  static const String tableBanks = 'banks';
  static const String tableComplaints = 'complaints';
  static const String tableTripRecords = 'trip_records';
  static const String tableRatings = 'ratings';
}
