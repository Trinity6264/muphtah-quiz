import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:mutapha/screen/category.dart';
import 'package:mutapha/screen/results.dart';
import 'package:flutter/material.dart';

class PQuestions extends StatelessWidget {
  final String coursename;
  PQuestions(this.coursename);
  String assettoload;
  List mydata;

  setasset() {
    if (coursename == 'C++') {
      assettoload = 'assets/cpp.json';
    } else if (coursename == 'CALCULUS') {
      assettoload = 'assets/calculus.json';
    } else if (coursename == 'DIGITAL ELECTRONICS') {
      assettoload = 'assets/digital.json';
    } else if (coursename == 'IT TOOLS') {
      assettoload = 'assets/it.json';
    } else if (coursename == "EDUCATIONAL TECHNOLOGY") {
      assettoload = 'assets/edutech.json';
    } else if (coursename == "COMPUTER ARCHITECTURE") {
      assettoload = 'assets/architecture.json';
    } else if (coursename == "IT TOOLS") {
      assettoload = 'assets/it.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                    fontSize: 20.0,
                    wordSpacing: 1.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return QuizPage(mydata: mydata, coursename: coursename);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final dynamic mydata;
  final String coursename;

  QuizPage({Key key, @required this.mydata, this.coursename}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    startTimer();
    super.initState();
    calTim();
    random();
  }

  void calTim() {
    if (widget.coursename == "CALCULUS") {
      timer += 20;
    }
  }

  String random() {
    Random _rand = Random();
    String play = _rand.nextInt(10).toString();
    i = int.parse(play);
    i = i++;
    if (play == '0') {
      ++i;
    }
    return i.toString();
  }

  List mydata;
  Color colorToShow = Colors.blue[900];
  Color right = Colors.green[700];
  Color wrong = Colors.red[700];
  int marks = 0;
  int i = 1;
  int timer = 40;
  String showTimer = '40';
  bool cancelTimer = false;
  Color tcolor = Colors.black;
  bool cancelAnswer = false;

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(
      onesec,
      (Timer t) {
        setState(
          () {
            if (timer < 1) {
              t.cancel();
              nextQuestion();
              timer -= 1;
            } else if (cancelTimer == true) {
              t.cancel();
            } else if (timer <= 11) {
              setState(
                () {
                  tcolor = Colors.redAccent;
                  timer -= 1;
                },
              );
            } else {
              timer -= 1;
            }
            showTimer = timer.toString();
          },
        );
      },
    );
  }

  Map<String, Color> btncolor = {
    'a': Colors.blue[900],
    'b': Colors.blue[900],
    'c': Colors.blue[900],
    'd': Colors.blue[900],
  };

  void nextQuestion() {
    cancelTimer = false;
    tcolor = Colors.black;
    timer = 40;
    cancelAnswer = false;
    setState(() {
      debugPrint(i.toString());
      if (i < 58) {
        i++;
        calTim();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Try(
              marks: marks,
              mydata: widget.mydata,
            ),
          ),
        );
      }
      btncolor['a'] = Colors.blue[900];
      btncolor['b'] = Colors.blue[900];
      btncolor['c'] = Colors.blue[900];
      btncolor['d'] = Colors.blue[900];
    });
    startTimer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void checkAnswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks += 1;
      colorToShow = right;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${marks}'),
          width: 50,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black.withOpacity(0.5),
          duration: Duration(
            seconds: 1,
          ),
        ),
      );
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btncolor[k] = colorToShow;
      cancelTimer = true;
      cancelAnswer = true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }

  _QuizPageState(this.mydata);

  Widget answerButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: AbsorbPointer(
        absorbing: cancelAnswer,
        child: MaterialButton(
          child: Text(
            mydata[1][i.toString()][k],
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onPressed: () => checkAnswer(k),
          color: btncolor[k],
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 45.0,
          minWidth: 400.0,
          highlightColor: Colors.blue[800],
          splashColor: Colors.blue[700],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Do you want to go back?'),
            contentTextStyle: TextStyle(fontSize: 20, color: Colors.red),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Text(
                    mydata[0][i.toString()],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    answerButton('a'),
                    answerButton('b'),
                    answerButton('c'),
                    answerButton('d'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(
                      showTimer,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: tcolor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
