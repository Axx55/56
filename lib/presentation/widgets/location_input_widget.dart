import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class LocationInputWidget extends StatelessWidget {
  final String? location;
  final bool isLoading;
  final VoidCallback onGetLocation;

  const LocationInputWidget({
    super.key,
    this.location,
    this.isLoading = false,
    required this.onGetLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الموقع',
          style: TextStyle(
            fontSize: AppDimensions.fontSm,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSm),
        GestureDetector(
          onTap: isLoading ? null : onGetLocation,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  isLoading ? Icons.hourglass_top : Icons.location_on,
                  color: AppColors.primary,
                  size: AppDimensions.iconMd,
                ),
                const SizedBox(width: AppDimensions.paddingSm),
                Expanded(
                  child: Text(
                    location ??
                        (isLoading
                            ? 'جاري تحديد الموقع...'
                            : 'اضغط لتحديد الموقع'),
                    style: TextStyle(
                      color: location != null
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                      fontSize: AppDimensions.fontSm,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
