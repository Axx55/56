import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AvatarService {
  final SupabaseClient _supabase;
  final ImagePicker _picker = ImagePicker();

  AvatarService(this._supabase);

  Future<XFile?> pickImage(ImageSource source) async {
    return _picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
  }

  Future<String?> uploadAvatar(String userId, File imageFile) async {
    final fileExt = imageFile.path.split('.').last;
    final filePath = 'avatars/$userId.$fileExt';
    await _supabase.storage.from('avatars').upload(filePath, imageFile);
    final url = _supabase.storage.from('avatars').getPublicUrl(filePath);
    return url;
  }

  Future<void> deleteAvatar(String path) async {
    await _supabase.storage.from('avatars').remove([path]);
  }
}
