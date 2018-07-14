import 'package:flutter/material.dart';
import '../utils/quiz.dart';
import '../utils/question.dart';
import '../ui/answer_button.dart';
import '../ui/question_text.dart';
import '../ui/overlay.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget{
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage>{
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", true),
    new Question("Pizza is healthy", false),
    new Question("flutter is awesome", true)
  ]);
  String questionText;
  int qNo;
  bool isCorrect, overlayVisible=false;

  @override
  void initState() {
      super.initState();
      currentQuestion = quiz.nextQuestion;
      questionText = currentQuestion.question;
      qNo = quiz.currIndex;
    }

  void handleAnswer(bool answer){
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      overlayVisible = true;
    });
  }
  @override
  Widget build(BuildContext context){
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new AnswerButton(true, ()=>handleAnswer(true)),
            new QuestionText(qNo, questionText),
            new AnswerButton(false, ()=>handleAnswer(false))
        ],),
        overlayVisible==true? new OverlayModal(
          isCorrect,
          (){
            if(quiz.length == qNo){
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context)=> new ScorePage(quiz.score, qNo)), (Route route)=> route == null);
            }
            else{
              currentQuestion = quiz.nextQuestion;
              this.setState((){
                overlayVisible = false;
                questionText = currentQuestion.question;
                qNo = quiz.currIndex;
              });
            }
          }
        ):new Container()
      ],);
  }
}