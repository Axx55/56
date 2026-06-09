import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_config.dart';
import 'core/services/auth_service/auth_service_base.dart';
import 'core/services/auth_service/email_auth_service.dart';
import 'core/services/mock/mock_auth_service.dart';
import 'core/services/mock/mock_repositories.dart';
import 'core/themes/app_theme.dart';
import 'data/services/subscriptions_service.dart';
import 'data/services/bill_service.dart';
import 'data/services/requests_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/database_service.dart';
import 'data/repositories/students_repository_impl.dart';
import 'data/repositories/parent_repository_impl.dart';
import 'data/repositories/bills_repository_impl.dart';
import 'data/repositories/requests_repository_impl.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'data/repositories/cities_repository_impl.dart';
import 'data/services/lookup_service.dart';
import 'data/services/student_service.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/students_provider.dart';
import 'presentation/providers/subscriptions_provider.dart';
import 'presentation/providers/bills_provider.dart';
import 'presentation/providers/requests_provider.dart';
import 'presentation/providers/notifications_provider.dart';
import 'presentation/providers/parent_profile_provider.dart';
import 'presentation/providers/user_type_provider.dart';
import 'presentation/providers/transport_plan_provider.dart';
import 'presentation/providers/add_child_wizard_provider.dart';
import 'presentation/providers/location_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/pages/main_navigation_page.dart';
import 'presentation/pages/bills_main_page.dart';
import 'presentation/pages/requests_page.dart';
import 'presentation/pages/subscriptions_simple_page.dart';
import 'presentation/pages/children_page.dart';
import 'presentation/pages/add_child_wizard_page.dart';
import 'presentation/pages/customer_support_page.dart';
import 'presentation/pages/complaints_page.dart';
import 'presentation/pages/new_complaint_page.dart';
import 'presentation/pages/ratings_page.dart';
import 'presentation/pages/all_trips_page.dart';
import 'presentation/pages/terms_and_conditions_page.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool useMock = AppConfig.useMock;

  AuthServiceBase authService;
  late StudentsRepositoryImpl studentsRepo;
  late BillsRepositoryImpl billsRepo;
  late RequestsRepositoryImpl requestsRepo;
  late NotificationsRepositoryImpl notifsRepo;
  late CitiesRepositoryImpl citiesRepo;

  if (!useMock) {
    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        publishableKey: AppConfig.supabaseAnonKey,
      );

      final supabase = Supabase.instance.client;
      final dbService = DatabaseService.instance;

      authService = EmailAuthService(supabase: supabase);
      studentsRepo = StudentsRepositoryImpl(StudentService(supabase));
      billsRepo = BillsRepositoryImpl(BillService(supabase));
      requestsRepo = RequestsRepositoryImpl(RequestsService(supabase));
      notifsRepo = NotificationsRepositoryImpl(NotificationService(supabase));
      citiesRepo = CitiesRepositoryImpl(LookupService(supabase));

      runApp(
        _buildApp(
          authService,
          studentsRepo,
          billsRepo,
          requestsRepo,
          notifsRepo,
          citiesRepo,
          supabase,
          dbService,
        ),
      );
      return;
    } catch (_) {
      useMock = true;
    }
  }

  if (useMock) {
    authService = MockAuthService();
    final mockStudentsRepo = MockStudentsRepository();
    final mockBillsRepo = MockBillsRepository();
    final mockRequestsRepo = MockRequestsRepository();
    final mockNotifsRepo = MockNotificationsRepository();
    final mockCitiesRepo = MockCitiesRepository();

    runApp(
      _buildAppMock(
        authService,
        mockStudentsRepo,
        mockBillsRepo,
        mockRequestsRepo,
        mockNotifsRepo,
        mockCitiesRepo,
      ),
    );
  }
}

