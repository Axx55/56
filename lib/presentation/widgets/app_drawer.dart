import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 32, color: Colors.white),
                ),
                const SizedBox(height: AppDimensions.paddingSm),
                Text(
                  'ولي أمر',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: AppDimensions.fontLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildItem(context, Icons.home_outlined, 'الرئيسية', '/main'),
          _buildItem(context, Icons.receipt_long, 'الفواتير', '/bills'),
          _buildItem(context, Icons.assignment, 'الطلبات', '/requests'),
          _buildItem(context, Icons.directions_bus, 'سجل الرحلات', '/trips'),
          _buildItem(
            context,
            Icons.feedback_outlined,
            'الشكاوي',
            '/complaints',
          ),
          _buildItem(context, Icons.star_outline, 'التقييم', '/ratings'),
          _buildItem(
            context,
            Icons.subscriptions_outlined,
            'الاشتراكات',
            '/subscriptions',
          ),
          _buildItem(context, Icons.headset_mic, 'خدمة العملاء', '/support'),
          _buildItem(
            context,
            Icons.description_outlined,
            'الشروط والأحكام',
            '/terms',
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () async {
              await context.read<AuthProvider>().signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
