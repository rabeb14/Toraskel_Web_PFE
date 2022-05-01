import 'dart:convert';

import 'package:flutter/material.dart';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    @required this.message,
    @required this.data,
  });
   String message;
   String data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data;
    return _data;
  }
}
