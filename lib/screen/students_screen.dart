import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/module_page.dart';
import 'student_form_dialog.dart';
import 'student_profile_dialog.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final searchController = TextEditingController();
  final List<Student> students = [];
  String searchText = '';

  List<Student> get filteredStudents {
    if (searchText.isEmpty) return students;

    final text = searchText.toLowerCase();
    return students.where((student) {
      return student.fullName.toLowerCase().contains(text) ||
          student.studentId.toLowerCase().contains(text) ||
          student.studentClass.toLowerCase().contains(text) ||
          student.programme.toLowerCase().contains(text);
    }).toList();
  }

  void openRegisterDialog() {
    showDialog(
      context: context,
      builder: (_) => StudentFormDialog(
        onSave: (student) {
          setState(() {
            students.add(student);
          });
        },
      ),
    );
  }

  void deleteStudent(Student student) {
    setState(() {
      students.remove(student);
    });
  }

  void registerFace(Student student) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Face registration for ${student.fullName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleStudents = filteredStudents;

    return ModulePage(
      title: 'Students',
      subtitle:
          'Manage learners, classes, guardian details, and face profiles.',
      icon: Icons.groups_rounded,
      action: ElevatedButton.icon(
        onPressed: openRegisterDialog,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Register Student'),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: modulePanelDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by name, ID, class, or program',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: const Color(0xFFF7F9FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${visibleStudents.length} record(s)',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            decoration: modulePanelDecoration(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 50, child: Text('Photo')),
                      Expanded(flex: 2, child: Text('Student Name')),
                      Expanded(child: Text('Student ID')),
                      Expanded(child: Text('Class')),
                      Expanded(child: Text('Program')),
                      Expanded(child: Text('Face')),
                      Expanded(child: Text('Status')),
                      SizedBox(width: 190, child: Text('Actions')),
                    ],
                  ),
                ),

                if (visibleStudents.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'No students found. Click "Register Student" to add one.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  ...visibleStudents.map((student) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.15),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: CircleAvatar(
                              radius: 17,
                              child: Icon(Icons.person_rounded, size: 18),
                            ),
                          ),
                          Expanded(flex: 2, child: Text(student.fullName)),
                          Expanded(child: Text(student.studentId)),
                          Expanded(child: Text(student.studentClass)),
                          Expanded(
                            child: Text(
                              student.programme.isEmpty
                                  ? '-'
                                  : student.programme,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              student.faceRegistered
                                  ? 'Registered'
                                  : 'Not Registered',
                              style: TextStyle(
                                color: student.faceRegistered
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              student.status,
                              style: TextStyle(
                                color: student.status == 'Active'
                                    ? Colors.green
                                    : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: Row(
                              children: [
                                IconButton(
                                  tooltip: 'View Profile',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => StudentProfileDialog(
                                        student: student,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.visibility_rounded),
                                ),
                                IconButton(
                                  tooltip: 'Register Face',
                                  onPressed: () => registerFace(student),
                                  icon: const Icon(Icons.face_rounded),
                                ),
                                IconButton(
                                  tooltip: 'Edit',
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit_rounded),
                                ),
                                IconButton(
                                  tooltip: 'Delete',
                                  onPressed: () => deleteStudent(student),
                                  icon: const Icon(Icons.delete_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
