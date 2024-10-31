import 'package:flutter/material.dart';
import '../help/DatabaseHelper.dart';

class TaskDetailPage extends StatefulWidget {
  final Map<String, dynamic> task;
  final bool isEditing;

  TaskDetailPage({required this.task, this.isEditing = false});

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? _selectedCategory;
  int? _selectedPriority;

  final List<String> categories = ['General', 'Work', 'Personal'];
  final List<Map<String, dynamic>> priorities = [
    {'value': 1, 'label': 'Low'},
    {'value': 2, 'label': 'Medium'},
    {'value': 3, 'label': 'High'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController = TextEditingController(text: widget.task['description']);
    _selectedCategory = widget.task['category'] ?? categories[0];
    _selectedPriority = widget.task['priority'] ?? priorities[0]['value'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    Map<String, dynamic> updatedTask = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'isCompleted': widget.task['isCompleted'] ?? 0,
      'category': _selectedCategory,
      'priority': _selectedPriority,
    };

    if (widget.isEditing) {
      updatedTask['id'] = widget.task['id'];
    }

    try {
      if (widget.isEditing) {
        await DatabaseHelper().updateTask(updatedTask);
      } else {
        await DatabaseHelper().insertTask(updatedTask);
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Task' : 'Add Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Select Category',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<int>(
              value: _selectedPriority,
              decoration: InputDecoration(
                labelText: 'Select Priority',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: priorities.map((priority) {
                return DropdownMenuItem<int>(
                  value: priority['value'],
                  child: Text(priority['label']),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedPriority = newValue;
                });
              },
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.isEditing ? 'Update Task' : 'Save Task',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
