import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/repository/roles_repo.dart';
import '../models/models.dart';
import '../controllers/controller.dart';


class RolesController extends GetxController {
  final RolesRepo rolesRepo;
  RolesController({
    required this.rolesRepo,
  });
  var controller = Get.find<UserAuthController>();
    var _dropdownInitialValue ;
  set dropdownInitialValue (value) {
    _dropdownInitialValue = value;
    update();
  }
  get dropdownInitialValue => _dropdownInitialValue;


  String _dropdownPlaceholder ="Select A Role";
  get dropdownPlaceholder => _dropdownPlaceholder;
  set dropdownPlaceholder (value){
    _dropdownPlaceholder = value;
    update();
  }


  bool _isLoading = false;
   get isLoading => _isLoading;


  RxList _rolesModel = [].obs;
  RxList get rolesModel => _rolesModel;


  Future<void> getAllRoles() async {
      _isLoading = true;
      update();
      Response response = await rolesRepo.getRoles();
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _rolesModel = [].obs;
        _rolesModel.addAll(responseBody.map((e)=>RolesModel.fromJson(e)));
        _isLoading = false;
      } else {
        Get.snackbar("Failed", "Server Error Occurred !",backgroundColor: Colors.red,colorText: Colors.white);

      }
      // _isLoading = false;
      update();

  }
 Future<ResponseModel> addRole(RolesModel roleData) async{
    _isLoading = true;
    update();
    Response response = await rolesRepo.addRole(roleData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body['message'].toString());
      responseModel = ResponseModel(response.body['success'], response.body['message'].toString());
    } else{
      print(response.statusCode);
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> deleteTheRole(RolesModel roleId) async{
    _isLoading = true;
    update();
    Response response = await rolesRepo.deleteTheRole(roleId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(response.body['success'], response.body['message'].toString());


    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");

    }
    _isLoading = false;
    Get.back();
    update();
    return responseModel;
  }
}
