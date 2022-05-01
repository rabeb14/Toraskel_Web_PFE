
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../models/tuto_model.dart';
import '../tutoService.dart';
import 'styles.dart';

List<DecorationImage> imageData = [image5, image3, image4, image2, image1];
/*
class Data {


  List<DecorationImage> imageD ;
  Data(){
    this.imageD=[];
    DataTuto();

  }
  void DataTuto() async {
    var response = await TutoService.getTutos();
    List d = [];
    response.forEach((element) {
     this.imageD.add(new DecorationImage(
        image: new NetworkImage(element.image),
        fit: BoxFit.cover,
      ));
      // print(d);
    });
  }
}*/
