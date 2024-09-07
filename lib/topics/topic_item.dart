import 'package:flutter/material.dart';
import 'package:pro/services/models.dart';
import 'package:pro/shared/progress_bar.dart';
import 'package:pro/topics/drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key,required this.topic});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: topic.img,
    child: Card(
      clipBehavior: Clip.antiAlias, 
      child: InkWell(onTap:(){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => TopicScreen(topic : topic)
          ),
        );
      },
      child : Column(    crossAxisAlignment : CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(flex: 3,
        child:SizedBox(
          child: Image.asset(
              'assets/covers/${topic.img}',
              fit: BoxFit.contain,
          ),
          ),
          ),
          Flexible(child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child : Text(topic.title,
              style: const TextStyle(height: 1.5,
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.fade,
          softWrap: false,),
           ),
          ),
          Flexible(child: TopicProgress(topic: topic))
      ],),
      ),
      ),
      );
  }
}
 class TopicScreen extends StatelessWidget {
  final Topic topic;
  const TopicScreen({super.key,required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey,),
      body: ListView(children: [
        Hero(tag : topic.img,
        child: Image.asset('assets/covers/${topic.img}',
        width: MediaQuery.of(context).size.width),
        ),
        Text(topic.title,
        style :const TextStyle(height: 2, 
        fontSize : 20,
        fontWeight: FontWeight.bold)
        
        ),
        QuizList(topic: topic)
      ],),
    );
  }
}