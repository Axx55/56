import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/onboarding_step.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/onboarding_step_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _key = 'onboarding_complete';

  @override
  Future<List<OnboardingStep>> getOnboardingSteps() async {
    return [
      OnboardingStepModel(
        id: '1',
        title: 'أضف أبناءك',
        description: 'قم بإضافة أبنائك الطلاب ببياناتهم ومدارسهم',
        stepNumber: 1,
      ),
      OnboardingStepModel(
        id: '2',
        title: 'اختر الخطة المناسبة',
        description: 'اختر خطة النقل التي تناسب احتياجات أبنائك',
        stepNumber: 2,
      ),
      OnboardingStepModel(
        id: '3',
        title: 'اشترك واستمتع',
        description: 'قم بالاشتراك وتمتع بخدمة النقل المدرسي الآمن',
        stepNumber: 3,
      ),
    ];
  }

  @override
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
