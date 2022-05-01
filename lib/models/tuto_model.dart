
//fonction tutoFromJson prend en paramètre une variable dynamique nommé str
//qui permet de convertir les données  de dynamic en json
List<Tuto> tutoFromJson(dynamic str)=>
    List <Tuto>.from((str).map((x)=>Tuto.fromJson(x)));


class Tuto {
  String titre;
  String text;
  String image ;

  Tuto({this.titre,this.text,this.image});

  Tuto.fromJson(Map<String,dynamic>json){
    titre=json["titre"];
    text=json["text"];
    image=json["image"];
  }
  Map<String,dynamic>toJson(){
    final _data= <String , dynamic>{};
    _data ["titre"]=titre;
    _data ["text"]=text;
    _data ["image"]=image;

    return _data;
    }
  }
