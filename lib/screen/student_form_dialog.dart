import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentFormDialog extends StatefulWidget {
  final Function(Student) onSave;

  const StudentFormDialog({super.key, required this.onSave});

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final studentIdController = TextEditingController();
  final fullNameController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final facultyController = TextEditingController();
  final departmentController = TextEditingController();
  final programmeController = TextEditingController();
  final yearController = TextEditingController();
  final semesterController = TextEditingController();
  final classController = TextEditingController();
  final admissionNumberController = TextEditingController();
  final admissionDateController = TextEditingController();

  final guardianNameController = TextEditingController();
  final guardianRelationshipController = TextEditingController();
  final guardianPhoneController = TextEditingController();
  final guardianEmailController = TextEditingController();
  final guardianAddressController = TextEditingController();

  String status = 'Active';
  bool faceRegistered = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    studentIdController.text = 'STU-${DateTime.now().millisecondsSinceEpoch}';
  }

  void saveStudent() {
    if (fullNameController.text.trim().isEmpty ||
        studentIdController.text.trim().isEmpty ||
        classController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in Student ID, Full Name, and Class'),
        ),
      );
      return;
    }

    final student = Student(
      studentId: studentIdController.text.trim(),
      fullName: fullNameController.text.trim(),
      gender: genderController.text.trim(),
      dateOfBirth: dateOfBirthController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      faculty: facultyController.text.trim(),
      department: departmentController.text.trim(),
      programme: programmeController.text.trim(),
      year: yearController.text.trim(),
      semester: semesterController.text.trim(),
      studentClass: classController.text.trim(),
      admissionNumber: admissionNumberController.text.trim(),
      admissionDate: admissionDateController.text.trim(),
      status: status,
      guardianName: guardianNameController.text.trim(),
      guardianRelationship: guardianRelationshipController.text.trim(),
      guardianPhone: guardianPhoneController.text.trim(),
      guardianEmail: guardianEmailController.text.trim(),
      guardianAddress: guardianAddressController.text.trim(),
      faceRegistered: faceRegistered,
    );

    widget.onSave(student);
    Navigator.pop(context);
  }

  void simulateFaceEnrollment() {
    setState(() {
      faceRegistered = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Face profile enrolled successfully')),
    );
  }

  @override
  void dispose() {
    tabController.dispose();

    studentIdController.dispose();
    fullNameController.dispose();
    genderController.dispose();
    dateOfBirthController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();

    facultyController.dispose();
    departmentController.dispose();
    programmeController.dispose();
    yearController.dispose();
    semesterController.dispose();
    classController.dispose();
    admissionNumberController.dispose();
    admissionDateController.dispose();

    guardianNameController.dispose();
    guardianRelationshipController.dispose();
    guardianPhoneController.dispose();
    guardianEmailController.dispose();
    guardianAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register Student'),
      content: SizedBox(
        width: 760,
        height: 560,
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(icon: Icon(Icons.person_rounded), text: 'Personal'),
                Tab(icon: Icon(Icons.school_rounded), text: 'Academic'),
                Tab(
                  icon: Icon(Icons.family_restroom_rounded),
                  text: 'Guardian',
                ),
                Tab(icon: Icon(Icons.face_rounded), text: 'AI Face'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  personalTab(),
                  academicTab(),
                  guardianTab(),
                  faceTab(),
                ],
              ),
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

  Widget personalTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildField(studentIdController, 'Student ID', Icons.badge_rounded),
          buildField(fullNameController, 'Full Name', Icons.person_rounded),
          buildField(genderController, 'Gender', Icons.wc_rounded),
          buildField(
            dateOfBirthController,
            'Date of Birth',
            Icons.cake_rounded,
          ),
          buildField(phoneController, 'Phone Number', Icons.phone_rounded),
          buildField(emailController, 'Email Address', Icons.email_rounded),
          buildField(
            addressController,
            'Residential Address',
            Icons.location_on_rounded,
          ),
        ],
      ),
    );
  }

  Widget academicTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildField(
            facultyController,
            'Faculty',
            Icons.account_balance_rounded,
          ),
          buildField(
            departmentController,
            'Department',
            Icons.business_rounded,
          ),
          buildField(
            programmeController,
            'Programme / Grade',
            Icons.menu_book_rounded,
          ),
          buildField(yearController, 'Year', Icons.timeline_rounded),
          buildField(
            semesterController,
            'Semester',
            Icons.calendar_month_rounded,
          ),
          buildField(classController, 'Class / Stream', Icons.class_rounded),
          buildField(
            admissionNumberController,
            'Admission Number',
            Icons.confirmation_number_rounded,
          ),
          buildField(
            admissionDateController,
            'Admission Date',
            Icons.date_range_rounded,
          ),
          DropdownButtonFormField<String>(
            initialValue: status,
            decoration: fieldDecoration(
              'Student Status',
              Icons.verified_user_rounded,
            ),
            items: const [
              DropdownMenuItem(value: 'Active', child: Text('Active')),
              DropdownMenuItem(value: 'Suspended', child: Text('Suspended')),
              DropdownMenuItem(value: 'Graduated', child: Text('Graduated')),
              DropdownMenuItem(
                value: 'Transferred',
                child: Text('Transferred'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                status = value ?? 'Active';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget guardianTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildField(
            guardianNameController,
            'Guardian Name',
            Icons.person_rounded,
          ),
          buildField(
            guardianRelationshipController,
            'Relationship',
            Icons.group_rounded,
          ),
          buildField(
            guardianPhoneController,
            'Guardian Phone',
            Icons.phone_rounded,
          ),
          buildField(
            guardianEmailController,
            'Guardian Email',
            Icons.email_rounded,
          ),
          buildField(
            guardianAddressController,
            'Guardian Address',
            Icons.location_on_rounded,
          ),
        ],
      ),
    );
  }

  Widget faceTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            faceRegistered
                ? 'Face Profile Registered'
                : 'No Face Profile Registered',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: faceRegistered ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'For the final version, the system will capture multiple face angles to improve recognition accuracy.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          faceStep('Look Straight', faceRegistered),
          faceStep('Look Left', faceRegistered),
          faceStep('Look Right', faceRegistered),
          faceStep('Smile / Natural Face', faceRegistered),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: simulateFaceEnrollment,
            icon: const Icon(Icons.camera_alt_rounded),
            label: const Text('Open Camera & Enroll Face'),
          ),
        ],
      ),
    );
  }

  Widget faceStep(String title, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: done ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
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
        decoration: fieldDecoration(label, icon),
      ),
    );
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF7F9FC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
