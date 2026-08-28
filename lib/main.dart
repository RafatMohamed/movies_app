import 'package:flutter/material.dart';

import 'core/utilities/app_them.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppThem.darkThem,
      themeMode: .dark,
    );
  }
}
