import 'package:flutter/material.dart';
import '../pages/dashboard_home.dart';
import '../widgets/sidebar.dart';
import 'students_screen.dart';
import '../pages/placeholder_page.dart';

class DashboardScreen extends StatefulWidget {
  final String institutionName;
  final String institutionType;
  final String adminName;

  const DashboardScreen({
    super.key,
    required this.institutionName,
    required this.institutionType,
    required this.adminName,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedPage = 'Dashboard';

  Widget getCurrentPage() {
    if (selectedPage == 'Students') {
      return const StudentsScreen();
    }

    if (selectedPage == 'Lecturers') {
      return const PlaceholderPage(
        title: 'Lecturers',
        subtitle:
            'Manage lecturer profiles, departments, and teaching assignments.',
        icon: Icons.person_rounded,
      );
    }

    if (selectedPage == 'Classes') {
      return const PlaceholderPage(
        title: 'Classes',
        subtitle: 'Create and manage classes, years, groups, and streams.',
        icon: Icons.class_rounded,
      );
    }

    if (selectedPage == 'Subjects') {
      return const PlaceholderPage(
        title: 'Subjects',
        subtitle: 'Manage subjects, courses, modules, and lecture units.',
        icon: Icons.menu_book_rounded,
      );
    }

    if (selectedPage == 'Timetable') {
      return const PlaceholderPage(
        title: 'Timetable',
        subtitle: 'Plan class schedules, lecturers, rooms, and lecture times.',
        icon: Icons.calendar_month_rounded,
      );
    }

    if (selectedPage == 'Face Attendance') {
      return const PlaceholderPage(
        title: 'Face Attendance',
        subtitle:
            'Start class sessions and scan students using AI face recognition.',
        icon: Icons.camera_alt_rounded,
      );
    }

    if (selectedPage == 'Examination') {
      return const PlaceholderPage(
        title: 'Examination',
        subtitle: 'Manage assessments, exams, marks, and performance reports.',
        icon: Icons.assignment_rounded,
      );
    }

    if (selectedPage == 'Fees') {
      return const PlaceholderPage(
        title: 'Fees',
        subtitle: 'Track fee balances, payments, invoices, and receipts.',
        icon: Icons.payments_rounded,
      );
    }

    if (selectedPage == 'Reports') {
      return const PlaceholderPage(
        title: 'Reports',
        subtitle:
            'Generate attendance, academic, finance, and administration reports.',
        icon: Icons.analytics_rounded,
      );
    }

    if (selectedPage == 'MS Dashboard') {
      return const PlaceholderPage(
        title: 'MS Dashboard',
        subtitle:
            'Sync this institution with the MS Tech dashboard and cloud services.',
        icon: Icons.cloud_sync_rounded,
      );
    }

    if (selectedPage == 'Settings') {
      return const PlaceholderPage(
        title: 'Settings',
        subtitle:
            'Configure institution profile, users, permissions, and system options.',
        icon: Icons.settings_rounded,
      );
    }

    return DashboardHome(
      institutionName: widget.institutionName,
      institutionType: widget.institutionType,
      adminName: widget.adminName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Column(
        children: [
          TopBar(
            institutionName: widget.institutionName,
            adminName: widget.adminName,
          ),
          Expanded(
            child: Row(
              children: [
                Sidebar(
                  selectedPage: selectedPage,
                  onMenuSelected: (page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: getCurrentPage(),
                  ),
                ),
              ],
            ),
          ),
          const StatusBar(),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final String institutionName;
  final String adminName;

  const TopBar({
    super.key,
    required this.institutionName,
    required this.adminName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.school_rounded, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            institutionName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded),
          const SizedBox(width: 18),
          const Icon(Icons.search_rounded),
          const SizedBox(width: 18),
          Text(adminName.isEmpty ? 'Administrator' : adminName),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            child: Icon(Icons.person_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFF0F172A),
      child: const Row(
        children: [
          Icon(Icons.storage_rounded, color: Colors.white70, size: 16),
          SizedBox(width: 8),
          Text(
            'Local Database: Ready',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(width: 24),
          Icon(Icons.cloud_sync_rounded, color: Colors.white70, size: 16),
          SizedBox(width: 8),
          Text(
            'MS Dashboard: Not synced',
            style: TextStyle(color: Colors.white70),
          ),
          Spacer(),
          Text(
            'ClassVision Pro • Powered by MS Tech Solutions',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
