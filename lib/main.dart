import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/app_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const AppShell(),
    );
  }
}
