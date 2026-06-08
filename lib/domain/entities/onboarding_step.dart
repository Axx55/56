class OnboardingStep {
  final String id;
  final String title;
  final String description;
  final String? iconUrl;
  final int stepNumber;

  OnboardingStep({
    required this.id,
    required this.title,
    required this.description,
    this.iconUrl,
    required this.stepNumber,
  });
}
