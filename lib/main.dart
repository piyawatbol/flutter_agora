import 'package:flutter/material.dart';
import 'package:flutter_agora_app/screens/splash/splash_screen.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.kanitTextTheme()),
      getPages: AppRoutes.getPages,
      home: SplachScreen(),
    );
  }
}
