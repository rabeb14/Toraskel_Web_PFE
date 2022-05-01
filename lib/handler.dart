import 'dart:convert';
import 'package:http/http.dart' as http;
import'package:logger/logger.dart';
class Handler
{
   //l'url de base
   String baseurl="http://192.168.1.11:8086";



   var log = Logger();
   Future<dynamic> get(String url)async
   {
      url=formater(url);

      var response = await http.get(url);
      if(response.statusCode==200||response.statusCode==201)
      {
         log.i(response.body);
         return json.decode(response.body);
      }

      log.i(response.body);
      log.i(response.statusCode);
   }
   Future<http.Response>post(String url,Map<String,String>body)async
   {
      url=formater(url);
      log.d(body);
      var response = await http.post(url,
          headers: {"Content-type":"application/json"},
          body:json.encode(body),
          );
   return response;
   }
      Future<http.Response>patch(String url,Map<String,String>body)async
   {
      url=formater(url);
      log.d(body);
      var response = await http.patch(url,
          headers: {"Content-type":"application/json"},
          body:json.encode(body),
          );
   return response;
   }
   String formater(String url) 
   {
      return baseurl+url;
   }
}