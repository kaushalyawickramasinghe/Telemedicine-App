import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  List<dynamic> _pharmacies = [];
  bool _loading = false;
  String? _error;

  Future<void> _findNearby() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final api = Provider.of<ApiService>(context, listen: false);
      final res = await api.getNearbyPharmacies(pos.latitude, pos.longitude);
      setState(() {
        _pharmacies = res;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _orderAt(Map<String, dynamic> pharmacy) async {
    // TODO: call backend to create a pharmacy order from a prescription
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order stubbed to ${pharmacy['name'] ?? 'pharmacy'}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearest Pharmacies')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(onPressed: _findNearby, child: const Text('Find Nearby Pharmacies')),
        ),
        if (_loading) const LinearProgressIndicator(),
        if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
        Expanded(
            child: ListView.builder(
          itemCount: _pharmacies.length,
          itemBuilder: (context, idx) {
            final p = _pharmacies[idx];
            return ListTile(
              title: Text(p['name'] ?? 'Pharmacy'),
              subtitle: Text(p['address'] ?? ''),
              trailing: ElevatedButton(onPressed: () => _orderAt(p), child: const Text('Order')),
            );
          },
        ))
      ]),
    );
  }
}