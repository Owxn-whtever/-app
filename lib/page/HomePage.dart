import 'package:flutter/material.dart';
import 'ManageAppointmentsPage.dart';
import 'ManageHealthPage.dart';
import 'ReportPage.dart';
import '../help/DatabaseHelper.dart';
import 'TaskDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> _tasks = [];
  List<int> _deletedTaskIds = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    _tasks = await _databaseHelper.getTasks();
    setState(() {});
  }

  void _addTask() async {
    Map<String, dynamic> newTask = {
      'title': 'New Task',
      'description': 'Task description here',
      'isCompleted': 0,
      'category': 'General',
      'priority': 1,
    };
    await _databaseHelper.insertTask(newTask);
    _loadTasks();
  }

  void _deleteTask(int id) async {
    setState(() {
      _deletedTaskIds.add(id);
    });
    await Future.delayed(Duration(seconds: 1));
    await _databaseHelper.deleteTask(id);
    _loadTasks();
  }

  void _toggleTaskCompletion(int id, int isCompleted) async {
    final newIsCompleted = isCompleted == 0 ? 1 : 0;
    await _databaseHelper.updateTask({
      'id': id,
      'isCompleted': newIsCompleted,
    });
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Management')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('หน้าหลัก', style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            _buildDrawerItem(context, 'จัดการเวลานัดหมาย', ManageAppointmentsPage()),
            _buildDrawerItem(context, 'บันทึกสุขภาพ', ManageHealthPage()),
            _buildDrawerItem(context, 'รายงาน', ReportPage()),
          ],
        ),
      ),
      body: _tasks.isEmpty
          ? Center(child: Text('ไม่มีงานที่ต้องทำ', style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final taskId = _tasks[index]['id'];
          final isDeleted = _deletedTaskIds.contains(taskId);
          final isCompleted = _tasks[index]['isCompleted'] == 1;

          return AnimatedOpacity(
            opacity: isDeleted ? 0 : 1,
            duration: Duration(milliseconds: 300),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              color: isCompleted ? Colors.green[50] : Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                leading: Icon(
                  isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isCompleted ? Colors.green : Colors.grey,
                ),
                title: Text(
                  _tasks[index]['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_tasks[index]['description'] ?? 'ไม่มีคำอธิบาย',
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                    SizedBox(height: 4),
                    Text('หมวดหมู่: ${_tasks[index]['category'] ?? 'ไม่มี'}',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                    Text('ความสำคัญ: ${_tasks[index]['priority'] ?? 'ต่ำ'}',
                        style: TextStyle(color: Colors.orange, fontSize: 14)),
                  ],
                ),
                onTap: () {
                  _toggleTaskCompletion(taskId, _tasks[index]['isCompleted']);
                },
                trailing: _buildTaskActions(taskId, index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  Widget _buildTaskActions(int taskId, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blueAccent),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailPage(task: _tasks[index], isEditing: true),
              ),
            );
            if (result == true) {
              _loadTasks();
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _deleteTask(taskId),
        ),
      ],
    );
  }
}
