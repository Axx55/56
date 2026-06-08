import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/themes/app_colors.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(ImageSource) onPick;

  const ImagePickerDialog({super.key, required this.onPick});

  static Future<void> show(
    BuildContext context,
    Function(ImageSource) onPick,
  ) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ImagePickerDialog(onPick: onPick),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              _buildOption(
                context,
                icon: Icons.camera_alt,
                label: 'كاميرا',
                source: ImageSource.camera,
              ),
              _buildOption(
                context,
                icon: Icons.photo_library,
                label: 'المعرض',
                source: ImageSource.gallery,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onPick(source);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
            child: Icon(icon, size: 32, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
