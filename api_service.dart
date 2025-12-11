import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class ApiService {
  final String baseUrl = API_BASE_URL;

  // Common headers - add auth token in callers as needed
  Map<String, String> defaultHeaders([String? token]) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(Uri.parse('$baseUrl/auth/login'),
        headers: defaultHeaders(),
        body: jsonEncode({'email': email, 'password': password}));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Login failed: ${res.body}');
    }
  }

  Future<List<dynamic>> getDoctors({double? lat, double? lng}) async {
    final uri = Uri.parse('$baseUrl/doctors').replace(queryParameters: {
      if (lat != null) 'lat': lat.toString(),
      if (lng != null) 'lng': lng.toString(),
    });
    final res = await http.get(uri, headers: defaultHeaders());
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as List<dynamic>;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  // Telemedicine token creation - stubbed; replace with your backend route
  Future<Map<String, dynamic>> createTeleSession(String appointmentId, String token) async {
    final res = await http.post(Uri.parse('$baseUrl/tele/sessions'),
        headers: defaultHeaders(token), body: jsonEncode({'appointment_id': appointmentId}));
    if (res.statusCode == 201 || res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to create tele session');
    }
  }

  // Pharmacy nearest lookup - uses backend endpoint that accepts lat/lng
  Future<List<dynamic>> getNearbyPharmacies(double lat, double lng, {int radius = 5000}) async {
    final uri = Uri.parse('$baseUrl/pharmacies/nearby').replace(queryParameters: {
      'lat': lat.toString(),
      'lng': lng.toString(),
      'radius': radius.toString(),
    });
    final res = await http.get(uri, headers: defaultHeaders());
    if (res.statusCode == 200) return jsonDecode(res.body) as List<dynamic>;
    throw Exception('Failed to fetch pharmacies');
  }

  // Payment intent creation (server-side)
  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency, String token) async {
    final res = await http.post(Uri.parse('$baseUrl/payments/create-intent'),
        headers: defaultHeaders(token),
        body: jsonEncode({'amount': (amount * 100).toInt(), 'currency': currency}));
    if (res.statusCode == 200) return jsonDecode(res.body);
    throw Exception('Failed to create payment intent');
  }
}