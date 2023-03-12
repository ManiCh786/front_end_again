import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/repository.dart';
import '../models/models.dart';

class EnrolledStudentsController extends GetxController {
  EnrolledStudentsController({
    required this.enrolledStRepo,
  });

  bool _isLoading = false;
  get isLoading => _isLoading;

  RxList<EnrolledStudentsModel> _getEnrolledStydentsObx =
      RxList<EnrolledStudentsModel>();
  RxList<EnrolledStudentsModel> get getEnrolledStydentsObx =>
      _getEnrolledStydentsObx;

  final EnrolledStudentsRepo enrolledStRepo;

  var selectedValues = Map<int, String>().obs;

  void setSelectedValue(int id, String value) {
    selectedValues[id] = value;
    update();
  }

  Future<void> getallEnrolledSudents() async {

    try {
      _isLoading = true;
      update();
      Response response = await enrolledStRepo.getAllEnrolledCourses();
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _getEnrolledStydentsObx = RxList();
        _getEnrolledStydentsObx.addAll((responseBody as List)
            .map((e) => EnrolledStudentsModel.fromJson(e))
            .toList());
        _isLoading = false;
        update();
      }
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      Get.back();
      Get.back();
    }
  }
   Future<ResponseModel> enrollNewStudent(studentData) async {
    _isLoading = true;
    update();
    Response response = await enrolledStRepo.enrollNewStudent(studentData);
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
