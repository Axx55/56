import '../../../data/models/bank_model.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/models/trip_record_model.dart';
import '../../../data/models/parent_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/models/bill_model.dart';
import '../../../data/models/subscription_model.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/models/school_model.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/district_model.dart';
import '../../../data/models/add_child_request_model.dart';
import '../../../domain/entities/student.dart';
import '../../../domain/entities/school.dart';
import '../../../domain/entities/subscription.dart';
import '../../../domain/entities/bill.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/entities/trip_record.dart';

class MockDataStore {
  static final List<DriverModel> drivers = [
    DriverModel(
      id: 'driver-1',
      fullName: 'خالد العتيبي',
      phone: '0551234567',
      photoUrl: null,
      vehiclePlate: 'ABC 1234',
      vehicleModel: 'تويوتا هايس 2024',
      vehicleColor: 'أبيض',
    ),
  ];

  static final List<TripRecordModel> trips = [
    TripRecordModel(
      id: 'trip-1',
      studentId: 'mock-student-1',
      driverName: 'خالد العتيبي',
      tripDate: DateTime.now(),
      startTime: '06:30',
      endTime: '07:00',
      status: TripStatus.upcoming,
      pickupLocation: 'حي النزهة، جدة',
      dropoffLocation: 'مدرسة النزهة الأهلية',
    ),
  ];

  static final List<BankModel> banks = [
    BankModel(
      id: 'bank-1',
      name: 'البنك الأهلي السعودي',
      accountNumber: '1234567890',
      accountName: 'مؤسسة مسارات للنقل المدرسي',
      iban: 'SA1234567890123456789012',
    ),
    BankModel(
      id: 'bank-2',
      name: 'بنك الراجحي',
      accountNumber: '9876543210',
      accountName: 'مؤسسة مسارات للنقل المدرسي',
      iban: 'SA9876543210987654321098',
    ),
    BankModel(
      id: 'bank-3',
      name: 'البنك الأول',
      accountNumber: '5555555555',
      accountName: 'مؤسسة مسارات للنقل المدرسي',
      iban: 'SA5555555555555555555555',
    ),
  ];

  static final List<ParentModel> parents = [
    ParentModel(
      id: 'mock-parent-1',
      userId: 'mock-user-1',
      fullName: 'أحمد محمد',
      email: 'ahmed@example.com',
      phone: '0501234567',
      avatarUrl: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<StudentModel> students = [
    StudentModel(
      id: 'mock-student-1',
      parentId: 'mock-parent-1',
      fullName: 'سارة أحمد',
      gender: Gender.male,
      dateOfBirth: DateTime(2012, 5, 15),
      educationLevelId: 'level-1',
      schoolId: 'school-1',
      location: 'حي النزهة، جدة',
      latitude: 21.4858,
      longitude: 39.1925,
      avatarUrl: null,
      status: StudentStatus.active,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    StudentModel(
      id: 'mock-student-2',
      parentId: 'mock-parent-1',
      fullName: 'عمر أحمد',
      gender: Gender.female,
      dateOfBirth: DateTime(2014, 8, 20),
      educationLevelId: 'level-2',
      schoolId: 'school-1',
      location: 'حي النزهة، جدة',
      latitude: 21.4858,
      longitude: 39.1925,
      avatarUrl: null,
      status: StudentStatus.active,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<SchoolModel> schools = [
    SchoolModel(
      id: 'school-1',
      name: 'مدرسة النزهة الأهلية',
      nameEn: 'Al Nuzha National School',
      districtId: 'district-1',
      cityId: 'city-1',
      type: SchoolType.private,
      status: SchoolStatus.active,
      latitude: 21.4858,
      longitude: 39.1925,
      address: 'حي النزهة، جدة',
      phone: '0123456789',
    ),
  ];

  static final List<CityModel> cities = [
    CityModel(id: 'city-1', name: 'جدة', nameEn: 'Jeddah', sortOrder: 1),
    CityModel(id: 'city-2', name: 'مكة', nameEn: 'Makkah', sortOrder: 2),
    CityModel(id: 'city-3', name: 'الرياض', nameEn: 'Riyadh', sortOrder: 3),
  ];

  static final List<DistrictModel> districts = [
    DistrictModel(
      id: 'district-1',
      name: 'النزهة',
      nameEn: 'Al Nuzha',
      cityId: 'city-1',
      sortOrder: 1,
    ),
    DistrictModel(
      id: 'district-2',
      name: 'الشاطئ',
      nameEn: 'Al Shate',
      cityId: 'city-1',
      sortOrder: 2,
    ),
  ];

  static final List<SubscriptionModel> subscriptions = [
    SubscriptionModel(
      id: 'mock-sub-1',
      studentId: 'mock-student-1',
      transportPlanId: null,
      status: SubscriptionStatus.trialActive,
      period: SubscriptionPeriod.monthly,
      type: SubscriptionType.monthly,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      amount: 350.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    SubscriptionModel(
      id: 'mock-sub-2',
      studentId: 'mock-student-2',
      transportPlanId: null,
      status: SubscriptionStatus.active,
      period: SubscriptionPeriod.monthly,
      type: SubscriptionType.monthly,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      amount: 350.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<BillModel> bills = [
    BillModel(
      id: 'mock-bill-1',
      subscriptionId: 'mock-sub-1',
      parentId: 'mock-parent-1',
      amount: 350.0,
      paidAmount: 350.0,
      status: BillStatus.paid,
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      paidAt: DateTime.now().subtract(const Duration(days: 6)),
      paymentMethod: 'card',
      receiptUrl: null,
      notes: null,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    BillModel(
      id: 'mock-bill-2',
      subscriptionId: 'mock-sub-2',
      parentId: 'mock-parent-1',
      amount: 350.0,
      paidAmount: null,
      status: BillStatus.pending,
      dueDate: DateTime.now().add(const Duration(days: 10)),
      paidAt: null,
      paymentMethod: null,
      receiptUrl: null,
      notes: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'mock-notif-1',
      userId: 'mock-parent-1',
      type: NotificationType.billPaymentConfirmed,
      title: 'تم تأكيد الدفع',
      body: 'تم تأكيد دفع فاتورة الاشتراك الشهري بقيمة 350 ريال',
      isRead: false,
      relatedId: 'mock-bill-1',
      relatedType: 'bill',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: 'mock-notif-2',
      userId: 'mock-parent-1',
      type: NotificationType.subscriptionActivated,
      title: 'تم تفعيل الاشتراك',
      body: 'تم تفعيل اشتراك الطالب عمر أحمد في خطة النقل المدرسية',
      isRead: true,
      relatedId: 'mock-sub-2',
      relatedType: 'subscription',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      id: 'mock-notif-3',
      userId: 'mock-parent-1',
      type: NotificationType.tripUpdate,
      title: 'تحديث الرحلة',
      body: 'موعد الرحلة الصباحية غداً الساعة 6:30 صباحاً',
      isRead: false,
      relatedId: null,
      relatedType: 'trip',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  static final List<AddChildRequestModel> requests = <AddChildRequestModel>[];
}
