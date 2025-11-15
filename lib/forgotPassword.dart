import 'package:bdver/Services/auth_services.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final AuthService auth = AuthService();

  bool loading = false;

  Future<void> sendResetLink() async {
    setState(() => loading = true);

    try {
      await auth.sendPasswordResetEmail(emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reset link sent to your email")),
      );

      emailController.clear();

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B6C68),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 32,
                color: Colors.orange[200],
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Enter your email and we’ll send you a password reset link.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange[100]),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                prefixIcon:
                    Icon(Icons.email, color: Colors.orange[200]),
                filled: true,
                fillColor: Colors.white24,
                hintStyle: TextStyle(color: Colors.orange[100]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA66B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Send Reset Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Back to Login",
                style: TextStyle(color: Colors.orange[100]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
