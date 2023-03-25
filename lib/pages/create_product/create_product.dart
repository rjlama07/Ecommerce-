import 'dart:io';
import 'package:ecommerce/providers/auth_providers.dart';
import 'package:ecommerce/providers/common_providers.dart';
import 'package:ecommerce/providers/curd_provider.dart';
import 'package:ecommerce/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/curd_services.dart';

class CreatePost extends ConsumerWidget {
  CreatePost({super.key});
  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();

  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    final image = ref.watch(imageProvider);
    final crudProviders = ref.watch(curdProvider);
    ref.listen(
      curdProvider,
      (previous, next) {
        if (next.isError) {
          SnackShow.showSnackbar(context, next.error, true);
        } else if (next.isSuccess) {
          ref.invalidate(productShow);
          SnackShow.showSnackbar(context, "Sucessfully added Product", false);
          Get.back();
        }
      },
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                controller: nameController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please Provider title";
                  }
                  return null;
                }),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    hintText: "Product name",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Details field required";
                  }
                  return null;
                }),
                controller: detailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.details),
                    hintText: "Product Details",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Details field required";
                  }
                  return null;
                }),
                controller: priceController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.details),
                    hintText: "Price",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: "Select",
                      content: const Text("Select an image"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(imageProvider.notifier).imagePick(true);
                            },
                            child: const Text("Camera")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref.read(imageProvider.notifier).imagePick(false);
                            },
                            child: const Text("Gallery"))
                      ]);
                },
                child: Container(
                    height: 80.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: image != null
                        ? Image.file(File(image.path))
                        : const Center(
                            child: Text("Upload Image"),
                          )),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (image != null) {
                      if (form.currentState!.validate()) {
                        ref.read(curdProvider.notifier).productCreate(
                            productName: nameController.text,
                            prodctDetail: detailController.text,
                            price: int.parse(priceController.text),
                            image: image,
                            token: ref.watch(authProvider).users[0].token);
                      }
                    } else {
                      SnackShow.showSnackbar(
                          context, "Please select a image", true);
                    }
                  },
                  child: crudProviders.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit")),
              SizedBox(
                height: 6.h,
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
