
import 'package:flutter/material.dart';
import 'package:pro/shared/loading.dart';

import './screens/screens.dart';
import './services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }  else if (snapshot.hasData ) {
            return const TopicsScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
