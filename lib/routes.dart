import 'package:pro/screens/about.dart';
import 'package:pro/screens/profile.dart';
import 'package:pro/screens//login.dart';
import 'package:pro/topics/topic.dart';
import 'package:pro/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};