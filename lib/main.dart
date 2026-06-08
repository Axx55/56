import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_config.dart';
import 'core/themes/app_theme.dart';
import 'data/services/student_service.dart';
import 'data/services/subscriptions_service.dart';
import 'data/services/bill_service.dart';
import 'data/services/requests_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/lookup_service.dart';
import 'data/services/database_service.dart';
import 'data/repositories/students_repository_impl.dart';
import 'data/repositories/parent_repository_impl.dart';
import 'data/repositories/bills_repository_impl.dart';
import 'data/repositories/requests_repository_impl.dart';
import 'data/repositories/notifications_repository_impl.dart';
import 'data/repositories/cities_repository_impl.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    publishableKey: AppConfig.supabaseAnonKey,
  );

  final supabase = Supabase.instance.client;
  final dbService = DatabaseService.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(supabase)),
        ChangeNotifierProvider(create: (_) => UserTypeProvider()),
        ChangeNotifierProvider(
          create: (_) => StudentsProvider(
            StudentsRepositoryImpl(StudentService(supabase)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SubscriptionsProvider(SubscriptionsService(supabase)),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              BillsProvider(BillsRepositoryImpl(BillService(supabase))),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestsProvider(
            RequestsRepositoryImpl(RequestsService(supabase)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationsProvider(
            NotificationsRepositoryImpl(NotificationService(supabase)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ParentProfileProvider(ParentRepositoryImpl(dbService), supabase),
        ),
        ChangeNotifierProvider(
          create: (_) => TransportPlanProvider(
            CitiesRepositoryImpl(LookupService(supabase)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddChildWizardProvider(
            studentsRepo: StudentsRepositoryImpl(StudentService(supabase)),
            requestsRepo: RequestsRepositoryImpl(RequestsService(supabase)),
          ),
        ),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: const MasaratApp(),
    ),
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
