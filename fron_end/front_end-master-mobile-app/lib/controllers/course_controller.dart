import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/repository.dart';
import '../models/models.dart';

class CoursesController extends GetxController {
  final CoursesRepo courseRepo;
  late CoursesModel courses;
  final List<String> bloomsTaxonomyLevels = [
    "Level1-Create",
    "Level2-Evaluate",
    "Level3-Analyze",
    "Level4-Apply",
    "Level5-Understand",
    "Level6-Remember"
  ];
  // @override
  // onInit(){
  //   super.onInit();
  //   courses = Get.arguments['courses']??"";
  //   print("Courses Are ${courses}");
  //   update();
  // }

  var _semDropdownInitialValue;
  set semDropdownInitialValue(value) {
    _semDropdownInitialValue = value;
    update();
  }

  get semDropdownInitialValue => _semDropdownInitialValue;

  String _semdropdownPlaceholder = "Select Semester";
  get dropdownPlaceholder => _semdropdownPlaceholder;
  set dropdownPlaceholder(value) {
    _semdropdownPlaceholder = value;
    update();
  }

  var _depDropdownInitialValue;
  set depDropdownInitialValue(value) {
    _depDropdownInitialValue = value;
    update();
  }

  get depDropdownInitialValue => _depDropdownInitialValue;

  String _depDropdownPlaceholder = "Select Department";
  get depDropdownPlaceholder => _depDropdownPlaceholder;
  set depDropdownPlaceholder(value) {
    _depDropdownPlaceholder = value;
    update();
  }

  var _sessionDropdownInitialValue;
  set sessionDropdownInitialValue(value) {
    _sessionDropdownInitialValue = value;
    update();
  }

  get sessionDropdownInitialValue => _sessionDropdownInitialValue;

  String _sessionDropdownPlaceholder = "Select Session";
  get sessionDropdownPlaceholder => _sessionDropdownPlaceholder;
  set sessionDropdownPlaceholder(value) {
    _sessionDropdownPlaceholder = value;
    update();
  }

  String _sessionFilterDropDownPlaceholder = "Select Session";
  get sessionFilterDropDownPlaceholder => _sessionFilterDropDownPlaceholder;
  set sessionFilterDropDownPlaceholder(value) {
    _sessionFilterDropDownPlaceholder = value;
    update();
  }

  var sessionFilter = "fall".obs;
  setSession(String value) {
    sessionFilter.value = value;
  }

  String _yearFilterDropDownPlaceholder = "Select Year";
  get yearFilterDropDownPlaceholder => _yearFilterDropDownPlaceholder;
  set yearFilterDropDownPlaceholder(value) {
    _yearFilterDropDownPlaceholder = value;
    update();
  }

  // DateTime.now().year
  var yearFilter = DateTime.now().year.toString().obs;
  setYear(String value) {
    yearFilter.value = value;
  }

  String _bTLFilterDropDownPlaceholder = "Select BT Level";
  get bTLFilterDropDownPlaceholder => _bTLFilterDropDownPlaceholder;
  set bTLFilterDropDownPlaceholder(value) {
    _bTLFilterDropDownPlaceholder = value;
    update();
  }

  String selectedbTLevel = "Level1-Create";
  setLevel(String value) {
    selectedbTLevel = value;
  }

  final _selectedbTLevelObsPlaceholder = ("Select BT Level").obs;
  String get selectedbTLevelObsPlaceholder =>
      _selectedbTLevelObsPlaceholder.value;
  set selectedbTLevelObsPlaceholder(String newValue) =>
      _selectedbTLevelObsPlaceholder.value = newValue;

  final _selectedbTLevelObs = ("Level1-Create").obs;
  String get selectedbTLevelObs => _selectedbTLevelObs.value;
  set setSelectedbTLevelObs(String newValue) =>
      _selectedbTLevelObs.value = newValue;

// For Add Objectives Drop down
  final _selectedObjectivesObsPlaceholder = ("Select Objectives ").obs;
  String get selectedObjectivesObsPlaceholder =>
      _selectedObjectivesObsPlaceholder.value;
  set selectedObjectivesObsPlaceholder(String newValue) =>
      _selectedObjectivesObsPlaceholder.value = newValue;

