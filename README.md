# CarePlus Mobile (Flutter) — Scaffold

This repository is a starter scaffold for the CarePlus Mobile App (Flutter + Dart) with REST API stubs and feature demos:

- Telemedicine demo (Jitsi stub + token flow)
- Payments demo (Stripe test integration - client stub)
- Pharmacy flow (nearest pharmacy lookup stub)
- Notifications (push token registration stub using Firebase Messaging)
- Minimal offline caching (sqflite example + simple sync pattern)

What’s included
- Flutter project skeleton with screens:
  - Login / Register
  - Patient Dashboard
  - Appointments list + booking
  - Telemedicine (Jitsi stub)
  - Prescriptions
  - Pharmacy order (nearest lookup + order stub)
  - Payment screen (Stripe test flow stub)
- Services:
  - REST API client (lib/services/api_service.dart)
  - Local DB (sqflite) example and sync (lib/services/local_db.dart)
  - Jitsi helper (lib/services/jitsi_service.dart)
  - Stripe payment helper stub (lib/services/payment_service.dart)
  - Notifications registration stub (lib/services/notification_service.dart)
- GitHub Actions workflow (.github/workflows/flutter.yml) for CI (flutter pub get, flutter test, flutter build apk)

Quickstart (development)
1. Prereqs:
   - Flutter SDK (stable)
   - Android SDK / Xcode for platform builds
2. Clone repo
3. Edit lib/config.dart:
   - Set API_BASE_URL
   - Add JITSI_SERVER_URL (if self-hosted) or leave to use Jitsi public
   - Set STRIPE_PUBLISHABLE_KEY
4. Run:
   - flutter pub get
   - flutter run

Platform setup notes (required for full functionality)
- Firebase (for push notifications):
  - Add Android `google-services.json` and iOS `GoogleService-Info.plist` and follow Firebase setup for messaging.
- Stripe:
  - Configure your backend to create PaymentIntents and return client secrets; set publishable key here.
  - Add platform-native configuration as required by `flutter_stripe`.
- Jitsi:
  - If self-hosted, set JITSI_SERVER_URL; otherwise uses default Jitsi meet servers.
- Permissions:
  - Add necessary Android/iOS runtime permissions for camera, microphone, location, and notifications.

CI
- GitHub Actions workflow is configured to run `flutter test` and build an APK. See `.github/workflows/flutter.yml`.

Next steps
- Wire the REST endpoints in lib/services/api_service.dart to your HMS backend.
- Configure Firebase & Stripe on platforms.
- Replace demo-stubs with production tokens and server flows (telemedicine token issuance, payment-intent creation, pharmacy partner API).

If you want, I can:
- Create an OpenAPI client (Dart) tailored to your backend schema.
- Expand the Jitsi flow to include server-side token generation examples.
- Add more test coverage or end-to-end tests.
