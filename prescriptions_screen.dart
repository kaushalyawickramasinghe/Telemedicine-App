import 'package:flutter/material.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo static list
    final prescriptions = [
      {'id': 'rx1', 'date': '2025-01-10', 'summary': 'Amoxicillin 500mg - 7 days'},
      {'id': 'rx2', 'date': '2025-03-02', 'summary': 'Paracetamol PRN'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Prescriptions')),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, idx) {
          final rx = prescriptions[idx];
          return ListTile(title: Text(rx['summary']!), subtitle: Text(rx['date']!));
        },
      ),
    );
  }
}