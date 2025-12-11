import 'package:flutter_stripe/flutter_stripe.dart';
import '../config.dart';

// Stripe helper (client-side only). Your backend must create PaymentIntents and return clientSecret.
class PaymentService {
  PaymentService() {
    Stripe.publishableKey = STRIPE_PUBLISHABLE_KEY;
    // Stripe.instance.applySettings(); // optional
  }

  Future<void> initPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'CarePlus',
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }
}