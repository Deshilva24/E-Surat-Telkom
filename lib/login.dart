import 'package:flutter/material.dart';
import 'jenissurat.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String _validEmail = 'yustikamonita@gmail.com';
  static const String _validPassword = 'IndibizBanyuwangi';
  bool _emailError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final emailIsValid = email.toLowerCase() == _validEmail.toLowerCase();
    final passwordIsValid = password.toLowerCase() == _validPassword.toLowerCase();

    setState(() {
      _emailError = !emailIsValid;
    });

    if (!emailIsValid || !passwordIsValid) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PilihJenisSuratScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232066), Color(0xFFE8F1FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 0,
              color: const Color(0xFFDCDCDC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF140F47),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.mark_email_read_rounded, size: 70, color: Color(0xFF2C82C9)),
                    const SizedBox(height: 12),
                    const Text(
                      'Pembuat Surat\nOtomatis',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 28),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _emailError = value.trim().toLowerCase() != _validEmail.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: _emailError ? const Color(0xFFFFE5E5) : const Color(0xFFC4C4C4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: _emailError ? Colors.red : Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: _emailError ? Colors.red : const Color(0xFF140F47)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_emailError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email salah',
                            style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                          ),
                        ),
                      ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        filled: true,
                        fillColor: const Color(0xFFC4C4C4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF140F47),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _handleLogin(context),
                        child: const Text('Masuk', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(color: Color(0xFF140F47)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}