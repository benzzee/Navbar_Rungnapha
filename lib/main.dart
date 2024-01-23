import 'package:budbfjksbksf/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: '/home',
            page: () => const HomePage(),
            transition: Transition.zoom
            ),  
      ],
    );
  }
}
