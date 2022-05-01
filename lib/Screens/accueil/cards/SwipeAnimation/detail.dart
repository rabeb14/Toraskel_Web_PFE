import 'data.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/scheduler.dart';


class DetailPage extends StatefulWidget {
  final DecorationImage type;

  const DetailPage({Key key, @required this.type}) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState(type: type);

}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _DetailPageState extends State<DetailPage>
    with TickerProviderStateMixin {
   AnimationController _containerController;
   Animation<double> width;
   Animation<double> heigth;
   DecorationImage type;

  _DetailPageState({@required this.type});

  List data = imageData;
  double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>
      (
      begin: 200.0,
      end: 220.0,
    ).animate
      (
      new CurvedAnimation(parent: _containerController, curve: Curves.ease),
    );
    heigth = new Tween<double>
      (
      begin: 400.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(parent: _containerController, curve: Curves.ease,),
    );
    heigth.addListener
      (() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    }
    );
    _containerController.forward();
  }

  //------------------------------------------------------

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

//-------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    timeDilation = 0.7;
    int img = data.indexOf(type);
    //print("detail");
    return new Theme
      (
      data: new ThemeData
        (
        brightness: Brightness.light,
        primaryColor: const Color.fromRGBO(106, 94, 175, 1.0),
        platform: Theme
            .of(context)
            .platform,
      ),
      child: new Container
        (
        width: width.value,
        height: heigth.value,
        color: const Color.fromRGBO(111, 187, 152, 1),
        child: new Hero
          (
          tag: "img",
          child: new Card
            (
            color: Colors.transparent,
            child: new Container
              (
              alignment: Alignment.center,
              width: width.value,
              height: heigth.value,
              decoration: new BoxDecoration
                (
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>
              [
              new CustomScrollView
              (
              shrinkWrap: false,
                slivers: <Widget>
              [
              new SliverAppBar
              (
              elevation: 0.0,
                forceElevated: true,
                leading: new IconButton
                  (
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: new Icon(
                      Icons.arrow_back, color: Colors.white, size: 30.0),
                ),

                expandedHeight: _appBarHeight,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating ||
                    _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                flexibleSpace: new FlexibleSpaceBar
                  (
                  //title: new Text("Party"),
                  background: new Stack
                    (
                    fit: StackFit.expand,

                    children:[
                      new Container(
                        width: width.value,
                        height: _appBarHeight,
                        decoration: new BoxDecoration
                          (
                          image: data[img],
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),),
                    ],
                  ),
                ),
              ),
              new SliverList
                (
                delegate: new SliverChildListDelegate(<Widget>
                [
                new Container(
                color: Colors.white,
                child: new Padding
                (
                padding: const EdgeInsets.all(25.0),
                child: new Column
                  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                new Container
                (
                padding: new EdgeInsets.only(bottom: 15.0),
                alignment: Alignment.center,
                decoration: new BoxDecoration
                  (
                    color: Colors.white,
                    border: new Border
                      (
                        bottom: new BorderSide
                          (color: Colors.black12)
                    )
                ),
                child: new Row
                  (
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>
                  [
                    new Row
                      (
                      children: <Widget>
                      [
                        new Text("Titre", style: TextStyle(color: Color
                            .fromRGBO(22, 74, 88, 1), fontSize: 30))
                      ],
                    ),
                  ],
                ),
              ),

              new Text(
                  "It's party, party, party like a nigga just got out of jail Flyin' in my 'Rari like a bat that just flew outta hell I'm from the east of ATL, but ballin' in the Cali hills Lil mama booty boomin', that bitch movin' and she standin' still I know these bitches choosin' me, but I got 80 on me still. host for the purposes of socializing, conversation, recreation, or as part of a festival or other commemoration of a special occasion. A party will typically feature food and beverages, and often music and dancing or other forms of entertainment.  "),
              new Container(
                margin: new EdgeInsets.only(top: 25.0),
                padding: new EdgeInsets.only(top: 5.0, bottom: 10.0),
                height: 130.0,
                decoration: new BoxDecoration
                  (
                    color: Colors.white,
                    border: new Border
                      (
                        top: new BorderSide(color: Colors.black12)
                    )
                ),
                child: new Column
                  (
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    new Text("ATTENDEES",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        new CircleAvatar(backgroundImage: avatar1),
                        new CircleAvatar(backgroundImage: avatar2,),
                        new CircleAvatar(backgroundImage: avatar3,),
                        new CircleAvatar(backgroundImage: avatar4,),
                        new CircleAvatar(backgroundImage: avatar5,),
                        new CircleAvatar(backgroundImage: avatar6,)
                      ],
                    )
                  ],
                ),
              ),

              ],
            ),
          ),
                ),
          ],),
      ),
      ],


    ),
    ],
    ),
    ),
    ),
    ),
    )
    ,
    );
  }
}