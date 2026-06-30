import 'package:flutter/material.dart';

class DashboardHome extends StatelessWidget {
  final String institutionName;
  final String institutionType;
  final String adminName;

  const DashboardHome({
    super.key,
    required this.institutionName,
    required this.institutionType,
    required this.adminName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          institutionName,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Powered by ClassVision Pro School Management System',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 28),

        const Row(
          children: [
            DashboardCard(
              title: 'Total Students',
              value: '0',
              icon: Icons.groups_rounded,
            ),
            DashboardCard(
              title: 'Present Today',
              value: '0',
              icon: Icons.check_circle_rounded,
            ),
            DashboardCard(
              title: 'Absent Today',
              value: '0',
              icon: Icons.cancel_rounded,
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              flex: 2,
              child: Panel(
                title: 'Current Attendance Session',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoRow('Register Class', 'No class selected'),
                    infoRow('Subject / Lecture', 'No subject selected'),
                    infoRow(
                      'Lecturer',
                      adminName.isEmpty ? 'Administrator' : adminName,
                    ),
                    infoRow('Classroom', 'Not selected'),
                    const SizedBox(height: 30),
                    const Text(
                      'AI Face Attendance Scanner',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Start a class session, scan the whole classroom, mark detected students present, and automatically identify absentees.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.play_arrow_rounded),
                      label: Text('Start Attendance Session'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Panel(
                title: 'System Status',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusRow(
                      icon: Icons.camera_alt_rounded,
                      label: 'Camera',
                      status: 'Not connected',
                    ),
                    StatusRow(
                      icon: Icons.cloud_sync_rounded,
                      label: 'MS Dashboard',
                      status: 'Not synced',
                    ),
                    StatusRow(
                      icon: Icons.storage_rounded,
                      label: 'Local Database',
                      status: 'Ready',
                    ),
                    StatusRow(
                      icon: Icons.lock_rounded,
                      label: 'License Status',
                      status: 'Trial Mode',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 125,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(22),
        decoration: panelDecoration(),
        child: Row(
          children: [
            Icon(icon, size: 38, color: Colors.blue),
            const SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(title, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const Panel({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;

  const StatusRow({
    super.key,
    required this.icon,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          Text(status, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

Widget infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

BoxDecoration panelDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
  );
}
