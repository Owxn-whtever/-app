import 'package:flutter/material.dart';
import 'AddHealthRecordPage.dart'; // นำเข้าหน้าสำหรับเพิ่มข้อมูลสุขภาพ

class ManageHealthPage extends StatefulWidget {
  @override
  _ManageHealthPageState createState() => _ManageHealthPageState();
}

class _ManageHealthPageState extends State<ManageHealthPage> {
  List<Map<String, String>> healthRecords = [];

  void _addHealthRecord(Map<String, String> record) {
    setState(() {
      healthRecords.add(record);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกสุขภาพ'),
        backgroundColor: Colors.greenAccent, // เปลี่ยนสีพื้นหลัง AppBar
      ),
      body: healthRecords.isEmpty
          ? Center(
        child: Text(
          'ไม่มีข้อมูลสุขภาพ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: healthRecords.length,
        itemBuilder: (context, index) {
          final record = healthRecords[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              title: Text(
                'ข้อมูลสุขภาพ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('การนอน: ${record['sleep']} ชั่วโมง'),
                    Text('การกิน: ${record['food']}'),
                    Text('อาการ: ${record['symptoms']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHealthRecordPage()),
          );
          if (result != null) {
            _addHealthRecord(result);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent, // สีของปุ่มลอย
      ),
    );
  }
}
