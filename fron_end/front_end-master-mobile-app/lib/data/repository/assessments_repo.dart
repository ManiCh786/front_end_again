import 'package:front_end/screens/faculty/faculty_Dashboard/lectures/addAssessments.dart';

import '../../controllers/controller.dart';
import '/data/api/api_client.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class AssessmentsRepo extends GetxService {
  final ApiClient apiClient;
  AssessmentsRepo({required this.apiClient});

  Future<Response> getMyAssessments() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_ASSESSMENTS_URI);
  }

  Future<Response> uploadNewAssessmentFile(file) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    // return await apiClient.postData(AppConstants.ADD_NEW_LECTURE, file)
    return await apiClient.postData(
        AppConstants.ADD_NEW_ASSESSMENTS_FILE_TO_SERVER, file);
  }

  Future<Response> addAssessmentsRecToDb(
      AssessmentsModel assessmentData) async {
    return await apiClient.postData(
        AppConstants.ADD_NEW_ASSESSMENTS_INFO_TO_DB, assessmentData.toJson());
  }

  Future<Response> addAssesmentsBreakdownStructure(
      List<DataModel> assessmentBreakDownData) async {
    return await apiClient.postData(AppConstants.ASSESSMENT_BREAKDOWN_STRUCTURE,
        {'data': assessmentBreakDownData.map((s) => s.toJson()).toList()});
  }

  Future<Response> sendResultToHod(int assessmentId) async {
    return await apiClient.postData(
        AppConstants.SEND_RESULT_TO_HOD, {'assessmentId': assessmentId});
  }

  Future<http.Response> getMyAssessmentsFile(
      String fileName, int userId) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.downloadFile(
        "${AppConstants.BASE_URL}${AppConstants.GET_ASSESSMENTS_FILE}",
        fileName,
        userId);
  }

  Future<http.Response> getMyAssessmentFile(String fileName, int userId) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.downloadFile(
        "${AppConstants.BASE_URL}${AppConstants.GET_ASSESSMENTS_FILE}",
        fileName,
        userId);
  }
}
