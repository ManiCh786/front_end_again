import 'package:get/get.dart';

import '../../controllers/controller.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../api/api_client.dart';

class EnrolledStudentsRepo extends GetxService {
  final ApiClient apiClient;
  EnrolledStudentsRepo({required this.apiClient});


  Future<Response> getAllEnrolledCourses() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(
      AppConstants.GET_ENROLLED_STUDENTS,
    );
  }
   Future<Response> enrollNewStudent(EnrolledStudentsModel studentData) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    // return await apiClient.postData(AppConstants.ADD_NEW_LECTURE, file)
    return await apiClient.postData(
        AppConstants.ENROLL_NEW_STUDENT, studentData.toJson());

    // return await apiClient.postData(AppConstants.ADD_NEW_LECTURE_INFO_TO_DB, pdf);
  }
}