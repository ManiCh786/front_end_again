import 'package:flutter/material.dart';
import 'package:front_end/data/repository/assessments_repo.dart';
import 'package:get/get.dart';
import '../data/repository/repository.dart';
import '/data/repository/roles_repo.dart';
import '../models/models.dart';
import '../controllers/controller.dart';

class AssessmentsMarksController extends GetxController {
  final AssessmentsMarksRepo assMarksRepo;

  AssessmentsMarksController({
    required this.assMarksRepo,
  });

  bool _isLoading = false;
  get isLoading => _isLoading;

  RxList<dynamic> _assessmentsMarks = RxList<dynamic>();
  RxList<dynamic> get allAssessmentsMarks => _assessmentsMarks;

  RxList<dynamic> _everyAssessmentsMarks = RxList<dynamic>();
  RxList<dynamic> get everyAssessmentsMarks => _everyAssessmentsMarks;

  RxList<dynamic> _getAccomplishedObjectives = RxList<dynamic>();
  RxList<dynamic> get getAccomplishedObjectives => _getAccomplishedObjectives;

  Future<void> getAllAssessmentsMarks() async {
    _isLoading = true;
    update();
    Response response = await assMarksRepo.getAllAssessmentsMarks();
    if (response.statusCode == 200) {
      final responseBody = response.body;

      _assessmentsMarks = RxList<dynamic>();
      final RxList<dynamic> list = [].obs;
      _assessmentsMarks
          .addAll(responseBody.map((e) => AssessmentsMarksModel.fromJson(e)));
      _isLoading = false;
    } else {
      Get.snackbar("Failed", "Server Error Occurred !",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    _isLoading = false;
    update();
  }

  Future<void> getEveryInfoWithMarks() async {
    _isLoading = true;
    update();
    Response response = await assMarksRepo.getEveryInfoWithMarks();
    if (response.statusCode == 200) {
      final responseBody = response.body;

      _everyAssessmentsMarks = RxList<dynamic>();
      final RxList<dynamic> list = [].obs;
      _everyAssessmentsMarks
          .addAll(responseBody.map((e) => AssessmentsMarksModel.fromJson(e)));
      _isLoading = false;
    } else {
      Get.snackbar("Failed", "Server Error Occurred !",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> uploadAssMarksToDB(
      List<AssessmentsMarksModel> assMarksData) async {
    _isLoading = true;
    update();
    Response response = await assMarksRepo.addAssessmentsMarks(assMarksData);
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

  Future<void> getObjectivesAccomplishedReport() async {
    _isLoading = true;
    update();
    Response response = await assMarksRepo.getObjectivesAccomplishedReport();
    if (response.statusCode == 200) {
      final responseBody = response.body;

      _getAccomplishedObjectives = RxList<dynamic>();
      final RxList<dynamic> list = [].obs;
      _getAccomplishedObjectives.addAll(responseBody);
      _isLoading = false;
    } else {
      Get.snackbar("Failed", "Server Error Occurred !",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    _isLoading = false;
    update();
  }
}
