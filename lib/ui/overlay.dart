import 'dart:math';
import 'package:flutter/material.dart';

class OverlayModal extends StatefulWidget{
  final bool _isCorrect;
  final VoidCallback _onTap;
  OverlayModal(this._isCorrect, this._onTap);

  @override
  State createState ()=> new OverlayState();
}

class OverlayState extends State<OverlayModal> with SingleTickerProviderStateMixin{
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
    void initState() {
      super.initState();
      _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2), vsync: this);
      _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
      _iconAnimation.addListener(()=>this.setState((){}));
      _iconAnimationController.forward();
    }
  
  @override
    void dispose() {
      _iconAnimationController.dispose();
      super.dispose();
    }

  @override
    Widget build(BuildContext context) {
      return new Material(
         color: Colors.black54,
         child: new InkWell(
           onTap: ()=>widget._onTap(),
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Container(
                 decoration: new BoxDecoration(
                   color: Colors.white,
                   shape: BoxShape.circle,
                 ),
                 child: new Transform.rotate(
                   child: new Icon(widget._isCorrect == true? Icons.done:Icons.clear, size: _iconAnimation.value*80.0),
                   angle: _iconAnimation.value * PI * 2
                 ),
               ),
               new Padding(
                 padding: EdgeInsets.only(bottom:30.0),
               ),
               new Text(widget._isCorrect == true?"Correct":"Not Correct", style: new TextStyle(fontSize: 30.0, color: Colors.white),)
             ],
           ),));
    }
}