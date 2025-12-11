import 'package:flutter/material.dart';
import 'appointments_screen.dart';
import 'telemedicine_screen.dart';
import 'pharmacy_screen.dart';
import 'payments_screen.dart';
import 'prescriptions_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CarePlus — Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Text('Welcome to CarePlus', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentsScreen())),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Appointments')),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TelemedicineScreen())),
              icon: const Icon(Icons.video_call),
              label: const Text('Telemedicine')),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionsScreen())),
              icon: const Icon(Icons.receipt_long),
              label: const Text('Prescriptions')),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacyScreen())),
              icon: const Icon(Icons.local_pharmacy),
              label: const Text('Pharmacy')),
          ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentsScreen())),
              icon: const Icon(Icons.payment),
              label: const Text('Payments')),
        ]),
      ),
    );
  }
}