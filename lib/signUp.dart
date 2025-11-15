import 'package:bdver/Services/auth_services.dart';
import 'package:bdver/login.dart';
import 'package:flutter/material.dart';

class MinimalLoginPage extends StatefulWidget {
  const MinimalLoginPage({super.key});

  @override
  State<MinimalLoginPage> createState() => _MinimalLoginPageState();
}

class _MinimalLoginPageState extends State<MinimalLoginPage> {
  final AuthService auth = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  Future<void> signUp() async {
    setState(() {
      loading = true;
    });

    try {
      await auth.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      nameController.clear();
      emailController.clear();
      passwordController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("SignUp Success! Please Login")));
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("SignUp Error: $error")));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B6C68), // background color
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create new\nAccount",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Inspiration',
                color: Colors.orange[200],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40),
            // Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.orange[200]),
                hintText: "Your Name",
                hintStyle: TextStyle(color: Colors.orange.shade200),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Email Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.orange[200]),
                hintText: "hello@reallygreatsite.com",
                hintStyle: TextStyle(color: Colors.orange[100]),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Password Field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint, color: Colors.orange[200]),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.orange[100]),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : () => signUp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA66B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckLogin()),
                );
              },
              child: Text(
                "Already Have Account? Login !",
                style: TextStyle(color: Colors.orange[100], fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
