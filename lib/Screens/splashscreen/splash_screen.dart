import 'package:flutter/material.dart';
import 'package:try1/Screens/splashscreen/components/content_model.dart';
import 'package:try1/Screens/Access_verification/access_verification_screen.dart';
import 'package:lottie/lottie.dart';
import '../../constants.dart';


class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  int currentIndex = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
                  child: Column(
                    children: [
                      Lottie.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      SizedBox(height: 30),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 80, 80, 80),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(30),
            width: double.infinity,
            child: FlatButton(
              child: Text(
                  currentIndex == contents.length - 1 ? "Continuer" : "Continuer"),
              onPressed: () {
                 if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AccessVerificationScreen(),
                    ),
                  );
                } 
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
                
              },
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kPrimaryColor,
      ),
    );
  }
}