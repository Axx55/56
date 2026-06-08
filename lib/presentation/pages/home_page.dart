import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/parent_profile_provider.dart';
import '../widgets/user_avatar_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthProvider>().user?.id;
      if (userId != null) {
        context.read<ParentProfileProvider>().loadProfile(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final profile = context.watch<ParentProfileProvider>();

    return RefreshIndicator(
      onRefresh: () async {
        final userId = auth.user?.id;
        if (userId != null) {
          await context.read<ParentProfileProvider>().loadProfile(userId);
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(context, auth, profile),
            _buildHowItWorks(context),
            _buildActions(context),
            const SizedBox(height: AppDimensions.paddingLg),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AuthProvider auth,
    ParentProfileProvider profile,
  ) {
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً بك في',
                      style: TextStyle(
                        fontSize: AppDimensions.fontSm,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'مسارات',
                      style: TextStyle(
                        fontSize: AppDimensions.fontXl,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  UserAvatarWidget(
                    imageUrl: profile.profile?.avatarUrl,
                    fullName: profile.profile?.fullName,
                    size: 60,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    auth.user?.email ?? '',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXs,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMd),
        ],
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'كيف يعمل النظام',
            style: TextStyle(
              fontSize: AppDimensions.fontLg,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildStep(
            icon: Icons.person_add,
            title: 'أضف أبناءك',
            description: 'قم بإضافة أبنائك الطلاب مع تحديد مدارسهم وبياناتهم',
            step: 1,
          ),
          _buildStep(
            icon: Icons.route,
            title: 'اختر الخطة',
            description: 'اختر خطة النقل المناسبة من حيث الوقت والمسارات',
            step: 2,
          ),
          _buildStep(
            icon: Icons.check_circle,
            title: 'اشترك واستمتع',
            description: 'قم بالاشتراك وتمتع بخدمة نقل مدرسي آمنة وموثوقة',
            step: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String description,
    required int step,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMd),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: AppDimensions.paddingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontMd,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMd),
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed('/add-child'),
          icon: const Icon(Icons.person_add),
          label: const Text('تقديم طلب إضافة ابن'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
