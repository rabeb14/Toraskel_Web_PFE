import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:try1/Screens/accueil/cards/config.dart';
import 'package:try1/models/tuto_model.dart';

class TutoService {
static var client = http.Client();


//nous avons céée un client
// developpé la fonction getTuto  qui va retourné une liste de tuto
//nous avons créée une variable intitulé requestHeaders qui représente le type de contenu qui est json
//nous avons céée une variable url qui contient l'url de l'execution de l'application
// nous avons fait appele a la fonction get du back qui prend en paramètre l'url et le type de contenu qu'on va recevoir et on l'a mis dans une variable intitulé response
// maintenant si le status de la variable ==200
// decodé le contenu de response et mettez le dans la variable data puis retourné la (pour afficher le resultat)
  //sinon retourné null

  static Future<List<Tuto>> getTutos() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json',};
    var url = Uri.http(Config.apiURL, Config.tutoURL);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200 || response.statusCode == 201)
    {
      var data = jsonDecode(response.body);
      return tutoFromJson(data["data"]);
    } else {
      return null;
    }
  }
  //-----------------------------------------------------------------------------

   static Future getImage() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json',};
    var url = Uri.http(Config.apiURL, Config.tutoURL);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200 || response.statusCode == 201)
    {
      var data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }
//---------------------------------------------------------------------------
  static Future<bool> createTuto(
    Tuto model,
    bool isEditMode,
  ) async {
    var tutoURL = Config.tutoURL;
    if (isEditMode) {tutoURL = tutoURL + "/" + model.titre;}
    var url = Uri.http(Config.apiURL, Config.tutoURL);
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);
    request.fields["text"] = model.text;
    request.fields["image"] = model.image;
    if (model.image != null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', model.image,);
      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//-------------------------------------------------------------------------

  static Future<bool> deleteTuto(titre) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.tutoURL+"/"+titre);
    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200)
    {
      return true;
    } else {
      return false;
    }
  }
}


//A Future class permits you to run work asynchronously to let loose whatever other threads ought not to be obstructed
// the execution of the code within the caller suspends while the async operation is executed
