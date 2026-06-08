import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';

class SimpleFilterChips extends StatelessWidget {
  final String? selectedFilter;
  final ValueChanged<String?> onChanged;

  static const List<Map<String, String>> filters = [
    {'key': 'all', 'label': 'الكل'},
    {'key': 'active', 'label': 'نشط'},
    {'key': 'expired', 'label': 'منتهي'},
    {'key': 'suspended', 'label': 'موقوف'},
  ];

  const SimpleFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMd),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter['key'];
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FilterChip(
                label: Text(filter['label']!),
                selected: isSelected,
                onSelected: (_) => onChanged(isSelected ? null : filter['key']),
                selectedColor: AppColors.primary,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
