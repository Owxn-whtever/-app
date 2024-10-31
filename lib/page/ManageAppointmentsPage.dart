import 'package:flutter/material.dart';
import 'AddAppointmentPage.dart'; // นำเข้าหน้าสำหรับเพิ่มนัดหมาย

class ManageAppointmentsPage extends StatefulWidget {
  @override
  _ManageAppointmentsPageState createState() => _ManageAppointmentsPageState();
}

class _ManageAppointmentsPageState extends State<ManageAppointmentsPage> {
  List<Map<String, dynamic>> appointments = [];

  void _addAppointment(Map<String, dynamic> appointment) {
    setState(() {
      appointments.add(appointment);
    });
  }

  void _removeAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Appointments'),
        backgroundColor: Colors.blueAccent,
      ),
      body: appointments.isEmpty
          ? Center(child: Text('No appointments yet.', style: TextStyle(fontSize: 20, color: Colors.grey)))
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(
                appointment['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('${appointment['date']} เวลา ${appointment['time']}', style: TextStyle(color: Colors.grey[600])),
              trailing: IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  _removeAppointment(index); // เรียกฟังก์ชันลบเมื่อกดเครื่องหมายเช็ก
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Appointment completed!')),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAppointmentPage(),
            ),
          );
          if (result != null) {
            _addAppointment(result);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
