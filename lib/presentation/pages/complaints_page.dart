import 'package:flutter/material.dart';
import '../widgets/shared/empty_state_widget.dart';
import '../../core/themes/app_colors.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الشكاوي')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/new-complaint'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: const EmptyStateWidget(
        icon: Icons.feedback_outlined,
        title: 'لا توجد شكاوي',
        subtitle: 'لم تقم بتقديم أي شكوى بعد',
      ),
    );
  }
}
