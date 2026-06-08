import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/add_child_wizard_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/children/step_indicator.dart';
import '../widgets/children/wizard_buttons.dart';
import '../widgets/children/child_image_picker.dart';
import '../widgets/children/gender_selector.dart';
import '../widgets/children/custom_dropdown_field.dart';
import '../widgets/children/location_picker.dart';
import '../widgets/children/time_picker_field.dart';
import '../widgets/children/work_days_selector.dart';
import '../widgets/shared/loading_widget.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../domain/entities/transport_plan.dart';

class AddChildWizardPage extends StatelessWidget {
  const AddChildWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة طالب')),
      body: Consumer<AddChildWizardProvider>(
        builder: (context, wizard, _) {
          return Column(
            children: [
              StepIndicator(
                currentStep: wizard.currentStep,
                totalSteps: AddChildWizardProvider.steps.length,
                stepLabels: AddChildWizardProvider.steps
                    .map((s) => s.title)
                    .toList(),
              ),
              Expanded(
                child: wizard.isLoading
                    ? const LoadingWidget(message: 'جاري إرسال الطلب...')
                    : Padding(
                        padding: const EdgeInsets.all(AppDimensions.paddingMd),
                        child: _buildStepContent(context, wizard),
                      ),
              ),
              WizardButtons(
                isFirstStep: wizard.isFirstStep,
                isLastStep: wizard.isLastStep,
                canGoNext: wizard.validateStep(wizard.currentStep),
                isLoading: wizard.isLoading,
                onBack: () => wizard.previousStep(),
                onNext: () => wizard.nextStep(),
                onSubmit: () async {
                  final userId = context.read<AuthProvider>().user?.id;
                  if (userId != null) {
                    final success = await wizard.submit(parentId: userId);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إرسال الطلب بنجاح')),
                      );
                      Navigator.of(context).pop();
                    } else if (wizard.error != null && context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(wizard.error!)));
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    AddChildWizardProvider wizard,
  ) {
    switch (wizard.currentStep) {
      case 0:
        return _buildChildInfoStep(context, wizard);
      case 1:
        return _buildSchoolInfoStep(context, wizard);
      case 2:
        return _buildPlanSelectionStep(context, wizard);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildChildInfoStep(
    BuildContext context,
    AddChildWizardProvider wizard,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ChildImagePicker(
              imagePath: wizard.childImagePath,
              onPick: () => _pickImage(context, wizard),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLg),
          const Text(
            'الجنس',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          GenderSelector(
            selectedGender: wizard.gender,
            onChanged: (gender) => wizard.setGender(gender),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          TextField(
            controller: wizard.fullNameController,
            decoration: const InputDecoration(
              labelText: 'الاسم الكامل',
              hintText: 'أدخل اسم الطالب',
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          CustomDropdownField<String>(
            label: 'المرحلة الدراسية',
            value: wizard.educationLevelId,
            items: const ['ابتدائي', 'متوسط', 'ثانوي'],
            itemLabel: (item) => item,
            onChanged: (value) {
              if (value != null) wizard.setEducationLevel(value);
            },
            hint: 'اختر المرحلة الدراسية',
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolInfoStep(
    BuildContext context,
    AddChildWizardProvider wizard,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdownField<String>(
            label: 'المدينة',
            value: wizard.cityId,
            items: const ['الرياض', 'جدة', 'مكة', 'المدينة'],
            itemLabel: (item) => item,
            onChanged: (value) {
              if (value != null) wizard.setCity(value);
            },
            hint: 'اختر المدينة',
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          CustomDropdownField<String>(
            label: 'الحي',
            value: wizard.districtId,
            items: const ['حي النزهة', 'حي السليمانية', 'حي العليا'],
            itemLabel: (item) => item,
            onChanged: (value) {
              if (value != null) wizard.setDistrict(value);
            },
            hint: 'اختر الحي',
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          CustomDropdownField<String>(
            label: 'المدرسة',
            value: wizard.schoolId,
            items: const ['مدرسة النور', 'مدرسة الفلاح', 'مدرسة الأندلس'],
            itemLabel: (item) => item,
            onChanged: (value) {
              if (value != null) wizard.setSchool(value);
            },
            hint: 'اختر المدرسة',
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          LocationPicker(location: null, onPick: () {}),
          const SizedBox(height: AppDimensions.paddingMd),
          Row(
            children: [
              Expanded(
                child: TimePickerField(
                  label: 'وقت الحضور',
                  value: wizard.startTime,
                  onChanged: (time) => wizard.setStartTime(time),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMd),
              Expanded(
                child: TimePickerField(
                  label: 'وقت الانصراف',
                  value: wizard.endTime,
                  onChanged: (time) => wizard.setEndTime(time),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          WorkDaysSelector(
            selectedDays: wizard.selectedDays,
            onToggle: (day) => wizard.toggleDay(day),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanSelectionStep(
    BuildContext context,
    AddChildWizardProvider wizard,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نوع الرحلة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildTripTypeOption(
            context,
            wizard,
            TripType.go,
            'ذهاب فقط',
            Icons.arrow_forward,
          ),
          _buildTripTypeOption(
            context,
            wizard,
            TripType.return_both,
            'عودة فقط',
            Icons.arrow_back,
          ),
          _buildTripTypeOption(
            context,
            wizard,
            TripType.goAndReturn,
            'ذهاب وعودة',
            Icons.swap_horiz,
          ),
          const SizedBox(height: AppDimensions.paddingLg),
          const Text(
            'فترة الاشتراك',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildPeriodOption(context, wizard, 'شهري', 'monthly'),
          _buildPeriodOption(context, wizard, 'فصلي', 'semester'),
          _buildPeriodOption(context, wizard, 'سنوي', 'yearly'),
        ],
      ),
    );
  }

  Widget _buildTripTypeOption(
    BuildContext context,
    AddChildWizardProvider wizard,
    TripType type,
    String label,
    IconData icon,
  ) {
    final isSelected = wizard.tripType == type;
    return GestureDetector(
      onTap: () => wizard.setTripType(type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodOption(
    BuildContext context,
    AddChildWizardProvider wizard,
    String label,
    String value,
  ) {
    final isSelected = wizard.subscriptionPeriod == value;
    return GestureDetector(
      onTap: () => wizard.setSubscriptionPeriod(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    AddChildWizardProvider wizard,
  ) async {
    final source = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 20),
            const Text(
              'اختيار صورة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context, 'camera'),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.primaryLight.withValues(
                          alpha: 0.2,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('كاميرا'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context, 'gallery'),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.primaryLight.withValues(
                          alpha: 0.2,
                        ),
                        child: const Icon(
                          Icons.photo_library,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('المعرض'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (source != null) {
      wizard.setChildImage(
        source == 'camera' ? 'camera_placeholder' : 'gallery_placeholder',
      );
    }
  }
}