MultiProvider _buildApp(
  AuthServiceBase authService,
  StudentsRepositoryImpl studentsRepo,
  BillsRepositoryImpl billsRepo,
  RequestsRepositoryImpl requestsRepo,
  NotificationsRepositoryImpl notifsRepo,
  CitiesRepositoryImpl citiesRepo,
  dynamic supabase,
  DatabaseService dbService,
) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
      ChangeNotifierProvider(create: (_) => UserTypeProvider()),
      ChangeNotifierProvider(create: (_) => StudentsProvider(studentsRepo)),
      ChangeNotifierProvider(
        create: (_) => SubscriptionsProvider(SubscriptionsService(supabase)),
      ),
      ChangeNotifierProvider(create: (_) => BillsProvider(billsRepo)),
      ChangeNotifierProvider(create: (_) => RequestsProvider(requestsRepo)),
      ChangeNotifierProvider(create: (_) => NotificationsProvider(notifsRepo)),
      ChangeNotifierProvider(
        create: (_) =>
            ParentProfileProvider(ParentRepositoryImpl(dbService), supabase),
      ),
      ChangeNotifierProvider(create: (_) => TransportPlanProvider(citiesRepo)),
      ChangeNotifierProvider(
        create: (_) => AddChildWizardProvider(
          studentsRepo: studentsRepo,
          requestsRepo: requestsRepo,
        ),
      ),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ],
    child: const MasaratApp(),
  );
}

MultiProvider _buildAppMock(
  AuthServiceBase authService,
  MockStudentsRepository mockStudentsRepo,
  MockBillsRepository mockBillsRepo,
  MockRequestsRepository mockRequestsRepo,
  MockNotificationsRepository mockNotifsRepo,
  MockCitiesRepository mockCitiesRepo,
) {
  final mockSubsService = MockSubscriptionsService();
  final mockParentRepo = MockParentRepository();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
      ChangeNotifierProvider(create: (_) => UserTypeProvider()),
      ChangeNotifierProvider(create: (_) => StudentsProvider(mockStudentsRepo)),
      ChangeNotifierProvider(
        create: (_) => SubscriptionsProvider(mockSubsService),
      ),
      ChangeNotifierProvider(create: (_) => BillsProvider(mockBillsRepo)),
      ChangeNotifierProvider(create: (_) => RequestsProvider(mockRequestsRepo)),
      ChangeNotifierProvider(
        create: (_) => NotificationsProvider(mockNotifsRepo),
      ),
      ChangeNotifierProvider(
        create: (_) => ParentProfileProvider(mockParentRepo, null),
      ),
      ChangeNotifierProvider(
        create: (_) => TransportPlanProvider(mockCitiesRepo),
      ),
      ChangeNotifierProvider(
        create: (_) => AddChildWizardProvider(
          studentsRepo: mockStudentsRepo,
          requestsRepo: mockRequestsRepo,
        ),
      ),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ],
    child: const MasaratApp(),
  );
}

class MasaratApp extends StatelessWidget {
  const MasaratApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'SA')],
      locale: const Locale('ar', 'SA'),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/main':
            return MaterialPageRoute(
              builder: (_) => const MainNavigationPage(),
            );
          case '/bills':
            return MaterialPageRoute(builder: (_) => const BillsMainPage());
          case '/requests':
            return MaterialPageRoute(builder: (_) => const RequestsPage());
          case '/subscriptions':
            return MaterialPageRoute(
              builder: (_) => const SubscriptionsSimplePage(),
            );
          case '/children':
            return MaterialPageRoute(builder: (_) => const ChildrenPage());
          case '/add-child':
            return MaterialPageRoute(
              builder: (_) => const AddChildWizardPage(),
            );
          case '/support':
            return MaterialPageRoute(
              builder: (_) => const CustomerSupportPage(),
            );
          case '/complaints':
            return MaterialPageRoute(builder: (_) => const ComplaintsPage());
          case '/new-complaint':
            return MaterialPageRoute(builder: (_) => const NewComplaintPage());
          case '/ratings':
            return MaterialPageRoute(builder: (_) => const RatingsPage());
          case '/trips':
            return MaterialPageRoute(builder: (_) => const AllTripsPage());
          case '/terms':
            return MaterialPageRoute(
              builder: (_) => const TermsAndConditionsPage(),
            );
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
