class Student {
  final String studentId;
  final String fullName;
  final String gender;
  final String dateOfBirth;
  final String phone;
  final String email;
  final String address;

  final String faculty;
  final String department;
  final String programme;
  final String year;
  final String semester;
  final String studentClass;
  final String admissionNumber;
  final String admissionDate;
  final String status;

  final String guardianName;
  final String guardianRelationship;
  final String guardianPhone;
  final String guardianEmail;
  final String guardianAddress;

  final bool faceRegistered;

  Student({
    required this.studentId,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.address,
    required this.faculty,
    required this.department,
    required this.programme,
    required this.year,
    required this.semester,
    required this.studentClass,
    required this.admissionNumber,
    required this.admissionDate,
    required this.status,
    required this.guardianName,
    required this.guardianRelationship,
    required this.guardianPhone,
    required this.guardianEmail,
    required this.guardianAddress,
    required this.faceRegistered,
  });
}
