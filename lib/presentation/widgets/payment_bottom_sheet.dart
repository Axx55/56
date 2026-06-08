import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class PaymentBottomSheet extends StatelessWidget {
  final double amount;
  final VoidCallback onPay;

  const PaymentBottomSheet({
    super.key,
    required this.amount,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLg),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLg),
          const Text(
            'تفاصيل الدفع',
            style: TextStyle(
              fontSize: AppDimensions.fontLg,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'المبلغ',
                style: TextStyle(
                  fontSize: AppDimensions.fontMd,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${amount.toStringAsFixed(2)} ر.س',
                style: const TextStyle(
                  fontSize: AppDimensions.fontXl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLg),
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton(
              onPressed: onPay,
              child: const Text('تأكيد الدفع'),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
        ],
      ),
    );
  }
}
