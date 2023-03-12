import '/data/repository/auth_repository/auth_repository.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';

class UserAuthController extends GetxController implements GetxService {
  final UserAuthRepo userAuthRepo;
  UserAuthController({
    required this.userAuthRepo,
  });
  bool _isLoading = false;
  UsersModel _loggedInUserInfo = new  UsersModel();
  get isLoading => _isLoading;
  UsersModel get loggedInUserInfo => _loggedInUserInfo;
  List<dynamic> _allUsersList = [];
  List<dynamic> get allUsersList => _allUsersList;
  List<dynamic> _allFacultyMembers = [];
  List<dynamic> get allFacultyMembers => _allFacultyMembers;

  var _dropdownInitialValue;
  set dropdownInitialValue(value) {
    _dropdownInitialValue = value;
    update();
  }

  get dropdownInitialValue => _dropdownInitialValue;

  String _dropdownPlaceholder = "Select A Instructor";
  get dropdownPlaceholder => _dropdownPlaceholder;
  set dropdownPlaceholder(value) {
    _dropdownPlaceholder = value;
    update();
  }

  Future<ResponseModel> login(data) async {
    _isLoading = true;
    update();
    Response response = await userAuthRepo.login(data);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Token Is ${response.body['token']}");
      userAuthRepo.saveUserToken(response.body['token']);
      userAuthRepo.saveUserEmailAndAccountType(
          response.body['email'] ?? 'none',
          response.body['accountType'] ?? 'none',
          response.body['userId'] ?? '');
      responseModel =
          ResponseModel(true, response.body['verifiedAddress'].toString());
    } else {
      responseModel = ResponseModel(false, response.body['message'].toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email) async {
    _isLoading = true;
    update();
    Response response = await userAuthRepo.login(email);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel =
          ResponseModel(true, response.body['verifiedAddress'].toString());
    } else {
      responseModel =
          ResponseModel(false, response.body['verifiedAddress'].toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getAllUsers() async {
    _isLoading = true;
    update();
    Response response = await userAuthRepo.getAllUsers();
    if (response.statusCode == 200) {
      final responseBody = response.body;
      _allUsersList = [];
      _allUsersList.addAll(responseBody.map((e) => UsersModel.fromJson(e)));
      _isLoading = false;
      update();
    } else {
      Get.snackbar("Failed", "Failed to Load Data from Database",
          backgroundColor: Colors.red, colorText: Colors.white);
      throw Exception('Failed to load Data From DataBase');
    }
  }

  Future<void> getAllFacultyMembers() async {
    _isLoading = false;
    update();
    Response response = await userAuthRepo.getAllFacultyMembers();
    if (response.statusCode == 200) {
      final responseBody = response.body;
      _allFacultyMembers = [];
      _allFacultyMembers
          .addAll(responseBody.map((e) => UsersModel.fromJson(e)));
      _isLoading = false;
      update();
    } else {
      Get.snackbar("Failed", "Failed to Load Data from Database",
          backgroundColor: Colors.red, colorText: Colors.white);
      throw Exception('Failed to load Data From DataBase');
    }
  }

  Future<ResponseModel> getLoggedInUserInfo() async {
    _isLoading = true;
    update();
    Response response = await userAuthRepo.getLoggedInUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      final responseBody = response.body;
      _loggedInUserInfo = UsersModel();
      _loggedInUserInfo = UsersModel.fromJson(responseBody);
      responseModel = ResponseModel(true, "Success");
    } else {
      final responseBody = response.body;
      _loggedInUserInfo = UsersModel.fromJson(responseBody);
      responseModel = ResponseModel(false, "Failed");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserEmailAndAccountType(
      String email, String accountType, int userId) {
    userAuthRepo.saveUserEmailAndAccountType(email, accountType, userId);
  }

  bool isUserLoggedIn() {
    return userAuthRepo.userLoggedIn();
  }

  String? getUserToken() {
    return userAuthRepo.getUserToken();
  }

  String userAccountType() {
    if (isUserLoggedIn()) {
      return userAuthRepo.getUserAccountType();
    } else {
      return "Not Logged In";
    }
  }
  int getUserId() {
    if (isUserLoggedIn()) {
      return userAuthRepo.getUserId();
    } else {
      return 0;
    }
  }

  bool logout() {
    return userAuthRepo.logout();
  }
}
