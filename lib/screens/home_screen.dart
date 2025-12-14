import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/subject.dart';
// Import the screen you navigate to for tracking attendance
import 'subject_list_screen.dart'; 

class HomeScreen extends StatelessWidget {
  final String studentName;
  // Static data for upcoming classes
  final List<String> upcomingClasses = ["Math - 10:00 AM", "Physics - 12:00 PM"];

  // Const constructor is possible because all fields are final
  HomeScreen({super.key, required this.studentName}); 

  @override
  Widget build(BuildContext context) {
    // 1. Get the correct Hive box (named 'subjects')
    final Box<Subject> subjectBox = Hive.box<Subject>('subjects');

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $studentName"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SUBJECTS LIST SECTION ---
            const Text(
              "Subjects",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: ValueListenableBuilder<Box<Subject>>(
                // 2. Listen to the correct Hive box
                valueListenable: subjectBox.listenable(),
                builder: (context, box, _) {
                  if (box.isEmpty) {
                    return const Center(child: Text("No subjects added yet."));
                  }
                  
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final subject = box.getAt(index)!;
                      final percent = subject.attendancePercentage;
                      final attendanceColor = percent < 75 ? Colors.red.shade600 : Colors.green.shade600;

                      return ListTile(
                        title: Text(subject.name),
                        subtitle: Text(
                            "Attendance: ${subject.attended}/${subject.total} (${percent.toStringAsFixed(2)}%)",
                            style: TextStyle(color: attendanceColor),
                        ),
                        
                        // 3. Trailing icon
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ),
                        
                        // 🎯 CRITICAL: onTap to navigate to the interactive tracking screen
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // Navigates to the screen with the attendance buttons
                                  builder: (context) => const SubjectListScreen(), 
                              ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),

            // --- UPCOMING CLASSES SECTION ---
            const Text(
              "Upcoming Classes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Display static upcoming classes
            ...upcomingClasses.map((c) => ListTile(
                leading: const Icon(Icons.schedule, color: Colors.blueGrey),
                title: Text(c),
            )),
          ],
        ),
      ),
    );
  }
}