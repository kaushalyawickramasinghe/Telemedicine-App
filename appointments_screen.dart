import 'package:flutter/material.dart';
import '../services/local_db.dart';
import 'book_appointment_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<Map<String, dynamic>> _localAppointments = [];

  @override
  void initState() {
    super.initState();
    _loadLocal();
  }

  Future<void> _loadLocal() async {
    final db = LocalDB.instance;
    final res = await db.getUnsyncedAppointments();
    setState(() {
      _localAppointments = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: _localAppointments.length,
            itemBuilder: (context, idx) {
              final appt = _localAppointments[idx];
              return ListTile(
                title: Text(appt['doctor'] ?? 'Unknown'),
                subtitle: Text(appt['scheduled_at'] ?? ''),
                trailing: Text(appt['status'] ?? ''),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookAppointmentScreen())),
                child: const Text('Book Appointment')),
          )
        ]));
  }
}