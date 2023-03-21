import 'package:ecommerce/pages/create_product/create_product.dart';
import 'package:ecommerce/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.post_add),
              title: const Text('Add Product'),
              onTap: () => Get.to(CreatePost()),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => ref.read(authProvider.notifier).userLogout(),
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: const Text("Logout")),
      ),
    );
  }
}
