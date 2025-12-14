import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String code;

  @HiveField(2)
  String professor;

  @HiveField(3)
  int attended;

  @HiveField(4)
  int total;

  Subject({
    required this.name,
    required this.code,
    required this.professor,
    required this.attended,
    required this.total,
  });

  double get attendancePercentage {
    if (total == 0) return 0;
    return (attended / total) * 100;
  }
}
