import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/config/routes.dart';
import 'package:machine_test_practice2/viewModels/auth_viewModel.dart';
import 'package:machine_test_practice2/views/home_page.dart';
import 'package:machine_test_practice2/views/login_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final authViewModel = ref.watch(authProvider);

   if (!authViewModel.isInitialised) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: Routes.route,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: authViewModel.isAuthenticated ? const HomePage() : const LoginPage(),
      home: const HomePage(),
    );
  }
}
