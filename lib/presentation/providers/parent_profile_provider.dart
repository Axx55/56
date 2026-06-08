import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/parent.dart';
import '../../domain/repositories/parent_repository.dart';

class ParentProfileProvider extends ChangeNotifier {
  final ParentRepository _repository;
  final SupabaseClient _supabase;
  Parent? _profile;
  bool _isLoading = false;
  String? _error;

  ParentProfileProvider(this._repository, this._supabase);

  Parent? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _profile = await _repository.getParentByUserId(userId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(Parent parent) async {
    try {
      _profile = await _repository.updateParent(parent);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<String?> updateAvatar(String userId, String imagePath) async {
    try {
      final fileExt = imagePath.split('.').last;
      final filePath = 'avatars/$userId.$fileExt';
      await _supabase.storage.from('avatars').upload(filePath, File(imagePath));
      final url = _supabase.storage.from('avatars').getPublicUrl(filePath);
      await _repository.updateParent(
        Parent(
          id: _profile!.id,
          userId: userId,
          fullName: _profile!.fullName,
          avatarUrl: url,
        ),
      );
      _profile = Parent(
        id: _profile!.id,
        userId: userId,
        fullName: _profile!.fullName,
        avatarUrl: url,
      );
      notifyListeners();
      return url;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
