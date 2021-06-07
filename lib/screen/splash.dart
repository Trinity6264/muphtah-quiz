import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mutapha/screen/category.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  List<Map<String, dynamic>> qoutes = [
    {
      "quotes":
          "Leaders are made, they are not born. They are made by hard effort, which is the price which all of us must pay to achieve any goal that is worthwhile.",
      "Person": "Vince Lombardi"
    },
    {
      "quotes":
          "Leadership is having compelling vision, a comprehensive plan, relentessly implementation, and talented people working togerther",
      "Person": "Alan Mulally"
    },
    {
      "quotes":
          "To walk safely through the maze of human life, one needs the light of wisdom and guidance of virtue",
      "Person": "Unknown"
    },
    {
      "quotes": "Where there is no vision, the people perish",
      "Person": "Proverbs 29:18"
    },
    {
      "quotes": "Leadership is the capacity to translate vision into reality",
      "Person": "Warren Bennis"
    },
    {
      "quotes":
          "A leader is one who knows the way, goes the way, and shows the way",
      "Person": "John Maxwell"
    },
    {
      "quotes":
          "Become the kind of leader that people would follow voluntarily; even if you had no title or position",
      "Person": "Brian Tracy"
    },
    {"quotes": "Leadership is influence", "Person": "John C. Maxwell"},
    {
      "quotes":
          "So much of what we call management consists in making it difficult for people to work",
      "Person": "Peter Drucker"
    },
    {
      "quotes":
          "A leader is one who knows the way, goes the way, and shows the way.",
      "Person": "John C. Maxwell"
    },
    {
      "quotes":
          "Leadership is about taking responsibility, not making excuses ",
      "Person": "Mitt Rommey"
    },
    {
      "quotes": "Today a reader, tomorrow a leader",
      "Person": "Margaret fuller"
    },
  ];

  Widget displayQuotes() {
    Random _rand = Random();
    int p = _rand.nextInt(qoutes.toList().length);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.topCenter,
            child: Center(
              child: Text(
                qoutes[p]['quotes'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Text(
            qoutes[p]['Person'].toString(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    displayQuotes();
    Future.delayed(
      Duration(
        seconds: 7,
      ),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CategoryItem(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aamusted Quiz',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent.shade200,
                    Colors.black38,
                    Colors.black12,
                    Colors.black,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Container(
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 30),
                      child: AnimatedTextKit(
                        totalRepeatCount: 6,
                        animatedTexts: [
                          WavyAnimatedText('Quiz App',
                              textStyle: TextStyle(color: Colors.orangeAccent),
                              speed: Duration(milliseconds: 300),
                              textAlign: TextAlign.center),
                          WavyAnimatedText('Team Muphtah',
                              textStyle: TextStyle(color: Colors.orangeAccent),
                              speed: Duration(milliseconds: 300),
                              textAlign: TextAlign.center),
                        ],
                        displayFullTextOnTap: true,
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      child: ClipOval(
                        child: Image.asset(
                          'image/skuul.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  displayQuotes(),
                  SizedBox(height: 80),
                  CircularProgressIndicator(
                    backgroundColor: Colors.orangeAccent,
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
