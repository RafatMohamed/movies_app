import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_text.dart';

import 'core/utilities/app_them.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
  TextTheme textStyle= Theme.of(context).textTheme;
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppThem.darkThem,
      themeMode: .dark,
      home: Scaffold(
        body: Text(
          AppText.title,
          style:textStyle.titleLarge,
        ),
      ),
    );
  }
}