  final _selectedObjectivesObs = ('').obs;
  String get selectedObjectivesObs => _selectedObjectivesObs.value;
  set setSelectedObjectivesObs(String newValue) =>
      _selectedObjectivesObs.value = newValue;

  bool _isLoading = false;
  get isLoading => _isLoading;
  RxList<dynamic> _myCourses = <dynamic>[].obs;
  List<dynamic> get myCourses => _myCourses;
  List<dynamic> _allCourses = [];
  List<dynamic> get allCourses => _allCourses;
  List<dynamic> _allAssignedCourses = [];
  List<dynamic> get allAssignedCourses => _allAssignedCourses;
  RxList<CourseObjectivesModel> _courseObjectives =
      RxList<CourseObjectivesModel>();
  RxList<dynamic> get courseObjectives => _courseObjectives;

  CoursesController({
    required this.courseRepo,
  });

  Future<ResponseModel> addCourse(CoursesModel courseData) async {
    _isLoading = true;
    update();
    Response response = await courseRepo.addCourse(courseData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> addCourseObjective(
      CourseObjectivesModel courseObjectivesData) async {
    _isLoading = true;
    update();
    Response response =
        await courseRepo.addCourseObjectives(courseObjectivesData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> addCourseObjectiveBreakdown(
      List<CourseObjectivesModel> courseObjectivesData) async {
    _isLoading = true;
    update();
    Response response =
        await courseRepo.addCourseObjectivesBreakdown(courseObjectivesData);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> assignCourseToInstructor(data) async {
    _isLoading = true;
    update();
    Response response = await courseRepo.assignCourseToInstructor(data);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> addCourseOutcomes(data) async {
    _isLoading = true;
    update();
    Response response = await courseRepo.addCourseOutcomes(data);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "Server Error Occurred !");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getMyCourses() async {
    _isLoading = true;
    update();
    Response response = await courseRepo.getMyCourses();
    try {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _myCourses = [].obs;
        final RxList<dynamic> list = [].obs;
        list.addAll(responseBody.map((e) => CoursesModel.fromJson(e)));
        _myCourses = list
            .where((e) =>
                e.session
                    .toString()
                    .toLowerCase()
                    .contains(sessionFilter.value) &&
                e.createdAt.toString().toLowerCase().contains(yearFilter.value))
            .toList()
            .obs;

        // _myCourses = list.where((h) => h.courseId.toString().contains(2.toString())).toList().obs;
        _isLoading = false;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCourseObjectives(courseId) async {
    _isLoading = true;
    update();
    Response response = await courseRepo.getCourseObjectives(courseId);
    try {
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _courseObjectives = RxList<CourseObjectivesModel>();
        _courseObjectives.addAll((responseBody as List)
            .map((e) => CourseObjectivesModel.fromJson(e))
            .toList());
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
      }
    } catch (e) {
      _isLoading = false;
      update();
      print(e);
    }
  }

  Future<void> getAllCourses() async {
    _isLoading = true;
    update();
    Response response = await courseRepo.getAllCourses();
    if (response.statusCode == 200) {
      final responseBody = response.body;
      _allCourses = [];
      _allCourses.addAll(responseBody.map((e) => CoursesModel.fromJson(e)));
      _isLoading = false;
      update();
    } else {
      Get.snackbar("Failed", "Failed to Load Data from Database",
          backgroundColor: Colors.red, colorText: Colors.white);
      throw Exception('Failed to load Data From DataBase');
    }
  }

  Future<void> getAllAssignedCourses() async {
    _isLoading = true;
    update();
    Response response = await courseRepo.getAllAssignedCourses();
    if (response.statusCode == 200) {
      final responseBody = response.body;
      _allAssignedCourses = [];
      _allAssignedCourses
          .addAll(responseBody.map((e) => CoursesModel.fromJson(e)));
      _isLoading = false;
      update();
    } else {
      Get.snackbar("Failed", "Failed to Load Data from Database",
          backgroundColor: Colors.red, colorText: Colors.white);
      throw Exception('Failed to load Data From DataBase');
    }
  }
}
