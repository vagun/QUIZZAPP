import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quizbrain quizbrain = Quizbrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Quizpage(),
        )),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  int score=0;
  List<Widget> scorekeeper = [];
  void checkans(bool userpickedans) {
    bool correctans = quizbrain.getcorrectans();
    setState(() {
      if(quizbrain.isfinished()==true){
        Alert(context: context,title: 'FINISHED',desc: 'Score=$score').show();
        quizbrain.reset();
        scorekeeper=[];

      }
      else{ if(userpickedans == correctans) {
        score++;
        scorekeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          
        );
      } else {
        scorekeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      quizbrain.nextquestion();
    }});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getquestiontext(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: const Text(
                'true',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                checkans(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text(
                'false',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
              checkans(false);
              }
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
