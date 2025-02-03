// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:machine_test_practice2/core/constants/app_colors.dart';
import 'package:machine_test_practice2/core/widgets/custom_dialog.dart';
import 'package:machine_test_practice2/core/widgets/loader.dart';
import 'package:machine_test_practice2/core/widgets/snackbar.dart';
import 'package:machine_test_practice2/viewModels/auth_viewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine_test_practice2/viewModels/post_viewModel.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final postViewModel = ref.watch(postProvider);

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
                        onPressed: () async {
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
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: currentIndex == 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: AppColors.secondaryColor, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "Username: ${ref.watch(authProvider).username}"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: AppColors.secondaryColor, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "AccessToken: ${ref.watch(authProvider).accessToken}"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : postViewModel.isLoading
              ? const Loader()
              : ListView.builder(
                  itemCount: postViewModel.posts.length,
                  itemBuilder: (context, index) {
                    final post = postViewModel.posts[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: AppColors.secondaryColor, width: 2)),
                      child: ListTile(
                        title: Text(
                          post.title.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(post.body.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(
                            post.id.toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(currentIndexProvider.notifier).update((state) => index);
            if (index == 1) {
              ref.read(postProvider.notifier).getAllPosts();
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Posts"),
          ]),
    );
  }
}
