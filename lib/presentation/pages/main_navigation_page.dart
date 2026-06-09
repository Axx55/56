import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications_provider.dart';
import '../widgets/app_drawer.dart';
import 'home_page.dart';
import 'children_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ChildrenPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  final List<String> _titles = const [
    'الرئيسية',
    'الطلاب',
    'الإشعارات',
    'الملف الشخصي',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsProvider>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 3
          ? null
          : AppBar(
              title: Text(_titles[_currentIndex]),
              centerTitle: true,
              actions: [
                if (_currentIndex == 1)
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/add-child'),
                  ),
              ],
            ),
      drawer: const AppDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'الطلاب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'الإشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}
