import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/services/auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
                child: LoginButton(
                    icon: FontAwesomeIcons.userNinja,
                    text: 'Continue as Guest',
                    loginMethod: AuthService().anonLogin,
                    color: Colors.deepPurple),
                    ),
                    LoginButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Google Sign In',
                    loginMethod: AuthService().googleLogin,
                    color: Colors.lightGreen
        ),
           FutureBuilder<Object>(
        future: SignInWithApple.isAvailable(),
        builder: (context, snapshot) {
        if (snapshot.data == true) {
            return SignInWithAppleButton(
            onPressed: () {
                AuthService().signInWithApple();
            },
            );
        } else {
            return Center(
              child: Container(
                color: Colors.brown,
                child: const Text("Try Logging in with other methods",
                style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            );
        }
        },
    ),

        ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final Function loginMethod;
  const LoginButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child : ElevatedButton.icon(
        icon: Icon(icon , 
        color: Colors.white,
        size : 20),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color
        ),
        onPressed: () => loginMethod(),
        label: Text(text,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,
        fontSize: 22),),
        )
    );
  }
}
