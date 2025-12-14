import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/subject.dart'; 
import 'screens/main_navigation_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SubjectAdapter());
  final subjectBox = await Hive.openBox<Subject>('subjects');

  if (subjectBox.isEmpty) {
    print("No subjects found. Populating default list...");

    
    subjectBox.addAll([
      Subject(
        name: "Differential Calculus",
        code: "MATH101",
        professor: "Dr. A. Sharma",
        attended: 10,
        total: 12,
      ),
      Subject(
        name: "Data Structures & Algorithms",
        code: "CS205",
        professor: "Prof. S. Iyer",
        attended: 8,
        total: 10,
      ),
      Subject(
        name: "Digital Logic Design",
        code: "ECE210",
        professor: "Ms. P. Singh",
        attended: 15,
        total: 18,
      ),
    ]);
  }

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainNavigationScreen(studentName: "Tushita Kohli"), 
      
      debugShowCheckedModeBanner: false,
    );
  }
}
