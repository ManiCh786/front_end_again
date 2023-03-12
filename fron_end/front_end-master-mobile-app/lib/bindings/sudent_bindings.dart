import 'package:front_end/controllers/lecturesController.dart';
import 'package:front_end/data/repository/assessments_repo.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';
import '../data/repository/lectures_repo.dart';
import '../data/repository/repository.dart';

class StudentsBindings implements Bindings {
  @override
  void dependencies() {
    // repos

    Get.put<EnrolledStudentsRepo>(EnrolledStudentsRepo(apiClient: Get.find()));

    Get.put<EnrolledStudentsController>(
        EnrolledStudentsController(enrolledStRepo: Get.find()));

    Get.put<CoursesRepo>(CoursesRepo(apiClient: Get.find()));
    Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));

    Get.put<StartEnrollmentRepo>(StartEnrollmentRepo(apiClient: Get.find()));
    Get.put<EnrollmentsScheduleController>(
        EnrollmentsScheduleController(enrScheduleRepo: Get.find()));

    Get.put<AssessmentsMarksRepo>(AssessmentsMarksRepo(apiClient: Get.find()));

    Get.put<AssessmentsMarksController>(
        AssessmentsMarksController(assMarksRepo: Get.find()));
    Get.put<AssessmentsRepo>(AssessmentsRepo(apiClient: Get.find()));

    Get.put<AssessmentsController>(AssessmentsController(assRepo: Get.find()));

    Get.put<LecturesRepo>(LecturesRepo(apiClient: Get.find()));

    Get.put<LecturesController>(LecturesController(lecRepo: Get.find()));
  }
}
