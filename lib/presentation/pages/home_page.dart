import 'package:flutter/material.dart';
import '../../core/services/mock/mock_data_store.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';
import '../../domain/entities/trip_record.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todayTrips = MockDataStore.trips
        .where(
          (t) =>
              t.tripDate != null &&
              t.tripDate!.year == DateTime.now().year &&
              t.tripDate!.month == DateTime.now().month &&
              t.tripDate!.day == DateTime.now().day,
        )
        .toList();

    return RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
        children: [
          _buildHeader(),
          const SizedBox(height: AppDimensions.paddingMd),
          Row(
            children: [
              const Text(
                'رحلات اليوم',
                style: TextStyle(
                  fontSize: AppDimensions.fontLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.history, size: 18),
                label: const Text('السجل'),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingSm),
          if (todayTrips.isEmpty)
            _buildEmptyTrips()
          else
            ...todayTrips.map((trip) => _buildTripCard(trip)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFFFFA000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مسارات',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'النقل المدرسي الآمن',
            style: TextStyle(
              fontSize: AppDimensions.fontSm,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTrips() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Icon(Icons.directions_bus, size: 80, color: AppColors.textHint),
            const SizedBox(height: 16),
            const Text(
              'لا توجد رحلات اليوم',
              style: TextStyle(
                fontSize: AppDimensions.fontMd,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(TripRecord trip) {
    final driver = MockDataStore.drivers
        .where((d) => d.fullName == trip.driverName)
        .firstOrNull;

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMd),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: InkWell(
        onTap: () => _showTripDetails(context, trip, driver),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSm,
                      ),
                    ),
                    child: const Icon(
                      Icons.directions_bus,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.driverName ?? 'سائق',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildStatusBadge(trip.status),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_left,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingMd),
              _infoRow(
                Icons.schedule,
                '${trip.startTime ?? ""} - ${trip.endTime ?? ""}',
              ),
              if (trip.pickupLocation != null)
                _infoRow(Icons.location_on, trip.pickupLocation!),
              if (trip.dropoffLocation != null)
                _infoRow(Icons.location_on, trip.dropoffLocation!),
              const SizedBox(height: AppDimensions.paddingSm),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الحضور')),
                    );
                  },
                  icon: const Icon(Icons.check_circle, size: 18),
                  label: const Text('تسجيل الحضور'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTripDetails(BuildContext context, TripRecord trip, dynamic driver) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
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
            const Text(
              'تفاصيل الرحلة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (driver != null) ...[
              _detailRow('السائق', driver.fullName),
              if (driver.phone != null) _detailRow('الجوال', driver.phone!),
              if (driver.vehicleModel != null)
                _detailRow('المركبة', driver.vehicleModel!),
              if (driver.vehiclePlate != null)
                _detailRow('اللوحة', driver.vehiclePlate!),
              if (driver.vehicleColor != null)
                _detailRow('اللون', driver.vehicleColor!),
            ],
            const Divider(height: 24),
            _detailRow(
              'حالة الرحلة',
              trip.status == TripStatus.upcoming ? 'في الطريق' : 'تم الوصول',
            ),
            Row(
              children: [
                Icon(
                  trip.status == TripStatus.upcoming
                      ? Icons.directions_bus
                      : Icons.check_circle,
                  color: trip.status == TripStatus.upcoming
                      ? AppColors.warning
                      : AppColors.success,
                  size: 48,
                ),
                const SizedBox(width: 12),
                Text(
                  trip.status == TripStatus.upcoming
                      ? 'السائق في الطريق إليك'
                      : 'تم إيصال الطالب بنجاح',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(TripStatus status) {
    final isUpcoming = status == TripStatus.upcoming;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isUpcoming
            ? Colors.orange.withValues(alpha: 0.1)
            : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isUpcoming ? 'في الطريق' : 'تم الوصول',
        style: TextStyle(
          fontSize: 11,
          color: isUpcoming ? Colors.orange.shade700 : Colors.green.shade700,
        ),
      ),
    );
  }
}
