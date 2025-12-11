import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('CarePlus — Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _emailCtl, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _passCtl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 12),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                        _error = null;
                      });
                      try {
                        final res = await api.login(_emailCtl.text.trim(), _passCtl.text.trim());
                        // expected backend returns { user: {...}, token: "..." }
                        final user = User.fromJson(res['user']);
                        final token = res['token'] as String;
                        userModel.setUser(user, token);
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      } catch (e) {
                        setState(() {
                          _error = e.toString();
                        });
                      } finally {
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
              child: _loading ? const CircularProgressIndicator.adaptive() : const Text('Login')),
          TextButton(onPressed: () => Navigator.pushNamed(context, '/'), child: const Text('Register (not implemented)')),
        ]),
      ),
    );
  }
}