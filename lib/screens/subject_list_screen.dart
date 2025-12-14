import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/subject.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({super.key});

  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  
  late final Box<Subject> subjectBox;

  @override
  void initState() {
    super.initState();
    
    subjectBox = Hive.box<Subject>('subjects');
  }

  void incrementAttendance(int index) {
    /
    final subject = subjectBox.getAt(index)!;

    
    subject.attended += 1;
    subject.total += 1;

    
    subjectBox.putAt(index, subject);
  }

 
  void decrementAttendance(int index) {
    final subject = subjectBox.getAt(index)!;

  
    subject.total += 1;

    subjectBox.putAt(index, subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Attendance"),
        
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Subject>>(
       
        valueListenable: subjectBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No subjects found. Add them first!",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final subject = box.getAt(index)!;
              final percent = subject.attendancePercentage;
              
              final color = percent < 75 ? Colors.red.shade600 : Colors.green.shade600;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    subject.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                      "Professor: ${subject.professor}\nCode: ${subject.code}"),
                  
               
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color, width: 1.5)
                    ),
                    child: Text(
                      "${percent.toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w900,
                        fontSize: 16
                      ),
                    ),
                  ),

                 
                  onTap: () {
                  
                    _showTrackingDialog(context, index, subject);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
  

  void _showTrackingDialog(BuildContext context, int index, Subject subject) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(subject.name),
          content: Text("Did you attend or miss the last class?"),
          actions: [
            TextButton(
              onPressed: () {
                decrementAttendance(index);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${subject.name}: Marked Absent (+1 total).")),
                );
              },
              child: const Text("Missed (Absent)", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                incrementAttendance(index); 
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${subject.name}: Marked Present (+1 attended).")),
                );
              },
              child: const Text("Attended (Present)"),
            ),
          ],
        );
      },
    );
  }
}
