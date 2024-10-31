import 'package:flutter/material.dart';

class AddHealthRecordPage extends StatefulWidget {
  @override
  _AddHealthRecordPageState createState() => _AddHealthRecordPageState();
}

class _AddHealthRecordPageState extends State<AddHealthRecordPage> {
  final TextEditingController _sleepHoursController = TextEditingController();
  final TextEditingController _foodIntakeController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();

  void _saveRecord() {
    final sleepHours = _sleepHoursController.text;
    final foodIntake = _foodIntakeController.text;
    final symptoms = _symptomsController.text;

    if (sleepHours.isEmpty || foodIntake.isEmpty || symptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง')),
      );
      return;
    }

    final newRecord = {
      'sleep': sleepHours,
      'food': foodIntake,
      'symptoms': symptoms,
    };

    Navigator.pop(context, newRecord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มบันทึกสุขภาพ'),
        backgroundColor: Colors.greenAccent, // เปลี่ยนสี AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // ให้สามารถเลื่อนลงได้เมื่อข้อมูลมีมาก
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _sleepHoursController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ชั่วโมงการนอน (ชั่วโมง)',
                      border: OutlineInputBorder(), // เพิ่มกรอบให้กับ TextField
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // ปรับ padding ภายใน
                    ),
                  ),
                  SizedBox(height: 16), // เพิ่มระยะห่างระหว่าง TextField
                  TextField(
                    controller: _foodIntakeController,
                    decoration: InputDecoration(
                      labelText: 'การรับประทานอาหาร',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _symptomsController,
                    decoration: InputDecoration(
                      labelText: 'อาการป่วยหรือรู้สึกไม่สบาย',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveRecord,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // เปลี่ยนสีปุ่ม
                      padding: EdgeInsets.symmetric(vertical: 14), // ปรับ padding ของปุ่ม
                      textStyle: TextStyle(fontSize: 18), // ปรับขนาดฟอนต์
                    ),
                    child: Text('บันทึกข้อมูลสุขภาพ'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
