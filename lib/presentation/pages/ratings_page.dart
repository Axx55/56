import 'package:flutter/material.dart';
import '../widgets/shared/empty_state_widget.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقييمات')),
      body: const EmptyStateWidget(
        icon: Icons.star_outline,
        title: 'لا توجد تقييمات',
        subtitle: 'سوف تظهر تقييماتك هنا',
      ),
    );
  }
}
