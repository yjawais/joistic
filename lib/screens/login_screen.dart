import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign-in"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Text(
                "Find Your Dream Job Today",
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton.icon(
              icon: Image.asset(
                'assets/images/googlelogo.png',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
              onPressed: () => loginController.signInWithGoogle(),
              label: const Text("Sign-in with Google"),
              style: TextButton.styleFrom(
                  side: BorderSide(
                color: Colors.blue[900]!,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
