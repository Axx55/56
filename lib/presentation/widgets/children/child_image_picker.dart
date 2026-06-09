import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';

class ChildImagePicker extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPick;

  const ChildImagePicker({super.key, this.imagePath, required this.onPick});

  Widget _buildImage(String path) {
    if (kIsWeb) {
      return const Icon(Icons.image, size: 48, color: AppColors.textHint);
    }
    return Image.file(File(path), fit: BoxFit.cover, width: 120, height: 120);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: AppColors.border),
        ),
        child: imagePath != null
            ? ClipOval(child: _buildImage(imagePath!))
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 32, color: AppColors.textHint),
                  SizedBox(height: 4),
                  Text(
                    'إضافة صورة',
                    style: TextStyle(fontSize: 12, color: AppColors.textHint),
                  ),
                ],
              ),
      ),
    );
  }
}
