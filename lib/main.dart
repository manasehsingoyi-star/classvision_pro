import 'package:flutter/material.dart';
import 'screen/institution_setup_screen.dart';

void main() {
  runApp(const ClassVisionApp());
}

class ClassVisionApp extends StatelessWidget {
  const ClassVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClassVision Pro',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const InstitutionSetupScreen(),
    );
  }
}
