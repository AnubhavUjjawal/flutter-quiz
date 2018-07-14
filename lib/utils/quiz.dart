import './question.dart';

class Quiz{
  List<Question> _questions;
  int _currIndex = 0;
  int _score = 0;

  Quiz(this._questions){
    _questions.shuffle();
  }
  int get score => _score;
  int get currIndex => _currIndex;
  List<Question> get questions => _questions;
  int get length => _questions.length;

  Question get nextQuestion{
    if(_currIndex > length)
      return null;
    
    return _questions[_currIndex++];
  }
  void answer(bool flag){
    if(flag)
      _score++;
  }
}