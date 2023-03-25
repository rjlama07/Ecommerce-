import 'package:ecommerce/pages/create_product/create_product.dart';
import 'package:ecommerce/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../services/curd_services.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final productData = ref.watch(productShow);
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
      body: SafeArea(
        child: productData.when(
          data: (data) => GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridTile(
                  footer: Container(
                    color: Colors.black54,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data[index].product_name),
                        Text(data[index].price.toString())
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    child: Image.network(
                      data[index].image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              );
            },
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
