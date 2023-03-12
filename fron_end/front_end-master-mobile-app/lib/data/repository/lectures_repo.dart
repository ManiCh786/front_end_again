import 'dart:html';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../controllers/controller.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../api/api_client.dart';

class LecturesRepo extends GetxService {
  final ApiClient apiClient;
  LecturesRepo({required this.apiClient});
  Future<Response> getMyLecturesOutline() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(
      AppConstants.GET_MY_LECTURE_OUTLINE,
    );
  }

  Future<http.Response> getMyOutlineFile(String fileName, int userId) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);

    return await apiClient.downloadFile(
        "${AppConstants.BASE_URL}${AppConstants.DOWNLOAD_MY_OUTLINE}",
        fileName,
        userId);
  }

  Future<Response> uploadNewLecFile(file) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);

    // return await apiClient.postData(AppConstants.ADD_NEW_LECTURE, file)
    return await apiClient.postData(
        AppConstants.ADD_NEW_LECTURE_FILE_TO_SERVER, file);
  }

  Future<Response> uploadFileRecToDB(LecturesModel lecInfo) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    // return await apiClient.postData(AppConstants.ADD_NEW_LECTURE, file)
    return await apiClient.postData(
        AppConstants.ADD_NEW_LECTURE_INFO_TO_DB, lecInfo.toJson());

  } Future<Response> uploadMoreLecFile(LecturesModel lecInfo) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(
        AppConstants.UPLOAD_MORE_LEC_FILE, lecInfo.toJson());

  }

  Future<Response> approveOrRejectOutline(LecturesModel lecInfo) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(
        AppConstants.APPROVE_OR_REJECT_OUTLINE, lecInfo.toJson());
  }

  Future<Response> updateLectureOutline(LecturesModel lecInfo) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(
        AppConstants.UPDATE_OUTLINE_FILE, lecInfo.toJson());
  }
}
