import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../help/DatabaseHelper.dart'; // นำเข้า DatabaseHelper สำหรับดึงข้อมูลจากฐานข้อมูล

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> monthlyReports = [];
  String currentMonth = DateFormat('MMMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadMonthlyReports();
  }

  void _loadMonthlyReports() async {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0); // สิ้นสุดเดือนนี้

    monthlyReports = await _databaseHelper.getTasksInDateRange(
      startOfMonth,
      endOfMonth,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายงานประจำเดือน $currentMonth')),
      body: monthlyReports.isEmpty
          ? Center(child: Text('ไม่มีข้อมูลในเดือนนี้'))
          : ListView.builder(
        itemCount: monthlyReports.length,
        itemBuilder: (context, index) {
          final report = monthlyReports[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(report['title'] ?? 'ไม่มีชื่อรายการ'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('คำอธิบาย: ${report['description'] ?? 'ไม่มีรายละเอียด'}'),
                  Text('หมวดหมู่: ${report['category'] ?? 'ไม่มี'}'),
                  Text('ความสำคัญ: ${report['priority'] ?? 'ไม่ระบุ'}'),
                  Text('วันที่: ${report['date']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
