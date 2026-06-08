import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_dimensions.dart';

class LocationPicker extends StatelessWidget {
  final String? location;
  final bool isLoading;
  final VoidCallback onPick;
  final VoidCallback? onClear;

  const LocationPicker({
    super.key,
    this.location,
    this.isLoading = false,
    required this.onPick,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'موقع المنزل',
          style: TextStyle(
            fontSize: AppDimensions.fontSm,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: ListTile(
            leading: Icon(
              isLoading ? Icons.hourglass_top : Icons.location_on,
              color: AppColors.primary,
            ),
            title: Text(
              location ?? (isLoading ? 'جاري التحديد...' : 'اختر الموقع'),
              style: TextStyle(
                color: location != null
                    ? AppColors.textPrimary
                    : AppColors.textHint,
              ),
            ),
            trailing: onClear != null && location != null
                ? IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: onClear,
                  )
                : null,
            onTap: isLoading ? null : onPick,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
          ),
        ),
      ],
    );
  }
}
