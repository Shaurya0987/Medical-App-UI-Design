import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // SIGN UP
  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // LOGIN
  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // SOCIAL LOGIN (Google, GitHub, Facebook, Apple)
  Future<void> signInWithProvider(OAuthProvider provider) async {
  await supabase.auth.signInWithOAuth(
    provider,
    redirectTo: 'bdver://login-callback',
  );
}





  // SEND PASSWORD RESET EMAIL
  Future<void> sendPasswordResetEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'bdver://reset-password',
    );
  }

  // UPDATE PASSWORD AFTER RESET LINK
  Future<void> updatePassword(String newPassword) async {
    await supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // SIGN OUT
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // CHECK CURRENT USER
  User? currentUser() {
    return supabase.auth.currentUser;
  }
}
