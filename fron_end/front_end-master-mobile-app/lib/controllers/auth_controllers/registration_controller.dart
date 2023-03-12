
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/repository.dart';
import '../../models/models.dart';

class RegistrationController extends GetxController{
  final RegistrationRepository regRepo;
  RegistrationController({
    required this.regRepo,
});
  bool  _isLoading = false;
  get isLoading => _isLoading;
  List<dynamic>  _registeredUsersList = [] ;
  List<dynamic> get registeredUsersList => _registeredUsersList;

Future<void> getRegisteredUsers() async{
  _isLoading = true;
  update();
  Response response = await regRepo.getRegisteredUsers();
  if(response.statusCode == 200){
    final responseBody = response.body;
    _registeredUsersList = [];
    _registeredUsersList.addAll(responseBody.map((e)=>RegistrationModel.fromJson(e)));
    _isLoading = false;
    update();
  }else{
    Get.snackbar("Failed", "Failed to Load Data from Database",backgroundColor: Colors.red,colorText: Colors.white);
    throw Exception('Failed to load Registered Users From DataBase');
  }
}
  Future<ResponseModel> registerNewUser(RegistrationModel registrationData) async{
    _isLoading = true;
    update();
    Response response = await regRepo.registerNewUser(registrationData);
    late ResponseModel responseModel ;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, response.body['message'].toString());
    }else{
      responseModel = ResponseModel(false, response.body['message'].toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> deleteRegUser(RegistrationModel regUserData) async{
  _isLoading = true;
  update();
  Response response = await regRepo.deleteRegUser(regUserData);
  late ResponseModel responseModel;
  if(response.statusCode == 200){
    responseModel = ResponseModel(true, response.body['message'].toString());

  }else{
    responseModel = ResponseModel(false, response.body['message'].toString());

  }
  _isLoading = false;
  Get.back();
  update();
  return responseModel;
  }
  Future<ResponseModel> assignRoleToRegUser(data) async{
    _isLoading = true;
    update();
  Response response = await regRepo.assignRoleToRegUser(data);
  late ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, response.body['message'].toString());
      _isLoading = false;

    }else{
      responseModel = ResponseModel(false, response.body['message'].toString());
      _isLoading = false;

    }
    update();
    Get.back();
    return responseModel;

  }
}