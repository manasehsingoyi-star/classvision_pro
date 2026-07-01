import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentProfileDialog extends StatelessWidget {
  final Student student;

  const StudentProfileDialog({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(student.fullName),
      content: SizedBox(
        width: 760,
        height: 520,
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_rounded), text: 'Personal'),
                  Tab(icon: Icon(Icons.school_rounded), text: 'Academic'),
                  Tab(
                    icon: Icon(Icons.check_circle_rounded),
                    text: 'Attendance',
                  ),
                  Tab(icon: Icon(Icons.payments_rounded), text: 'Fees'),
                  Tab(icon: Icon(Icons.face_rounded), text: 'AI Face'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    profileTab([
                      detailRow('Student ID', student.studentId),
                      detailRow('Full Name', student.fullName),
                      detailRow('Gender', student.gender),
                      detailRow('Date of Birth', student.dateOfBirth),
                      detailRow('Phone', student.phone),
                      detailRow('Email', student.email),
                      detailRow('Address', student.address),
                    ]),
                    profileTab([
                      detailRow('Faculty', student.faculty),
                      detailRow('Department', student.department),
                      detailRow('Programme', student.programme),
                      detailRow('Year', student.year),
                      detailRow('Semester', student.semester),
                      detailRow('Class', student.studentClass),
                      detailRow('Admission Number', student.admissionNumber),
                      detailRow('Admission Date', student.admissionDate),
                      detailRow('Status', student.status),
                    ]),
                    profileTab([
                      detailRow('Attendance Percentage', '0%'),
                      detailRow('Present Sessions', '0'),
                      detailRow('Absent Sessions', '0'),
                      detailRow('Last Attendance', 'No record yet'),
                    ]),
                    profileTab([
                      detailRow('Fee Status', 'Not connected yet'),
                      detailRow('Total Fees', 'K0.00'),
                      detailRow('Paid', 'K0.00'),
                      detailRow('Balance', 'K0.00'),
                    ]),
                    profileTab([
                      detailRow(
                        'Face Profile',
                        student.faceRegistered
                            ? 'Registered'
                            : 'Not Registered',
                      ),
                      detailRow(
                        'Enrollment Quality',
                        student.faceRegistered ? 'Good' : 'Pending',
                      ),
                      detailRow('Last Face Update', 'No update yet'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_rounded),
          label: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget profileTab(List<Widget> children) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 190,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
