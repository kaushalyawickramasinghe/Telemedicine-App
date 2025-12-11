import 'package:flutter/material.dart';
import '../services/payment_service.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  bool _processing = false;

  Future<void> _payDemo() async {
    setState(() => _processing = true);
    try {
      final api = Provider.of<ApiService>(context, listen: false);
      // Backend should create a PaymentIntent and return clientSecret
      final pi = await api.createPaymentIntent(10.0, 'usd', ''); // TODO: pass real auth token
      final clientSecret = pi['client_secret'] as String?;
      if (clientSecret == null) throw Exception('No client secret from server');

      final paymentService = PaymentService();
      await paymentService.initPaymentSheet(clientSecret);
      await paymentService.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment successful (demo)')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment failed: $e')));
    } finally {
      setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Payments')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const Text('Demo payment of \$10.00'),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _processing ? null : _payDemo, child: const Text('Pay (Stripe test)')),
            if (_processing) const CircularProgressIndicator(),
          ]),
        ));
  }
}