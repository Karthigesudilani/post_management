import 'package:flutter/material.dart';
import 'package:post_management/models/post.dart';
import 'package:post_management/services/api_service.dart';
import 'package:post_management/utils/enum/api_status.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  // Separate API states
  ApiStatus loadStatus = ApiStatus.initial;
  ApiStatus addStatus = ApiStatus.initial;
  ApiStatus updateStatus = ApiStatus.initial;
  ApiStatus deleteStatus = ApiStatus.initial;

  // Separate error messages
  String loadError = '';
  String addError = '';
  String updateError = '';
  String deleteError = '';

  final ApiService _apiService = ApiService();

  List<Post> get posts => _posts;

  Future<void> loadPosts() async {
    loadStatus = ApiStatus.loading;
    notifyListeners();
    try {
      _posts = await _apiService.fetchPosts();
      loadStatus = ApiStatus.success;
    } catch (e) {
      _posts = [];
      loadStatus = ApiStatus.error;
      loadError = e.toString();
    }
    notifyListeners();
  }

  Future<void> addPost(String title, String body) async {
    addStatus = ApiStatus.loading;
    notifyListeners();
    try {
      Post newPost = await _apiService.createPost(title, body);
      _posts.add(newPost);
      addStatus = ApiStatus.success;
    } catch (e) {
      addStatus = ApiStatus.error;
      addError = e.toString();
    }
    notifyListeners();
  }

  Future<void> updatePost(int id, String title, String body) async {
    updateStatus = ApiStatus.loading;
    notifyListeners();
    try {
      Post updatedPost = await _apiService.updatePost(id, title, body);
      int index = _posts.indexWhere((post) => post.id == id);
      if (index != -1) {
        _posts[index] = updatedPost;
      }
      updateStatus = ApiStatus.success;
    } catch (e) {
      updateStatus = ApiStatus.error;
      updateError = e.toString();
    }
    notifyListeners();
  }

  Future<void> deletePost(int id) async {
    deleteStatus = ApiStatus.loading;
    notifyListeners();
    try {
      await _apiService.deletePost(id);
      _posts.removeWhere((post) => post.id == id);
      deleteStatus = ApiStatus.success;
    } catch (e) {
      deleteStatus = ApiStatus.error;
      deleteError = e.toString();
    }
    notifyListeners();
  }
}
