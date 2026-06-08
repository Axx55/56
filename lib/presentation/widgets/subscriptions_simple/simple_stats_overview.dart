import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';

class SimpleStatsOverview extends StatelessWidget {
  final Map<String, int> stats;

  const SimpleStatsOverview({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Row(
        children: [
          _buildStatCard('نشط', stats['active'] ?? 0, AppColors.success),
          const SizedBox(width: AppDimensions.paddingSm),
          _buildStatCard('منتهي', stats['expired'] ?? 0, AppColors.overdue),
          const SizedBox(width: AppDimensions.paddingSm),
          _buildStatCard('الإجمالي', stats['total'] ?? 0, AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: AppDimensions.fontXl,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: AppDimensions.fontSm, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
