import 'package:flutter/material.dart';
import '../widgets/shared/empty_state_widget.dart';

class AllTripsPage extends StatelessWidget {
  const AllTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سجل الرحلات'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'القادمة'),
              Tab(text: 'مكتملة'),
              Tab(text: 'ملغية'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TripList(status: 'upcoming'),
            _TripList(status: 'completed'),
            _TripList(status: 'cancelled'),
          ],
        ),
      ),
    );
  }
}

class _TripList extends StatelessWidget {
  final String status;
  const _TripList({required this.status});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon: Icons.directions_bus_outlined,
      title: 'لا توجد رحلات',
      subtitle: 'سوف تظهر الرحلات هنا عند توفرها',
    );
  }
}
