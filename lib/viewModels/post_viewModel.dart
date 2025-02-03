// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/models/post_model.dart';
import 'package:machine_test_practice2/repositories/post_repostiory.dart';

class PostViewmodel with ChangeNotifier {
  final PostRepostiory _postRepostiory;

  PostViewmodel(this._postRepostiory);

  List<PostModel> _posts = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> getAllPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _postRepostiory.fetchPosts();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

final postProvider = ChangeNotifierProvider<PostViewmodel>((ref) {
  final postRepostiory = PostRepostiory();
  return PostViewmodel(postRepostiory);
});
