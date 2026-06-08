import '../../domain/entities/onboarding_step.dart';

class OnboardingStepModel extends OnboardingStep {
  OnboardingStepModel({
    required super.id,
    required super.title,
    required super.description,
    super.iconUrl,
    required super.stepNumber,
  });
}
