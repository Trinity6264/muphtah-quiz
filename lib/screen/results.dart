import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:mutapha/screen/category.dart';
import 'package:mutapha/screen/questions.dart';
import 'package:flutter/material.dart';

class Try extends StatefulWidget {
  final dynamic mydata;
  final int marks;

  Try({
    Key key,
    this.mydata,
    @required this.marks,
  }) : super(key: key);
  @override
  _TryState createState() => _TryState(marks, mydata);
}

class _TryState extends State<Try> {
  List images = [
    'image/bad.png',
    'image/good.png',
    'image/succes.png',
  ];

  _TryState(this.marks, this.mydata);
  int marks;
  List mydata;
  String image;
  String message;

  void checkingResults() {
    if (marks < 25) {
      image = images[0];
      message = 'WO PAPA DAWASE wai, You scored $marks';
    } else if (marks < 45) {
      image = images[1];
      message = 'Wow That was genius keep it up, You scored $marks';
    } else {
      image = images[2];
      message = 'Congratulations You did it, You scored $marks';
    }
  }

  @override
  void initState() {
    checkingResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          Container(
            child: Material(
              shadowColor: Colors.blue[900].withOpacity(0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              elevation: 20.0,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 330,
                      height: 330,
                      padding: EdgeInsets.fromLTRB(40, 10, 30, 10),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "$message/60",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: Text('Back To Category'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CategoryItem(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '(Team Muphtah)'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      decorationColor: Colors.blue[900],
                      decorationStyle: TextDecorationStyle.dashed,
                      letterSpacing: 1.0,
                      decoration: TextDecoration.underline,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.blue,
                          offset: Offset.fromDirection(9.0),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 13,
            child: ListView.builder(
                itemCount: 60,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: Colors.white,
                      elevation: 3.0,
                      shadowColor: Colors.blue.shade300,
                      borderOnForeground: true,
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mydata[0][index.toString()].toString(),
                              style: GoogleFonts.aBeeZee(),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Answer: ' +
                                  mydata[2][index.toString()].toString(),
                              style: GoogleFonts.alike(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
