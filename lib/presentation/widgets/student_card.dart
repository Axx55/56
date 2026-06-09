import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../domain/entities/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentCard({super.key, required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMd,
        vertical: AppDimensions.paddingXs,
      ),
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMd),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: AppDimensions.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    _buildStatusChip(),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.chevron_left,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        child: Icon(
          student.gender == Gender.female ? Icons.female : Icons.male,
          size: 28,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color bgColor;
    Color textColor;
    String label;

    switch (student.status) {
      case StudentStatus.active:
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green.shade700;
        label = 'نشط';
      case StudentStatus.suspended:
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey.shade700;
        label = 'موقوف';
      case StudentStatus.pending:
        bgColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange.shade700;
        label = 'قيد الانتظار';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
