import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../data/models/bill_model.dart';
import '../../../../data/models/student_model.dart';
import '../../../../data/models/subscription_model.dart';
import '../../../../data/models/add_child_request_model.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../domain/entities/student.dart';
import '../../../../domain/entities/bill.dart';
import '../../../../domain/entities/bills_statistics.dart';
import '../../../../domain/entities/notification.dart';
import '../../../../domain/entities/add_child_request.dart';
import '../../../../domain/entities/parent.dart';
import '../../../../domain/entities/city.dart';
import '../../../../domain/entities/district.dart';
import '../../../../domain/entities/school.dart';
import '../../../../domain/entities/education_level.dart';
import '../../../../domain/entities/gathering_point.dart';
import '../../../../domain/repositories/students_repository.dart';
import '../../../../domain/repositories/notifications_repository.dart';
import '../../../../domain/repositories/bills_repository.dart';
import '../../../../domain/repositories/parent_repository.dart';
import '../../../../domain/repositories/requests_repository.dart';
import '../../../../domain/repositories/cities_repository.dart';
import '../../../../data/services/subscriptions_service.dart';
import 'mock_data_store.dart';

class MockStudentsRepository implements StudentsRepository {
  @override
  Future<List<Student>> getStudents({String? parentId}) async {
    if (parentId == null) return MockDataStore.students;
    return MockDataStore.students.where((s) => s.parentId == parentId).toList();
  }

  @override
  Future<Student?> getStudentById(String id) async {
    try {
      return MockDataStore.students.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Student> addStudent(Student student) async {
    final newStudent = StudentModel(
      id: 'mock-student-${DateTime.now().millisecondsSinceEpoch}',
      parentId: student.parentId,
      fullName: student.fullName,
      gender: student.gender,
      dateOfBirth: student.dateOfBirth,
      educationLevelId: student.educationLevelId,
      schoolId: student.schoolId,
      location: student.location,
      latitude: student.latitude,
      longitude: student.longitude,
      avatarUrl: student.avatarUrl,
      status: student.status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    MockDataStore.students.add(newStudent);
    return newStudent;
  }

  @override
  Future<Student> updateStudent(Student student) => Future.value(student);

  @override
  Future<void> deleteStudent(String id) async {
    MockDataStore.students.removeWhere((s) => s.id == id);
  }
}

class MockBillsRepository implements BillsRepository {
  @override
  Future<List<Bill>> getBills({String? parentId, String? status}) async {
    var bills = MockDataStore.bills;
    if (parentId != null) {
      bills = bills.where((b) => b.parentId == parentId).toList();
    }
    return bills;
  }

  @override
  Future<Bill?> getBillById(String id) async {
    try {
      return MockDataStore.bills.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<BillsStatistics> getBillsStatistics(String parentId) async {
    final bills = MockDataStore.bills.where((b) => b.parentId == parentId);
    return BillsStatistics(
      totalBills: bills.length,
      paidBills: bills.where((b) => b.status == BillStatus.paid).length,
      unpaidBills: bills
          .where((b) => b.status == BillStatus.pending && b.paidAt == null)
          .length,
      overdueBills: bills.where((b) => b.status == BillStatus.overdue).length,
      totalPaidAmount: bills.fold(0.0, (sum, b) => sum + (b.paidAmount ?? 0)),
      totalUnpaidAmount: bills.fold(
        0.0,
        (sum, b) =>
            sum +
            (b.status == BillStatus.pending && b.paidAt == null ? b.amount : 0),
      ),
    );
  }

  @override
  Future<Bill> payBill(
    String billId, {
    String? paymentMethod,
    String? receiptUrl,
  }) async {
    final index = MockDataStore.bills.indexWhere((b) => b.id == billId);
    if (index == -1) throw Exception('الفاتورة غير موجودة');
    final old = MockDataStore.bills[index];
    final updated = BillModel(
      id: old.id,
      subscriptionId: old.subscriptionId,
      parentId: old.parentId,
      amount: old.amount,
      paidAmount: old.amount,
      status: BillStatus.pending,
      dueDate: old.dueDate,
      paidAt: DateTime.now(),
      paymentMethod: paymentMethod,
      receiptUrl: receiptUrl,
      notes: old.notes,
      createdAt: old.createdAt,
      updatedAt: DateTime.now(),
    );
    MockDataStore.bills[index] = updated;
    return updated;
  }
}

class MockNotificationsRepository implements NotificationsRepository {
  @override
  Future<List<AppNotification>> getNotifications({String? userId}) async {
    return MockDataStore.notifications;
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    return MockDataStore.notifications.where((n) => n.isRead == false).length;
  }

  @override
  Future<void> markAsRead(String id) async {}

  @override
  Future<void> markAllAsRead(String userId) async {}
}

class MockRequestsRepository implements RequestsRepository {
  @override
  Future<List<AddChildRequest>> getRequests({String? parentId}) async {
    if (parentId == null) return MockDataStore.requests;
    return MockDataStore.requests.where((r) => r.parentId == parentId).toList();
  }

  @override
  Future<AddChildRequest> createRequest(AddChildRequest request) async {
    final now = DateTime.now();
    final newRequest = AddChildRequestModel(
      id: 'mock-req-${now.millisecondsSinceEpoch}',
      parentId: request.parentId,
      studentId: request.studentId,
      studentName: request.studentName,
      status: RequestStatus.pending,
      createdAt: now,
      updatedAt: now,
    );
    MockDataStore.requests.add(newRequest);

    MockDataStore.notifications.add(
      NotificationModel(
        id: 'mock-notif-${now.millisecondsSinceEpoch}',
        userId: request.parentId,
        type: NotificationType.childRequestPending,
        title: 'طلب إضافة طالب',
        body:
            'تم استلام طلب إضافة الطالب ${request.studentName ?? ""} وهو قيد المراجعة',
        isRead: false,
        relatedId: newRequest.id,
        relatedType: 'request',
        createdAt: now,
      ),
    );

    return newRequest;
  }

  @override
  Future<void> deleteRequest(String id) async {
    MockDataStore.requests.removeWhere((r) => r.id == id);
  }
}

class MockParentRepository implements ParentRepository {
  @override
  Future<Parent?> getParentByUserId(String userId) async {
    try {
      return MockDataStore.parents.firstWhere((p) => p.userId == userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Parent> createParent(Parent parent) => Future.value(parent);

  @override
  Future<Parent> updateParent(Parent parent) => Future.value(parent);
}

class MockCitiesRepository implements CitiesRepository {
  @override
  Future<List<City>> getCities() async {
    return MockDataStore.cities;
  }

  @override
  Future<List<District>> getDistricts(String cityId) async {
    return MockDataStore.districts.where((d) => d.cityId == cityId).toList();
  }

  @override
  Future<List<School>> getSchools(String districtId) async {
    return MockDataStore.schools
        .where((s) => s.districtId == districtId)
        .toList();
  }

  @override
  Future<List<EducationLevel>> getEducationLevels() async {
    return [];
  }

  @override
  Future<List<GatheringPoint>> getGatheringPoints(String districtId) async {
    return [];
  }
}

class MockSubscriptionsService extends SubscriptionsService {
  MockSubscriptionsService() : super(SupabaseClient('', ''));

  @override
  Future<List<SubscriptionModel>> getSubscriptions({String? parentId}) async {
    return MockDataStore.subscriptions;
  }

  @override
  Future<SubscriptionModel?> getSubscriptionById(String id) async {
    try {
      return MockDataStore.subscriptions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, int>> getSubscriptionStats(String parentId) async {
    return {'active': 1, 'expired': 0, 'trial': 1, 'total': 2};
  }
}
