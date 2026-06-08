import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';

class CheckboxGroup extends StatelessWidget {
  final String label;
  final List<CheckboxOption> options;

  const CheckboxGroup({super.key, required this.label, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontSm,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        ...options.map(
          (option) => CheckboxListTile(
            title: Text(option.label),
            value: option.isSelected,
            onChanged: (_) => option.onChanged(),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
      ],
    );
  }
}

class CheckboxOption {
  final String label;
  final bool isSelected;
  final VoidCallback onChanged;

  CheckboxOption({
    required this.label,
    required this.isSelected,
    required this.onChanged,
  });
}
