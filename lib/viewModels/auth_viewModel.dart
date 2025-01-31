// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/models/user_model.dart';
import 'package:machine_test_practice2/repositories/auth_repository.dart';

class AuthViewmodel with ChangeNotifier {
  UserModel? _user;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    try {


      final _authRepo = AuthRepository();
      final result = await _authRepo.login(username, password);

      _isAuthenticated = true;
      _user = UserModel.fromJson(result);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

final authProvider =
    ChangeNotifierProvider<AuthViewmodel>((ref) => AuthViewmodel());
