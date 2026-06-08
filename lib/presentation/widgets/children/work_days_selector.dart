import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';

class WorkDaysSelector extends StatelessWidget {
  final List<String> selectedDays;
  final ValueChanged<String> onToggle;

  static const List<Map<String, String>> days = [
    {'key': 'saturday', 'label': 'السبت'},
    {'key': 'sunday', 'label': 'الأحد'},
    {'key': 'monday', 'label': 'الإثنين'},
    {'key': 'tuesday', 'label': 'الثلاثاء'},
    {'key': 'wednesday', 'label': 'الأربعاء'},
    {'key': 'thursday', 'label': 'الخميس'},
  ];

  const WorkDaysSelector({
    super.key,
    required this.selectedDays,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أيام الدراسة',
          style: TextStyle(
            fontSize: AppDimensions.fontSm,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: days.map((day) {
            final isSelected = selectedDays.contains(day['key']);
            return FilterChip(
              label: Text(day['label']!),
              selected: isSelected,
              onSelected: (_) => onToggle(day['key']!),
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
