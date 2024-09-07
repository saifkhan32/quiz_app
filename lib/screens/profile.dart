import 'package:flutter/material.dart';
import 'package:pro/home.dart';
import 'package:pro/services/auth.dart';
import 'package:pro/services/models.dart';
import 'package:pro/shared/loading.dart';
import 'package:provider/provider.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
 if (user != null) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(user?.displayName ?? "GUEST"),
      ),
      body: Center(
        child: Column( crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children : [Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(top : 50),
        decoration: BoxDecoration(
          shape : BoxShape.circle,
          image : DecorationImage(
            image: NetworkImage(user?.photoURL ?? 'https://www.gravatar.com/avatar/placeholder'),
            )
        ),
      ),
      Text (user?.email ?? '',
      style : Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 10,),
         Text ('${report.total}' ,
      style : Theme.of(context).textTheme.headlineMedium),
         Text ('QUIZ COMPLETED',
      style : TextStyle(fontSize: 22,
      fontWeight: FontWeight.bold)),
      
      
     ElevatedButton.icon(
          icon: const Icon(Icons.power_settings_new, color: Colors.white, size: 20),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: Colors.black,
          ),
          onPressed: () async {
            await AuthService().signOut();
            // ignore: use_build_context_synchronously
            if(context.mounted){
            Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic>route) => false) ;
          }},
          label: const Text(
            "Sign Out",
            textAlign: TextAlign.center,
          ),
        ),
        ]),
      )
      );
    }
    else
    {
      return const Loader();
    }
  }
}