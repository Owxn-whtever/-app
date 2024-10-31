import 'package:flutter/material.dart';

class AddAppointmentPage extends StatefulWidget {
  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blueAccent, // สีที่ใช้ใน DatePicker
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(primary: Colors.blueAccent).copyWith(secondary: Colors.blueAccent),
          ),
          child: child ?? Container(),
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveAppointment() {
    if (_titleController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
      Navigator.pop(context, {
        'title': _titleController.text,
        'date': '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        'time': _selectedTime!.format(context),
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter title here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _selectDate,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(Icons.calendar_today, color: Colors.blueAccent),
                ),
              ),
            ),
            GestureDetector(
              onTap: _selectTime,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    _selectedTime == null
                        ? 'Select Time'
                        : 'Time: ${_selectedTime!.format(context)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Icon(Icons.access_time, color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveAppointment,
                child: Text('Save Appointment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.blueAccent,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
