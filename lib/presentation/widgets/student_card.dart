import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../core/helpers/field_naming_helper.dart';
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
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
          child: Icon(
            student.gender == Gender.female ? Icons.female : Icons.male,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          student.fullName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'الحالة: ${FieldNamingHelper.getStatusLabel(student.status.name)}',
          style: TextStyle(color: _getStatusColor(student.status.name)),
        ),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.success;
      case 'suspended':
        return AppColors.warning;
      default:
        return AppColors.textHint;
    }
  }
}
