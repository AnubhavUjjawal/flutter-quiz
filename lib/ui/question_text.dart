import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget{
  final String _question;
  final int _num;

  QuestionText(this._num, this._question);
  
  @override
  State createState ()=> new QuestionTextState();
}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin{

  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
      super.initState();
      _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);
      _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceIn);
      _fontSizeAnimation.addListener(()=>this.setState((){}));
      _fontSizeAnimationController.reset(); 
      _fontSizeAnimationController.forward(); 
    }

  @override
    void dispose() {
      _fontSizeAnimationController.dispose();
      super.dispose();
    }
  
  @override
    void didUpdateWidget(QuestionText oldWidget) {
      super.didUpdateWidget(oldWidget);
      _fontSizeAnimationController.forward();
    }

  @override
  Widget build(BuildContext context) {
      return new Material(
              color: Colors.white,
              child: new Padding(
                child: new Center(child: new Text(widget._num.toString() + ". " + widget._question,
                                                  style: new TextStyle(fontSize: _fontSizeAnimation.value*15),)),
                padding: EdgeInsets.symmetric(vertical: 20.0),) 
            );    
    }
}