import 'package:ecommerce/pages/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import 'models/users.dart';

final box = Provider<List<Users>>((ref) => []);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UsersAdapter());
  final userBox = await Hive.openBox<Users>("users");
  runApp(ProviderScope(
      overrides: [box.overrideWithValue(userBox.values.toList())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(932, 430),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme:
                const AppBarTheme().copyWith(foregroundColor: Colors.white)),
        home: const StatusPage(),
      ),
    );
  }
}
