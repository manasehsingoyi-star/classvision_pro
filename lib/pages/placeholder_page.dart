import 'package:flutter/material.dart';
import '../widgets/module_page.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ModulePage(
      title: title,
      subtitle: subtitle,
      icon: icon,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: modulePanelDecoration(),
        child: const Text(
          'This module will be built next.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
