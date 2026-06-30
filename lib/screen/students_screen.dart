import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/module_page.dart';

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
                      Expanded(child: Text('Status')),
                      SizedBox(width: 160, child: Text('Actions')),
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
                              student.programme.isEmpty ? '-' : student.programme,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Active',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            child: Row(
                              children: [
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

class StudentFormDialog extends StatefulWidget {
  final Function(Student) onSave;

  const StudentFormDialog({super.key, required this.onSave});

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog> {
  final fullNameController = TextEditingController();
  final studentIdController = TextEditingController();
  final classController = TextEditingController();
  final programController = TextEditingController();
  final guardianPhoneController = TextEditingController();

  void saveStudent() {
    if (fullNameController.text.trim().isEmpty ||
        studentIdController.text.trim().isEmpty ||
        classController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in name, student ID, and class'),
        ),
      );
      return;
    }

    widget.onSave(
      Student(
        studentId: studentIdController.text.trim(),
        fullName: fullNameController.text.trim(),
        gender: '',
        dateOfBirth: '',
        phone: '',
        email: '',
        address: '',
        faculty: '',
        department: '',
        programme: programController.text.trim(),
        year: '',
        semester: '',
        studentClass: classController.text.trim(),
        admissionNumber: '',
        admissionDate: '',
        status: 'Active',
        guardianName: '',
        guardianRelationship: '',
        guardianPhone: guardianPhoneController.text.trim(),
        guardianEmail: '',
        guardianAddress: '',
        faceRegistered: false,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register Student'),
      content: SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildField(fullNameController, 'Full Name', Icons.person_rounded),
            buildField(studentIdController, 'Student ID', Icons.badge_rounded),
            buildField(classController, 'Class / Year', Icons.class_rounded),
            buildField(
              programController,
              'Program / Grade',
              Icons.school_rounded,
            ),
            buildField(
              guardianPhoneController,
              'Guardian Phone',
              Icons.phone_rounded,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: saveStudent,
          icon: const Icon(Icons.save_rounded),
          label: const Text('Save Student'),
        ),
      ],
    );
  }

  Widget buildField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
