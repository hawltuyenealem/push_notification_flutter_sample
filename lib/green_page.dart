import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Green extends StatefulWidget{
  String routeMessage;
  Green({required this.routeMessage});
  _GreenState createState()=> _GreenState();
}
class _GreenState extends State<Green>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    backgroundColor: Colors.green,
    body: Center(
      child: Container(
        child: Text(
            widget.routeMessage,
           style: TextStyle(fontSize: 40),
        ),
      ),
    )
    );
  }
}