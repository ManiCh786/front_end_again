import 'package:flutter/material.dart';
import 'package:front_end/data/repository/assessments_repo.dart';
import 'package:get/get.dart';
import '/data/repository/roles_repo.dart';
import '../models/models.dart';
import '../controllers/controller.dart';

class AssessmentsController extends GetxController {
  final AssessmentsRepo assRepo;
  AssessmentsController({
    required this.assRepo,
  });

  bool _isLoading = false;
  get isLoading => _isLoading;

  RxList<dynamic> _assessments = RxList<dynamic>();
  RxList<dynamic> get allAssessments => _assessments;

  Future<void> getAllAssessments() async {
    _isLoading = true;
    update();
    Response response = await assRepo.getMyAssessments();
    if (response.statusCode == 200) {
      final responseBody = response.body;

      _assessments = RxList<dynamic>();
      final RxList<dynamic> list = [].obs;
      _assessments
          .addAll(responseBody.map((e) => AssessmentsModel.fromJson(e)));
      _isLoading = false;
    } else {
      Get.snackbar("Failed", "Server Error Occurred !",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> uploadNewAssFile(assFile) async {
    _isLoading = true;
    update();
    Response response = await assRepo.uploadNewAssessmentFile(assFile);
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

  Future<ResponseModel> uploadAssFileRecToDB(AssessmentsModel assInfo) async {
    _isLoading = true;
    update();
    Response response = await assRepo.addAssessmentsRecToDb(assInfo);
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

  Future<ResponseModel> addAssessmentBreakdown(List<DataModel> assBreakdownData) async {
    _isLoading = true;
    update();
    Response response =
        await assRepo.addAssesmentsBreakdownStructure(assBreakdownData);
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

  downloadAssessemntFile(String fileName, int currentUserId) async {
    // final currentUserId = Get.find<UserAuthController>().getUserId();
    _isLoading = true;
    update();
    final response = await assRepo.getMyAssessmentFile(fileName, currentUserId);
    if (response.statusCode == 200) {
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> sendResultToHod(int assFile) async {
    _isLoading = true;
    update();
    Response response = await assRepo.sendResultToHod(assFile);
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
