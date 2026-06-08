import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/themes/app_colors.dart';

class UserAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? fullName;
  final double size;
  final bool isEditable;
  final VoidCallback? onTap;

  const UserAvatarWidget({
    super.key,
    this.imageUrl,
    this.fullName,
    this.size = 80,
    this.isEditable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEditable ? onTap : null,
      child: Stack(
        children: [
          CircleAvatar(
            radius: size / 2,
            backgroundColor: AppColors.primaryLight,
            backgroundImage: imageUrl != null
                ? CachedNetworkImageProvider(imageUrl!)
                : null,
            child: imageUrl == null
                ? Text(
                    _getInitials(),
                    style: TextStyle(
                      fontSize: size * 0.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          if (isEditable)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getInitials() {
    if (fullName == null || fullName!.isEmpty) return '?';
    final parts = fullName!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return parts[0][0];
  }
}
