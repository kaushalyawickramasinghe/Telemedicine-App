import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/local_db.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _doctorCtl = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _doctorCtl, decoration: const InputDecoration(labelText: 'Doctor name')),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Text(_selectedDate == null ? 'No date selected' : _selectedDate!.toIso8601String())),
            TextButton(
                onPressed: () async {
                  final dt = await showDatePicker(
                      context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (dt != null) setState(() => _selectedDate = dt);
                },
                child: const Text('Pick Date')),
          ]),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () async {
                final id = const Uuid().v4();
                final appt = {
                  'id': id,
                  'doctor': _doctorCtl.text,
                  'patient': 'local_patient',
                  'scheduled_at': _selectedDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
                  'status': 'pending',
                };
                await LocalDB.instance.insertAppointment(appt);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved locally (offline)')));
                Navigator.pop(context);
              },
              child: const Text('Save (offline demo)'))
        ]),
      ),
    );
  }
}