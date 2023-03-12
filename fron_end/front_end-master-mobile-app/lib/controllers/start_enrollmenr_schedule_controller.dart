import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repository/repository.dart';
import '../models/models.dart';

class EnrollmentsScheduleController extends GetxController {
  final StartEnrollmentRepo enrScheduleRepo;
  EnrollmentsScheduleController({required this.enrScheduleRepo});

  bool _isLoading = false;
  get isLoading => _isLoading;

  var _sessionDropdownInitialValue;
  set sessionDropdownInitialValue(value) {
    _sessionDropdownInitialValue = value;
    update();
  }

  get sessionDropdownInitialValue => _sessionDropdownInitialValue;

  String _sessionDropdownPlaceholder = "Select Session";
  get sessionDropdownPlaceholder => _sessionDropdownPlaceholder;
  set sessionDropdownPlaceholder(value) {
    _sessionDropdownPlaceholder = value;
    update();
  }

  RxList<dynamic> _enrollmentSchedules = RxList<dynamic>();
  RxList<dynamic> get allEnrollmentSchedules => _enrollmentSchedules;

  Future<void> getAllEnrollmentSchedules() async {
    _isLoading = true;
    update();
    Response response = await enrScheduleRepo.getEnrollmentSchedules();
    if (response.statusCode == 200) {
      final responseBody = response.body;

      _enrollmentSchedules = RxList<dynamic>();
      final RxList<dynamic> list = [].obs;
      _enrollmentSchedules
          .addAll(responseBody.map((e) => StartEnrollmentModel.fromJson(e)));
      _isLoading = false;
    } else {
      Get.snackbar("Failed", "Server Error Occurred !",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> addEnrollmentSchedule(
      StartEnrollmentModel scheduleData) async {
    _isLoading = true;
    update();
    Response response =
        await enrScheduleRepo.addNewEnrollmentSchedule(scheduleData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> extendEnrollmentDate(
      StartEnrollmentModel scheduleData) async {
    _isLoading = true;
    update();
    Response response =
        await enrScheduleRepo.extendEnrollmentDate(scheduleData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
