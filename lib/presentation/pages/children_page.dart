import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/students_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../widgets/student_card.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../domain/entities/student.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudents();
    });
  }

  Future<void> _loadStudents() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId != null) {
      await context.read<StudentsProvider>().loadStudents(parentId: userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsProvider = context.watch<StudentsProvider>();
    final accepted = studentsProvider.students
        .where((s) => s.status == StudentStatus.active)
        .toList();

    return Scaffold(
      body: _buildBody(studentsProvider, accepted),
      floatingActionButton: accepted.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed('/add-child'),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildBody(StudentsProvider provider, List<Student> accepted) {
    if (provider.isLoading) {
      return const LoadingWidget(message: 'جاري تحميل البيانات...');
    }
    if (provider.error != null) {
      return AppErrorWidget(message: provider.error, onRetry: _loadStudents);
    }
    if (accepted.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: AppColors.textHint),
            const SizedBox(height: 16),
            const Text(
              'لا يوجد طلاب بعد',
              style: TextStyle(
                fontSize: AppDimensions.fontMd,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/add-child'),
              icon: const Icon(Icons.add),
              label: const Text('إضافة طالب'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadStudents,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: AppDimensions.paddingSm,
          bottom: 80,
        ),
        itemCount: accepted.length,
        itemBuilder: (context, index) {
          return StudentCard(
            student: accepted[index],
            onTap: () => _showStudentDetails(context, accepted[index]),
          );
        },
      ),
    );
  }

  void _showStudentDetails(BuildContext context, dynamic student) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              student.fullName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              Icons.person,
              'الجنس',
              student.gender == 'male' ? 'ذكر' : 'أنثى',
            ),
            _buildDetailRow(
              Icons.school,
              'المرحلة',
              student.educationLevelId ?? 'غير محدد',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
