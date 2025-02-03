// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:machine_test_practice2/core/widgets/custom_dialog.dart';
import 'package:machine_test_practice2/core/widgets/snackbar.dart';
import 'package:machine_test_practice2/viewModels/auth_viewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
  

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.brightness_6)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      title: "Logout",
                      content: "Are you sure you want to logout?",
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () async{
                            await ref.read(authProvider.notifier).logout();

                            Navigator.of(context).pop();

                            showSnackbar("Logged out Successfully!", context);

                            Navigator.pushNamedAndRemoveUntil(
                                context, "/login", (route) => false);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
