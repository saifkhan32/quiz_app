
import 'package:flutter/material.dart' ;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/screens/profile.dart';
import 'package:pro/services/firestore.dart';
import 'package:pro/services/models.dart';
import 'package:pro/shared/bottom_nav.dart';
import 'package:pro/shared/error.dart';
import 'package:pro/shared/loading.dart';
import 'package:pro/topics/drawer.dart';
import 'package:pro/topics/topic_item.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: FirestoreService().getTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } 
          else if (snapshot.hasError) {
            return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );

          } 
          else if (snapshot.hasData ) {
            
                var topics = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(backgroundColor: Colors.deepPurple,
                title : const Text('TOPIC'),
                actions: [
                  IconButton( icon: Icon(
                    FontAwesomeIcons.circleUser,
                    color: Colors.pink[200],),
                    onPressed: ()=> Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => const ProfileScreen())),)
                ],
                ),
                drawer: TopicDrawer(topics : topics),
                body : GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(10.0),
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    children : topics.map((topic)=> TopicItem(topic: topic)).toList()
                ),
                bottomNavigationBar: const AppBottomNav(),
                );
          } 
          else
           {
            return const Text('NO TOPICS FOUND HERE. PLEASE TRY AGAIIN');
          }
        }
    );
  }
}