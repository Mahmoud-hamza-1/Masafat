

 import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/class/crud.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/constant/routesname.dart';
import '../../../../core/function/checkinternet.dart';
import 'package:http/http.dart' as http;

import '../../../../link_api.dart';


class LoginData {

  Crud crud;
  LoginData(this.crud);
 
  postData(String password, String email) async {
    var response = await crud.postData(AppLink.loginApi, {
      "password": password,
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
