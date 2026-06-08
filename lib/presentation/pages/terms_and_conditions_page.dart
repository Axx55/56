import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الشروط والأحكام')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'مسارات - النقل المدرسي',
                style: TextStyle(
                  fontSize: AppDimensions.fontXl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLg),
            _section(
              'مقدمة',
              'مرحباً بك في تطبيق مسارات. باستخدامك لهذا التطبيق، فإنك توافق على الشروط والأحكام التالية. يرجى قراءتها بعناية.',
            ),
            _section(
              'الخدمات المقدمة',
              'يقدم تطبيق مسارات خدمة النقل المدرسي للطلاب والطالبات، بما في ذلك جدولة الرحلات، تتبع المركبات، وإدارة الاشتراكات والمدفوعات.',
            ),
            _section(
              'التسجيل والحسابات',
              'يجب عليك تقديم معلومات دقيقة عند التسجيل. أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور.',
            ),
            _section(
              'الاشتراكات والمدفوعات',
              'تخضع جميع الاشتراكات والمدفوعات لسياسات التسعير المعلنة. يجب سداد المدفوعات في المواعيد المحددة لتجنب تعليق الخدمة.',
            ),
            _section(
              'خصوصية البيانات',
              'نحن نلتزم بحماية خصوصية بياناتك الشخصية. يتم جمع واستخدام بياناتك وفقاً لسياسة الخصوصية الخاصة بنا.',
            ),
            const SizedBox(height: AppDimensions.paddingLg),
            Text(
              'آخر تحديث: 2025',
              style: TextStyle(
                fontSize: AppDimensions.fontSm,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppDimensions.fontMd,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSm),
          Text(
            content,
            style: const TextStyle(
              fontSize: AppDimensions.fontSm,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
