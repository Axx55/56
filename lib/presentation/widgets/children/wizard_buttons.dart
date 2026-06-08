import 'package:flutter/material.dart';
import '../../../core/themes/app_dimensions.dart';

class WizardButtons extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final bool canGoNext;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback? onSubmit;

  const WizardButtons({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.canGoNext,
    this.isLoading = false,
    required this.onBack,
    required this.onNext,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Row(
        children: [
          if (!isFirstStep)
            Expanded(
              child: OutlinedButton(
                onPressed: isLoading ? null : onBack,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, AppDimensions.buttonHeight),
                ),
                child: const Text('السابق'),
              ),
            ),
          if (!isFirstStep) const SizedBox(width: AppDimensions.paddingMd),
          Expanded(
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : (canGoNext
                        ? (isLastStep ? () => onSubmit?.call() : onNext)
                        : null),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(isLastStep ? 'إرسال الطلب' : 'التالي'),
            ),
          ),
        ],
      ),
    );
  }
}
