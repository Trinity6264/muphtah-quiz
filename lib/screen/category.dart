import 'dart:ui';
import 'package:mutapha/screen/coursectegory.dart';
import 'package:mutapha/screen/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryItem extends StatelessWidget {
  static String coursename;

  void urlWhatsapp({@required number, @required message}) async {
    String url = 'whatsapp://send?phone=$number&text=$message';
    await canLaunch(url) ? launch(url) : print('Cant open whatsapp');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.7),
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            title: Text(
              'Exit',
              style: TextStyle(color: Colors.black),
            ),
            content: Text('Are you sure you want to exit?'),
            titleTextStyle: TextStyle(
              fontSize: 18.0,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.canPop(context),
                child: Text('Yes'),
                style: ButtonStyle(),
              ),
            ],
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/aa.jpg'), fit: BoxFit.cover),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 2.0,
            ),
            child: Container(
              width: size.width,
              height: size.width - 200,
              child: Scaffold(
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.black38,
              elevation: 9.0,
              title: Text(
                'Category',
                style: GoogleFonts.aladin(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    urlWhatsapp(number: '+233557758141', message: 'hi');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 28,
                          child: CircleAvatar(
                            maxRadius: 25.0,
                            backgroundImage: AssetImage(
                              'image/mujeeb.jpg',
                            ),
                          ),
                        ),
                        Positioned(
                          left: 35,
                          bottom: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  minRadius: 7,
                                  child: CircleAvatar(
                                    minRadius: 6,
                                    backgroundColor: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 3.0, right: 10.0),
                  child: Text(
                    'online',
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.black26,
            body: ListView.builder(
              itemCount: categories.length,
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    return showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        scrollable: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        title: Text(
                          'To Quiz Page',
                          style: TextStyle(color: Colors.black),
                        ),
                        content: Text(
                            'Please note you can\'t go back after you start quiz'),
                        titleTextStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Back to Page'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PQuestions(categories[index].courseName),
                              ),
                            ),
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Cat(
                    description: categories[index].description,
                    image: categories[index].imageUrl,
                    subtitle: categories[index].courseName,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Cat extends StatelessWidget {
  final String image;
  final String subtitle;
  final String description;
  final int index;
  const Cat({
    Key key,
    this.index,
    @required this.image,
    @required this.subtitle,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double consize = size.width * 0.80;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Container(
        width: consize,
        height: consize,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 0.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 0.1,
                    spreadRadius: 5.0,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      width: 200,
                      height: 180,
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.low,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  child: Text(
                    subtitle,
                    style: GoogleFonts.alike(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
                  child: Align(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
