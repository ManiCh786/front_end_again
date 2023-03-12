import '../../controllers/controller.dart';
import '/data/api/api_client.dart';
import 'package:get/get.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class CoursesRepo extends GetxService {
  final ApiClient apiClient;
  CoursesRepo({required this.apiClient});
  Future<Response> getMyCourses() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_MY_COURSES_URL);
  }

  Future<Response> getAllCourses() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_ALL_COURSES_URL);
  }

  Future<Response> getAllAssignedCourses() async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_ALL_ASSIGNED_COURSES_URL);
  }

  Future<Response> getCourseObjectives(courseId) async {
    final token = Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient
        .postData(AppConstants.GET_COURSE_OBJECTIVES, {'courseId': courseId});
  }

  Future<Response> addCourse(CoursesModel courseData) async {
    return await apiClient.postData(
        AppConstants.ADD_COURSE_URL, courseData.toJson());
  }

  Future<Response> addCourseObjectives(
      CourseObjectivesModel courseObjectivesData) async {
    return await apiClient.postData(
        AppConstants.ADD_COURSE_OBJECTIVES, courseObjectivesData.toJson());
  }

  Future<Response> addCourseObjectivesBreakdown(
      List<CourseObjectivesModel> courseObjectivesData) async {
    return await apiClient.postData(AppConstants.ADD_OBJECTIVE_BREAKDOWN,
        {'data': courseObjectivesData.map((s) => s.toJson()).toList()});
  }

  Future<Response> assignCourseToInstructor(data) async {
    return await apiClient.postData(
        AppConstants.ASSIGN_COURSE_TO_INSTRUCTOR, data);
  }

  Future<Response> addCourseOutcomes(data) async {
    return await apiClient.postData(AppConstants.ADD_COURSE_OUTCOMES, data);
  }
  // Future<Response> deleteCourse(RolesModel roleData) async{
  //   return await apiClient.postData(AppConstants.DELETE_ROLE_URL, roleData.toJson());
  // }
}
