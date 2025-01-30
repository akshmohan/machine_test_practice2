import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/core/constants/app_colors.dart';
import 'package:machine_test_practice2/core/constants/strings.dart';
import 'package:machine_test_practice2/core/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isObscureProvier = StateProvider<bool>((ref) => true);

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  final isObscure = ref.watch(isObscureProvier);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              prefixIcon: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              obscureText: isObscure,
              controller: passwordController,
              label: Strings.passwordLabel,
              hintText: Strings.passwordHint,
              prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
              suffixIcon: IconButton(
                color: AppColors.primaryColor,
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  ref.read(isObscureProvier.notifier).state = !isObscure;
                }
              ),
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
              onPressed: () {},
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
    );
  }
}
