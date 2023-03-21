import 'package:ecommerce/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/common_providers.dart';
import '../widgets/custom_snackbar.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final fullNameConttoller = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(
      authProvider,
      (previous, next) {
        if (next.isError) {
          SnackShow.showSnackbar(context, next.error, true);
        } else if (next.isSuccess) {
          SnackShow.showSnackbar(context, "Sucess", false);
        }
      },
    );
    final auth = ref.watch(authProvider);
    final isLogin = ref.watch(commonProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: form,
            child: Column(
              children: [
                const Spacer(),
                if (!isLogin)
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Filed is required";
                      }
                      return null;
                    }),
                    controller: fullNameConttoller,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Full Name",
                        border: OutlineInputBorder()),
                  ),
                SizedBox(height: 10.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Email field required";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  }),
                  controller: emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Email",
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Password field required";
                    } else if (value.length < 8) {
                      return "Password must be atleast 8 characters";
                    }
                    return null;
                  }),
                  controller: passWordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Password",
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                    onPressed: () {
                      if (isLogin) {
                        ref.read(authProvider.notifier).userLogin(
                              email: emailController.text,
                              password: passWordController.text,
                            );
                      } else {
                        ref.read(authProvider.notifier).userSignUp(
                            email: emailController.text,
                            password: passWordController.text,
                            fullName: fullNameConttoller.text);
                      }
                    },
                    child: auth.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Submit")),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin ? "Not a member? " : "Already a member? "),
                    InkWell(
                      onTap: () {
                        ref.read(commonProvider.notifier).togle();
                      },
                      child: Text(isLogin ? "Signup " : "Login "),
                    )
                  ],
                ),
                SizedBox(height: 10.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
