// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/config/routes.dart';
import 'package:machine_test_practice2/core/constants/app_colors.dart';
import 'package:machine_test_practice2/core/constants/strings.dart';
import 'package:machine_test_practice2/core/widgets/custom_text_field.dart';
import 'package:machine_test_practice2/viewModels/auth_viewModel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final isObscureProvider = StateProvider<bool>((ref) => true);

  final authViewModel = AuthViewmodel();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObscure = ref.watch(isObscureProvider);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor, 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.loginTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: AppColors.primaryColor), 
              ),
              const SizedBox(height: 60),
              CustomTextField(
                controller: usernameController,
                label: Strings.usernameLabel,
                hintText: Strings.usernameHint,
                prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor), 
                validator: (value) {
                  if(value!.isEmpty) {
                    return Strings.usernameValidator;
                  }
                }
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: isObscure,
                controller: passwordController,
                label: Strings.passwordLabel,
                hintText: Strings.passwordHint,
                validator: (value) {
                  if(value!.isEmpty) {
                    return Strings.passwordValidator;
                  }
                },
                prefixIcon:
                    const Icon(Icons.lock, color: AppColors.primaryColor), 
                suffixIcon: IconButton(
                 color: AppColors.primaryColor, 
                    icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      ref.read(isObscureProvider.notifier).state = !isObscure;
                    }),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, 
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    try {
                      await authViewModel.login(
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (authViewModel.isAuthenticated) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.homePage, (route) => false);
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: const Text(
                  Strings.loginButton,
                  style: TextStyle(
                    color: AppColors.secondaryColor, 
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}