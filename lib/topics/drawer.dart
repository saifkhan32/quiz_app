import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/screens/screens.dart';
import 'package:pro/services/models.dart';
import 'package:provider/provider.dart';

class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(  
      child : ListView.separated(shrinkWrap: true,
      itemCount: topics.length,
      itemBuilder: (BuildContext context, int index) {
        Topic topic = topics[index]; 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.only(top: 10.0,left:10),
            child : Text(topic.title,
            //textalign : Text Align Left)
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color : Colors.white70
            ),),
            ),
            QuizList(topic : topic)
          ]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider())

    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key,required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map(
        (quiz) {
          return Card(
              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 4,
              margin: const EdgeInsets.all(4),
              child: InkWell(
                onTap : ()
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => QuizScreen(quizId : quiz.id)
                    )
                  );

                },
                  child : Container(
                     width: double.maxFinite,
                    padding: const EdgeInsets.all(9),
                    child: ListTile(
                        title: Text(
                          quiz.title,
                          style : Theme.of(context).textTheme.headlineMedium
                        ),
                          subtitle: Text(
                            quiz.description,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                          leading: QuizBadge(topic : topic,quizId : quiz.id),
                    ),
                    )
                
              ),
          );
        }
      ).toList()
      );
  }
}
 class QuizBadge extends StatelessWidget {
  final Topic topic;
  final String quizId;
  const QuizBadge({super.key,required this.topic,required this.quizId});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
       if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    } else {
      return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
    }
  }
}