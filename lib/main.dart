import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int next = 0;
  List<Icon> scoreKeeper = [Icon(null)];
  int isFinished(int next){
    if (next == quizBrain.getLength()) {
      Alert(
          context: context,
          title: "Alert !",
          desc: "You've reached the end of the quiz!",
          buttons: [
            DialogButton(
              child: Text(
                'RELOAD!',
                style: TextStyle(color: Colors.yellowAccent),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ]).show();
      scoreKeeper = [Icon(null)];
      return 0;
    }
    else{
      return next;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(next),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    if (quizBrain.getAnswer(next) == true) {
                      scoreKeeper.add(
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      );
                    } else {
                      scoreKeeper.add(
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      );
                    }
                    next = next + 1;
                   next = isFinished(next);
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    if (quizBrain.getAnswer(next) == false) {
                      scoreKeeper.add(
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      );
                    } else {
                      scoreKeeper.add(
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      );
                    }
                    next = next + 1;
                    next = isFinished(next);
                  },
                );
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
