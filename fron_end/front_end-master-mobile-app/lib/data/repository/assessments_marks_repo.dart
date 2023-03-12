import '../../controllers/controller.dart';
import '/data/api/api_client.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class AssessmentsMarksRepo extends GetxService {
  final ApiClient apiClient;
  AssessmentsMarksRepo({required this.apiClient});

  Future<Response> getAllAssessmentsMarks() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_ASSESSMENTS_GRADES);
  }

  Future<Response> getEveryInfoWithMarks() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_EVERYINFOWITHMARKS);
  }

  Future<Response> addAssessmentsMarks(
      List<AssessmentsMarksModel> assessmentradesData) async {
    // print("qno is ");
    // print(assessmentradesData.map((e) => e.qno));
    return await apiClient.postData(AppConstants.ADD_ASSESSMENTS_GRADES,
        {'students': assessmentradesData.map((s) => s.toJson()).toList()});
  }

  Future<Response> getObjectivesAccomplishedReport() async {
    return await apiClient.getData(AppConstants.GET_ACCOMPLISHED_OBJECTIVES);
  }
}
