import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../themes/app_dimensions.dart';

class PlatformDownloadButtons extends StatelessWidget {
  final String androidUrl;

  const PlatformDownloadButtons({super.key, required this.androidUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          context,
          icon: Icons.android,
          label: 'تحميل للأندرويد',
          color: const Color(0xFF34A853),
          onTap: () => _launchUrl(androidUrl),
        ),
        const SizedBox(height: AppDimensions.paddingMd),
        _buildButton(
          context,
          icon: Icons.apple,
          label: 'الإصدار القادم قريباً',
          color: Colors.grey,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 24),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
        ),
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
