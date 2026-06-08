import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class SubscriptionPeriodSelector extends StatelessWidget {
  final String? selectedPeriod;
  final ValueChanged<String> onSelected;
  final List<Map<String, String>> periods;

  const SubscriptionPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onSelected,
    required this.periods,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'فترة الاشتراك',
          style: TextStyle(
            fontSize: AppDimensions.fontMd,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        Row(
          children: periods.map((period) {
            final isSelected = selectedPeriod == period['value'];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => onSelected(period['value']!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMd,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          period['label']!,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (period['price'] != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            period['price']!,
                            style: TextStyle(
                              fontSize: AppDimensions.fontXs,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
