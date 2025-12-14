import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import necessary files:
import 'models/subject.dart'; 
import 'screens/main_navigation_screen.dart'; // The new navigation structure

void main() async {
  // Ensure that Flutter is initialized before running any code that needs it (like Hive)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register the adapter for the Subject class
  await Hive.initFlutter();
  // Ensure you have run 'flutter packages pub run build_runner build' at least once
  Hive.registerAdapter(SubjectAdapter());

  // Open the box that stores the subjects
  final subjectBox = await Hive.openBox<Subject>('subjects');

  // Logic to auto-populate if the box is empty (Optional but useful for testing)
  if (subjectBox.isEmpty) {
    print("No subjects found. Populating default list...");

    // Default subjects list
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

  // Run the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Planner', // Updated title
      theme: ThemeData(primarySwatch: Colors.blue),
      
      // 🎯 CRITICAL CHANGE: MainNavigationScreen is set as the app's starting point
      home: const MainNavigationScreen(studentName: "Tushita Kohli"), 
      
      debugShowCheckedModeBanner: false,
    );
  }
}