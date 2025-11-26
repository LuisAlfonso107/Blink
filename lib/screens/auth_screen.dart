import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<UserCredential> _googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.radar, size: 180, color: Colors.cyan),
            const SizedBox(height: 40),
            const Text("Blink", style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900, color: Colors.white)),
            const SizedBox(height: 100),
            ElevatedButton.icon(
              onPressed: () async {
                await _googleSignIn();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              icon: const Icon(Icons.g_mobiledata, size: 40),
              label: const Text("Continuar con Google", style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 20),
            SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email]);
                final oauthCredential = OAuthProvider("apple.com").credential(idToken: credential.identityToken);
                await FirebaseAuth.instance.signInWithCredential(oauthCredential);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}