import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خدمة العملاء')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLg),
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingLg),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.headset_mic,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMd),
            const Text(
              'كيف يمكننا مساعدتك؟',
              style: TextStyle(
                fontSize: AppDimensions.fontXl,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSm),
            const Text(
              'تواصل معنا عبر القنوات التالية',
              style: TextStyle(
                fontSize: AppDimensions.fontSm,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXl),
            _buildContactCard(
              icon: Icons.chat,
              color: const Color(0xFF25D366),
              title: 'واتساب',
              subtitle: 'تواصل عبر واتساب',
              onTap: () => _launchUrl('https://wa.me/966500000000'),
            ),
            const SizedBox(height: AppDimensions.paddingMd),
            _buildContactCard(
              icon: Icons.email,
              color: AppColors.primary,
              title: 'البريد الإلكتروني',
              subtitle: 'info@masarat.sa',
              onTap: () => _launchUrl('mailto:info@masarat.sa'),
            ),
            const SizedBox(height: AppDimensions.paddingMd),
            _buildContactCard(
              icon: Icons.telegram,
              color: const Color(0xFF0088CC),
              title: 'تلغرام',
              subtitle: '@masarat_support',
              onTap: () => _launchUrl('https://t.me/masarat_support'),
            ),
            const SizedBox(height: AppDimensions.paddingMd),
            _buildContactCard(
              icon: Icons.phone,
              color: AppColors.success,
              title: 'اتصال هاتفي',
              subtitle: '920000000',
              onTap: () => _launchUrl('tel:920000000'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
        onTap: onTap,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
