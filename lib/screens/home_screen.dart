import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/subject.dart';

import 'subject_list_screen.dart'; 

class HomeScreen extends StatelessWidget {
  final String studentName;
  final List<String> upcomingClasses = ["Math - 10:00 AM", "Physics - 12:00 PM"];


  HomeScreen({super.key, required this.studentName}); 

  @override
  Widget build(BuildContext context) {
   
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
          
            const Text(
              "Subjects",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: ValueListenableBuilder<Box<Subject>>(
               
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
                        
                        /
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ),
                        
                        
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  
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

            
            const Text(
              "Upcoming Classes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            
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
