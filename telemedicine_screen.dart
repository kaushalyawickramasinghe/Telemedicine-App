import 'package:flutter/material.dart';
import '../services/jitsi_service.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';

class TelemedicineScreen extends StatefulWidget {
  const TelemedicineScreen({super.key});

  @override
  State<TelemedicineScreen> createState() => _TelemedicineScreenState();
}

class _TelemedicineScreenState extends State<TelemedicineScreen> {
  final _roomCtl = TextEditingController(text: 'careplus-demo-room');

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Telemedicine (Demo)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _roomCtl, decoration: const InputDecoration(labelText: 'Room name (demo)')),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () async {
                // Example flow:
                // 1) create tele session on backend to get server token if required (optional)
                // 2) launch Jitsi
                try {
                  // final sess = await api.createTeleSession('appointment-id', 'YOUR_AUTH_TOKEN');
                  // if server returns room, token etc, supply as needed
                  await JitsiService.joinMeeting(roomName: _roomCtl.text.trim(), displayName: 'Patient Demo');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              child: const Text('Join (Jitsi demo)'))
        ]),
      ),
    );
  }
}