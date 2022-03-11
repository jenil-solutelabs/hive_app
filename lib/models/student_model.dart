import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final String firstname;
  @HiveField(1)
  final String lastname;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;
  @HiveField(5)
  final String date;
  @HiveField(6)
  final String grade;
  @HiveField(7)
  final bool status;
  Student(
      {required this.firstname,
      required this.lastname,
      required this.username,
      required this.email,
      required this.password,
      required this.date,
      required this.grade,
      required this.status});
}
