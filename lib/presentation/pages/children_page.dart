import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/students_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/shared/loading_widget.dart';
import '../widgets/shared/empty_state_widget.dart';
import '../widgets/shared/error_widget.dart';
import '../widgets/student_card.dart';
import '../../core/themes/app_colors.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('أبنائي')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/add-child'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _buildBody(studentsProvider),
    );
  }

  Widget _buildBody(StudentsProvider provider) {
    if (provider.isLoading) {
      return const LoadingWidget(message: 'جاري تحميل البيانات...');
    }
    if (provider.error != null) {
      return AppErrorWidget(message: provider.error, onRetry: _loadStudents);
    }
    if (provider.students.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.people_outline,
        title: 'لا يوجد أبناء',
        subtitle: 'قم بإضافة أبنائك للاستفادة من خدمة النقل المدرسي',
        actionLabel: 'إضافة ابن',
        onAction: () => Navigator.of(context).pushNamed('/add-child'),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadStudents,
      child: ListView.builder(
        itemCount: provider.students.length,
        itemBuilder: (context, index) {
          return StudentCard(
            student: provider.students[index],
            onTap: () => _showStudentDetails(context, provider.students[index]),
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
            _buildDetailRow(Icons.info, 'الحالة', student.status.name),
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
