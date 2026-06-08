import '../entities/onboarding_step.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingStep>> getOnboardingSteps();
  Future<bool> isOnboardingComplete();
  Future<void> completeOnboarding();
}
