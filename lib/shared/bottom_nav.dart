import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.graduationCap, size: 20),
              label: "Topics"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bolt, size: 20), label: 'About'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.circleUser, size: 20),
              label: "Profile")
        ],
        fixedColor: Colors.green,
        onTap: (int idx){
              switch (idx) {
          case 0:
            break;
          case 1:
           Navigator.of(context).pushNamed( '/about');
            break;
          case 2:
           Navigator.of(context).pushNamed( '/profile');
            break;
        }
        },
      );
  }
}