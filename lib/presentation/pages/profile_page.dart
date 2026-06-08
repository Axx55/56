import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/parent_profile_provider.dart';
import '../widgets/user_avatar_widget.dart';
import '../widgets/shared/loading_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../core/utils/time_formatter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<ParentProfileProvider>().loadProfile(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final profile = context.watch<ParentProfileProvider>();

    if (profile.isLoading) return const LoadingWidget();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAvatarSection(context, profile, auth),
          _buildInfoSection(profile, auth),
          _buildSettingsSection(context),
          const SizedBox(height: AppDimensions.paddingLg),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(
    BuildContext context,
    ParentProfileProvider profile,
    AuthProvider auth,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLg),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppDimensions.radiusXl),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingMd),
          UserAvatarWidget(
            imageUrl: profile.profile?.avatarUrl,
            fullName: profile.profile?.fullName,
            size: 80,
            isEditable: true,
            onTap: () {},
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          Text(
            profile.profile?.fullName ?? auth.user?.email ?? 'مستخدم',
            style: const TextStyle(
              fontSize: AppDimensions.fontLg,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            auth.user?.email ?? '',
            style: TextStyle(
              fontSize: AppDimensions.fontSm,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'ولي أمر',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(ParentProfileProvider profile, AuthProvider auth) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'معلومات الحساب',
                style: TextStyle(
                  fontSize: AppDimensions.fontMd,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMd),
              _infoRow(Icons.person, 'الاسم', profile.profile?.fullName ?? ''),
              const Divider(),
              _infoRow(
                Icons.phone,
                'الهاتف',
                profile.profile?.phone ?? 'غير مضاف',
              ),
              const Divider(),
              _infoRow(Icons.email, 'البريد', auth.user?.email ?? ''),
              const Divider(),
              _infoRow(
                Icons.calendar_today,
                'تاريخ التسجيل',
                profile.profile?.createdAt != null
                    ? TimeFormatter.formatDate(profile.profile!.createdAt)
                    : '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: AppDimensions.fontSm),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMd),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMd),
              child: Text(
                'الإعدادات',
                style: TextStyle(
                  fontSize: AppDimensions.fontMd,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.textSecondary),
              title: const Text('تغيير رقم الهاتف'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.lock, color: AppColors.textSecondary),
              title: const Text('تغيير كلمة المرور'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: AppColors.textSecondary,
              ),
              title: const Text('إعدادات الإشعارات'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {},
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.textSecondary),
              title: const Text('مساعدة'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () => Navigator.of(context).pushNamed('/support'),
            ),
          ],
        ),
      ),
    );
  }
}
