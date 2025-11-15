import 'package:bdver/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qmyrrbofqhtshbvmoyrx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFteXJyYm9mcWh0c2hidm1veXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMxNTE3MDEsImV4cCI6MjA3ODcyNzcwMX0.9DplbxiUk2l3wHBU6jWVEFuDybjlaJVueo8clGerm0I',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
