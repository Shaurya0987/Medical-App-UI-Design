import 'package:bdver/Services/auth_services.dart';
import 'package:bdver/forgotPassword.dart';
import 'package:bdver/homePage.dart';
import 'package:bdver/signUp.dart'; // for MinimalLoginPage
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  final AuthService auth = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    setState(() {
      loading = true;
    });
    try {
      await auth.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Error $error")));
    }
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B6C68),
      body: Padding(
        padding: const EdgeInsets.all(20), // ✅ fixed
        child: Center(
          child: SingleChildScrollView(
            // ✅ in case of small screens
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'Inspiration',
                    fontSize: 80,
                    color: Colors.orange.shade200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in to Continue",
                  style: TextStyle(
                    color: Colors.orange.shade200,
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: 50),

                // Email field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "hello@reallygreatsite.com",
                    hintStyle: TextStyle(color: Colors.orange.shade200),
                    labelText: "Enter Your Email",
                    labelStyle: TextStyle(color: Colors.orange.shade200),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.orange.shade200,
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "abc23%gsjh",
                    hintStyle: TextStyle(color: Colors.orange.shade200),
                    labelText: "Enter Your password",
                    labelStyle: TextStyle(color: Colors.orange.shade200),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orange.shade200,
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      loading ? null : login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Social Login Icons ---
                Text(
                  "Or continue with",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Google
                    GestureDetector(
                      onTap: () async{
                        await auth.signInWithProvider(OAuthProvider.google);
                      },
                      child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.google,color:Colors.black,)
                    ),
                    ),

                    // GitHub
                    GestureDetector(
                      onTap: () async{
                        await auth.signInWithProvider(OAuthProvider.github);
                      },
                      child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.github,color:Colors.black)
                    ),
                    ),

                    // Facebook
                    GestureDetector(
                      onTap: () async{
                        await auth.signInWithProvider(OAuthProvider.facebook);
                      },
                      child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.facebook,color:Colors.black)
                    ),
                    ),

                    // Apple
                    GestureDetector(
                      onTap: ()async{
                        await auth.signInWithProvider(OAuthProvider.apple);
                      },
                      child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.apple,color:Colors.black)),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MinimalLoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
