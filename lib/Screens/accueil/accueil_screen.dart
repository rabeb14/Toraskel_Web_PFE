import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:try1/components/curved_navigation_bar.dart';

import 'cards/SwipeAnimation/activeCard.dart';
import 'cards/SwipeAnimation/data.dart';
import 'cards/SwipeAnimation/dummyCard.dart';
import 'cards/tutoService.dart';


class Accueil_screen extends StatefulWidget {
  const Accueil_screen({Key key}) : super(key: key);

  @override
  _Accueil_screenState createState() => _Accueil_screenState();
}

class _Accueil_screenState extends State<Accueil_screen> with TickerProviderStateMixin  {

  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0; //contient  des infos sur l'activité d'un utilisateur (role general)

  List data = imageData;// jeya mel data.dart
  List selectedData = [];

  void initState() {
    super.initState();
    //DataTuto();
    // Timer.run(()async {
    //
    //   var response = await TutoService.getTutos();
    //   List d=[];
    //   response.forEach((element) {
    //     d.add(new DecorationImage(
    //       image: new NetworkImage(element.image),
    //       fit: BoxFit.cover,
    //     ));
    //     // print(d);
    //   });
    //   setState(() {
    //     this.data=d;
    //   });
    //
    // });
   // print(data);

    _buttonController = new AnimationController(
      //durée de lanimation
        duration: new Duration(milliseconds: 1000), vsync: this);

    //rotation de l'animation de la carte
    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      //
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    //after thend of animation we destroy the buttonController
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }
  //supprimer l'image a chaque fois qu'on swipe
  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }
//afficher l'image de la card selectionner
  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }
//si on swipe a droite
  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    //lapse de temps du swipe
    timeDilation = 0.4;
    //le décalage des cards
    double initialBottom = 20.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -50.0;

    return  Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Accueil"),
          backgroundColor: Color.fromRGBO(31, 164, 145, 121),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {

                // do something
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),

          ],
        ),

        body: new Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: dataLength > 0
              ? new Stack(
            //alignement des cartes par rapport a la bg
              alignment: AlignmentDirectional.center,
              children: data.map((item) {
                if (data.indexOf(item) == dataLength - 1) {
                  return cardDemo(
                      item,
                      bottom.value,
                      right.value,
                      0.0,
                      backCardWidth + 10,//front card width
                      rotate.value,
                      rotate.value < -10 ? 0.1 : 0.0,
                      context,
                      dismissImg,
                      flag,
                      addImg,
                      swipeRight,
                      swipeLeft);
                } else {
                  backCardPosition = backCardPosition - 10;
                  backCardWidth = backCardWidth + 10;

                  return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                      backCardWidth, 0.0, 0.0, context);
                }
              }).toList())
              : new Text("Félicitation vous avez lu toutes les cartes ",
              style: new TextStyle(color: Color.fromRGBO(111, 187, 152, 1), fontSize: 30.0),textAlign: TextAlign.center),
        ),

        bottomNavigationBar: SizedBox(height: 80, child:CurvedNavigationBar(

            items: [

              Icon(
                  Icons.home,
                  size: 30,
                  color:Color.fromRGBO(111, 187, 152, 1),
              ),
              Icon(
                  Icons.wifi_protected_setup_rounded,
                  size: 30,
                  color:Color.fromRGBO(111, 187, 152, 1)
              ),
              Icon(
                  Icons.wallet_giftcard_rounded,
                  size: 30,
                  color:Color.fromRGBO(111, 187, 152, 1)
              ),
              Icon(
                  Icons.wallpaper_rounded,
                  size: 30,
                  color:Color.fromRGBO(111, 187, 152, 1)
              ),

            ]

        ),


        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
/*
  void DataTuto() async {

    var response = await TutoService.getTutos();
    List d=[];
    response.forEach((element) {
      d.add(element.image);
      print(d);
    });
    setState(() {
      this.data=d;
    });

  }*/
}




