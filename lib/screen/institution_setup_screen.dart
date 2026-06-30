import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class InstitutionSetupScreen extends StatefulWidget {
  const InstitutionSetupScreen({super.key});

  @override
  State<InstitutionSetupScreen> createState() => _InstitutionSetupScreenState();
}

class _InstitutionSetupScreenState extends State<InstitutionSetupScreen> {
  final schoolNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final adminNameController = TextEditingController();

  String institutionType = 'School';

  @override
  void dispose() {
    schoolNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    adminNameController.dispose();
    super.dispose();
  }

  void continueToDashboard() {
    if (schoolNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the institution name')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardScreen(
          institutionName: schoolNameController.text.trim(),
          institutionType: institutionType,
          adminName: adminNameController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Center(
        child: Container(
          width: 620,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.school_rounded, size: 70, color: Colors.blue),
                const SizedBox(height: 12),
                const Text(
                  'ClassVision Pro',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Set up your school or university profile',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),

                buildTextField(
                  controller: schoolNameController,
                  label: 'School / University Name',
                  icon: Icons.account_balance_rounded,
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: institutionType,
                  decoration: inputDecoration(
                    label: 'Institution Type',
                    icon: Icons.category_rounded,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'School', child: Text('School')),
                    DropdownMenuItem(value: 'College', child: Text('College')),
                    DropdownMenuItem(
                      value: 'University',
                      child: Text('University'),
                    ),
                    DropdownMenuItem(
                      value: 'Training Centre',
                      child: Text('Training Centre'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      institutionType = value ?? 'School';
                    });
                  },
                ),

                const SizedBox(height: 16),

                buildTextField(
                  controller: addressController,
                  label: 'Address',
                  icon: Icons.location_on_rounded,
                ),

                const SizedBox(height: 16),

                buildTextField(
                  controller: phoneController,
                  label: 'Contact Number',
                  icon: Icons.phone_rounded,
                ),

                const SizedBox(height: 16),

                buildTextField(
                  controller: emailController,
                  label: 'Email Address',
                  icon: Icons.email_rounded,
                ),

                const SizedBox(height: 16),

                buildTextField(
                  controller: adminNameController,
                  label: 'Administrator Name',
                  icon: Icons.person_rounded,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: continueToDashboard,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text(
                      'Continue to Dashboard',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Powered by MS Tech Solutions',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: inputDecoration(label: label, icon: icon),
    );
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
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
