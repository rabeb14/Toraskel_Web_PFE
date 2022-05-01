import 'package:flutter/material.dart';

Positioned cardDemoDummy(
    // String img,
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return new Positioned(
    bottom: 50.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: 350/ 1.2 + cardWidth,
        height: 710/ 1.7,
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
                //
                image:img,
              ),
            ),
            new Container(
                width: screenSize.width / 1.2 + cardWidth,
                height: 710/ 1.7 - screenSize.height / 2.2,
                alignment: Alignment.center,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    new FlatButton(
                        padding: new EdgeInsets.all(20.0),
                        onPressed: () {},
                        child: new Container(
                          height: 50.0,
                          width: 50.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(24, 125, 135, 1),
                            borderRadius: new BorderRadius.circular(70.0),
                          ),
                            child: new Icon(Icons.arrow_right_alt_rounded,color: Colors.white,)
                        ))
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}
