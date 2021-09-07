//Строю виджеты

import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;

  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 23.0,
      ),
      margin: EdgeInsets.only(
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFDFB8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Нет названия)",
            style: TextStyle(
              color: Color(0xFF1F1F1F),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 3.0,
            ),
            child: Text(
              desc ?? "Нет описания",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF242424),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CheckWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  CheckWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            margin: EdgeInsets.only(
              right: 12.0,
              top: 2,
            ),
            decoration: BoxDecoration(
              color: isDone ? Color(0xFF4ABD70) : Colors.transparent,
              borderRadius: BorderRadius.circular(90.0),
              border: isDone ? null : Border.all(
                color: Color(0xFFC94545),
                width: 2.5
              )
            ),
            child: Image(
              image: AssetImage('assets/images/check.png'),
              color: isDone ? Color(0xFF050505) : Color(0x0),

            ),
          ),
          Flexible(


                  child: Text(
                    text ?? "(Нет названия)",
                    style: TextStyle(
                      color: isDone ? Color(0xFF050505) : Color(0xFF505050),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),







          /*  Text(
              text ?? "(Нет названия)",
              style: TextStyle(
                color: isDone ? Color(0xFF050505) : Color(0xFF878787),
                fontSize: 18.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w700,
              ),
            ),*/
          ),
        ],
      ),
    );
  }
}


//Украл эту штуку из интернета, что бы скролл в виджетах был без эффекта
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}