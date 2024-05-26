import 'package:ecommerce_application/core/constant/routesname.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/crud.dart';
import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/auth/login_data.dart';
import '../../data/handling_data.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
  showPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  bool isShow = true;
  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.put(Crud()));
  static var token = '';



  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(password.text, email.text);
      print("=============controller $response");
      statusRequest = handlingData(response);
      print('object');
      print(response);
      if (StatusRequest.success == statusRequest) {
        print('fff');
        if (response['message'] == "Login successful!") {
          String name = response['data']['name'];
          token = response['access_token'];
          print("-------------------------------");
          print(token);
          Get.offNamed(AppRoute.successSignUP);
        }
        print('no success');
      }
      update();
    } else {
      print(" not valid");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  showPassword() {
    isShow = isShow == true ? false : true;
    update();
  }
}
