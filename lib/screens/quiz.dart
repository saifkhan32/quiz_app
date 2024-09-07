
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro/screens/quiz_state.dart';
import 'package:pro/screens/screens.dart';
import 'package:pro/services/firestore.dart';
import 'package:pro/services/models.dart';
import 'package:pro/shared/loading.dart';
import 'package:pro/shared/progress_bar.dart';
import 'package:provider/provider.dart';


class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({super.key,required this.quizId});

  @override
  Widget build(BuildContext context)
   {
    return ChangeNotifierProvider(create: (_) => QuizState(),
    child: FutureBuilder<Quiz>(
    future: FirestoreService().getQuiz(quizId),
    builder: (context,snapshot){
            var state = Provider.of<QuizState>(context);
            if(!snapshot.hasData || snapshot.hasError) {
              return const Loader();
            } else
            {
            var quiz = snapshot.data!;

             return Scaffold(
                  appBar: AppBar(
                    title: ProgressBar(value: state.progress,),
                    leading: IconButton(
                      icon: const Icon(FontAwesomeIcons.xmark), 
                      onPressed: ()=> Navigator.pop(context),
                      ),
                    ),
                    body:  PageView.builder(
                      physics: const NeverScrollableScrollPhysics(), 
                    scrollDirection: Axis.vertical,
                    controller: state.controller,
                    onPageChanged: (int idx ) =>
                    state.progress = (idx / quiz.questions.length + 1),
                    itemBuilder: (BuildContext context , int idx){
                      if(idx == 0)
                      {
                        return MaterialApp(home : StartPage(quiz : quiz));
                      }
                      else if(idx == quiz.questions.length)
                      {
                        return CongratsPage(quiz : quiz);
                      }
                      else
                      { 
                      return QuestionPage(ques : quiz.questions[idx-1]);
                      }
                    },
                    ),
             );
            }
    },),);
  }

}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key,required this.quiz });

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Text(quiz.title,style: Theme.of(context).textTheme.headlineLarge,),
          const Divider(),
          Expanded(child: Text(quiz.description,style: Theme.of(context).textTheme.bodyMedium,),),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(onPressed: state.nextPage,
               label: const Text("Start Quiz"),
               icon: const Icon(Icons.poll),)
            ],
          )
        ]

      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;

  const CongratsPage({super.key,required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Congrats! You completed the ${quiz.title} quiz',
          textAlign: TextAlign.center,),
          const Divider(),
          Image.asset('assets/congrats.gif'),
          const Divider(),
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,

            ),
            icon : const Icon(FontAwesomeIcons.check),
            label: const Text('Mark Complete'),
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(builder: (context) => const TopicsScreen()), (Route<dynamic>route) => false
              );
            },
        )
        ],
      ),);
  }
}


class QuestionPage extends StatelessWidget {
  final Question ques;
  const QuestionPage({super.key,required this.ques});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Column(
      children : [
        Expanded(
          child: Container
        (
          padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(ques.text),
        )
        ),
        Container(padding: const EdgeInsets.all(20),
      child : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children : ques.options.map((e)
        {
          return Container(
            height: 90,
            margin : const EdgeInsets.only(bottom: 10),
            color: Colors.black26,
            child :InkWell(
              onTap: (){
                state.selected = e;
                  _bottomsheet(context,e,state);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      state.selected == e
                      ? FontAwesomeIcons.circleCheck :
                      FontAwesomeIcons.circle,size: 30,
                    ),
                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                  ],
                ),
              ),

            )
          );
        },).toList()
      ))

      ]
        


    );
  }
  //Bottom Sheet Shown when question is answered

  _bottomsheet(BuildContext context, Option e, QuizState state) {
    bool correct = e.correct;

    showModalBottomSheet(context: context, builder: (BuildContext context){
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment : CrossAxisAlignment.center,
            children : <Widget>[
              Text(correct ? 'GOOD JOB' : 'WRONG'),
              Text(
                e.detail,
                style : const TextStyle(fontSize: 18,color: Colors.black)

              ),
              ElevatedButton(style: ElevatedButton.styleFrom(
                foregroundColor: correct ? Colors.green : Colors.red
              ),
              child: Text(
                correct ? 'Onward' : 'Try AGAIN',
                style: const TextStyle(
                  color: Colors.black38,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold
                ),
              ),
               onPressed: () { if(correct)
               {
                state.nextPage();
               } 
               Navigator.pop(context);
               },
               )
            ],)
        );
    });
  }
}
