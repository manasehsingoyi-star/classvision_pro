import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String selectedPage;
  final Function(String) onMenuSelected;

  const Sidebar({
    super.key,
    required this.selectedPage,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF0F172A),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.visibility_rounded, color: Colors.white, size: 42),
            const SizedBox(height: 14),
            const Text(
              'ClassVision Pro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            menuItem(Icons.dashboard_rounded, 'Dashboard'),
            menuItem(Icons.groups_rounded, 'Students'),
            menuItem(Icons.person_rounded, 'Lecturers'),
            menuItem(Icons.class_rounded, 'Classes'),
            menuItem(Icons.menu_book_rounded, 'Subjects'),
            menuItem(Icons.calendar_month_rounded, 'Timetable'),
            menuItem(Icons.camera_alt_rounded, 'Face Attendance'),
            menuItem(Icons.assignment_rounded, 'Examination'),
            menuItem(Icons.payments_rounded, 'Fees'),
            menuItem(Icons.analytics_rounded, 'Reports'),
            menuItem(Icons.cloud_sync_rounded, 'MS Dashboard'),
            const SizedBox(height: 30),
            menuItem(Icons.settings_rounded, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title) {
    final isSelected = selectedPage == title;

    return InkWell(
      onTap: () => onMenuSelected(title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
