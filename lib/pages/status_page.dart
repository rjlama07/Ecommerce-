import 'package:ecommerce/pages/homepage/homepage.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body:
          Center(child: auth.users.isNotEmpty ? const HomePage() : LoginPage()),
    );
  }
}
