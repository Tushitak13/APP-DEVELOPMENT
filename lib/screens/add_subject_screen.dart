import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/subject.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _profController = TextEditingController();
  final TextEditingController _attendedController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  void _saveSubject() {
    if (_formKey.currentState!.validate()) {
      final subject = Subject(
        name: _nameController.text,
        code: _codeController.text,
        professor: _profController.text,
        attended: int.parse(_attendedController.text),
        total: int.parse(_totalController.text),
      );

      
      Hive.box<Subject>('subjects').add(subject); 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject added successfully")),
      );

      _nameController.clear();
      _codeController.clear();
      _profController.clear();
      _attendedController.clear();
      _totalController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Subject")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField("Subject Name", _nameController),
              _buildField("Subject Code", _codeController),
              _buildField("Professor", _profController),
              _buildField(
                "Classes Attended",
                _attendedController,
                isNumber: true,
              ),
              _buildField(
                "Total Classes",
                _totalController,
                isNumber: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSubject,
                child: const Text("Save Subject"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
