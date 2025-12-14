import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/subject.dart'; 

class DashboardScreen extends StatelessWidget {

  final String studentName = "Tushita Kohli";
  final String studentID = "22BCE1234";
  final String program = "B.Tech Computer Science";
  final String campus = "Main Campus, Vellore";

  DashboardScreen({Key? key}) : super(key: key);

  double _calculateOverallAttendance(Box<Subject> box) {
    if (box.isEmpty) return 0.0;
    
    int totalAttended = 0;
    int totalClasses = 0;
    
    for (var subject in box.values) {
      totalAttended += subject.attended;
      totalClasses += subject.total;
    }

    if (totalClasses == 0) return 0.0;
    return (totalAttended / totalClasses) * 100;
  }
-
  @override
  Widget build(BuildContext context) {
  
    final Box<Subject> subjectBox = Hive.box<Subject>('subjects');

    return Scaffold(
      appBar: AppBar(title: const Text("Student Dashboard")),
      body: ValueListenableBuilder<Box<Subject>>(
        valueListenable: subjectBox.listenable(),
        builder: (context, box, _) {
          
          final overallAttendance = _calculateOverallAttendance(box);
          final attendanceColor = overallAttendance < 75 ? Colors.red : Colors.green;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              
              _buildDashboardCard(
                icon: Icons.access_time_filled,
                title: "Overall Attendance",
                content: Text(
                  "${overallAttendance.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: attendanceColor,
                  ),
                ),
              ),

              const SizedBox(height: 20),

             
              _buildSectionTitle(context, "Student Credentials"),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCredentialRow("Name", studentName, Icons.person),
                      _buildCredentialRow("ID", studentID, Icons.badge),
                      _buildCredentialRow("Program", program, Icons.school),
                      _buildCredentialRow("Campus", campus, Icons.location_city),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /
              _buildSectionTitle(context, "Timetable (Next 7 Days)"),
              _buildDashboardCard(
                icon: Icons.calendar_month,
                title: "Timetable View",
                content: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      "Timetable feature coming soon!",
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

             
              _buildSectionTitle(context, "Subjects Taken (${box.length})"),
              if (box.isEmpty)
                const Center(child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No subjects added yet!"),
                ))
              else
                ...box.values.map((subject) => _buildSubjectTile(subject, box.keyAt(box.values.toList().indexOf(subject)))).toList(),
            ],
          );
        },
      ),
    );
  }

  
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
            const Divider(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildSubjectTile(Subject subject, dynamic subjectKey) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          subject.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Prof: ${subject.professor} | Code: ${subject.code}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            Hive.box<Subject>('subjects').delete(subjectKey);
          },
        ),
      ),
    );
  }
}
