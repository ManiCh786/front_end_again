import '/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class StartEnrollmentRepo extends GetxService {
  final ApiClient apiClient;
  StartEnrollmentRepo({required this.apiClient});

  Future<Response> getEnrollmentSchedules() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_ENROLLMENT_SCHEDULES);
  }

  Future<Response> addNewEnrollmentSchedule(
      StartEnrollmentModel scheduleData) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(
        AppConstants.ADD_NEW_ENROLLMENT_SCHEDULE, scheduleData.toJson());
  }

  Future<Response> extendEnrollmentDate(
      StartEnrollmentModel scheduleData) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(
        AppConstants.UPDATE_ENROLLMENT_SCHEDULE, scheduleData.toJson());
  }
}
