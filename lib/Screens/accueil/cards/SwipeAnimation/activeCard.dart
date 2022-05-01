import 'dart:math';

import 'detail.dart';
import 'package:flutter/material.dart';

Positioned cardDemo(
   // String img,
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return new Positioned(
    bottom: 50.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
        //print("here");
        // setState(() {
        //   var i = data.removeLast();

        //   data.insert(0, i);
        // });
      },
      //donne acces ou la permission de swiper la carte suivante
      onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
        if (direction == DismissDirection.endToStart)
          dismissImg(img);
        else
          addImg(img);
      },
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: new Hero(
            tag: "img",
            child: new GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => new DetailPage(type: img)));
                Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new DetailPage(type: img),
                    ));
              },
              child: new Card(
                color: Colors.transparent,
                elevation: 4.0,
                child: new Container(
                  alignment: Alignment.center,
                  width: 350/ 1.2 + cardWidth,//width de la carte
                  height: 710 / 1.7, // height de la partie mauve
                  decoration: new BoxDecoration(
                    color: new Color.fromRGBO(199, 229, 229, 1.0),
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 2.2,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(20.0),
                              topRight: new Radius.circular(20.0)),
                          // image: new DecorationImage(
                          //   image: new NetworkImage(img),
                          //   fit: BoxFit.cover,
                          // ),
                          image:img,
                        ),
                      ),
                      new Container(
                          width: screenSize.width / 1.2 + cardWidth,
                          height:
                              710 / 1.7 - screenSize.height / 2.2, // height du button
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              new FlatButton(
                                  padding: new EdgeInsets.all(20.0),

                                  onPressed: () {
                                    swipeRight();
                                  },
                                  child: new Container(
                                    height: 50.0,
                                    width: 50.0,
                                    alignment: Alignment.topCenter,
                                    decoration: new BoxDecoration(
                                      color: Color.fromRGBO(24, 125, 135, 1),
                                      borderRadius:
                                          new BorderRadius.circular(70.0),
                                    ),
                                    child: new Icon(Icons.arrow_right_alt_rounded,color: Colors.white,)
                                    ),
                                  )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
